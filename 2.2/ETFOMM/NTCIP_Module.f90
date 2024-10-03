  MODULE NTCIP_DATA
    INTEGER, ALLOCATABLE :: GREEN_PHASES(:)
    INTEGER, ALLOCATABLE :: YELLOW_PHASES(:)
    INTEGER :: PHASE_CALLS_GROUP
    INTEGER :: EXTENSION_GROUP = 0
    INTEGER :: FORCEOFF_GROUP = 0
    INTEGER :: SBA(2)
    INTEGER :: SBB(2)
    INTEGER :: SBC(2)

    CONTAINS
  
    SUBROUTINE ALLOCATE_NTCIP_ARRAYS(NACS)
    INTEGER :: NACS
    IF(.NOT. ALLOCATED(GREEN_PHASES)) THEN
      ALLOCATE(GREEN_PHASES(NACS))
      ALLOCATE(YELLOW_PHASES(NACS))
      GREEN_PHASES = 0
      YELLOW_PHASES = 0
    ENDIF
    END SUBROUTINE
  
    SUBROUTINE CLEAR_EXTENSION(PHASE)
    INTEGER, INTENT(IN) :: PHASE
    EXTENSION_GROUP = IBCLR(EXTENSION_GROUP, PHASE - 1)
    END SUBROUTINE

    SUBROUTINE SET_EXTENSION(PHASE)
    INTEGER, INTENT(IN) :: PHASE
    EXTENSION_GROUP = IBSET(EXTENSION_GROUP, PHASE - 1)
    END SUBROUTINE
  
    SUBROUTINE CLEAR_FORCEOFF(PHASE)
    INTEGER, INTENT(IN) :: PHASE
    FORCEOFF_GROUP = IBCLR(FORCEOFF_GROUP, PHASE - 1)
    END SUBROUTINE

    SUBROUTINE SET_FORCEOFF(PHASE, TIME_IN_GREEN)
    USE SIMPARAMS
    USE TEXT
    USE ACTUATED_CONTROLLERS
    INTEGER, INTENT(IN) :: PHASE
    REAL, INTENT(IN) :: TIME_IN_GREEN
    FORCEOFF_GROUP = IBSET(FORCEOFF_GROUP, PHASE - 1)
    write(msgtext, '(a, i1, a, f8.1)') 'forcing off phase ', phase, ' at time = ', simtime + timestep
    call sendtextmsg(m_info)
    write(msgtext, '(a, f8.1)') '  time in green = ', time_in_green
    call sendtextmsg(m_info)
    END SUBROUTINE
  
  END MODULE
  