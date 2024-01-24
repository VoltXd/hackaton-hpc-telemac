#!/usr/bin/env python3
"""
Example of a telapy telemac3d-waqtel run (test case heat_exchange)
"""
import sys
from os import path, chdir, environ, getcwd, makedirs
if(not path.exists(path.join(environ.get('HOMETEL', ''),
                             'builds',
                             environ.get('USETELCFG', ''),
                             'wrap_api', 'lib', 'api.pyf'))):
    print("  -> telapy not available doing nothing")
    sys.exit(0)

from telapy.api.t3d import Telemac3d
from execution.telemac_cas import TelemacCas
from mpi4py import MPI
import numpy as np

def vnv_copy_files(module, cas_file, par, cpl_mod=None, cpl_cas=None):
    """
    Copying input files into validation folder if HOMETEL and USETEL other wise
    running in cas folder

    @param module (str) Name of the module
    @param cas_file (str) steering file
    @param dist (str) Folder in which to copy (creates it if it does not exist)
    """

    if 'USETELCFG' in environ and 'HOMETEL' in environ:
        vnv_working_dir = path.join(getcwd(),
                                    'vnv_api',
                                    path.basename(__file__[:-3])+par,
                                    environ['USETELCFG'])

        # Creating folders if they do not exists
        if MPI.COMM_WORLD.Get_rank() == 0:
            if not path.exists(vnv_working_dir):
                print("  ~> Creating: ", vnv_working_dir)
                makedirs(vnv_working_dir)
            chdir(path.dirname(cas_file))
            dico_file = path.join(environ['HOMETEL'], 'sources', module,
                                  module+'.dico')
            cas = TelemacCas(cas_file, dico_file)

            cas.copy_cas_files(vnv_working_dir, copy_cas_file=True)

            del cas

            if cpl_cas is not None:
                chdir(path.dirname(cpl_cas))
                dico_file = path.join(environ['HOMETEL'], 'sources', cpl_mod,
                                      cpl_mod+'.dico')
                cas = TelemacCas(cpl_cas, dico_file)

                cas.copy_cas_files(vnv_working_dir, copy_cas_file=True)
                del cas
        MPI.COMM_WORLD.barrier()

    else:
        vnv_working_dir = path.dirname(cas_file)

    return vnv_working_dir


def main(recompile=True):
    """
    Main function of script

    @param recompile (Boolean) If True recompiling user fortran

    @retuns Value of ... at the end of the simulation
    """
    comm = MPI.COMM_WORLD

    root = environ.get('HOMETEL', path.join('..', '..', '..'))

    pwd = getcwd()

    cas_file = path.join(root, 'examples', 'waqtel', 'heat_exchange',
                         't3d_heat_exchange_rain_wind.cas')
    cpl_cas_file = path.join(root, 'examples', 'waqtel', 'heat_exchange',
                             'waq_steer.cas')

    ncsize = comm.Get_size()

    par = '-par' if ncsize > 1 else "-seq"

    vnv_working_dir = vnv_copy_files('telemac3d', cas_file, par,
                                     cpl_mod='waqtel',
                                     cpl_cas=cpl_cas_file)

    chdir(vnv_working_dir)

    # Creation of the instance Telemac3d
    study = Telemac3d('t3d_heat_exchange_rain_wind.cas',
                      user_fortran='user_fortran',
                      stdout=0,
                      comm=comm, recompile=recompile)

    # Testing construction of variable list
    _ = study.variables
    study.set_case()
    # Initalization
    study.init_state_default()
    # Run all time steps
    ntimesteps = study.get("MODEL.NTIMESTEPS")
    for _ in range(10):
        study.run_one_time_step()

        tmp = study.get_array("MODEL.IKLE")
        study.set_array("MODEL.IKLE", tmp)
        tmp2 = study.get_array("MODEL.IKLE")
        diff = abs(tmp2 - tmp)
        assert np.amax(diff) == 0

        tmp = study.mpi_get_array("MODEL.WATERDEPTH")
        study.mpi_set_array("MODEL.WATERDEPTH", tmp)
        tmp2 = study.mpi_get_array("MODEL.WATERDEPTH")
        diff = abs(tmp2 - tmp)
        assert np.amax(diff) < 1e-8
    # Ending the run
    study.finalize()
    # Instance delete
    del study
    chdir(pwd)

    return tmp2

if __name__ == "__main__":
    VAL1 = main()
    print("First run passed")
    VAL2 = main(recompile=False)
    print("Second run passed")
    assert np.array_equal(VAL1, VAL2)
    print("My work is done")
