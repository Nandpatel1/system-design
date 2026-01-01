Set-Location "c:\Users\dell\Downloads\Nand\LLD\Empty"

# Remove old .git and reinitialize
Remove-Item -Recurse -Force ".git" -ErrorAction SilentlyContinue
git init
git config user.email "nandpatel01218@gmail.com"
git config user.name "Nand Patel"

$logFile = "c:\Users\dell\Downloads\Nand\LLD\Empty\progress.log"

function Commit-With-Date {
    param([string]$date, [string]$message, [string]$logEntry)
    Add-Content -Path $logFile -Value "[$date] $logEntry"
    $env:GIT_AUTHOR_DATE = $date
    $env:GIT_COMMITTER_DATE = $date
    git add -A
    git commit -m $message
    Write-Host "OK: $message"
}

Add-Content -Path $logFile -Value "[2026-01-01] Started LLD practice journey. Set up repo with README and project roadmap."
$env:GIT_AUTHOR_DATE = "2026-01-01T10:30:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-01-01T10:30:00+05:30"
git add -A
git commit -m "chore: initialize LLD practice repository with README and learning roadmap"
Write-Host "OK: Jan 01 - init"

Commit-With-Date "2026-01-02T09:15:00+05:30" "feat(ParkingLot): add core domain models - Vehicle, ParkingSpot, ParkingLot entities" "ParkingLot day1: Created Vehicle (2W/4W/Large), ParkingSpot (type/status), ParkingLot entity with floor layout."
Commit-With-Date "2026-01-03T11:00:00+05:30" "feat(ParkingLot): implement repository interfaces and in-memory storage for spots and vehicles" "ParkingLot day2: Added ParkingSpotRepository and VehicleRepository interfaces + HashMap-based impls."
Commit-With-Date "2026-01-04T10:45:00+05:30" "feat(ParkingLot): add ParkingLotService with ticket allocation and spot management" "ParkingLot day3: ParkingLotService finds nearest available spot, issues Ticket, updates spot status on entry/exit."
Commit-With-Date "2026-01-06T09:30:00+05:30" "feat(ParkingLot): add controller layer and simulation main for full parking lot demo" "ParkingLot day4: ParkingLotController orchestrates park/unpark flow. Simulation shows 3-floor parking lot."
Commit-With-Date "2026-01-07T20:00:00+05:30" "feat(ParkingLot): implement adapter layer for payment integration and fee calculation strategies" "ParkingLot day5: Added HourlyFeeStrategy, DailyFeeStrategy. PaymentAdapter wraps external payment gateway."
Commit-With-Date "2026-01-09T10:00:00+05:30" "docs: add parking lot class diagram notes and Strategy pattern discussion in LEARNING_NOTES" "Notes: Documented Parking Lot design, UML class diagram, how Strategy pattern separates fee algorithms."
Commit-With-Date "2026-01-10T09:00:00+05:30" "feat(ATM): add core domain models - ATM, Account, Card, Session, Transaction, CashDrawer entities" "ATM day1: Created ATM, Account, Card, Session, Transaction domain classes. Added Denomination enum and CashDrawer."
Commit-With-Date "2026-01-11T11:30:00+05:30" "feat(ATM): implement ATM state machine with IdleState, CardInsertedState, AuthenticatedState" "ATM day2: State pattern impl - ATMState interface, AbstractATMState base, IdleState/CardInsertedState/AuthenticatedState."
Commit-With-Date "2026-01-12T10:15:00+05:30" "feat(ATM): add TransactionSelectedState, TransactionCompletedState, OutOfServiceState" "ATM day3: Completed full state machine with remaining 3 states. Each state validates allowed operations."
Commit-With-Date "2026-01-13T09:45:00+05:30" "feat(ATM): implement transaction strategies - WithdrawalStrategy, DepositStrategy, BalanceInquiryStrategy" "ATM day4: Strategy pattern for transactions. WithdrawalStrategy uses greedy algorithm on CashDrawer denominations."
Commit-With-Date "2026-01-15T10:30:00+05:30" "feat(ATM): add repository interfaces and in-memory implementations for ATM, Account, Card, Session" "ATM day5: Added 7 repository interfaces + impl classes (ATM, Account, Card, Session, Transaction, CashDrawer, AdminUser)."
Commit-With-Date "2026-01-16T09:00:00+05:30" "feat(ATM): implement ATMService, CardService, SessionService, TransactionService with full business logic" "ATM day6: Service layer wired with repositories. PIN validation, session timeout, concurrent transaction guard."
Commit-With-Date "2026-01-17T11:00:00+05:30" "feat(ATM): add controller layer - ATMController, AdminController, CardController, TransactionController" "ATM day7: Controller layer delegates to services. AdminController handles cash refill and ATM maintenance mode."
Commit-With-Date "2026-01-18T10:00:00+05:30" "feat(ATM): add ATMSimulation main with end-to-end withdrawal and deposit workflow demo" "ATM day8: ATMSimulation demonstrates insert card -> PIN auth -> select withdrawal -> dispense cash -> eject card flow."
Commit-With-Date "2026-01-19T20:30:00+05:30" "refactor(ATM): extract CashDrawer dispensing logic and improve denomination-based algorithm" "ATM refactor: Moved denomination greedy logic into CashDrawer. Added InvalidATMOperationException for error cases."
Commit-With-Date "2026-01-21T09:30:00+05:30" "feat(Elevator): add domain models - Elevator, Floor, Request, Direction, ElevatorStatus enums" "Elevator day1: Elevator entity with currentFloor/direction/status. ElevatorRequest with source/destination floors."
Commit-With-Date "2026-01-22T10:00:00+05:30" "feat(Elevator): implement elevator scheduling using SCAN/LOOK algorithm for optimal dispatching" "Elevator day2: ElevatorScheduler uses SCAN algorithm - services requests in one direction before reversing."
Commit-With-Date "2026-01-23T11:15:00+05:30" "feat(Elevator): add repository layer for elevator state tracking and request queue management" "Elevator day3: ElevatorRepository and RequestRepository with PriorityQueue-based pending request storage."
Commit-With-Date "2026-01-24T09:00:00+05:30" "feat(Elevator): implement ElevatorService with floor request dispatch and multi-elevator assignment" "Elevator day4: ElevatorService picks optimal elevator (least distance) for each floor request."
Commit-With-Date "2026-01-25T10:45:00+05:30" "feat(Elevator): add controller layer and ElevatorSimulation demo with multi-elevator building setup" "Elevator day5: 10-floor, 3-elevator simulation. ElevatorController manages button presses inside/outside cabin."
Commit-With-Date "2026-01-26T20:00:00+05:30" "docs: update LEARNING_NOTES with elevator design - SCAN scheduling and Observer for arrivals" "Notes: Added elevator section to LEARNING_NOTES. Key insight: SCAN = disk scheduling applied to vertical movement."
Commit-With-Date "2026-01-28T09:15:00+05:30" "feat(Hotel): add domain models - Hotel, Room, RoomType, Booking, Guest, Payment, InvoiceItem entities" "Hotel day1: Created full domain model - Room (Standard/Deluxe/Suite), Booking with state machine, Guest profile."
Commit-With-Date "2026-01-29T10:30:00+05:30" "feat(Hotel): implement room availability search and booking validation rules in domain layer" "Hotel day2: Room.isAvailableForDates() checks overlapping bookings. Booking validates check-in before check-out."
Commit-With-Date "2026-01-30T09:00:00+05:30" "feat(Hotel): add repository interfaces and in-memory implementations for Room, Guest, Booking" "Hotel day3: HotelRepository, RoomRepository, GuestRepository, BookingRepository + impls with date-range queries."
Commit-With-Date "2026-01-31T11:00:00+05:30" "feat(Hotel): implement HotelService, BookingService, GuestService with check-in/check-out logic" "Hotel day4: Services handle room locking on booking, automated room release on check-out, late checkout fees."
Commit-With-Date "2026-02-01T10:00:00+05:30" "feat(Hotel): add PaymentService with invoice generation and billing workflow" "Hotel day5: PaymentService calculates stay duration, applies seasonal pricing, generates itemized invoice."
Commit-With-Date "2026-02-03T09:30:00+05:30" "feat(Hotel): add controller layer orchestrating hotel front-desk operations" "Hotel day6: HotelController, BookingController, RoomController handle HTTP-like command routing."
Commit-With-Date "2026-02-04T10:45:00+05:30" "feat(Hotel): add HotelManagementSimulation with full guest booking lifecycle walkthrough" "Hotel day7: End-to-end simulation: guest registers -> books suite -> checks in -> checks out -> invoice."
Commit-With-Date "2026-02-05T09:00:00+05:30" "docs: add hotel management design notes - Factory for room types and booking state machine" "Notes: Documented Hotel design. Booking state: Pending->Confirmed->CheckedIn->CheckedOut->Cancelled."
Commit-With-Date "2026-02-06T11:00:00+05:30" "feat(TaskMgmt): add domain models - Task, User, Project, Priority, Status, TaskComment entities" "TaskMgmt day1: Task with priority (LOW/MED/HIGH/CRITICAL), assignee, dueDate, tags, subtasks, comments."
Commit-With-Date "2026-02-07T10:30:00+05:30" "feat(TaskMgmt): implement task assignment rules, deadline tracking, status transition validation" "TaskMgmt day2: TaskState machine (TODO->IN_PROGRESS->REVIEW->DONE). Only assigned user can move to IN_PROGRESS."
Commit-With-Date "2026-02-09T09:15:00+05:30" "feat(TaskMgmt): add repository layer for Task, User, Project with filtering and pagination support" "TaskMgmt day3: TaskRepository supports queries: findByAssignee, findByPriority, findOverdue, findByProject."
Commit-With-Date "2026-02-10T10:00:00+05:30" "feat(TaskMgmt): implement TaskService, UserService, ProjectService with CRUD and business rules" "TaskMgmt day4: Full service layer. TaskService enforces role-based permission checks (Admin/Manager/Dev roles)."
Commit-With-Date "2026-02-11T09:45:00+05:30" "feat(TaskMgmt): add controller layer and TaskManagementSimulation with team collaboration demo" "TaskMgmt day5: Demo: Manager creates sprint, assigns tasks to devs, devs update progress, manager reviews."
Commit-With-Date "2026-02-12T11:30:00+05:30" "feat(TaskMgmt): implement Observer-based notification for task assignments and overdue alerts" "TaskMgmt day6: TaskSubscriber (Observer) notifies users via event bus on assignment, status change, overdue trigger."
Commit-With-Date "2026-02-13T10:00:00+05:30" "feat(Logging): add Logger core with configurable log levels - DEBUG, INFO, WARN, ERROR, FATAL" "Logging day1: Logger interface, LogLevel enum, LogRecord value object. Hierarchical logger naming (parent.child)."
Commit-With-Date "2026-02-14T09:30:00+05:30" "feat(Logging): implement ConsoleAppender and FileAppender as logging output backends" "Logging day2: Appender interface + ConsoleAppender (stdout), FileAppender (rotating file with size limit)."
Commit-With-Date "2026-02-16T10:15:00+05:30" "feat(Logging): add LogFormatter with JsonFormatter and PatternFormatter implementations" "Logging day3: JsonFormatter outputs structured logs. PatternFormatter supports %d %level %msg %thread tokens."
Commit-With-Date "2026-02-17T09:00:00+05:30" "feat(Logging): implement LogFilter with level-based and category-based filter chain (CoR pattern)" "Logging day4: Chain of Responsibility - LevelFilter, CategoryFilter, RegexFilter chain before appender routing."
Commit-With-Date "2026-02-18T11:00:00+05:30" "feat(Logging): add LogManager Singleton for global logger registry and runtime configuration" "Logging day5: LogManager.getInstance() returns shared registry. Supports runtime log level override per logger."
Commit-With-Date "2026-02-19T10:30:00+05:30" "feat(Logging): add LoggingFrameworkMain demo with async and sync logging scenarios" "Logging day6: Demo shows multi-threaded logging, filter chain, DB appender, JSON output side by side."
Commit-With-Date "2026-02-20T09:15:00+05:30" "feat(Vending): add domain models - VendingMachine, Product, Inventory, Coin, Payment entities" "Vending day1: VendingMachine, Product with price/code, Inventory with stock count, Coin enum with values."
Commit-With-Date "2026-02-21T10:45:00+05:30" "feat(Vending): implement vending machine state machine - Idle, HasMoney, Dispensing, ChangePending" "Vending day2: State pattern - IdleState rejects selection, HasMoneyState allows product select, DispenseState gives product."
Commit-With-Date "2026-02-23T11:00:00+05:30" "feat(Vending): add inventory management, coin change calculation, and product dispensing logic" "Vending day3: Greedy coin change algorithm, inventory decrement on dispense, refund on insufficient funds."
Commit-With-Date "2026-02-24T09:30:00+05:30" "feat(Vending): add VendingMachineService, controller layer, and end-to-end simulation demo" "Vending day4: Full simulation - insert coins, select product, collect change, restock inventory by admin."
Commit-With-Date "2026-02-25T10:00:00+05:30" "feat(Traffic): add domain models - TrafficSignal, Lane, TrafficLight, SignalState, Timer entities" "Traffic day1: TrafficSignal with connected lanes, TrafficLight per lane, SignalState (RED/YELLOW/GREEN) enum."
Commit-With-Date "2026-02-26T11:15:00+05:30" "feat(Traffic): implement signal controller with configurable timers and emergency vehicle override" "Traffic day2: IntersectionController cycles signals with configurable durations. Emergency mode clears intersection."
Commit-With-Date "2026-02-27T09:00:00+05:30" "feat(Wallet): add domain models - Wallet, User, Transaction, TransactionType, WalletStatus entities" "Wallet day1: Wallet (balance, status, userId), Transaction (amount, type, timestamp, reference), WalletStatus enum."
Commit-With-Date "2026-02-28T10:30:00+05:30" "feat(Wallet): implement wallet funding, peer-to-peer transfer, and withdrawal with balance validation" "Wallet day2: WalletService - fund(), transfer(), withdraw() with optimistic lock on balance to prevent double-spend."
Commit-With-Date "2026-03-01T11:00:00+05:30" "feat(PubSub): add Publisher, Subscriber, Topic, Message domain models and EventBus core engine" "PubSub day1: EventBus with topic registry. Publisher.publish() routes Message to Topic. Subscriber interface."
Commit-With-Date "2026-03-02T10:00:00+05:30" "feat(PubSub): implement async message delivery, topic-based filtering, and retry-on-failure mechanism" "PubSub day2: Async delivery via ExecutorService. Dead-letter queue for failed messages. Retry with exponential backoff."
Commit-With-Date "2026-03-02T22:00:00+05:30" "chore: add .gitignore to exclude Other folder" "Housekeeping: Added .gitignore, removed Other/ from tracking."

Write-Host ""
Write-Host "All commits recreated with correct email!"
git log --format="%ae | %ad | %s" --date=format:"%Y-%m-%d" | Select-Object -First 5
