! Copyright � 2014
! New Global Systems for Intelligent Transportation Management Corp.
  
! This file is part of ETFOMM.
!
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU Affero General Public License as
! published by the Free Software Foundation, either version 3 of the
! License, or (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU Affero General Public License for more details.
!
! You should have received a copy of the GNU Affero General Public License
! along with this program.  If not, see <http://www.gnu.org/licenses/>.

  MODULE ACTUATED_CONTROLLERS
    IMPLICIT NONE
    INTEGER, PARAMETER :: NRINGS = 2
    INTEGER, PARAMETER :: NBARRIERS = 2
    INTEGER, PARAMETER :: NPHASES = 8
    INTEGER, PARAMETER :: PHASESPERRING = 4
    LOGICAL :: WRITE154 = .FALSE.

    TYPE PHASE_DATA
      LOGICAL :: IN_USE = .FALSE.
      INTEGER :: MAX_INIT_INTERVAL
      LOGICAL :: LEFTARROW(20)
      LOGICAL :: THRUARROW(20)
      LOGICAL :: RIGHTARROW(20)
      LOGICAL :: LDIAGARROW(20)
      LOGICAL :: RDIAGARROW(20)
    END TYPE

    TYPE SDP_DATA
      INTEGER :: INTERSECTION_TYPE
      INTEGER :: CONTROL_MODE
      INTEGER :: ACTUATED_MODE(0:NPHASES)
      INTEGER :: PREVIOUS_PHASES(NRINGS)
      REAL    :: GREEN_TIME(NPHASES)
      REAL    :: PHASE_TIMER(NPHASES)
      INTEGER :: PHASE_COUNTER(NPHASES)
      INTEGER :: PHASES_TYPE(NPHASES)
      REAL    :: PASSAGE_TIMER(NPHASES)
      INTEGER :: PASSAGE_COUNTER(NPHASES)
      REAL    :: GAP_DOWN_TIMER(NPHASES)
      INTEGER :: GAP_DOWN_COUNTER(NPHASES)
      REAL    :: REDUCTION_TIMER(NPHASES)
      INTEGER :: REDUCTION_COUNTER(NPHASES)
      REAL    :: TIME_LIMIT(NPHASES)
      REAL    :: TIME_PLUS_EXTENSION(NPHASES)
      INTEGER :: DETECTOR_COUNT
      INTEGER :: DETECTOR_LIST(64)
      REAL    :: COMPUTED_GAP_TIME(NPHASES)
      REAL    :: GAP_TIMES(NPHASES)
      REAL    :: MINIMUM_GREEN_TIME(NPHASES)
      REAL    :: MAXIMUM_GREEN_TIME(NPHASES)
      LOGICAL :: WAIT_FOR_GAP(NPHASES)
      LOGICAL :: PREVIOUS_WAIT_FOR_GAP(NPHASES)
      LOGICAL :: QUEUED(NPHASES)
      LOGICAL :: PEDESTRIAN_ACTIVE(NPHASES)
      LOGICAL :: GREEN_DONE_ONCE(NPHASES)
      LOGICAL :: GREEN_DONE_FRAME(NPHASES)
      LOGICAL :: GAPOUT(NPHASES)
      LOGICAL :: REDUCTION_MESSAGE_SENT(NPHASES)
      REAL    :: YC(NPHASES)
      REAL    :: RC(NPHASES)
      INTEGER :: CURRENT_COLORS(NRINGS)
      INTEGER :: PREVIOUS_COLORS(NRINGS)
      LOGICAL :: CONCURRENT_RECALL = .TRUE.
      LOGICAL :: ACTUATED
      INTEGER :: ADJUSTMENT = 1
      INTEGER :: CONSECUTIVE_FAILURES = 5
      REAL    :: EXTENSION_TIME(NPHASES)
      REAL    :: MAXIMUM_GREEN_ORIGINAL_VALUE(NPHASES)
      REAL    :: MIN_GAP_TIMES(NPHASES)
      REAL    :: PED_WALK_TIME(NPHASES)
      REAL    :: PED_CLEARANCE_TIME(NPHASES)
      LOGICAL :: PED_OMIT(NPHASES)
      INTEGER :: PED_DETECT_ASSIGN(NPHASES)
      INTEGER :: PED_DETECTOR_CALL(NPHASES)
      REAL    :: TIME_TO_REDUCE(NPHASES)
      REAL    :: TIME_BEFORE_REDUCTION(NPHASES)
      INTEGER :: MASTER_PHASE(NPHASES)
      INTEGER :: SLAVE_PHASE(NPHASES)
    END TYPE

    TYPE ACTUATED_DATA
      REAL    :: GUI_MIN_GREEN_TIMES(NPHASES)
      INTEGER :: GUI_ACTUATED_MODE(0:NPHASES)
      REAL    :: GUI_MAX_GREEN_TIMES(NPHASES)
      REAL    :: GUI_RC(NPHASES)
      REAL    :: GUI_YC(NPHASES)
      REAL    :: GUI_TRUE_MAX_GREEN_TIMES(NPHASES)
      REAL    :: GUI_DEFAULT_EXTENSION_TIMES(NPHASES)
      REAL    :: GUI_GAP_TIMES(NPHASES)
      REAL    :: GUI_TIME_BEFORE_REDUCTION(NPHASES)
      REAL    :: GUI_TIME_TO_REDUCE(NPHASES)
      REAL    :: GUI_MIN_GAP_TIMES(NPHASES)
      REAL    :: NEW_PED_WALK_TIMES(NPHASES)
      REAL    :: NEW_PED_CLEARANCE_TIMES(NPHASES)
      LOGICAL :: NEW_PED_OMIT(NPHASES)
      REAL    :: NEW_PED_DETECTOR_ASSIGNMENTS(NPHASES)
      REAL    :: GUI_EXTENSION_TIME_INCREMENT
      !INTEGER :: CONST_DEMAND_PERIOD_BEGIN(5)
      !INTEGER :: CONST_DEMAND_PERIOD_END(5)
      INTEGER :: CURRENT_PHASES(NRINGS) = 0
      INTEGER :: N_DIRECT_APPROACHES = 0
      INTEGER :: DIRECT_APPROACH(10) = 0
      INTEGER :: APPROACH_LINK(10) = 0
      INTEGER :: N_INDIRECT_APPROACHES = 0
      INTEGER :: INDIRECT_APPROACH(5) = 0
      LOGICAL :: EXTERNAL_CONTROL = .FALSE.
      INTEGER :: NODE(NPHASES)   
      INTEGER :: RANGE = 0
      INTEGER :: NDET
      TYPE(PHASE_DATA) :: PHASE(NPHASES)
      TYPE(SDP_DATA) :: SDP
      INTEGER :: QUEUED_PHASES
      INTEGER :: BARRIER(NPHASES)
      INTEGER :: RING(NPHASES)
      INTEGER :: RING_INDEX(NRINGS)
      INTEGER :: MAX_INDEX(2, 2)
      LOGICAL :: READY_TO_CROSS(NRINGS)
      LOGICAL :: SERVED_THIS_CYCLE(NPHASES)
      INTEGER :: RING_PHASE_SEQUENCE(NRINGS, PHASESPERRING)
      INTEGER :: NEXT_PHASE(NRINGS)
      INTEGER :: PHASE_COUNT(NPHASES)
      REAL    :: TOTAL_GREEN_TIME(NPHASES)
      REAL    :: START_TIME(NPHASES)
      INTEGER :: RED_LIGHT_RUNNERS(NPHASES)
      INTEGER :: TIMES_STARTED(NPHASES)
      INTEGER :: VEHICLES_DISCHARGED(NPHASES)
      INTEGER :: VEHICLES_INDZ(NPHASES)
      INTEGER :: MIN_GREENS(NPHASES)
      INTEGER :: MAXOUTS(NPHASES)
      INTEGER :: COORDINATION_COUNTER, LOCAL_CYCLE_COUNTER , MASTER_CYCLE_COUNTER
      REAL    :: COORDINATION_TIMER
      INTEGER :: COORDINATION_FLAG
      INTEGER :: COORDINATION_PLAN
      REAL    :: CYCLE_LENGTH
      REAL    :: OFFSET
      REAL    :: NEW_CYCLE_LENGTH
      REAL    :: NEW_OFFSET
      REAL    :: FORCE_OFF_TIME(NPHASES)
      REAL    :: PHASE_SPLITS(NPHASES)
      REAL    :: NEW_FORCE_OFF_TIME(NPHASES)
      REAL    :: LOCAL_CYCLE_TIMER
      REAL    :: MASTER_CYCLE_TIMER
      INTEGER :: INTRAN
      INTEGER :: TRANSITION_METHOD = 4  !Default to Immediate Transition
      INTEGER :: MAXPCT_ADD = 20
      INTEGER :: MAXPCT_SUBTRACT = 17
      INTEGER :: PHASE_SEQUENCE(NPHASES)
      LOGICAL :: NEWPLAN
      LOGICAL :: LOCKED(NRINGS)
      LOGICAL :: TERMINATE_FLAG(NRINGS)
      LOGICAL :: LEAD(NPHASES)
      INTEGER :: PEDESTRIAN_DETECTOR_STATE(NPHASES)
      INTEGER :: DETECTOR_OPERATING_CODE(NPHASES)
      LOGICAL :: HAS_DEMAND(NPHASES)
      INTEGER :: OVERLAP_A(2)
      INTEGER :: OVERLAP_B(2)
      INTEGER :: OVERLAP_C(2)
      INTEGER :: OVERLAP_D(2)
      !LOGICAL :: EXTEND_GREEN(NPHASES)
      !INTEGER :: RED_LOCK_CODE(NPHASES)
      !INTEGER :: YELLOW_LOCK_CODE(NPHASES)
      INTEGER :: DUAL_ENTRY_CODE(NPHASES)
      !REAL    :: RED_REVERT_TIME(NPHASES)
      !INTEGER :: SIMULTANEOUS_GAP_CODE(NPHASES)
      !INTEGER :: CONDITIONAL_SERVICE_CODE(NPHASES)
      !REAL    :: MIN_CONDITIONAL_SERVICE_TIME(NPHASES)
      !LOGICAL :: READY_TO_TERMINATE(NPHASES)
      LOGICAL :: PED_PHASE(NPHASES)
      INTEGER :: PED_INTENSITY(NPHASES)
      INTEGER :: PED_HEADWAY(NPHASES)
      INTEGER :: PED_RECALL_CODE(NPHASES)
      INTEGER :: PED_REST_CODE(NPHASES)
      INTEGER :: PED_TYPE(NPHASES)
      REAL    :: NEXT_PED_ARRIVAL(NPHASES)
      logical :: tram_phase(nphases)
      logical :: tram_only_phase(nphases)
      integer :: checkin_distance(nphases, 10)
      integer :: checkout_distance(nphases, 10)
      integer :: policy(nphases, 10)
      !integer :: rtmode(nphases, 10)
      integer :: tram_reset_index(2)
      integer :: next_tram_phase(2)
      integer :: last_tram_car(nphases)
      integer :: forceoff_flags
      integer :: extension_flags
      logical :: serving_tram(nphases)
      integer :: checkin_policy(nphases)
      logical :: hold_for_tram
    END TYPE
    
    INTEGER :: COORDINATED_OPERATION_CODE
    INTEGER :: NUMBER_OF_ACS
    INTEGER :: NUMBER_OF_SUPER_ACS
    LOGICAL :: CONFLICTS(0:NPHASES, 0:NPHASES)
    LOGICAL :: PHASE_PAIRS(0:NPHASES, 0:NPHASES)
    INTEGER :: PAIRED_PHASE(NPHASES)
    INTEGER :: COMPLEMENTARY_PHASE(NPHASES)
    TYPE(ACTUATED_DATA), ALLOCATABLE :: AC_SIGNALS(:)
    TYPE(ACTUATED_DATA), ALLOCATABLE :: ACSIGNAL_DATA(:,:)
    LOGICAL, ALLOCATABLE :: WRITE4X(:,:)
    LOGICAL :: SIGNALS_INITIALIZED = .FALSE.
    
    CONTAINS
        
    INTEGER FUNCTION THE_OTHER_RING(R)
    INTEGER R
    IF(R .EQ. 1) THEN
      THE_OTHER_RING = 2
    ELSE
      THE_OTHER_RING = 1
    ENDIF
    END FUNCTION
  
    SUBROUTINE SET_SDP_DATA
    PAIRED_PHASE(1) = 5
    PAIRED_PHASE(2) = 6
    PAIRED_PHASE(3) = 7
    PAIRED_PHASE(4) = 8
    PAIRED_PHASE(5) = 1
    PAIRED_PHASE(6) = 2
    PAIRED_PHASE(7) = 3
    PAIRED_PHASE(8) = 4
    
    COMPLEMENTARY_PHASE(1) = 6
    COMPLEMENTARY_PHASE(2) = 5
    COMPLEMENTARY_PHASE(3) = 8
    COMPLEMENTARY_PHASE(4) = 7
    COMPLEMENTARY_PHASE(5) = 2
    COMPLEMENTARY_PHASE(6) = 1
    COMPLEMENTARY_PHASE(7) = 4
    COMPLEMENTARY_PHASE(8) = 3
    
    PHASE_PAIRS = .FALSE.
    PHASE_PAIRS(1, 5) = .TRUE.
    PHASE_PAIRS(2, 6) = .TRUE.
    PHASE_PAIRS(3, 7) = .TRUE.
    PHASE_PAIRS(4, 8) = .TRUE.
    PHASE_PAIRS(5, 1) = .TRUE.
    PHASE_PAIRS(6, 2) = .TRUE.
    PHASE_PAIRS(7, 3) = .TRUE.
    PHASE_PAIRS(8, 4) = .TRUE.

    CONFLICTS = .FALSE.
    CONFLICTS(1, 2) = .TRUE.
    CONFLICTS(1, 3) = .TRUE.
    CONFLICTS(1, 4) = .TRUE.
    CONFLICTS(1, 7) = .TRUE.
    CONFLICTS(1, 8) = .TRUE.
    CONFLICTS(2, 1) = .TRUE.
    CONFLICTS(2, 3) = .TRUE.
    CONFLICTS(2, 4) = .TRUE.
    CONFLICTS(2, 7) = .TRUE.
    CONFLICTS(2, 8) = .TRUE.
    CONFLICTS(3, 1) = .TRUE.
    CONFLICTS(3, 2) = .TRUE.
    CONFLICTS(3, 4) = .TRUE.
    CONFLICTS(3, 5) = .TRUE.
    CONFLICTS(3, 6) = .TRUE.
    CONFLICTS(4, 1) = .TRUE.
    CONFLICTS(4, 2) = .TRUE.
    CONFLICTS(4, 3) = .TRUE.
    CONFLICTS(4, 5) = .TRUE.
    CONFLICTS(4, 6) = .TRUE.
    CONFLICTS(5, 3) = .TRUE.
    CONFLICTS(5, 4) = .TRUE.
    CONFLICTS(5, 6) = .TRUE.
    CONFLICTS(5, 7) = .TRUE.
    CONFLICTS(5, 8) = .TRUE.
    CONFLICTS(6, 3) = .TRUE.
    CONFLICTS(6, 4) = .TRUE.
    CONFLICTS(6, 5) = .TRUE.
    CONFLICTS(6, 7) = .TRUE.
    CONFLICTS(6, 8) = .TRUE.
    CONFLICTS(7, 1) = .TRUE.
    CONFLICTS(7, 2) = .TRUE.
    CONFLICTS(7, 5) = .TRUE.
    CONFLICTS(7, 6) = .TRUE.
    CONFLICTS(7, 8) = .TRUE.
    CONFLICTS(8, 1) = .TRUE.
    CONFLICTS(8, 2) = .TRUE.
    CONFLICTS(8, 5) = .TRUE.
    CONFLICTS(8, 6) = .TRUE.
    CONFLICTS(8, 7) = .TRUE.
    END SUBROUTINE

! ==================================================================================================
    SUBROUTINE ALLOCATE_AC_ARRAYS(N)
    INTEGER :: N
    IF(ALLOCATED(AC_SIGNALS)) DEALLOCATE(AC_SIGNALS)
    ALLOCATE(AC_SIGNALS(N))
    RETURN
    END SUBROUTINE

! ==================================================================================================
    SUBROUTINE DEALLOCATE_AC_ARRAYS
    USE SIMPARAMS
    IF(ALLOCATED(AC_SIGNALS)) DEALLOCATE(AC_SIGNALS)
    NUMBER_OF_ACS = 0
#ifndef TSIS_COMPATIBLE
    IF(ALLOCATED(ACSIGNAL_DATA)) DEALLOCATE(ACSIGNAL_DATA)
    IF(ALLOCATED(WRITE4X)) DEALLOCATE(WRITE4X)
#endif
    RETURN
    END SUBROUTINE
    
! ==================================================================================================
    SUBROUTINE SAVE_ACTUATED_CONTROLLERS(FILE1, FILE2)
    USE SIMPARAMS
    INTEGER, INTENT(IN) :: FILE1, FILE2
    RETURN
    END SUBROUTINE  

! ==================================================================================================
    SUBROUTINE RESTORE_ACTUATED_CONTROLLERS(FILE1, FILE2)
    USE SIMPARAMS
    INTEGER, INTENT(IN) :: FILE1, FILE2
    RETURN
    END SUBROUTINE  

  ! ==================================================================================================
    LOGICAL FUNCTION PHASE_IS_GREEN(IACT, PHASE)
  !----------------------------------------------------------------------
  !--  Method : Phase Is Green
  !--
  !--  Purpose
  !--
  !--    Returns whether a phase is currrently in green
  !--
  !--
  !--  Change History
  !--
  !--  DATE                 Description
  !--
  !--  Apr 11, 2011         Initial Version
  !----------------------------------------------------------------------
    USE GLOBAL_DATA
    IMPLICIT NONE
    INTEGER :: IACT, PHASE
  !----------------------------------------------------------------------
    PHASE_IS_GREEN = .FALSE.
    IF(PHASE .EQ. AC_SIGNALS(IACT)%CURRENT_PHASES(1) .AND. AC_SIGNALS(IACT)%SDP%CURRENT_COLORS(1) .EQ. GREEN) THEN
      PHASE_IS_GREEN = .TRUE.
    ELSEIF(PHASE .EQ. AC_SIGNALS(IACT)%CURRENT_PHASES(2) .AND. AC_SIGNALS(IACT)%SDP%CURRENT_COLORS(2) .EQ. GREEN) THEN
      PHASE_IS_GREEN = .TRUE.
    ENDIF
    END FUNCTION
  
    LOGICAL FUNCTION PHASE_IS_YELLOW(IACT, PHASE)
    USE GLOBAL_DATA
    IMPLICIT NONE
    INTEGER :: IACT, PHASE
  !----------------------------------------------------------------------
    PHASE_IS_YELLOW = .FALSE.
    IF(PHASE .EQ. AC_SIGNALS(IACT)%CURRENT_PHASES(1) .AND. AC_SIGNALS(IACT)%SDP%CURRENT_COLORS(1) .EQ. YELLOW) THEN
      PHASE_IS_YELLOW = .TRUE.
    ELSEIF(PHASE .EQ. AC_SIGNALS(IACT)%CURRENT_PHASES(2) .AND. AC_SIGNALS(IACT)%SDP%CURRENT_COLORS(2) .EQ. YELLOW) THEN
      PHASE_IS_YELLOW = .TRUE.
    ENDIF
    END FUNCTION
  
  ! ==================================================================================================
    LOGICAL FUNCTION PHASE_IS_RED(IACT, PHASE)
  !----------------------------------------------------------------------
    USE GLOBAL_DATA
    IMPLICIT NONE
    INTEGER :: IACT, PHASE
  !----------------------------------------------------------------------
    PHASE_IS_RED = .FALSE.
    IF(SUM(AC_SIGNALS(IACT)%CURRENT_PHASES) .EQ. 0) THEN
      PHASE_IS_RED = .TRUE.
    ELSEIF(PHASE .EQ. AC_SIGNALS(IACT)%CURRENT_PHASES(1) .AND. AC_SIGNALS(IACT)%SDP%CURRENT_COLORS(1) .EQ. RED) THEN
      PHASE_IS_RED = .TRUE.
    ELSEIF(PHASE .EQ. AC_SIGNALS(IACT)%CURRENT_PHASES(2) .AND. AC_SIGNALS(IACT)%SDP%CURRENT_COLORS(2) .EQ. RED) THEN
      PHASE_IS_RED = .TRUE.
    ENDIF
    END FUNCTION

  ! ==================================================================================================
    LOGICAL FUNCTION PHASE_IS_ALLOWED(IACT, PHASE)
  !----------------------------------------------------------------------
    USE SCOPE_PARAMETERS
    IMPLICIT NONE
    INTEGER :: IACT, PHASE
    REAL :: MINTIME, TIMELEFT
  !----------------------------------------------------------------------
    PHASE_IS_ALLOWED = .TRUE.
    IF(AC_SIGNALS(IACT)%CYCLE_LENGTH .NE. 0.) THEN
      IF(PHASE .NE. 2 .AND. PHASE .NE. 6) THEN
        TIMELEFT = AC_SIGNALS(IACT)%FORCE_OFF_TIME(PHASE) - AC_SIGNALS(IACT)%LOCAL_CYCLE_TIMER
        MINTIME = AC_SIGNALS(IACT)%GUI_MIN_GREEN_TIMES(PHASE)
        IF(TIMELEFT .LT. MINTIME) THEN
          PHASE_IS_ALLOWED = .FALSE.
        ENDIF
      ENDIF
    ENDIF
    END FUNCTION
  
  END MODULE
  
  MODULE TIMED_CONTROLLERS
    IMPLICIT NONE
    TYPE FTC_DATA
      INTEGER :: ACTIVE_INTERVALS = 0
      INTEGER :: APPROACH(6) = 0
      INTEGER :: APPROACHES = 0
      INTEGER :: CURRENT_INTERVAL = 0
      REAL    :: CYCLE_LENGTH
      REAL    :: DURATION(12) = 0
      LOGICAL :: EXTERNAL_CONTROL = .FALSE.
      INTEGER :: NODE = 0   
      INTEGER :: OFFSET
      INTEGER :: RANGE = 0
      INTEGER :: SIGNAL_CODE(6, 12) = 0
      REAL    :: TIME_IN_INTERVAL = 0
    END TYPE

    INTEGER :: NUMBER_OF_FTCS
    INTEGER :: NUMBER_OF_FTSIGNALS
    TYPE(FTC_DATA), ALLOCATABLE :: FTC_SIGNALS(:)
    LOGICAL, ALLOCATABLE :: WRITE3536(:,:)
    
    CONTAINS
        
! ==================================================================================================
    SUBROUTINE ALLOCATE_FTC_ARRAYS
    IF(ALLOCATED(FTC_SIGNALS)) RETURN
    ALLOCATE(FTC_SIGNALS(NUMBER_OF_FTCS))
    RETURN
    END SUBROUTINE

! ==================================================================================================
    SUBROUTINE DEALLOCATE_FTC_ARRAYS
    USE SIMPARAMS
    IF(ALLOCATED(FTC_SIGNALS)) DEALLOCATE(FTC_SIGNALS)
    NUMBER_OF_FTCS = 0
    IF(ALLOCATED(WRITE3536)) DEALLOCATE(WRITE3536)
    RETURN
    END SUBROUTINE
                       
! ==================================================================================================
    SUBROUTINE SAVE_TIMED_CONTROLLERS(FILE1, FILE2, FIRST)
    INTEGER, INTENT(IN) :: FILE1, FILE2
    LOGICAL, INTENT(IN) :: FIRST
    INTEGER :: I, J, N
! ----------------------------------------------------------------------

! --- Save static data.
    
    IF(FIRST) THEN
      WRITE(FILE1) NUMBER_OF_FTCS
      DO I = 1, NUMBER_OF_FTCS
        WRITE(FILE1) FTC_SIGNALS(I)%NODE
        WRITE(FILE1) FTC_SIGNALS(I)%ACTIVE_INTERVALS
        WRITE(FILE1) (FTC_SIGNALS(I)%DURATION(N), N = 1, 12)
        WRITE(FILE1) FTC_SIGNALS(I)%APPROACH
        WRITE(FILE1) FTC_SIGNALS(I)%APPROACHES
      ENDDO
    ENDIF

! --- Save dynamic data.

    DO I = 1, NUMBER_OF_FTCS
      IF(FTC_SIGNALS(I)%ACTIVE_INTERVALS .GT. 1) THEN
        WRITE(FILE2) FTC_SIGNALS(I)%CURRENT_INTERVAL
        WRITE(FILE2) FTC_SIGNALS(I)%TIME_IN_INTERVAL
        DO J = 1, FTC_SIGNALS(I)%APPROACHES
          WRITE(FILE2) (FTC_SIGNALS(I)%SIGNAL_CODE(J, N), N = 1, 12)
        ENDDO
      ENDIF
    ENDDO
    RETURN
    END SUBROUTINE
        
! ==================================================================================================
    SUBROUTINE RESTORE_TIMED_CONTROLLERS(FILE1, FILE2)
    INTEGER, INTENT(IN) :: FILE1, FILE2
    INTEGER :: I, J, N
! ----------------------------------------------------------------------
    READ(FILE1) NUMBER_OF_FTCS
    IF(NUMBER_OF_FTCS .GT. 0) THEN
      CALL ALLOCATE_FTC_ARRAYS
      DO I = 1, NUMBER_OF_FTCS
        READ(FILE1) FTC_SIGNALS(I)%NODE
        READ(FILE1) FTC_SIGNALS(I)%ACTIVE_INTERVALS
        READ(FILE1) (FTC_SIGNALS(I)%DURATION(N), N = 1, 12)
        READ(FILE1) FTC_SIGNALS(I)%APPROACH
        READ(FILE1) FTC_SIGNALS(I)%APPROACHES
      ENDDO
      DO I = 1, NUMBER_OF_FTCS
        IF(FTC_SIGNALS(I)%ACTIVE_INTERVALS .GT. 1) THEN
          READ(FILE2) FTC_SIGNALS(I)%CURRENT_INTERVAL
          READ(FILE2) FTC_SIGNALS(I)%TIME_IN_INTERVAL
          DO J = 1, FTC_SIGNALS(I)%APPROACHES
            READ(FILE2) (FTC_SIGNALS(I)%SIGNAL_CODE(J, N), N = 1, 12)
          ENDDO
        ENDIF
      ENDDO
    ENDIF
    RETURN
    END SUBROUTINE
        
  END MODULE
  
  MODULE ROUNDABOUT_DATA
    IMPLICIT NONE
    TYPE RABT_DATA
      INTEGER :: APPROACHES = 0
      INTEGER :: APPROACH_LINKS(5) = 0
      INTEGER :: DEPARTING_LINKS(5) = 0
      REAL    :: EXIT_PCTS(5, 5) = 0.
      INTEGER :: RADIUS = 0
    END TYPE

    INTEGER :: NUMBER_OF_ROUNDABOUTS
    TYPE(RABT_DATA), ALLOCATABLE :: ROUNDABOUT(:)
    
    CONTAINS
        
! ==================================================================================================
    SUBROUTINE ALLOCATE_ROUNDABOUT_ARRAYS
    IF(ALLOCATED(ROUNDABOUT)) RETURN
    ALLOCATE(ROUNDABOUT(NUMBER_OF_ROUNDABOUTS))
    RETURN
    END SUBROUTINE
              
! ==================================================================================================
    SUBROUTINE DEALLOCATE_ROUNDABOUT_ARRAYS
    USE SIMPARAMS
    IF(ALLOCATED(ROUNDABOUT)) DEALLOCATE(ROUNDABOUT)
    NUMBER_OF_ROUNDABOUTS = 0
    RETURN
    END SUBROUTINE
              
! ==================================================================================================
    SUBROUTINE SAVE_ROUNDABOUTS(FILE1)
    INTEGER, INTENT(IN) :: FILE1
    INTEGER :: I
! ----------------------------------------------------------------------

! --- Save static data.
    
    WRITE(FILE1) NUMBER_OF_ROUNDABOUTS
    DO I = 1, NUMBER_OF_ROUNDABOUTS
      WRITE(FILE1) ROUNDABOUT(I)%APPROACHES
      WRITE(FILE1) ROUNDABOUT(I)%APPROACH_LINKS
      WRITE(FILE1) ROUNDABOUT(I)%DEPARTING_LINKS
      WRITE(FILE1) ROUNDABOUT(I)%EXIT_PCTS
      WRITE(FILE1) ROUNDABOUT(I)%RADIUS
    ENDDO
    RETURN
    END SUBROUTINE 
    
! ==================================================================================================
    SUBROUTINE RESTORE_ROUNDABOUTS(FILE1)
    INTEGER, INTENT(IN) :: FILE1
    INTEGER :: I
! ----------------------------------------------------------------------

! --- Save static data.
    
    WRITE(FILE1) NUMBER_OF_ROUNDABOUTS
    CALL ALLOCATE_ROUNDABOUT_ARRAYS
    DO I = 1, NUMBER_OF_ROUNDABOUTS
      READ(FILE1) ROUNDABOUT(I)%APPROACHES
      READ(FILE1) ROUNDABOUT(I)%APPROACH_LINKS
      READ(FILE1) ROUNDABOUT(I)%DEPARTING_LINKS
      READ(FILE1) ROUNDABOUT(I)%EXIT_PCTS
      READ(FILE1) ROUNDABOUT(I)%RADIUS
    ENDDO
    RETURN
    END SUBROUTINE
        
  END MODULE 
     
  MODULE TURNING_WAYS   
    TYPE RTW_DATA
      INTEGER :: USN
      INTEGER :: DSN
      INTEGER :: USN2
      INTEGER :: DSN2
      REAL :: RTW_EXIT_POINT
      REAL :: RTW_ENTRY_POINT
      REAL :: RTW_LENGTH
      REAL :: RTW_FFSPEED
      real :: unused
      INTEGER :: RTW_CONTROL_CODE
      INTEGER :: RTW_LANES
    END TYPE
    INTEGER :: NUMBER_OF_TURNING_WAYS
    TYPE(RTW_DATA), ALLOCATABLE :: TURNING_WAY(:)
    
    CONTAINS
        
! ==================================================================================================
    SUBROUTINE ALLOCATE_TURNING_WAY_ARRAYS
    IF(ALLOCATED(TURNING_WAY)) RETURN
    ALLOCATE(TURNING_WAY(NUMBER_OF_TURNING_WAYS))
    RETURN
    END SUBROUTINE
              
! ==================================================================================================
    SUBROUTINE DEALLOCATE_TURNING_WAY_ARRAYS
    USE SIMPARAMS
    IF(ALLOCATED(TURNING_WAY)) DEALLOCATE(TURNING_WAY)
    NUMBER_OF_TURNING_WAYS = 0
    RETURN
    END SUBROUTINE
              
! ==================================================================================================
    SUBROUTINE SAVE_TURNING_WAYS(FILE1)
    INTEGER, INTENT(IN) :: FILE1
    INTEGER :: I
! ----------------------------------------------------------------------

! --- Save static data.
    
    WRITE(FILE1) NUMBER_OF_TURNING_WAYS
    DO I = 1, NUMBER_OF_TURNING_WAYS
      WRITE(FILE1) TURNING_WAY(I)%USN
      WRITE(FILE1) TURNING_WAY(I)%DSN
      WRITE(FILE1) TURNING_WAY(I)%RTW_EXIT_POINT
      WRITE(FILE1) TURNING_WAY(I)%RTW_ENTRY_POINT
      WRITE(FILE1) TURNING_WAY(I)%RTW_LENGTH
    ENDDO
    RETURN
    END SUBROUTINE 
    
! ==================================================================================================
    SUBROUTINE RESTORE_TURNING_WAYS(FILE1)
    INTEGER, INTENT(IN) :: FILE1
    INTEGER :: I
! ----------------------------------------------------------------------

! --- Save static data.
    
    WRITE(FILE1) NUMBER_OF_TURNING_WAYS
    CALL ALLOCATE_TURNING_WAY_ARRAYS
    DO I = 1, NUMBER_OF_TURNING_WAYS
      READ(FILE1) TURNING_WAY(I)%USN
      READ(FILE1) TURNING_WAY(I)%DSN
      READ(FILE1) TURNING_WAY(I)%RTW_EXIT_POINT
      READ(FILE1) TURNING_WAY(I)%RTW_ENTRY_POINT
      READ(FILE1) TURNING_WAY(I)%RTW_LENGTH
    ENDDO
    RETURN
    END SUBROUTINE
        
  END MODULE  
  
  MODULE RAMP_METERS
    IMPLICIT NONE
        
    INTEGER, PARAMETER :: MS_INACTIVE = 0
    INTEGER, PARAMETER :: MS_GREEN = -1
    INTEGER, PARAMETER :: MS_RED = 1
        
    TYPE RM_DATA
      INTEGER :: DSN
      INTEGER :: LINK
      INTEGER :: CONTROL
      INTEGER :: ONSET
      INTEGER :: STATE
      INTEGER :: DETECTOR(10) = 0
      INTEGER :: CAPACITY
      INTEGER :: SPEED(6)
      REAL    :: HEADWAY(6)
      REAL    :: TIMER
      REAL    :: UPDINT
      LOGICAL :: TWO_PERGREEN = .FALSE.
    END TYPE
        
    INTEGER :: NUMBER_OF_RAMPMETERS
    TYPE(RM_DATA), ALLOCATABLE :: RAMPMETERS(:)
    LOGICAL, ALLOCATABLE :: WRITE37(:,:)

    CONTAINS
        
! ==================================================================================================
    SUBROUTINE ALLOCATE_RAMPMETER_ARRAYS
    IF(ALLOCATED(RAMPMETERS)) RETURN
    ALLOCATE(RAMPMETERS(NUMBER_OF_RAMPMETERS))
    ALLOCATE(WRITE37(NUMBER_OF_RAMPMETERS, 19))
    WRITE37 = .FALSE.
    RETURN
    END SUBROUTINE
        
! ==================================================================================================
    SUBROUTINE DEALLOCATE_RAMPMETER_ARRAYS
    USE SIMPARAMS
    IF(ALLOCATED(RAMPMETERS)) DEALLOCATE(RAMPMETERS)
    NUMBER_OF_RAMPMETERS = 0
#ifndef TSIS_COMPATIBLE
    IF(ALLOCATED(WRITE37)) DEALLOCATE(WRITE37)
#endif
    RETURN
    END SUBROUTINE

! ==================================================================================================
    SUBROUTINE SAVE_RAMP_METERS(FILE1, FILE2, FIRST)
    USE SIMPARAMS
    INTEGER, INTENT(IN) :: FILE1, FILE2
    LOGICAL, INTENT(IN) :: FIRST
    INTEGER :: I, N
! ----------------------------------------------------------------------

! --- Save static data.
    
    IF(FIRST) THEN
      WRITE(FILE1) NUMBER_OF_RAMPMETERS
      CALL ALLOCATE_RAMPMETER_ARRAYS
      DO I = 1, NUMBER_OF_RAMPMETERS
        WRITE(FILE1) RAMPMETERS(I)%DSN
        WRITE(FILE1) RAMPMETERS(I)%LINK
        WRITE(FILE1) RAMPMETERS(I)%CONTROL
        WRITE(FILE1) RAMPMETERS(I)%ONSET
        WRITE(FILE1) (RAMPMETERS(I)%DETECTOR(N), N = 1, 10)
        WRITE(FILE1) RAMPMETERS(I)%CAPACITY
        WRITE(FILE1) (RAMPMETERS(I)%SPEED(N), N = 1, 6)
        WRITE(FILE1) (RAMPMETERS(I)%HEADWAY(N), N = 1, 6)
        WRITE(FILE1) RAMPMETERS(I)%TIMER
        !WRITE(FILE1) RAMPMETERS(I)%UPDINT
        WRITE(FILE1) RAMPMETERS(I)%TWO_PERGREEN
      ENDDO
    ENDIF

! --- Save dynamic data.

    DO I = 1, NUMBER_OF_RAMPMETERS
      WRITE(FILE2) RAMPMETERS(I)%STATE
    ENDDO
    RETURN
    END SUBROUTINE
    
! ==================================================================================================
    SUBROUTINE RESTORE_RAMP_METERS(FILE1, FILE2)
    USE SIMPARAMS
    INTEGER, INTENT(IN) :: FILE1, FILE2
    INTEGER :: I, N
! ----------------------------------------------------------------------
    READ(FILE1) NUMBER_OF_RAMPMETERS
    IF(NUMBER_OF_RAMPMETERS .NE. 0) THEN
      CALL ALLOCATE_RAMPMETER_ARRAYS
      DO I = 1, NUMBER_OF_RAMPMETERS
        READ(FILE1) RAMPMETERS(I)%DSN
        READ(FILE1) RAMPMETERS(I)%LINK
        READ(FILE1) RAMPMETERS(I)%CONTROL
        READ(FILE1) RAMPMETERS(I)%ONSET
        READ(FILE1) (RAMPMETERS(I)%DETECTOR(N), N = 1, 10)
        READ(FILE1) RAMPMETERS(I)%CAPACITY
        READ(FILE1) (RAMPMETERS(I)%SPEED(N), N = 1, 6)
        READ(FILE1) (RAMPMETERS(I)%HEADWAY(N), N = 1, 6)
        READ(FILE1) RAMPMETERS(I)%TIMER
        !READ(FILE1) RAMPMETERS(I)%UPDINT
        READ(FILE1) RAMPMETERS(I)%TWO_PERGREEN
      ENDDO
      DO I = 1, NUMBER_OF_RAMPMETERS
        READ(FILE2) RAMPMETERS(I)%STATE
      ENDDO
    ENDIF
    RETURN
    END SUBROUTINE
    
  END MODULE
