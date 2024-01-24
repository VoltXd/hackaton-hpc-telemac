
"""
Validation script for island
"""
from vvytel.vnv_study import AbstractVnvStudy
from execution.telemac_cas import TelemacCas, get_dico
from data_manip.extraction.telemac_file import TelemacFile

class VnvStudy(AbstractVnvStudy):
    """
    Class for validation
    """

    def _init(self):
        """
        Defines the general parameter
        """
        self.rank = 1
        self.tags = ['telemac2d', 'fv']

    def _pre(self):
        """
        Defining the studies
        """

        # island scalar mode
        self.add_study('vnv_1',
                       'telemac2d',
                       't2d_island.cas')



    def _check_results(self):
        """
        Post-treatment processes
        """

        # Comparison with the last time frame of the reference file.
        self.check_epsilons('vnv_1:T2DRES',
                            'f2d_island.slf',
                            eps=[1.E-4])


    def _post(self):
        """
        Post-treatment processes
        """
        from postel.plot_vnv import vnv_plot1d_history, vnv_plot2d
                # Getting files
        vnv_1_t2dres = self.get_study_file('vnv_1:T2DRES')
        res_vnv_1_t2dres = TelemacFile(vnv_1_t2dres)
        vnv_1_t2dgeo = self.get_study_file('vnv_1:T2DGEO')
        res_vnv_1_t2dgeo = TelemacFile(vnv_1_t2dgeo)

        #TODO: Redo picture for documentation

        #Plotting FREE SURFACE on [9.3, 15], [10.5, 15], [13, 12.5] over records range(0, res_vnv_1_t2dres.ntimestep)
        vnv_plot1d_history(\
                'FREE SURFACE',
                res_vnv_1_t2dres,
                'FREE SURFACE',
                points=[[9.3, 15], [10.5, 15], [13, 12.5]],
                fig_size=(12, 5),
                fig_name='img/Gages6')


        #Plotting mesh
        vnv_plot2d('',
                   res_vnv_1_t2dgeo,
                   plot_mesh=True,
                   fig_size=(10, 10),
                   fig_name='img/Mesh')


        # Plotting BOTTOM at 0
        vnv_plot2d('BOTTOM',
                   res_vnv_1_t2dres,
                   record=0,
                   cbar_label='Bottom elevation (m)',
                   filled_contours=True,
                   fig_size=(10, 10),
                   fig_name='img/Bathy')


        # Plotting FREE SURFACE at -1
        vnv_plot2d('FREE SURFACE',
                   res_vnv_1_t2dres,
                   record=-1,
                   cbar_label='Free surface (m)',
                   filled_contours=True,
                   fig_size=(10, 10),
                   fig_name='img/FreeSurface')

        # Closing files
        res_vnv_1_t2dres.close()
        res_vnv_1_t2dgeo.close()
