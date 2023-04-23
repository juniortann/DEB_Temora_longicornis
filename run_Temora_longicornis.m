close all; 
global pets 

pets = {'Temora_longicornis'}; 
check_my_pet(pets); 

estim_options('default'); 
estim_options('max_step_number', 5e2);
estim_options('max_fun_evals', 5e3); 

estim_options('pars_init_method', 1); 
estim_options('results_output', 3);  
estim_options('method', 'no'); 

estim_pars;


% To work on: See results figs. 
% Figure 3 TL for 4 temperatures is bad
% Figure 6 Egg production FOod density for 2 temperatures is bad
% Figure 7 Egg production Food density for 3 temperatures is bad