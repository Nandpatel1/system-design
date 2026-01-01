// Service

IntersectionService:
    IntersectionService(IntersectionRepository, TimingRepository);
    void createIntersection(int id, String name); // Intersection, IntersectionCycle domains, Default timings
    Intersection getIntersection(int intersectionId);
    void startAutomaticCycle(int intersectionId); 
    void pauseCycle(int intersectionId);
    void emergencySetAllSignalsToRed(int intersectionId);
    void setSignalToGreen(int intersectionId, Direction direction);

TimingService:
    TimingService(TimingRepository, TrafficService);
    
