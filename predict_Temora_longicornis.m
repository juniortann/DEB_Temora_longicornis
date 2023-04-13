function [prdData, info] = predict_Temora_longicornis(par, data, auxData)
  
  % unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);
  
  % compute temperature correction factors
  TC_ab = tempcorr(temp.ab, T_ref, T_A);
  TC_tp = tempcorr(temp.tp, T_ref, T_A);
  TC_am = tempcorr(temp.am, T_ref, T_A);
  TC_Ri = tempcorr(temp.Ri, T_ref, T_A);
  TC_JR = tempcorr(temp.JR, T_ref, T_A);
  TC_tW = tempcorr(temp.tW1, T_ref, T_A);
%   TC_fR1 = tempcorr(temp.fR1, T_ref, T_A);
%   TC_fR2 = tempcorr(temp.fR2, T_ref, T_A);
%   TC_fR3 = tempcorr(temp.fR3, T_ref, T_A);
%   TC_fR4 = tempcorr(temp.fR4, T_ref, T_A);
%   TC_fR5 = tempcorr(temp.fR5, T_ref, T_A);
  
  
  % zero-variate data

  % life cycle
  pars_tj = [g k l_T v_Hb v_Hj];
  [t_j, t_b, l_j, l_b] = get_tp(pars_tj, f);
  pars_tp = [g k l_T v_Hb v_Hp]; 
  [t_p, t_b, l_p, l_b, info] = get_tp(pars_tp, f); % overwrite t_p, l_p
  
  % initial (used in R_i)
  pars_UE0 = [V_Hb; g; k_J; k_M; v]; % compose parameter vector
  E_0 = p_Am * initial_scaled_reserve(f, pars_UE0); % J, initial reserve

  % birth (start of acceleration)
  L_b = L_m * l_b;                  % cm, structural length at birth at f
  Lw_b = 10 * L_b/ del_M;           % mm, total length at birth at f
  Wd_b = 1e6 * L_b^3 * d_V * (1 + f * w); % mug, dry weight at birth
  aT_b = t_0 + t_b/ k_M/ TC_ab;     % d, age at birth at T

  % metam (morphological only)
  L_j = L_m * l_j;                  % cm, structural length at metam
  Lw_j = 10 * L_j/ del_M;           % mm, total length at metam at f
  Wd_j = 1e6 * L_j^3 * d_V * (1 + f * w); % mug, dry weight at metam
  
  % puberty (end of acceleration and growth and kappa-rule)
  L_p = L_m * l_p;                  % cm, structural length at puberty at f
  Lw_p = 10 * L_p/ del_M;           % mm, total length at puberty at f
  tT_p = (t_p - t_b)/ k_M/ TC_tp;   % d, time since birth at puberty at f and T
  Wd_p = 1e6 * L_p^3 * d_V * (1 + f * w); % mug, dry weight at puberty 
 
  % reproduction (no kappa-rule)
  R_i = kap_R * (p_Am * L_p^2 - p_M * L_p^3 - k_J * E_Hp)/ E_0; % #/d, ultimate reproduction rate at T_ref
  RT_i = TC_Ri * R_i; % 1/d, reprod at T

  % life span
  h3_W = f * h_a * v/ 6/ L_b; % 1/d^3, cubed Weibull ageing rate
  a_m = gamma(4/3)/ h3_W^(1/3); % d, mean life span at T_ref
  aT_m = a_m/ TC_am;           % d, mean life span at T
  
  % pack to output
  prdData.ab = aT_b;
  prdData.tp = tT_p;
  prdData.am = aT_m;
  prdData.Lb = Lw_b;
  prdData.Lj = Lw_j;
  prdData.Lp = Lw_p;
  prdData.Li = Lw_p;
  prdData.Wdb = Wd_b;
  prdData.Wdj = Wd_j;
  prdData.Wdp = Wd_p;
  prdData.Wdi = Wd_p;
  prdData.Ri = RT_i;
  
  % uni-variate data
   
  % L-W data
  EWd_L = 1e6 * (LW(:,1) * del_M / 10).^3 * d_V * (1 + f_LW * w); % mug, dry weight
   
  % L-R data
  %ER  = reprod_rate_j(LR(:,1) .* del_M ./ 10000, 1, pars_R) .* TC_LR;    % #/ d, temperature corrected reproduction rate
  % MAYBE INTRODUCE F VALUE HERE AS WELL!!!!!
   
  % t-W data; we neglect maternal effects
  % f_200
  [l_p, l_b] = get_lp(pars_tp, f_200); 
  L_b = L_m * l_b; L_p = L_m * l_p; L_i = L_m * f_200;
  kT_M = TC_tW * k_M; rT_B = kT_M/ 3/ (1 + w * f_200/ g); % 1/d, von Bert growth rate
  L = min(L_p, L_i - (L_i - L_b) * exp( - rT_B * tW1(:,1))); % cm, predicted length at time
  EWd_1 = 1e6 * L.^3 * (1 + f_200 * w) * d_V;               % mug, dry weight 
  % f_100
  [l_p, l_b] = get_lp(pars_tp, f_100); 
  L_b = L_m * l_b; L_p = L_m * l_p; L_i = L_m * f_100;
  rT_B = kT_M/ 3/ (1 + w * f_100/ g); % 1/d, von Bert growth rate
  L = min(L_p, L_i - (L_i - L_b) * exp( - rT_B * tW2(:,1)));    % cm, predicted length at time
  EWd_2 = 1e6 * L.^3 * (1 + f_100 * w) * d_V;               % mug, dry weight 
  % f_50
  [l_p, l_b] = get_lp(pars_tp, f_50); 
  L_b = L_m * l_b; L_p = L_m * l_p; L_i = L_m * f_50;
  rT_B = kT_M/ 3/ (1 + w * f_50/ g); % 1/d, von Bert growth rate
  L = min(L_p, L_i - (L_i - L_b) * exp( - rT_B * tW3(:,1)));    % cm, predicted length at time
  EWd_3 = 1e6 * L.^3 * (1 + f_50 * w) * d_V;               % mug, dry weight 
  % f_25
  [l_p, l_b] = get_lp(pars_tp, f_25); 
  L_b = L_m * l_b; L_p = L_m * l_p; L_i = L_m * f_25;
  rT_B = kT_M/ 3/ (1 + w * f_25/ g); % 1/d, von Bert growth rate
  L = min(L_p, L_i - (L_i - L_b) * exp( - rT_B * tW4(:,1)));    % cm, predicted length at time
  EWd_4 = 1e6 * L.^3 * (1 + f_25 * w) * d_V;               % mug, dry weight 
  
  % ingestion rate -reproduction rate as C (DamLope2003 calculated ingestion rate)
  % first convert mug C/d to J/d, ingested energy to assimilated energy, subtract maint, convert back to mug C/d. 
  EJT_C = (kap_X * mu_X * JR(:,1) * 1e-6/12 - TC_JR * k_J * E_Hp - TC_JR * p_M * L_p^3) * kap_R/ mu_E * 12e6; % mug/d, egg production as C
  
  %maybe transform ingestion rate to f-value with "f * pAm * L^2"
  %and then calculate reproduction rate
  
%   % f-R data
%   
%   % f-R1
%   %f_X = fR1(:,1) * f_fR1 / min(fR1(:,1));
%   f_X = f_fR1 * fR1(:,1) ./ (K_fR + fR1(:,1));
%   %f_X = fR1(:,1) ./ (K_fR + fR1(:,1));
%   pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp]; % compose parameter vector at T
%   Rf_1 = zeros(length(f_X),1);
%   for i = 1:length(f_X)
%       Rf_1(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R) * TC_fR1; % #/d, ultimate reproduction rate
%   end
%   
%   % f-R2
%   %f_X = fR2(:,1) * f_fR2 / min(fR2(:,1));
%   f_X = f_fR2 * fR2(:,1) ./ (K_fR + fR2(:,1));
%   %f_X = fR2(:,1) ./ (K_fR + fR2(:,1));
%   pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp]; % compose parameter vector at T
%   Rf_2 = zeros(length(f_X),1);
%   for i = 1:length(f_X)
%       Rf_2(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R) * TC_fR2; % #/d, ultimate reproduction rate
%   end
%   
%   % f-R3
%   %f_X = fR3(:,1) * f_fR3 / min(fR3(:,1));
%   f_X = f_fR3 * fR3(:,1) ./ (K_fR + fR3(:,1));
%   %f_X = fR3(:,1) ./ (K_fR + fR3(:,1));
%   pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp]; % compose parameter vector at T
%   Rf_3 = zeros(length(f_X),1);
%   for i = 1:length(f_X)
%       Rf_3(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R) * TC_fR3; % #/d, ultimate reproduction rate
%   end
%   
%   % f-R4
%   %f_X = fR4(:,1) * f_fR4 / min(fR4(:,1));
%   f_X = f_fR4 * fR4(:,1) ./ (K_fR + fR4(:,1));
%   %f_X = fR4(:,1) ./ (K_fR + fR4(:,1));
%   pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp]; % compose parameter vector at T
%   Rf_4 = zeros(length(f_X),1);
%   for i = 1:length(f_X)
%       Rf_4(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R) * TC_fR4; % #/d, ultimate reproduction rate
%   end
%   
%   % f-R5
%   %f_X = fR5(:,1) * f_fR5 / min(fR5(:,1));
%   f_X = f_fR5 * fR5(:,1) ./ (K_fR + fR5(:,1));
%   %f_X = fR5(:,1) ./ (K_fR + fR5(:,1));
%   pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp]; % compose parameter vector at T
%   Rf_5 = zeros(length(f_X),1);
%   for i = 1:length(f_X)
%       Rf_5(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R) * TC_fR5; % #/d, ultimate reproduction rate
%   end
%   
  
    
 
  prdData.LW = EWd_L;
  %prdData.LR = ER;
  prdData.tW1 = EWd_1;
  prdData.tW2 = EWd_2;
  prdData.tW3 = EWd_3;
  prdData.tW4 = EWd_4;
  prdData.JR  = EJT_C;
%   prdData.fR1 = Rf_1;
%   prdData.fR2 = Rf_2;
%   prdData.fR3 = Rf_3;
%   prdData.fR4 = Rf_4;
%   prdData.fR5 = Rf_5;
  