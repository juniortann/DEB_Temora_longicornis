function [par, metaPar, txtPar] = pars_init_Temora_longicornis(metaData)

metaPar.model = 'abp'; 

%% reference parameter (not to be changed) 
par.T_ref = 293.15;   free.T_ref = 0;   units.T_ref = 'K';        label.T_ref = 'Reference temperature'; 

food = 1;
specs = 0;
temps = 0;


%% core primary parameters 
par.T_A = 8102.9701;  free.T_A   = temps;   units.T_A = 'K';          label.T_A = 'Arrhenius temperature'; 
par.z = 0.20299;      free.z     = specs;   units.z = '-';            label.z = 'zoom factor'; 
par.F_m = 6.5;        free.F_m   = 0;   units.F_m = 'l/d.cm^2';   label.F_m = '{F_m}, max spec searching rate'; 
par.kap_X = 0.8;      free.kap_X = 0;   units.kap_X = '-';        label.kap_X = 'digestion efficiency of food to reserve'; 
par.kap_P = 0.7;      free.kap_P = 0;   units.kap_P = '-';        label.kap_P = 'faecation efficiency of food to faeces'; 
par.v = 0.024932;     free.v     = specs;   units.v = 'cm/d';         label.v = 'energy conductance'; 
par.kap = 0.91324;    free.kap   = specs;   units.kap = '-';          label.kap = 'allocation fraction to soma'; 
par.kap_R = 0.95;     free.kap_R = 0;   units.kap_R = '-';        label.kap_R = 'reproduction efficiency'; 
par.p_M = 204.806;    free.p_M   = specs;   units.p_M = 'J/d.cm^3';   label.p_M = '[p_M], vol-spec somatic maint'; 
par.p_T = 0;          free.p_T   = 0;   units.p_T = 'J/d.cm^2';   label.p_T = '{p_T}, surf-spec somatic maint'; 
par.k_J = 0.002;      free.k_J   = 0;   units.k_J = '1/d';        label.k_J = 'maturity maint rate coefficient'; 
par.E_G = 4316.4244;  free.E_G   = specs;   units.E_G = 'J/cm^3';     label.E_G = '[E_G], spec cost for structure'; 
par.E_Hb = 2.923e-04; free.E_Hb  = specs;   units.E_Hb = 'J';         label.E_Hb = 'maturity at birth'; 
par.E_Hp = 5.987e-02; free.E_Hp  = specs;   units.E_Hp = 'J';         label.E_Hp = 'maturity at puberty'; 
par.h_a = 3.816e-05;  free.h_a   = specs;   units.h_a = '1/d^2';      label.h_a = 'Weibull aging acceleration'; 
par.s_G = 0.0001;     free.s_G   = 0;   units.s_G = '-';          label.s_G = 'Gompertz stress coefficient'; 

%% other parameters 
par.E_Hj = 2.478e-03; free.E_Hj  = specs;   units.E_Hj = 'J';         label.E_Hj = 'maturity at metam'; 
par.T_AH = 7582.0587;  free.T_AH  = temps;   units.T_AH = 'K';         label.T_AH = 'Arrhenius temperature at upper boundary'; 
par.T_H = 309.7363;   free.T_H   = temps;   units.T_H = 'K';          label.T_H = 'upper boundary'; 
par.X_K_fR = 66.0683;  free.X_K_fR = food;   units.X_K_fR = 'mg.C.m^-3';  label.X_K_fR = 'half-saturation coefficient for f-R data'; 
par.X_K_tLX = 69.4857;  free.X_K_tLX = food;   units.X_K_tLX = 'mg.C.m^-3';  label.X_K_tLX = 'half-saturation coefficient for tLX data'; 
par.X_K_tpX = 97.2286;  free.X_K_tpX = food;   units.X_K_tpX = 'mg.C.m^-3';  label.X_K_tpX = 'half-saturation coefficient for tpX data'; 
par.del_M = 0.70832;  free.del_M = specs;   units.del_M = '-';        label.del_M = 'shape coefficient'; 
par.f = 1;            free.f     = 0;   units.f = '-';            label.f = 'scaled functional response for 0-var data'; 
par.f_100 = 1.1561;   free.f_100 = food;   units.f_100 = '-';        label.f_100 = 'scaled functional response for tW2 data'; 
par.f_200 = 1.2429;   free.f_200 = food;   units.f_200 = '-';        label.f_200 = 'scaled functional response for tW1 data'; 
par.f_25 = 0.66575;   free.f_25  = food;   units.f_25 = '-';         label.f_25 = 'scaled functional response for tW4 data'; 
par.f_50 = 1.065;     free.f_50  = food;   units.f_50 = '-';         label.f_50 = 'scaled functional response for tW3 data'; 
par.f_LW = 0.2;       free.f_LW  = food;   units.f_LW = '-';         label.f_LW = 'scaled functional response for LW data'; 
par.f_tL_Klei1999 = 0.72619;  free.f_tL_Klei1999 = food;   units.f_tL_Klei1999 = '-';  label.f_tL_Klei1999 = 'scaled functional response for Klei1999 tL data'; 
par.f_tL_Pete1994 = 0.87537;  free.f_tL_Pete1994 = food;   units.f_tL_Pete1994 = '-';  label.f_tL_Pete1994 = 'scaled functional response for Pete1994 tL data'; 
par.mu_X_JR = 159807.8979;  free.mu_X_JR = 0;   units.mu_X_JR = 'J/ mol';  label.mu_X_JR = 'chemical potential of food for JR data'; 
par.s_M = 20.8574;    free.s_M   = specs;   units.s_M = '-';          label.s_M = 'acceleration factor'; 

%% set chemical parameters from Kooy2010 
[par, units, label, free] = addchem(par, units, label, free, metaData.phylum, metaData.class); 

%% Pack output: 
txtPar.units = units; txtPar.label = label; par.free = free; 
