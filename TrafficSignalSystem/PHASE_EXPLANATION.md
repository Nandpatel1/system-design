# Understanding "Phase" in Traffic Signal System

## 1. WHAT IS A "PHASE"?

### Definition
A **Phase** represents the period when **ONE specific direction** has the GREEN light (and transitions through YELLOW to RED), while all other directions have RED lights.

### Phase Mapping
Based on the code comment in `IntersectionCycle.java:5`:
```java
private int currentPhase; // 0=NORTH, 1=EAST, 2=SOUTH, 3=WEST
```

| Phase Number | Direction | What Happens |
|--------------|-----------|--------------|
| **0** | **NORTH** | NORTH has GREEN → YELLOW → RED<br>EAST, SOUTH, WEST have RED |
| **1** | **EAST** | EAST has GREEN → YELLOW → RED<br>NORTH, SOUTH, WEST have RED |
| **2** | **SOUTH** | SOUTH has GREEN → YELLOW → RED<br>NORTH, EAST, WEST have RED |
| **3** | **WEST** | WEST has GREEN → YELLOW → RED<br>NORTH, EAST, SOUTH have RED |

### Phase Duration
A phase duration includes:
- **GREEN duration** (from `SignalTiming.greenDuration`, default: 45 seconds)
- **YELLOW duration** (constant: 3 seconds)
- **Total Phase Duration** = `greenDuration + YELLOW_DURATION` = 45 + 3 = **48 seconds** (for default timing)

### Complete Cycle
A **complete cycle** = All 4 phases in sequence:
```
Cycle = Phase 0 (NORTH) → Phase 1 (EAST) → Phase 2 (SOUTH) → Phase 3 (WEST) → Repeat
```

**Total Cycle Time** = Sum of all phase durations
- If all directions have 45s green + 3s yellow = 48s each
- Total cycle = 48 × 4 = **192 seconds** (3 minutes 12 seconds)

---

## 2. PHASE vs DIRECTION vs CYCLE

### Phase (What we're tracking)
- **One direction** having green light
- Tracked by `IntersectionCycle.currentPhase` (0-3)
- Has a **duration** (green + yellow time)

### Direction (Physical entity)
- **NORTH, EAST, SOUTH, WEST** - the actual traffic directions
- Each direction has a `TrafficLight` object
- Each direction has a `SignalTiming` object (stores green/yellow durations)

### Cycle (Complete sequence)
- **All 4 phases** in order
- One complete rotation through all directions
- Managed by `IntersectionCycle` object

### Visual Representation

```
┌─────────────────────────────────────────────────────────────┐
│                    COMPLETE CYCLE                            │
└─────────────────────────────────────────────────────────────┘

Phase 0 (NORTH)          Phase 1 (EAST)          Phase 2 (SOUTH)         Phase 3 (WEST)
┌──────────────┐        ┌──────────────┐        ┌──────────────┐        ┌──────────────┐
│ NORTH: GREEN │        │ EAST:  GREEN │        │ SOUTH: GREEN │        │ WEST:  GREEN │
│ EAST:  RED   │        │ NORTH: RED   │        │ NORTH: RED   │        │ NORTH: RED   │
│ SOUTH: RED   │        │ SOUTH: RED   │        │ EAST:  RED   │        │ EAST:  RED   │
│ WEST:  RED   │        │ WEST:  RED   │        │ WEST:  RED   │        │ SOUTH: RED   │
│              │        │              │        │              │        │              │
│ 45s + 3s     │        │ 45s + 3s     │        │ 45s + 3s     │        │ 45s + 3s     │
│ = 48s        │        │ = 48s        │        │ = 48s        │        │ = 48s        │
└──────────────┘        └──────────────┘        └──────────────┘        └──────────────┘
     │                        │                        │                        │
     └────────────────────────┴────────────────────────┴────────────────────────┘
                              Complete Cycle = 192 seconds
```

---

## 3. PHASE TIMING BREAKDOWN

### What Gets Tracked Per Phase

When `currentPhase = 0` (NORTH phase):

1. **Phase Start Time**
   - `phaseStartTime = System.currentTimeMillis()` (timestamp when phase started)
   - Example: `1704067200000` (Jan 1, 2024, 12:00:00 AM)

2. **Phase Duration**
   - From `SignalTiming` for NORTH direction:
     - `greenDuration = 45` seconds
     - `YELLOW_DURATION = 3` seconds
     - **Total = 48 seconds**

3. **Phase Progression**
   ```
   Time 0s:   NORTH turns GREEN, others RED
   Time 45s:  NORTH turns YELLOW
   Time 48s:  NORTH turns RED
   Time 48s:  Phase 0 ends, Phase 1 (EAST) begins
   ```

### Code Reference
```java
// domain/IntersectionCycle.java:5
private int currentPhase; // 0=NORTH, 1=EAST, 2=SOUTH, 3=WEST

// When phase changes:
public void setCurrentPhase(int currentPhase) {
    this.currentPhase = currentPhase;
    this.phaseStartTime = System.currentTimeMillis();  // Reset timer
    this.totalPauseTime = 0;
}

// When moving to next phase:
public void nextPhase() {
    this.currentPhase = (this.currentPhase + 1) % 4;  // 0→1→2→3→0
    this.phaseStartTime = System.currentTimeMillis();  // Reset timer
}
```

---

## 4. THE HARDCODED "30" BUG

### The Problem
In `IntersectionCycle.java:71`, there's a hardcoded value `30`:

```java
// Location: domain/IntersectionCycle.java:60-73
public void setPaused(boolean paused) {
    this.isPaused = paused;
    if (paused) {
        this.pausedAtPhase = this.currentPhase;
        this.pauseStartTime = System.currentTimeMillis();
        System.out.println("Cycle paused at phase: " + this.currentPhase + 
                         " (elapsed: " + getPhaseElapsedTime()/1000 + "s) for intersection " + intersectionId);
    } else {
        // Calculate total pause time when resuming
        this.totalPauseTime += (System.currentTimeMillis() - pauseStartTime);
        System.out.println("Cycle resumed from phase: " + this.pausedAtPhase + 
                         " (remaining: " + getPhaseRemainingTime(30)/1000 + "s) for intersection " + intersectionId);
                         //                                    ^^
                         //                              BUG: Hardcoded 30!
    }
}
```

### Why This Is Wrong

1. **30 doesn't represent anything meaningful**
   - It's not the default green duration (which is 45)
   - It's not the yellow duration (which is 3)
   - It's not the total phase duration (which is 48)
   - It's just a **placeholder/hardcoded value**

2. **It should use the actual phase duration**
   - The method needs to know which direction corresponds to the current phase
   - Then get the `SignalTiming` for that direction
   - Then use `greenDuration + YELLOW_DURATION` as the phase duration

3. **Impact**
   - The "remaining time" displayed when resuming will be **incorrect**
   - If the actual phase duration is 48 seconds, but it uses 30, the calculation will be wrong
   - Example: If 20 seconds elapsed, it would show "10 seconds remaining" instead of "28 seconds remaining"

### What It Should Be

The code should look something like this:

```java
public void setPaused(boolean paused) {
    this.isPaused = paused;
    if (paused) {
        this.pausedAtPhase = this.currentPhase;
        this.pauseStartTime = System.currentTimeMillis();
        System.out.println("Cycle paused at phase: " + this.currentPhase + 
                         " (elapsed: " + getPhaseElapsedTime()/1000 + "s) for intersection " + intersectionId);
    } else {
        // Calculate total pause time when resuming
        this.totalPauseTime += (System.currentTimeMillis() - pauseStartTime);
        
        // FIX: Get actual phase duration instead of hardcoded 30
        Direction currentDirection = getDirectionForPhase(this.pausedAtPhase);
        SignalTiming timing = timingRepository.getSignalTiming(intersectionId, currentDirection);
        int phaseDuration = timing.getGreenDuration() + SignalTiming.YELLOW_DURATION;
        
        System.out.println("Cycle resumed from phase: " + this.pausedAtPhase + 
                         " (remaining: " + getPhaseRemainingTime(phaseDuration)/1000 + "s) for intersection " + intersectionId);
    }
}

// Helper method needed:
private Direction getDirectionForPhase(int phase) {
    switch(phase) {
        case 0: return Direction.NORTH;
        case 1: return Direction.EAST;
        case 2: return Direction.SOUTH;
        case 3: return Direction.WEST;
        default: return Direction.NORTH;
    }
}
```

**However**, this would require `IntersectionCycle` to have access to `TimingRepository`, which it currently doesn't. This is a **design issue** - the cycle object doesn't know about timing configurations.

---

## 5. PHASE DURATION CALCULATION

### How Phase Duration Should Be Calculated

For a given phase (e.g., Phase 0 = NORTH):

1. **Get the direction**: Phase 0 → Direction.NORTH
2. **Get SignalTiming**: `timingRepository.getSignalTiming(intersectionId, Direction.NORTH)`
3. **Calculate duration**: 
   ```java
   int phaseDuration = timing.getGreenDuration() + SignalTiming.YELLOW_DURATION;
   // Example: 45 + 3 = 48 seconds
   ```

### Current Problem

`IntersectionCycle` **doesn't have access** to:
- `TimingRepository` (to get SignalTiming)
- Direction mapping (to convert phase number to Direction)

So it can't calculate the actual phase duration, which is why `30` is hardcoded as a placeholder.

---

## 6. SUMMARY

### What "Phase" Means
- ✅ **Phase = ONE direction having green light** (and its yellow transition)
- ✅ Phase 0 = NORTH, Phase 1 = EAST, Phase 2 = SOUTH, Phase 3 = WEST
- ✅ Phase duration = `greenDuration + YELLOW_DURATION` (default: 45 + 3 = 48 seconds)
- ✅ Complete cycle = All 4 phases in sequence (default: 192 seconds total)

### The "30" Bug
- ❌ **Hardcoded placeholder** that doesn't represent anything meaningful
- ❌ Should be replaced with actual phase duration from `SignalTiming`
- ❌ Causes incorrect "remaining time" display when resuming from pause
- ⚠️ **Root cause**: `IntersectionCycle` doesn't have access to timing information

### What Needs to Be Fixed
1. Add a method to convert phase number to Direction
2. Give `IntersectionCycle` access to `TimingRepository` (or pass timing info as parameter)
3. Replace hardcoded `30` with actual phase duration calculation

---

## 7. CODE REFERENCES

| File | Line | What It Shows |
|------|------|---------------|
| `domain/IntersectionCycle.java` | 5 | Phase mapping: 0=NORTH, 1=EAST, 2=SOUTH, 3=WEST |
| `domain/IntersectionCycle.java` | 71 | **BUG**: Hardcoded `30` in `getPhaseRemainingTime(30)` |
| `domain/SignalTiming.java` | 15 | Default `greenDuration = 45` seconds |
| `domain/SignalTiming.java` | 10 | Constant `YELLOW_DURATION = 3` seconds |
| `domain/IntersectionCycle.java` | 80-85 | `nextPhase()` cycles through 0→1→2→3→0 |

---

This explains what "Phase" means and why the hardcoded `30` is a bug that should be fixed!

