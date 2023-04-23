function [prdData, info] = predict_Temora_longicornis(par, data, auxData)
  
  % unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);

  % customized filters to constrain additional parameters 
  filterChecks =    f_100 > 1.5         ||...
                    f_200 > 1.5         ||...
                    f_25 > 1.5          ||...
                    f_50 > 1.5          ||...
                    f_tL_Klei1999 > 1.5 ||...
                    f_tL_Pete1994 > 1.5 ||...
                    f_LW < 0.2          ||...
                    s_M < 1             ...
                    ; 

  if filterChecks  
    info = 0;
    prdData = [];
    return;
  end  

  % compute temperature correction factors
  pars_TC = [T_A; T_H; T_AH];
  TC_ab = tempcorr(temp.ab, T_ref, T_A);
  TC_tp = tempcorr(temp.tp, T_ref, T_A);
  TC_am = tempcorr(temp.am, T_ref, T_A);
  TC_Ri = tempcorr(temp.Ri, T_ref, T_A);
  TC_JR = tempcorr(temp.JR, T_ref, T_A);
  TC_tW = tempcorr(temp.tW1, T_ref, T_A);
  TC_tL_Klei1999 = tempcorr(temp.tL_Klei1999, T_ref, T_A);
  TC_tL_Pete1994 = tempcorr(temp.tL_Pete1994, T_ref, T_A);
  TC_tLX = tempcorr(temp.tLX_2080, T_ref, T_A);
  TC_tpX_5C = tempcorr(temp.tpX_5C, T_ref, pars_TC);
  TC_tpX_10C = tempcorr(temp.tpX_10C, T_ref, pars_TC);
  TC_tpX_15C = tempcorr(temp.tpX_15C, T_ref, pars_TC);
  TC_tpX_20C = tempcorr(temp.tpX_20C, T_ref, pars_TC);
  TC_LR = tempcorr(temp.LR, T_ref, T_A);
  TC_fR_2C = tempcorr(temp.fR_2C, T_ref, pars_TC);
  TC_fR_6C = tempcorr(temp.fR_6C, T_ref, pars_TC);
  TC_fR_10C = tempcorr(temp.fR_10C, T_ref, pars_TC);
  TC_fR_14C = tempcorr(temp.fR_14C, T_ref, pars_TC);
  TC_fR_18C = tempcorr(temp.fR_18C, T_ref, pars_TC);
  
  
  % zero-variate data

  % life cycle
  pars_tj = [g k l_T v_Hb v_Hj v_Hp];
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f);
  
  % initial (used in R_i)
  pars_UE0 = [V_Hb; g; k_J; k_M; v];                                                            % compose parameter vector
  E_0 = p_Am * initial_scaled_reserve(f, pars_UE0);                                             % J, initial reserve

  % birth (start of acceleration)
  L_b = L_m * l_b;                                                                              % cm, structural length at birth at f
  Lw_b = L_b/ del_M;                                                                            % cm, total length at birth at f
  Wd_b = 1e6 * L_b^3 * d_V * (1 + f * w);                                                       % mug, dry weight at birth
  aT_b = t_b/ k_M/ TC_ab;                                                                       % d, age at birth at T

  % metam (morphological only)
  L_j = L_m * l_j;                                                                              % cm, structural length at metam
  Lw_j = L_j/ del_M;                                                                            % cm, total length at metam at f
  Wd_j = 1e6 * L_j^3 * d_V * (1 + f * w);                                                       % mug, dry weight at metam
 
  
  % % metamorphosis(= end acceleration)
  % s_M = l_j/ l_s;                     % -, acceleration factor


  % puberty (end of acceleration and growth and kappa-rule)
  L_p = L_m * l_p;                                                                              % cm, structural length at puberty at f
  Lw_p = L_p/ del_M;                                                                            % cm, total length at puberty at f
  tT_p = (t_p - t_b)/ k_M/ TC_tp;                                                               % d, time since birth at puberty at f and T
  Wd_p = 1e6 * L_p^3 * d_V * (1 + f * w);                                                       % mug, dry weight at puberty 

  % reproduction (no kappa-rule)
  R_i = kap_R * (p_Am * L_p^2 - p_M * L_p^3 - k_J * E_Hp)/ E_0;                                 % #/d, ultimate reproduction rate at T_ref
  RT_i = TC_Ri * R_i; % 1/d, reprod at T

  % life span
  h3_W = f * h_a * v/ 6/ L_b;                                                                   % 1/d^3, cubed Weibull ageing rate
  a_m = gamma(4/3)/ h3_W^(1/3);                                                                 % d, mean life span at T_ref
  aT_m = a_m/ TC_am;                                                                            % d, mean life span at T
  
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
  
  % Time-length Klei1999
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tL_Klei1999);
  kT_M = k_M * TC_tL_Klei1999;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tL_Klei1999(tL_Klei1999(:,1) < tT_j,1)/ 3);                           % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tL_Klei1999(tL_Klei1999(:,1) >= tT_j,1)- tT_j));    % cm, struc length
  ELw_Klei1999 = [L_bj; L_ji]/ del_M;                                                           % cm, phys body length

  
  % Time-length Pete1994
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tL_Pete1994);
  kT_M = k_M * TC_tL_Pete1994;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tL_Pete1994(tL_Pete1994(:,1) < tT_j,1)/ 3);                           % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tL_Pete1994(tL_Pete1994(:,1) >= tT_j,1)- tT_j));    % cm, struc length
  ELw_Pete1994 = [L_bj; L_ji]/ del_M;                                                           % cm, phys body length

  % Time-Length - food (tLX)
  % Food concentration level 4 (Klei1982b) 
  X_2080 = 2080.01;                                                                             % mug.C.l^-1, food concentration
  f_tLX_2080 = X_2080 / (X_K_tLX + X_2080);                                                     % -, functional response

  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tLX_2080);
  kT_M = k_M * TC_tLX;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tLX_2080(tLX_2080(:,1) < tT_j,1)/ 3);                                 % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tLX_2080(tLX_2080(:,1) >= tT_j,1)- tT_j));          % cm, struc length
  ELw_tLX_2080 = [L_bj; L_ji]/ del_M;                                                           % cm, phys length

  % Food concentration level 2 (Klei1982b) 
  X_1398 = 1398.78;                                                                             % mug.C.l^-1, food concentration
  f_tLX_1398 = X_1398 / (X_K_tLX + X_1398);                                                     % -, functional response

  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tLX_1398);
  kT_M = k_M * TC_tLX;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tLX_1398(tLX_1398(:,1) < tT_j,1)/ 3);                                 % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tLX_1398(tLX_1398(:,1) >= tT_j,1)- tT_j));          % cm, struc length
  ELw_tLX_1398 = [L_bj; L_ji]/ del_M;                                                           % cm, phys length

  % Food concentration level 1 (Klei1982b) 
  X_478 = 478.74;                                                                               % mug.C.l^-1, food concentration
  f_tLX_478 = X_478 / (X_K_tLX + X_478);                                                        % -, functional response

  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tLX_478);
  kT_M = k_M * TC_tLX;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tLX_478(tLX_478(:,1) < tT_j,1)/ 3);                                   % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tLX_478(tLX_478(:,1) >= tT_j,1)- tT_j));            % cm, struc length
  ELw_tLX_478 = [L_bj; L_ji]/ del_M;                                                            % cm, phys length

  % Food concentration level 1/2 (Klei1982b) 
  X_300 = 300.75;                                                                               % mug.C.l^-1, food concentration
  f_tLX_300 = X_300 / (X_K_tLX + X_300);                                                        % -, functional response

  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tLX_300);
  kT_M = k_M * TC_tLX;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tLX_300(tLX_300(:,1) < tT_j,1)/ 3);                                   % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tLX_300(tLX_300(:,1) >= tT_j,1)- tT_j));            % cm, struc length
  ELw_tLX_300 = [L_bj; L_ji]/ del_M;                                                            % cm, phys length

  % Food concentration level 1/4 (Klei1982b) 
  X_165 = 165.19;                                                                               % mug.C.l^-1, food concentration
  f_tLX_165 = X_165 / (X_K_tLX + X_165);                                                        % -, functional response

  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tLX_165);
  kT_M = k_M * TC_tLX;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tLX_165(tLX_165(:,1) < tT_j,1)/ 3);                                   % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tLX_165(tLX_165(:,1) >= tT_j,1)- tT_j));            % cm, struc length
  ELw_tLX_165 = [L_bj; L_ji]/ del_M;                                                            % cm, phys length

  % Food concentration level 1/8 (Klei1982b) 
  X_92 = 92.84;                                                                                 % mug.C.l^-1, food concentration
  f_tLX_92 = X_92 / (X_K_tLX + X_92);                                                           % -, functional response

  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tLX_92);
  kT_M = k_M * TC_tLX;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tLX_92(tLX_92(:,1) < tT_j,1)/ 3);                                     % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tLX_92(tLX_92(:,1) >= tT_j,1)- tT_j));              % cm, struc length
  ELw_tLX_92 = [L_bj; L_ji]/ del_M;                                                             % cm, phys length

  % Food concentration level 1/16 (Klei1982b) 
  X_47 = 47.59;                                                                                 % mug.C.l^-1, food concentration
  f_tLX_47 = X_47 / (X_K_tLX + X_47);                                                           % -, functional response

  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tLX_47);
  kT_M = k_M * TC_tLX;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tLX_47(tLX_47(:,1) < tT_j,1)/ 3);                                     % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tLX_47(tLX_47(:,1) >= tT_j,1)- tT_j));              % cm, struc length
  ELw_tLX_47 = [L_bj; L_ji]/ del_M;                                                             % cm, phys length

  % Food concentration level 0 (Klei1982b) 
  X_29 = 29.91;                                                                                 % mug.C.l^-1, food concentration
  f_tLX_29 = X_29 / (X_K_tLX + X_29);                                                           % -, functional response

  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_tLX_29);
  kT_M = k_M * TC_tLX;  rT_j = rho_j * kT_M; rT_B = rho_B * kT_M; 
  L_b = L_m * l_b; L_j = L_m * l_j; L_i = L_m * l_i; 
  tT_j = (t_j - t_b)/ kT_M;

  L_bj = L_b * exp(rT_j * tLX_29(tLX_29(:,1) < tT_j,1)/ 3);                                    % cm, struc length
  L_ji = L_i - (L_i - L_j) * exp( - rT_B * (tLX_29(tLX_29(:,1) >= tT_j,1)- tT_j));             % cm, struc length
  ELw_tLX_29 = [L_bj; L_ji]/ del_M;                                                            % cm, phys length

  
  % Time to puberty - food (tpX)
  % tpX (5°C)
  f_tpX_5C = tpX_5C(:, 1) ./ (X_K_tpX + tpX_5C(:, 1));                                          % -, functional response  
  t_p_vector = [];                                                                              % iterate over f to obtain t_p
  for i = 1:length(f_tpX_5C)
    [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f_tpX_5C(i));     
    t_p_vector(i) = t_p;                                                                        % append t_p result to vector
    
  end
  tT_p_5 = t_p_vector./ k_M./ TC_tpX_5C;                                                        % d, age at puberty at f and T
  
  % tpX (10°C)
  f_tpX_10C = tpX_10C(:, 1) ./ (X_K_tpX + tpX_10C(:, 1));                                       % -, functional response  
  t_p_vector = [];                                                                              % iterate over f to obtain t_p
  for i = 1:length(f_tpX_10C)
    [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f_tpX_10C(i));  
    t_p_vector(i) = t_p;                                                                        % append t_p result to vector
  end
  tT_p_10 = t_p_vector./ k_M./ TC_tpX_10C;                                                      % d, age at puberty at f and T
  
  % tpX (15°C)
  f_tpX_15C = tpX_15C(:, 1) ./ (X_K_tpX + tpX_15C(:, 1));                                       % -, functional response  
  t_p_vector = [];                                                                              % iterate over f to obtain t_p
  for i = 1:length(f_tpX_15C)
    [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f_tpX_15C(i));
    t_p_vector(i) = t_p;                                                                        % append t_p result to vector
  end
  tT_p_15 = t_p_vector./ k_M./ TC_tpX_15C;                                                      % d, age at puberty at f and T

  % tpX (20°C)
  f_tpX_20C = tpX_20C(:, 1) ./ (X_K_tpX + tpX_20C(:, 1));                                       % -, functional response  
  t_p_vector = [];                                                                              % iterate over f to obtain t_p
  for i = 1:length(f_tpX_20C)
    [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B, info] = get_tj(pars_tj, f_tpX_20C(i));
    t_p_vector(i) = t_p;                                                                        % append t_p result to vector
  end
  tT_p_20 = t_p_vector./ k_M./ TC_tpX_20C;                                                      % d, age at puberty at f and T


  % t-W data; we neglect maternal effects
  % f_200
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_200); 
  kT_M = TC_tW * k_M;
  L_b = L_m * l_b; L_p = L_m * l_p; L_i = L_m * f_200;
  rT_B = kT_M/ 3/ (1 + w * f_200/ g);                                                           % 1/d, von Bert growth rate
  L = min(L_p, L_i - (L_i - L_b) * exp( - rT_B * tW1(:,1)));                                    % cm, predicted length at time
  EWd_1 = 1e6 * L.^3 * d_V * (1 + f_200 * w);                                                   % mug, dry weight 
  
  % f_100
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_100); 
  L_b = L_m * l_b; L_p = L_m * l_p; L_i = L_m * f_100;
  rT_B = kT_M/ 3/ (1 + w * f_100/ g);                                                           % 1/d, von Bert growth rate
  L = min(L_p, L_i - (L_i - L_b) * exp( - rT_B * tW2(:,1)));                                    % cm, predicted length at time
  EWd_2 = 1e6 * L.^3 * d_V * (1 + f_100 * w);                                                   % mug, dry weight 
  
  % f_50
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_50); 
  L_b = L_m * l_b; L_p = L_m * l_p; L_i = L_m * f_50;
  rT_B = kT_M/ 3/ (1 + w * f_50/ g);                                                            % 1/d, von Bert growth rate
  L = min(L_p, L_i - (L_i - L_b) * exp( - rT_B * tW3(:,1)));                                    % cm, predicted length at time
  EWd_3 = 1e6 * L.^3 * d_V * (1 + f_50 * w);                                                    % mug, dry weight 
  
  % f_25
  [t_j, t_p, t_b, l_j, l_p, l_b, l_i, rho_j, rho_B] = get_tj(pars_tj, f_25); 
  L_b = L_m * l_b; L_p = L_m * l_p; L_i = L_m * f_25;
  rT_B = kT_M/ 3/ (1 + w * f_25/ g);                                                            % 1/d, von Bert growth rate
  L = min(L_p, L_i - (L_i - L_b) * exp( - rT_B * tW4(:,1)));                                    % cm, predicted length at time
  EWd_4 = 1e6 * L.^3 * d_V * (1 + f_25 * w);                                                    % mug, dry weight 
  
  
  % L-W data (has own d_V to differ Ww and AFDW)
  EWd_L = 1e6 * (LW(:,1) * del_M).^3 * d_V * (1 + f_LW * w);                                    % mug, dry weight

  
  % L-R data
  pars_R = [kap, kap_R, g, k_J, k_M, L_T, v, U_Hb, U_Hj, U_Hp];
  ER  = reprod_rate_j(LR(:,1) .* del_M ./ 10000, 1, pars_R) .* TC_LR;                           % #/ d, temperature corrected reproduction rate

    
  % Ingestion rate -reproduction rate as C (DamLope2003 calculated ingestion rate)
  % first convert mug C/d to J/d, ingested energy to assimilated energy, subtract, convert back to mug C/d.  
  EJT_C = (kap_X * mu_X_JR * JR(:,1) * 1e-6/12 - TC_JR * k_J * E_Hp - TC_JR * p_M * L_p^3) * kap_R/ mu_E * 12e6; % mug/d, egg production as C
  

  % f-R data
  % at 2 C
  f_X = fR_2C(:,1) ./ (X_K_fR + fR_2C(:,1));
  kT_M = k_M * TC_fR_2C; 
  pars_R = [kap; kap_R; g; k_J; kT_M; L_T; v; U_Hb; U_Hj; U_Hp];                               % compose parameter vector at T
  Rf_1 = zeros(length(f_X),1);
  for i = 1:length(f_X)
      Rf_1(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R);                                 % #/d, ultimate reproduction rate
  end
  
  % at 6 C
  f_X = fR_6C(:,1) ./ (X_K_fR + fR_6C(:,1));
  kT_M = k_M * TC_fR_6C; 
  pars_R = [kap; kap_R; g; k_J; kT_M; L_T; v; U_Hb; U_Hj; U_Hp];                               % compose parameter vector at T
  Rf_2 = zeros(length(f_X),1);
  for i = 1:length(f_X)
      Rf_2(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R);                                 % #/d, ultimate reproduction rate
  end

  % at 10 C
  f_X = fR_10C(:,1) ./ (X_K_fR + fR_10C(:,1));
  kT_M = k_M * TC_fR_10C; 
  pars_R = [kap; kap_R; g; k_J; kT_M; L_T; v; U_Hb; U_Hj; U_Hp];                               % compose parameter vector at T
  Rf_3 = zeros(length(f_X),1);
  for i = 1:length(f_X)
      Rf_3(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R);                                 % #/d, ultimate reproduction rate
  end
  
  % at 14 C
  f_X = fR_14C(:,1) ./ (X_K_fR + fR_14C(:,1));
  kT_M =  k_M * TC_fR_14C; 
  pars_R = [kap; kap_R; g; k_J; kT_M; L_T; v; U_Hb; U_Hj; U_Hp];                               % compose parameter vector at T
  Rf_4 = zeros(length(f_X),1);
  for i = 1:length(f_X)
      Rf_4(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R);                    % #/d, ultimate reproduction rate
  end
  
  
  % at 18 C
  f_X = fR_18C(:,1) ./ (X_K_fR + fR_18C(:,1));
  kT_M =  k_M * TC_fR_18C; 
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hj; U_Hp];                               % compose parameter vector at T
  Rf_5 = zeros(length(f_X),1);
  for i = 1:length(f_X)
      Rf_5(i,1) = reprod_rate_j(L_m * f_X(i), f_X(i), pars_R);                    % #/d, ultimate reproduction rate
  end
  
  
    
  prdData.tL_Klei1999 = ELw_Klei1999;
  prdData.tL_Pete1994 = ELw_Pete1994;
  prdData.tLX_2080 = ELw_tLX_2080;
  prdData.tLX_1398 = ELw_tLX_1398;
  prdData.tLX_478 = ELw_tLX_478;
  prdData.tLX_300 = ELw_tLX_300;
  prdData.tLX_165 = ELw_tLX_165; 
  prdData.tLX_92 = ELw_tLX_92;
  prdData.tLX_47 = ELw_tLX_47;
  prdData.tLX_29 = ELw_tLX_29;
  prdData.tpX_5C = tT_p_5';
  prdData.tpX_10C = tT_p_10';
  prdData.tpX_15C = tT_p_15';
  prdData.tpX_20C = tT_p_20';
  prdData.LW = EWd_L;
  prdData.LR = ER;
  prdData.tW1 = EWd_1;
  prdData.tW2 = EWd_2;
  prdData.tW3 = EWd_3;
  prdData.tW4 = EWd_4;
  prdData.JR  = EJT_C;
  prdData.fR_2C = Rf_1;
  prdData.fR_6C = Rf_2;
  prdData.fR_10C = Rf_3;
  prdData.fR_14C = Rf_4;
  prdData.fR_18C = Rf_5;
  