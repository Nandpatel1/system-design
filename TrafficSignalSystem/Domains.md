// Domains
EmergencyRequest {
    private int id;
    private int intersectionId;
    private Direction direction;
    private int duration;
    private boolean isActive;
    private long requestTime;
}

Intersection {
    private int id;
    private String name;
    private Map<Direction, TrafficLight> trafficLights;
    private boolean isEmergencyMode;
    private Direction emergencyDirection;
    private boolean isCyclePaused;
}

IntersectionCycle {
    private int intersectionId;
    private int currentPhase; // 0=NORTH, 1=EAST, 2=SOUTH, 3=WEST
    private boolean isPaused;
    private int pausedAtPhase;
    private long phaseStartTime;
    private long pauseStartTime; // NEW: Track when pause started
    private long totalPauseTime;
    public IntersectionCycle(int intersectionId);
}

SignalTiming {
    private int intersectionId;
    private Direction direction;
    private int greenDuration;
    private boolean isDynamic;
    public static final int YELLOW_DURATION = 3;
}

TrafficLight {
    private Direction direction;
    private TrafficLightState currentState;
}

VehicleCounter {
    private Direction direction;
    private int count;
    private long lastUpdate;
}


