!                   ***************************
                    SUBROUTINE USER_MESH_TRANSF
!                   ***************************
!
!
!***********************************************************************
! TELEMAC3D
!***********************************************************************
!
!brief    DEFINES THE MESH TRANSFORMATION
!
!history  C.-T. PHAM (LNHE)
!+        24/03/2017
!+        V7P3
!+   Creation from not splitted CONDIM
!+   Called by CONDIM
!
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
      USE DECLARATIONS_TELEMAC3D
      USE INTERFACE_TELEMAC3D, EX_USER_MESH_TRANSF => USER_MESH_TRANSF
!
      IMPLICIT NONE
!
!-----------------------------------------------------------------------
!
      INTEGER IPLAN
!
!-----------------------------------------------------------------------
!
      DO IPLAN = 1,NPLAN
        TRANSF_PLANE%I(IPLAN)=1
      ENDDO
      TRANSF_PLANE%I(7)=3
      ZPLANE%R(7)=-4.D0
!
!-----------------------------------------------------------------------
!
      RETURN
      END
