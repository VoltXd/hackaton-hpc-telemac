!                   *********************
                    SUBROUTINE DEALL_GAIA
!                   *********************
!
!
!***********************************************************************
! GAIA
!***********************************************************************
!
!>@brief    Memory deallocation of structures, aliases, blocks...
!
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!
      USE BIEF
      USE DECLARATIONS_SPECIAL
      USE DECLARATIONS_GAIA
!
      IMPLICIT NONE

!
!!-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
      INTEGER :: I,K
!
!!-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
!
!
      CALL OUTBIEF(MESH)
!     Deallocate the mesh structure
      CALL DEALMESH(MESH)

      NULLIFY(IKLE)
      NULLIFY(X)
      NULLIFY(Y)
      NULLIFY(NELEM)
      NULLIFY(NELMAX)
      NULLIFY(NPTFR)
      NULLIFY(NPTFRX)
      NULLIFY(TYPELM)
      NULLIFY(NPOIN)
      NULLIFY(NPMAX)
      NULLIFY(MXPTVS)
      NULLIFY(LV)
!


      CALL BIEF_DEALLOBJ(VARSOR)
!     Deallocating all the blocks first
      CALL BIEF_DEALLOBJ(S     )
      CALL BIEF_DEALLOBJ(E     )
      CALL BIEF_DEALLOBJ(Z     )
      CALL BIEF_DEALLOBJ(ESOMT )
      CALL BIEF_DEALLOBJ(CUMBE )
      CALL BIEF_DEALLOBJ(EMAX  )
      CALL BIEF_DEALLOBJ(EVOL_MB)
      CALL BIEF_DEALLOBJ(EVOL_MS)
      CALL BIEF_DEALLOBJ(EVOL_MM)
      CALL BIEF_DEALLOBJ(Q     )
      CALL BIEF_DEALLOBJ(QU    )
      CALL BIEF_DEALLOBJ(QV    )
      CALL BIEF_DEALLOBJ(U2D   )
      CALL BIEF_DEALLOBJ(V2D   )
      CALL BIEF_DEALLOBJ(THETAC)
      CALL BIEF_DEALLOBJ(QS    )
      CALL BIEF_DEALLOBJ(QSX   )
      CALL BIEF_DEALLOBJ(QSY   )
      CALL BIEF_DEALLOBJ(QS_C  )
      CALL BIEF_DEALLOBJ(QSXC  )
      CALL BIEF_DEALLOBJ(QSYC  )
      CALL BIEF_DEALLOBJ(HIDING)
      CALL BIEF_DEALLOBJ(ZF    )
      CALL BIEF_DEALLOBJ(ZR    )
      CALL BIEF_DEALLOBJ(RADSEC)
      CALL BIEF_DEALLOBJ(ZREF  )
      CALL BIEF_DEALLOBJ(COEFPN)
      CALL BIEF_DEALLOBJ(COEFCR)
      CALL BIEF_DEALLOBJ(CF    )
      CALL BIEF_DEALLOBJ(TOB   )
      CALL BIEF_DEALLOBJ(TOBW  )
      CALL BIEF_DEALLOBJ(TOBCW_MEAN)
      CALL BIEF_DEALLOBJ(TOBCW_MAX)
      CALL BIEF_DEALLOBJ(TAUP  )
      CALL BIEF_DEALLOBJ(MU    )
      CALL BIEF_DEALLOBJ(KSP   )
      CALL BIEF_DEALLOBJ(KS    )
      CALL BIEF_DEALLOBJ(KSR   )
      IF(KSCALC) CALL BIEF_DEALLOBJ(KS_T0)
      CALL BIEF_DEALLOBJ(THETAW)
      CALL BIEF_DEALLOBJ(FW    )
      CALL BIEF_DEALLOBJ(UW    )
      CALL BIEF_DEALLOBJ(SURF_ENG)
      CALL BIEF_DEALLOBJ(SURF_DIS)
      CALL BIEF_DEALLOBJ(HW    )
      CALL BIEF_DEALLOBJ(TW    )
      CALL BIEF_DEALLOBJ(ACLADM)
      CALL BIEF_DEALLOBJ(UNLADM)
      CALL BIEF_DEALLOBJ(HCPL  )
      CALL BIEF_DEALLOBJ(ECPL  )
      CALL BIEF_DEALLOBJ(ELAY  )
      CALL BIEF_DEALLOBJ(ESTRAT)
      CALL BIEF_DEALLOBJ(KX    )
      CALL BIEF_DEALLOBJ(KY    )
      CALL BIEF_DEALLOBJ(KZ    )
      ! Was pointing on UCONV_TEL
      IF(CONV_GAI_POINTER) THEN
        UCONV_GAI%R => NULL()
        VCONV_GAI%R => NULL()
        ALLOCATE(UCONV_GAI%R(1))
        ALLOCATE(VCONV_GAI%R(1))
      ENDIF
      CALL BIEF_DEALLOBJ(UCONV_GAI)
      CALL BIEF_DEALLOBJ(VCONV_GAI)
      CALL BIEF_DEALLOBJ(UNORM )
      CALL BIEF_DEALLOBJ(MASKB )
      CALL BIEF_DEALLOBJ(MASK  )
      CALL BIEF_DEALLOBJ(AFBOR )
      CALL BIEF_DEALLOBJ(BFBOR )
      CALL BIEF_DEALLOBJ(FLBOR )
      CALL BIEF_DEALLOBJ(Q2BOR )
!     BOUNDARY FLUX FOR CALL TO CVDFTR
      CALL BIEF_DEALLOBJ(FLBOR_GAI )
      CALL BIEF_DEALLOBJ(FLBORTRA  )
      CALL BIEF_DEALLOBJ(CSTAEQ)
!     MAK ADDITION
      CALL BIEF_DEALLOBJ(CSRATIO)
      CALL BIEF_DEALLOBJ(HN    )
      CALL BIEF_DEALLOBJ(HPROP )
      CALL BIEF_DEALLOBJ(VOLU2D)
      CALL BIEF_DEALLOBJ(V2DPAR)
      CALL BIEF_DEALLOBJ(UNSV2D)
      CALL BIEF_DEALLOBJ(MPM_ARAY)
      CALL BIEF_DEALLOBJ(FLULIM_GAI)

      ! MSK
      CALL BIEF_DEALLOBJ(MASKEL)
      CALL BIEF_DEALLOBJ(MSKTMP)
      CALL BIEF_DEALLOBJ(MASKPT)
!     FOR MIXED SEDIMENTS
      CALL BIEF_DEALLOBJ(MS_SABLE   )
      CALL BIEF_DEALLOBJ(MS_VASE    )
      CALL BIEF_DEALLOBJ( LIEBOR)
      CALL BIEF_DEALLOBJ( LIQBOR)
      CALL BIEF_DEALLOBJ( LIMTEC)
      CALL BIEF_DEALLOBJ( NUMLIQ)
      CALL BIEF_DEALLOBJ( CLT   )
      CALL BIEF_DEALLOBJ( CLU   )
      CALL BIEF_DEALLOBJ( CLV   )
      CALL BIEF_DEALLOBJ( LIMDIF)
      CALL BIEF_DEALLOBJ( LIHBOR)
      CALL BIEF_DEALLOBJ( BOUNDARY_COLOUR)
      CALL BIEF_DEALLOBJ( LIMPRO)
      CALL BIEF_DEALLOBJ( IT1   )
      CALL BIEF_DEALLOBJ( IT2   )
      CALL BIEF_DEALLOBJ( IT3   )
      CALL BIEF_DEALLOBJ( IT4   )
! NUMBER OF LAYERS
      CALL BIEF_DEALLOBJ( NLAYER)
      CALL BIEF_DEALLOBJ(BREACH)
      CALL BIEF_DEALLOBJ(IFAMAS)

      DEALLOCATE(AVAIL)
      DEALLOCATE(ES)
      DEALLOCATE(M2T)
      DEALLOCATE(MPA2T)

      DEALLOCATE(IVIDE)

      DEALLOCATE(SANFRA)

      CALL BIEF_DEALLOBJ(MASKTR)
      CALL BIEF_DEALLOBJ(EBOR  )
      CALL BIEF_DEALLOBJ(QBOR  )
      DO K=1,NOMBLAY
        ALLOCATE(LAYTHI%ADR(K)%P%R(1))
      ENDDO
      CALL BIEF_DEALLOBJ(LAYTHI)
      CALL BIEF_DEALLOBJ(LAYCONC)
      CALL BIEF_DEALLOBJ(MTRANSFER)
      CALL BIEF_DEALLOBJ(TOCEMUD)
      CALL BIEF_DEALLOBJ(PARTHE)
!
      CALL BIEF_DEALLOBJ(QSCL  )
      CALL BIEF_DEALLOBJ(QSCL_C)
      CALL BIEF_DEALLOBJ(QSCLXC)
      CALL BIEF_DEALLOBJ(QSCLYC)
      CALL BIEF_DEALLOBJ(MUDB)
      CALL BIEF_DEALLOBJ(F_MUDB)
!
      CALL BIEF_DEALLOBJ(QSCL_S)
      CALL BIEF_DEALLOBJ(ZFCL_C)
      CALL BIEF_DEALLOBJ(FLUDP )
      CALL BIEF_DEALLOBJ(FLUDPT)
      CALL BIEF_DEALLOBJ(FLUER )
      CALL BIEF_DEALLOBJ(FLUERT)
!
      CALL BIEF_DEALLOBJ(ZFCL_MS)
      CALL BIEF_DEALLOBJ(EVCL_MB)
      CALL BIEF_DEALLOBJ(CALFA_CL)
      CALL BIEF_DEALLOBJ(SALFA_CL)
      CALL BIEF_DEALLOBJ(FLBCLA)
      ! Parallel to what was done in point_gaia
      CALL BIEF_DEALLOBJ(RATIOS)
      CALL BIEF_DEALLOBJ(MASS_S)
      CALL BIEF_DEALLOBJ(RATIOM)
      CALL BIEF_DEALLOBJ(MASS_M)

      CALL BIEF_DEALLOBJ(MBOR )

      CALL BIEF_DEALLOBJ( W1 )
      CALL BIEF_DEALLOBJ( TE1)
      CALL BIEF_DEALLOBJ( TE2)
      CALL BIEF_DEALLOBJ( TE3)

      CALL BIEF_DEALLOBJ(VARCL)
      CALL BIEF_DEALLOBJ(PRIVE)
      CALL BIEF_DEALLOBJ(TB   )

      IF(NADVAR.GT.0) THEN
        CALL BIEF_DEALLOBJ(ADVAR )
      ENDIF
!  to check: all variables of new model deallocated?
!
      DEALLOCATE(RATIO_MUD_SAND)
      DEALLOCATE(MASS_SAND)
      DEALLOCATE(MASS_MUD)
      DEALLOCATE(MASS_MUD_TOT)
      DEALLOCATE(MASS_SAND_TOT)
      DEALLOCATE(MASS_MIX_TOT)
      DEALLOCATE(RATIO_SAND)
      DEALLOCATE(RATIO_MUD)
      DEALLOCATE(RATIO_DEBIMP)
      DEALLOCATE(TOCE_SAND)
      DEALLOCATE(TOCE_MUD)
      DEALLOCATE(CONC_MUD)
      DEALLOCATE(TRANS_MASS)
      DEALLOCATE(PARTHENIADES)
      DEALLOCATE(QER_MUD)
      DEALLOCATE(QER_SAND)
      DEALLOCATE(TIME)
      DEALLOCATE(TOCE_MIX)
      DEALLOCATE(CAE_ILAY)
      DEALLOCATE(QE_MOY)
      DEALLOCATE(FLUER_PUR_MUD)
      DEALLOCATE(FLUER_PUR_SAND)
      DEALLOCATE(FLUER_MIX)
      DEALLOCATE(CONC_MUD_ACTIV_TEMPO)
      DEALLOCATE(MASS_MUD_ACTIV_TEMPO)
      DEALLOCATE(MASS_SAND_ACTIVE_LAYER)
      DEALLOCATE(MASS_SAND_MASKED)
      DEALLOCATE(EVCL_M_TOT_SAND)
      DEALLOCATE(RATIO_EVOL_TOT_SAND)
      DEALLOCATE(FLUX_MASS_MUD)
      DEALLOCATE(FLUX_MASS_MUD_TOT)
      DEALLOCATE(FLUX_MASS_SAND)
      DEALLOCATE(NUM_TRANSF)
      DEALLOCATE(FLUX_NEG_MUD_ACTIV_LAYER)
      DEALLOCATE(FLUX_NEG_SAND_ACTIV_LAYER)
      DEALLOCATE(FLUX_POS_MUD_ACTIV_LAYER)
      DEALLOCATE(FLUX_POS_SAND_ACTIV_LAYER)
      IF(BILMA) THEN
        DEALLOCATE(BEDLOAD_B_FLUX)
        DEALLOCATE(SUMBEDLOAD_B)
      ENDIF
      IF(BILMA.OR.VSMTYPE==1) THEN
        DEALLOCATE(MCUMUCLA)
      ENDIF
!
      ! Resetting variable
      INIT_FLUXPR = .TRUE.
      IF(DEJA_RFC) THEN
        DEJA_RFC = .FALSE.
        DEALLOCATE(INFIC_RFC)
        DEALLOCATE(TIME_RFC)
      ENDIF
      IF(DEJA_FLUSEC) THEN
        DEJA_FLUSEC = .FALSE.
        OLD_METHOD_FLUSEC = .FALSE.
        DEALLOCATE(NSEG)
        DEALLOCATE(LISTE)
        DEALLOCATE(VOLNEGS)
        DEALLOCATE(VOLPOSS)
        DEALLOCATE(VOLNEGC)
        DEALLOCATE(VOLPOSC)
        DEALLOCATE(FLX)
        DEALLOCATE(VOLNEG)
        DEALLOCATE(VOLPOS)
        DEALLOCATE(FLXS)
        DEALLOCATE(FLXC)
      ENDIF
      IF(DEJA_FLUSEC2) THEN
        OLD_METHOD_FLUSEC = .FALSE.
        DEJA_FLUSEC2 = .FALSE.
        DO I = 1,NUMBEROFLINES_FLUSEC2
          DEALLOCATE(FLUXLINEDATA_FLUSEC2(I)%SECTIONIDS)
          DEALLOCATE(FLUXLINEDATA_FLUSEC2(I)%DIRECTION)
        ENDDO
        DEALLOCATE(FLUXLINEDATA_FLUSEC2)
        DEALLOCATE(FLUX_FLUSEC2)
        DEALLOCATE(VOLFLUX_FLUSEC2)
      ENDIF

      ! from lecdon
      DEALLOCATE(SOLDIS)
      DEALLOCATE(OKCGL)
      DEALLOCATE(OKQGL)
      DEALLOCATE(CTRLSC)
      ! from lecdon_gaia
      IF (BILMA) THEN
        DEALLOCATE(SUMBEDLOAD_B_FLUX)
      ENDIF

      ! from lecdon_telemac2d_gaia and lecdon_telemac3d_gaia
      IF (ALLOCATED(SCHADVSED)) THEN
        DEALLOCATE(SCHADVSED)
        DEALLOCATE(OPTADV_SED)
        DEALLOCATE(SLVSED)
        DEALLOCATE(SED0)
        DEALLOCATE(PRESED)
        DEALLOCATE(SEDSCE)
      ENDIF
      IF (ALLOCATED(VERPROSED)) THEN
        DEALLOCATE(VERPROSED)
        DEALLOCATE(DNUSEDH)
        DEALLOCATE(DNUSEDV)
      ENDIF


      DEALLOCATE(TYPE_SED)
      DEALLOCATE(NUM_IMUD_ICLA)
      DEALLOCATE(NUM_ICLA_IMUD)
      DEALLOCATE(NUM_ISAND_ICLA)
      DEALLOCATE(NUM_ICLA_ISAND)
      DEALLOCATE(NUM_ISUSP_ICLA)
!
!-----------------------------------------------------------------------
!
!=======================================================================
!
! WRITES OUT TO LISTING :
!
!      IF(LISTIN) THEN
!        IF(LNG.EQ.1) WRITE(LU,22)
!        IF(LNG.EQ.2) WRITE(LU,23)
!      ENDIF
!22    FORMAT(1X,///,21X,'****************************************',/,
!     &21X,              '* FIN DE LA DEALLOCATION DE LA MEMOIRE  : *',/,
!     &21X,              '****************************************',/)
!23    FORMAT(1X,///,21X,'*************************************',/,
!     &21X,              '*    END OF MEMORY ORGANIZATION:    *',/,
!     &21X,              '*************************************',/)
!
!-----------------------------------------------------------------------
!
      RETURN
      END SUBROUTINE DEALL_GAIA
