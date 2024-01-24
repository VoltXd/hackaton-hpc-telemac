
"""
Validation script for tetra
"""
from vvytel.vnv_study import AbstractVnvStudy
from execution.telemac_cas import TelemacCas, get_dico

class VnvStudy(AbstractVnvStudy):
    """
    Class for validation
    """

    def _init(self):
        """
        Defines the general parameter
        """
        self.rank = 2
        self.tags = ['telemac3d', 'postel3d']

    def _pre(self):
        """
        Defining the studies
        """

        # tetra scalar mode
        self.add_study('vnv_1',
                       'telemac3d',
                       't3d_tetra.cas')


        # tetra parallel mode
        cas = TelemacCas('t3d_tetra.cas', get_dico('telemac3d'))
        cas.set('PARALLEL PROCESSORS', 4)

        self.add_study('vnv_2',
                       'telemac3d',
                       't3d_tetra_par.cas',
                       cas=cas)

        del cas

        # postel post-treatment
        self.add_study('p3d',
                       'postel3d',
                       'p3d_tetra.cas')



    def _check_results(self):
        """
        Post-treatment processes
        """

        # Comparison with the last time frame of the reference file.
        self.check_epsilons('vnv_1:T3DRES',
                            'f3d_tetra.slf',
                            eps=[1.E-10])

        # Comparison with the last time frame of the reference file.
        self.check_epsilons('vnv_2:T3DRES',
                            'f3d_tetra.slf',
                            eps=[1.E-10])

        # Comparison between sequential and parallel run.
        self.check_epsilons('vnv_1:T3DRES',
                            'vnv_2:T3DRES',
                            eps=[1.E-10])


    def _post(self):
        """
        Post-treatment processes
        """
        from postel.plot_vnv import vnv_plot2d, vnv_plot1d_polylines
        # Getting files
        res_vnv_1_t3dres, _ = self.get_study_res('vnv_1:T3DRES')
        res_vnv_1_t3dgeo, _ = self.get_study_res('vnv_1:T3DGEO', load_bnd=True, module="T3D")
        res_vnv_1_t3dhyd, _ = self.get_study_res('vnv_1:T3DHYD')

        #Plotting mesh
        vnv_plot2d('',
                   res_vnv_1_t3dgeo,
                   plot_mesh=True,
                   fig_size=(12, 3.5),
                   fig_name='img/MeshH',
                   annotate_bnd=True)

        #Plotting vertical mesh at initial time step along y
        vnv_plot2d('ELEVATION Z',
                   res_vnv_1_t3dres,
                   poly=[[0, 1.], [20.5, 1.]],
#                   x_label='y (m)',
                   y_label='z (m)',
                   record=0,
                   plot_mesh=True,
                   fig_size=(12, 3.5),
                   fig_name='img/MeshV')

        # Plotting BOTTOM over polyline
        vnv_plot1d_polylines('BOTTOM',
                             res_vnv_1_t3dhyd,
                             legend_labels='bottom',
                             poly=[[0., 1.], [20.5, 1.]],
                             record=-1,
                             fig_size=(12, 3.5),
                             fig_name='img/Profil')

        # Plotting horizontal slice of bottom elevation
        vnv_plot2d('ELEVATION Z',
                   res_vnv_1_t3dres,
                   plane=1,
                   record=0,
                   cbar_label='Bottom elevation (m)',
                   filled_contours=True,
                   fig_size=(12, 3.5),
                   fig_name='img/Bottom')

        # Plotting FREE SURFACE at final time step
        vnv_plot2d('ELEVATION Z',
                   res_vnv_1_t3dres,
                   plane=res_vnv_1_t3dres.nplan-1,
                   record=-1,
                   cbar_label='Free surface (m)',
                   filled_contours=True,
                   fig_size=(12, 3.5),
                   fig_name='img/FreeSurface')

        # Plotting VELOCITY at final time step
        vnv_plot2d('VELOCITY',
                   res_vnv_1_t3dres,
                   plane=res_vnv_1_t3dres.nplan-1,
                   record=-1,
                   filled_contours=True,
                   fig_size=(12, 3.5),
                   fig_name='img/Velocity',
                   cbar_label='Velocity (m/s)',
                   vectors=True,
                   vectors_scale=25)

        # Plotting vertical slice of vectors velocity
        vnv_plot2d('VELOCITY',
                   res_vnv_1_t3dres,
                   poly=[[0., 1], [20.5, 1]],
                   y_label='z (m)',
                   record=-1,
                   filled_contours=True,
                   vectors=True,
                   vectors_scale=30,
                   cbar_label='Velocity (m/s)',
                   fig_size=(12, 3.5),
                   fig_name='img/VelocityV')

        # Closing files
        res_vnv_1_t3dres.close()
        res_vnv_1_t3dgeo.close()
        res_vnv_1_t3dhyd.close()
