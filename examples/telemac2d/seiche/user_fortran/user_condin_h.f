!                   ************************
                    SUBROUTINE USER_CONDIN_H
!                   ************************
!
!
!***********************************************************************
! TELEMAC2D   V7P3
!***********************************************************************
!
!brief    USER INITIALISES THE PHYSICAL PARAMETERS U, V
!
!history  J-M HERVOUET (LNHE)
!+        30/08/2007
!+        V6P0
!+
!
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
      USE BIEF
      USE DECLARATIONS_TELEMAC
      USE DECLARATIONS_TELEMAC2D
      USE TPXO
      USE OKADA
!
      USE DECLARATIONS_SPECIAL
      IMPLICIT NONE
!
!+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      INTEGER I
      DOUBLE PRECISION PI
!
!-----------------------------------------------------------------------
!
      PI = 4.D0*ATAN(1.D0)
!
      DO I=1,NPOIN
        H%R(I) = 10.D0+0.01D0*COS((2.D0*PI*X(I))/200.D0)
      ENDDO
!
!-----------------------------------------------------------------------
!
      RETURN
      END
