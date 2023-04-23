function [data, auxData, metaData, txtData, weights] = mydata_Temora_longicornis 

% http://www.debtheory.org/wiki/index.php?title=Mydata_file#Metadata

%% set metaData
metaData.phylum     = 'Arthropoda'; 
metaData.class      = 'Hexanauplia'; 
metaData.order      = 'Calanoida'; 
metaData.family     = 'Temoridae';
metaData.species    = 'Temora_longicornis'; 
metaData.species_en = 'Copepod'; 

metaData.ecoCode.climate = {'MB', 'MC'};
metaData.ecoCode.ecozone = {'MA'};
metaData.ecoCode.habitat = {'0iMpe'};
metaData.ecoCode.embryo  = {'Mbf'};
metaData.ecoCode.migrate = {};
metaData.ecoCode.food    = {'biPp'};
metaData.ecoCode.gender  = {'D'};
metaData.ecoCode.reprod  = {'O'};

metaData.T_typical  = C2K(12.5); % K, body temp
metaData.data_0     = {'ab'; 'ap'; 'am'; 'Lb'; 'Lj'; 'Lp'; 'Li'; 'Wdj'; 'Wdi'; 'Ri'}; % 'Wdb'; 
metaData.data_1     = {'tL'; 'tL-X'; 'tp-X'; 'L-Wd'; 't-Wd_f'; 'JX-Ri';'JR'; 'fR'}; % LWS

metaData.COMPLETE = 2.7; % using criteria of LikaKear2011 https://debportal.debtheory.org/docs/Completeness.html

metaData.author_0   = {'Karel Vlaeminck'};    
metaData.date_subm_0 = [2019 04 01];              
metaData.email_0    = {'karel.vlaeminck@ugent.be'};            
metaData.address_0  = {'GhEnToxLab (UGent)'};  

metaData.curator_0     = {'Bas Kooijman'};
metaData.email_cur_0   = {'bas.kooijman@vu.nl'}; 
metaData.date_acc_0    = [2019 04 14]; 

metaData.author_1   = {'Tan Tjui Yeuw', 'Jaap van der Meer'};    
metaData.date_subm_1 = [];              
metaData.email_1    = {'tan.tjuiyeuw@wur.nl'};            
metaData.address_1  = {'Wageningen Marine Research - Yerseke - NL (WUR)'}; 

metaData.curator_0     = {''};
metaData.email_cur_0   = {''}; 
metaData.date_acc_0    = []; 

%% set data
% zero-variate data

data.ab = 2;    units.ab = 'd';    label.ab = 'age at birth';             bibkey.ab = 'DamLope2003';   
  temp.ab = C2K(15.5);  units.temp.ab = 'K'; label.temp.ab = 'temperature'; 
  comment.ab = '>90% hatching succes was observed after 48 hours. Temperature between 14 and 17 C';
data.tp = 23.7;    units.tp = 'd';    label.tp = 'time since birth at puberty';           bibkey.tp = 'BakkRijs1976';
  temp.tp = C2K(12.5);  units.temp.tp = 'K'; label.temp.tp = 'temperature';
  comment.tp = 'Average time it takes from hatching to first copepodite stage';
data.am = 60;    units.am = 'd';    label.am = 'life span';                bibkey.am = 'SichKior2011';   
  temp.am = C2K(14);  units.temp.am = 'K'; label.temp.am = 'temperature'; 
  comment.am = 'Maximum value found for 50% succes rate from hatching to adult';

data.Lb  = 0.0138;   units.Lb  = 'cm';  label.Lb  = 'total length at birth';   bibkey.Lb  = 'TiteKior2003';
data.Lj  = 0.04084;   units.Lj  = 'cm';  label.Lj  = 'total length at metam';   bibkey.Lj  = 'BakkRijs1987';
  comment.Lj = 'Length at metamorphosis calculated as seasonal average length of the first three copepodite stages';
data.Lp  = 0.10545;   units.Lp  = 'cm';  label.Lp  = 'total length at puberty'; bibkey.Lp  = 'BakkRijs1987'; 
  comment.Lp = 'Length at puberty calculated as seasonal average lenght of the last three copepodite stages and the adult stage';
% data.Lp  = 0.06558;   units.Lp  = 'cm';  label.Lp  = 'total length at puberty'; bibkey.Lp  = 'Klei1982a'; 
%   comment.Lp = 'Length at puberty calculated as seasonal average lenght of the last three copepodite stages and the adult stage';
% data.Li  = 0.06558;   units.Li  = 'cm';  label.Li  = 'ultimate total length';   bibkey.Li  = 'Klei1982a';
%   comment.Li = 'Equal to Lp for the abp model';
data.Li  = 0.10545;   units.Li  = 'cm';  label.Li  = 'ultimate total length';   bibkey.Li  = 'SichKior2011';
  comment.Li = 'Maximum length recorded in all of the data';

data.Wdb = 0.1214;   units.Wdb = 'mug';   label.Wdb = 'dry weight at birth';     bibkey.Wdb = 'estimated';
  comment.Wdb = 'All wet weights are calculated from dry weight data assuming a 50% dry/wet weight ratio';
data.Wdj = 3.1250;   units.Wdj = 'mug';   label.Wdj = 'dry weight at metam';     bibkey.Wdj = 'BakkRijs1987';
  comment.Wdj = 'Weight at metamorphosis calculated as seasonal average weight of the first three copepodite stages';
data.Wdp = 31.8601;   units.Wdp = 'mug';   label.Wdp = 'dry weight at puberty';   bibkey.Wdp = 'BakkRijs1987';
  comment.Wdp = 'Weight at puberty calculated as seasonal average weight of last three copepodite stages and the adult stage';
data.Wdi = 31.8601;   units.Wdi = 'mug';   label.Wdi = 'ultimate dry weight';     bibkey.Wdi = 'BakkRijs1987';
  comment.Wdi = 'Maximum weight recorded in all of the data';

data.Ri  = 51.49;   units.Ri  = '#/d'; label.Ri  = 'maximum reprod rate';     bibkey.Ri  = 'MapsRung2005';   
temp.Ri = C2K(18);    units.temp.Ri = 'K'; label.temp.Ri = 'temperature';

% uni-variate data
% t-L data Klei1999
data.tL_Klei1999 =   [ ...    % time (days), length (mum)
    4	215.4175
    6	255.2184615
    8	301.8176923
    9	324
    11	363.324
    13	385.4972727
    15	460.8191667
    16	539.0534615
    18	636.7178571
    20	764.0372727
            ];
data.tL_Klei1999(:,2)  = data.tL_Klei1999(:,2) / 10000;  % convert mum to cm
units.tL_Klei1999 = {'d', 'cm'};  label.tL_Klei1999 = {'time', 'length'};  
temp.tL_Klei1999 = C2K(15);  units.temp.tL_Klei1999 = 'K'; label.temp.tL_Klei1999 = 'temperature';
bibkey.tL_Klei1999 = 'Klei1999';
comment.tL_Klei1999 = 'Experimental data originally time-stage. Converted from mean stage-length obtained from Klei1982a';


% t-L data Pete1994
data.tL_Pete1994 =   [ ...    % time (days), length (mum)
    15	255.2184615
    19	301.8176923
    23	363.324
    25	385.4972727
    34	460.8191667
    41	539.0534615
    46	636.7178571
    61	764.0372727
            ];
data.tL_Pete1994(:,2)  = data.tL_Pete1994(:,2) / 10000;  % convert mum to cm
units.tL_Pete1994 = {'d', 'cm'};  label.tL_Pete1994 = {'time', 'length'};  
temp.tL_Pete1994 = C2K(4);  units.temp.tL_Pete1994 = 'K'; label.temp.tL_Pete1994 = 'temperature';
bibkey.tL_Pete1994 = 'Pete1994';
comment.tL_Pete1994 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';

% t-L data at different food concentration Klei1982b at 15 degrees Celcius
% Food concentration level 4 (Klei1982b) 
data.tLX_2080 =    [ ...    % time (days), length (mum)
    2	172.8775
    4	215.4175
    5	255.2184615
    6	255.2184615
    9	363.324
    12	323.9163636
    13	385.4972727
    15	385.4972727
    16	460.8191667
    18	539.0534615
    21	636.7178571
    23	636.7178571
    24	764.0372727
    25	764.0372727
    28	764.0372727
    31	764.0372727
    32	764.0372727
                   ];
data.tLX_2080(:,2)  = data.tLX_2080(:,2) / 10000;  % convert mum to cm
units.tLX_2080   = {'d', 'cm'};  label.tLX_2080 = {'time', 'length'};  
temp.tLX_2080 = C2K(15);  units.temp.tLX_2080 = 'K'; label.temp.tLX_2080 = 'temperature';
% X.tLX_2080 = 2080.01;  units.X.tLX_2080 = 'mug.C.l^-1'; label.X.tLX_2080 = 'microgram of carbon per liter';
bibkey.tLX_2080 = 'Klei1982b';
comment.tLX_2080 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';
%
% Food concentration level 2 (see Klei1982b) 
data.tLX_1398 =    [ ...    % time (days), length (mum)
    3	172.8775
    4	172.8775
    5	215.4175
    7	301.8176923
    9	301.8176923
    12	363.324
    13	385.4972727
    16	460.8191667
    19	539.0534615
    21	636.7178571
    24	764.0372727
    28	764.0372727
    15	385.4972727
    22	636.7178571
    26	764.0372727
                   ];
data.tLX_1398(:,2)  = data.tLX_1398(:,2) / 10000;  % convert mum to cm
units.tLX_1398   = {'d', 'cm'};  label.tLX_1398 = {'time', 'length'};  
% X.tLX_1398 = 1398.78;  units.X.tLX_1398 = 'mug.C.l^-1'; label.X.tLX_1398 = 'microgram of carbon per liter';
bibkey.tLX_1398 = 'Klei1982b';
comment.tLX_1398 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';
%
% Food concentration level 1 (Klei1982b) 
data.tLX_478 =    [ ...    % time (days), length (mum)
    1	172.8775
    3	172.8775
    4	215.4175
    5	255.2184615
    6	255.2184615
    8	363.324
    9	363.324
    11	323.9163636
    12	323.9163636
    13	385.4972727
    14	460.8191667
    16	460.8191667
    17	539.0534615
    19	636.7178571
    20	636.7178571
    22	636.7178571
    23	636.7178571
    24	764.0372727
    25	764.0372727
    27	764.0372727
    28	764.0372727
    29	764.0372727
    31	764.0372727
    32	764.0372727
    33	764.0372727
    35	764.0372727
    37	764.0372727
                   ];
data.tLX_478(:,2)  = data.tLX_478(:,2) / 10000;  % convert mum to cm
units.tLX_478 = {'d', 'cm'};  label.tLX_478 = {'time', 'length'};  
% X.tLX_478 = 478.74;  units.X.tLX_478 = 'mug.C.l^-1'; label.X.tLX_478 = 'microgram of carbon per liter';
bibkey.tLX_478 = 'Klei1982b';
comment.tLX_478 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';
%
% Food concentration level 1/2 (Klei1982b) 
data.tLX_300 =    [ ...    % time (days), length (mum)
    4	172.8775
    3	172.8775
    5	255.2184615
    7	255.2184615
    8	301.8176923
    10	363.324
    12	323.9163636
    13	323.9163636
    15	385.4972727
    16	385.4972727
    19	460.8191667
    21	636.7178571
    23	636.7178571
    24	764.0372727
    25	636.7178571
    28	636.7178571
    31	764.0372727
    32	636.7178571
    35	764.0372727
                   ];
data.tLX_300(:,2)  = data.tLX_300(:,2) / 10000;  % convert mum to cm
units.tLX_300 = {'d', 'cm'};  label.tLX_300 = {'time', 'length'};  
% X.tLX_300 = 300.75;  units.X.tLX_300 = 'mug.C.l^-1'; label.X.tLX_300 = 'microgram of carbon per liter';
bibkey.tLX_300 = 'Klei1982b';
comment.tLX_300 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';
%
% Food concentration level 1/4 (Klei1982b) 
data.tLX_165 =    [ ...    % time (days), length (mum)
    0	120.405
    2	120.405
    3	215.4175
    5	215.4175
    6	215.4175
    7	301.8176923
    9	301.8176923
    10	363.324
    12	385.4972727
    13	323.9163636
    14	385.4972727
    16	385.4972727
    17	385.4972727
    20	385.4972727
    19	636.7178571
    21	764.0372727
    23	764.0372727
    24	764.0372727
    27	636.7178571
                   ];
data.tLX_165(:,2)  = data.tLX_165(:,2) / 10000;  % convert mum to cm
units.tLX_165 = {'d', 'cm'};  label.tLX_165 = {'time', 'length'};  
% X.tLX_165 = 165.19;  units.X.tLX_165 = 'mug.C.l^-1'; label.X.tLX_165 = 'microgram of carbon per liter';
bibkey.tLX_165 = 'Klei1982b';
comment.tLX_165 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';
%
% Food concentration level 1/8 (Klei1982b) 
data.tLX_92 =    [ ...    % time (days), length (mum)
    0	120.405
    2	172.8775
    2	215.4175
    3	215.4175
    5	215.4175
    5	255.2184615
    7	301.8176923
    8	363.324
    8	301.8176923
    10	363.324
    12	363.324
    13	323.9163636
    13	323.9163636
    15	323.9163636
    15	385.4972727
    17	460.8191667
    18	460.8191667
    20	460.8191667
    23	460.8191667
    24	460.8191667
    24	764.0372727
    26	764.0372727
    28	764.0372727
    31	764.0372727
                   ];
data.tLX_92(:,2)  = data.tLX_92(:,2) / 10000;  % convert mum to cm
units.tLX_92 = {'d', 'cm'};  label.tLX_92 = {'time', 'length'};  
% X.tLX_92 = 92.84;  units.X.tLX_92 = 'mug.C.l^-1'; label.X.tLX_92 = 'microgram of carbon per liter';
bibkey.tLX_92 = 'Klei1982b';
comment.tLX_92 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';
%
% Food concentration level 1/16 (Klei1982b) 
data.tLX_47 =    [ ...    % time (days), length (mum)
    2	120.405
    3	172.8775
    4	215.4175
    7	215.4175
    6	255.2184615
    9	301.8176923
    10	363.324
    11	301.8176923
    13	301.8176923
    16	363.324
    17	363.324
    18	323.9163636
    20	323.9163636
    24	460.8191667
    25	539.0534615
    32	636.7178571
    34	636.7178571
    35	764.0372727
    37	764.0372727
    39	636.7178571
    40	636.7178571
                   ];
data.tLX_47(:,2)  = data.tLX_47(:,2) / 10000;  % convert mum to cm
units.tLX_47 = {'d', 'cm'};  label.tLX_47 = {'time', 'length'};  
% X.tLX_47 = 47.59;  units.X.tLX_47 = 'mug.C.l^-1'; label.X.tLX_47 = 'microgram of carbon per liter';
bibkey.tLX_47 = 'Klei1982b';
comment.tLX_47 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';
%
% Food concentration level 0 (Klei1982b) 
data.tLX_29 =    [ ...    % time (days), length (mum)
    3	172.8775
    6	172.8775
    10	363.324
    13	363.324
    17	323.9163636
    20	385.4972727
    24	385.4972727
    27	460.8191667
    31	539.0534615
    34	636.7178571
    38	636.7178571
    41	764.0372727
                   ];
data.tLX_29(:,2)  = data.tLX_29(:,2) / 10000;  % convert mum to cm
units.tLX_29 = {'d', 'cm'};  label.tLX_29 = {'time', 'length'};  
% X.tLX_29 = 29.91;  units.X.tLX_29 = 'mug.C.l^-1'; label.X.tLX_29 = 'microgram of carbon per liter';
bibkey.tLX_29 = 'Klei1982b';
comment.tLX_29 = 'Data originally time-stage. Converted from mean stage-length obtained from Klei1982a';


% Time to puberty / food, at different temperatures (tpX)
% tpX (5°C)
data.tpX_5C =   [ ...    % food concentration (mg.C.m^-3), time to puberty (days)
    109 100
    149 79
    343	56
    895	62
               ];
units.tpX_5C   = {'mg.C.m^-3', 'd'};  label.tpX_5C = {'food concentration', 'time'};  
temp.tpX_5C    = C2K(5);  units.temp.tpX_5C = 'K'; label.temp.tpX_5C = 'temperature';
bibkey.tpX_5C = 'Dzie2011';
comment.tpX_5C = 'Cited dataset not located. Used data from figure 2 in article';
%
% tpX (10°C)
data.tpX_10C =   [ ...    % food concentration (mg.C.m^-3), time to puberty (days)
    53	70
    124	43
    206	30
    760	24
               ];
units.tpX_10C   = {'mg.C.m^-3', 'd'};  label.tpX_10C = {'food concentration', 'time'};  
temp.tpX_10C    = C2K(10);  units.temp.tpX_10C = 'K'; label.temp.tpX_10C = 'temperature';
bibkey.tpX_10C = 'Dzie2011';
comment.tpX_10C = 'Cited dataset not located. Used data from figure 2 in article';
%
% tpX (15°C)
data.tpX_15C =   [ ...    % food concentration (mg.C.m^-3), time to puberty (days)
    61	47
    88	28
    157	21
    461	17
               ];
units.tpX_15C   = {'mg.C.m^-3', 'd'};  label.tpX_15C = {'food concentration', 'time'};  
temp.tpX_15C    = C2K(15);  units.temp.tpX_15C = 'K'; label.temp.tpX_15C = 'temperature';
bibkey.tpX_15C = 'Dzie2011';
comment.tpX_15C = 'Cited dataset not located. Used data from figure 2 in article';
%
% tpX (20°C)
data.tpX_20C =   [ ...    % food concentration (mg.C.m^-3), time to puberty (days)
    45	31
    72	26
    141	19
    358	14
               ];
units.tpX_20C   = {'mg.C.m^-3', 'd'};  label.tpX_20C = {'food concentration', 'time'};  
temp.tpX_20C    = C2K(20);  units.temp.tpX_20C = 'K'; label.temp.tpX_20C = 'temperature';
bibkey.tpX_20C = 'Dzie2011';
comment.tpX_20C = 'Cited dataset not located. Used data from figure 2 in article';


% time - dry weight
data.tW1 = [ ... % time (d), ash-free dry weight (mug)
    12		1.01435115
    13		1.359571096
    15		4.217425267
    17		5.442270787
    18		6.87353852
    16		8.732969275
    19		7.473390187
    21		11.02966079
    20		14.20477836
    22		21.72536013
    23		32.303881
    23		24.25610179
    23		17.57783872
    28		19.45866145
    28		26.66797424
    29		40.98022907
    38		32.96535248
    38		25.10611566
    38		19.96026858
            ];
units.tW1   = {'d', 'mug'};  label.tW1 = {'time since birth', 'total weight', '200 mug/L'};  
temp.tW1    = C2K(12.5);  units.temp.tW1 = 'K'; label.temp.tW1 = 'temperature';
bibkey.tW1  = 'BakkRijs1976';
comment.tW1 = 'Population from the Island of Sylt in the Southeastern North Sea, at 200 mug/L food density';
%
data.tW2 = [ ... % time (d), ash-free dry weight (mug)
    14	0.869107617
    15	1.107083341
    11	0.850889972
    11	0.914214315
    11	0.966952747
    14	1.791986877
    15	2.449925509
    16	2.224619756
    18  2.003477827
    16	2.986740261
    17	3.289733628
    16	3.837752291
    17	4.052342124
    20	3.269739914
    21  3.788934836
    17	5.024554528
    19	5.06607626
    18	5.905504267
    17	6.225268429
    19	9.124815991
    20	10.34735448
    23	8.65743438
    21	7.058251133
    23	12.39356019
    21	13.27942608
    21	16.57360008
    23	14.72049742
    23	15.68877831
    24	16.81017953
    24	15.51756526
    25	14.01767846
    24	22.70709326
    25	22.65524283
    25	20.78924
    27	21.71873908
    30	17.39926371
    32	22.58285109
    30	34.59707339
    32	37.83483101
    30	52.04240746
            ];
units.tW2   = {'d', 'mug'};  label.tW2 = {'time since birth', 'total weight', '100 mug/L'};  
temp.tW2    = C2K(12.5);  units.temp.tW2 = 'K'; label.temp.tW2 = 'temperature';
bibkey.tW2  = 'BakkRijs1976';
comment.tW2 = 'Population from the Island of Sylt in the Southeastern North Sea, at 100 mug/L food density';
%
data.tW3 = [
    13		0.805954323
    13		0.858706388
    14		1.093834087
    14		1.96387524
    17		3.024761047
    18		3.038622264
    18		4.8300857
    20		4.984132652
    19		7.955267601
    21		7.272269772
    21		8.326165626
    22		9.811370319
    25		18.77980708
    26		16.01491082
    29		23.05932261
    30		26.02951723
    30		32.73006603
    32		35.17660075
    32		24.94592564
    32		18.59468808
            ];  % mug, total length at f and T
units.tW3   = {'d', 'mug'};  label.tW3 = {'time since birth', 'total weight', '50 mug/L'};  
temp.tW3    = C2K(12.5);  units.temp.tW3 = 'K'; label.temp.tW3 = 'temperature';
bibkey.tW3 = 'BakkRijs1976';
comment.tW3 = 'Population from the Island of Sylt in the Southeastern North Sea, at 50 mug/L food density';
%
data.tW4 = [  % time (d), ash-free dry weight (mug)
    17	0.807798888
    19	1.395468682
    21	2.059513262
    23	3.685845133
    26	5.717749214
    27	8.499246871
    30	9.664447752
    33	10.10886839
    37	10.50786124
    37	11.28298962
37	12.92796578];
units.tW4   = {'d', 'mug'};  label.tW4 = {'time since birth', 'total weight', '25 mug/L'};  
temp.tW4    = C2K(12.5);  units.temp.tW4 = 'K'; label.temp.tW4 = 'temperature';
bibkey.tW4  = 'BakkRijs1976';
comment.tW4 = 'Population from the Island of Sylt in the Southeastern North Sea, at 25 mug/L food density';


% length -  dry weight
% Seasonal data: average length and average ash-free dry weight
data.LW = [ ... % total length (mm), dry weight (mug) 
    0.416227402	3.94609344
    0.419175354	3.372697708
    0.420620046	3.203458396
    0.406778337	4.318458
    0.397516692	2.228761799
    0.453867479	3.462742921
    0.389652884	2.595605616
    0.386419898	2.725818989
    0.375545664	1.692107559
    0.436523369	3.388117712
    0.407410878	2.755136036
    0.408836047	3.694614103
    0.390441607	2.477385579
    0.407149272	3.416102165
    0.391776971	3.598857777
    0.672718754	15.94628381
    0.69092187	12.63440946
    0.66947015	10.310748
    0.722802702	13.58016975
    0.632626606	7.646513842
    0.641642263	9.521091457
    0.615606575	10.16873166
    0.575736988	7.036566987
    0.604626918	10.42382803
    0.613705049	15.49681923
    0.580028113	8.16470215
    0.552450119	7.240453716
    0.526394908	6.315253431
    0.552274413	5.856079956
    0.546077857	6.794606171
    0.50780524	7.617958277
    0.95198938	39.256191
    0.921377533	35.06785119
    0.912111983	38.68831601
    0.800562258	21.85995082
    0.777525282	18.957944
    0.824762797	26.30490997
    0.728401859	20.49309114
    0.76494475	22.89023558
    0.812178361	26.62378044
    0.773925266	23.19387642
    0.720385772	19.29889744
    0.65769396	15.52118664
    0.704939284	14.47776632
    0.662110031	14.19278179
    0.710858615	16.99674784
            ];   
data.LW(:,1)  = data.LW(:,1) / 10;  % convert mm to cm
units.LW = {'cm', 'mug'};     label.LW = {'total length', 'dry weight'};  
bibkey.LW = 'BakkRijs1987';
comment.LW = 'Population from the Southern North Sea. Dry weight and not AFDW, has own d_V';


% length-reproduction
% Egg production (#/d) as a function of the female size (mum)
data.LR = [ ... % size (mum), egg production (#/d)
    1000	    4.383256528 
    1003.686636	5.083870968
    1014.746544	2.285714286
    1044.239631	2.6906298
    1074.654378	1.895698925
    1114.285714	2.102304147
    1074.654378	3.462365591
    1075.576037	3.729185868
    1075.576037	4.262519201
    1078.341014	4.096313364
    1056.221198	3.959293395
    1045.16129	3.757450077
    1043.317972	4.523809524
    1043.317972	4.757142857
    1047.926267	4.924577573
    1056.221198	5.092626728
    1074.654378	5.062365591
    1095.852535	4.765898618
    1098.617512	5.333026114
    1104.147465	5.167281106
    1144.700461	3.907373272
    1144.700461	4.674039939
    1152.995392	4.842089094
    1143.778802	5.573886329
    1142.857143	5.840399386
    1115.207373	6.669124424
    1113.364055	8.635483871
    1143.778802	8.973886329
    1143.778802	7.573886329
    1143.778802	6.507219662
    1147.465438	6.507834101
    1154.83871	6.542396313
    1175.115207	5.812442396
    1194.470046	5.549001536
    1172.35023	5.378648233
    1177.880184	5.046236559
    1173.271889	4.678801843
    1174.193548	4.478955453
    1180.645161	4.513364055
    1305.069124	3.534101382
    1305.069124	5.600768049
    1376.958525	6.546082949
    1375.115207	8.479109063
    1214.746544	6.819047619
    1245.16129	7.09078341
    1274.654378	6.495698925
    1274.654378	7.395698925
    1305.069124	7.400768049
    1200.921659	9.350076805
    1199.078341	9.983102919
    1204.608295	10.01735791
    1215.668203	8.719201229
    1246.082949	8.357603687
    1256.221198	8.325960061
    1255.299539	8.659139785
    1244.239631	8.757296467
    1243.317972	9.357142857
    1256.221198	9.392626728
    1245.16129	9.657450077
    1245.16129	10.02411674
    1253.456221	9.925499232
    1244.239631	10.92396313
    1246.082949	12.35760369
    1254.37788	12.35898618
    1272.81106	12.49539171
    1295.852535	10.79923195
    1298.617512	9.99969278
    1301.382488	10.13348694
    1319.815668	10.03655914
    1305.990783	9.034254992
    1295.852535	9.432565284
    1288.479263	9.531336406
    1278.341014	10.09631336
    1275.576037	9.895852535
    1275.576037	9.629185868
    1273.732719	9.295545315
    1276.497696	9.096006144
    1281.105991	8.996774194
    1274.654378	8.862365591
    1278.341014	8.629646697
    1272.81106	8.462058372
    1274.654378	8.129032258
    1280.184332	7.96328725
    ]; 
units.LR   = {'mum', '#/d'};  label.LR = {'total length', 'egg production rate'};  
temp.LR    = C2K(14);  units.temp.LR = 'K'; label.temp.LR = 'temperature';
comment.LR = 'Lab culture, originally sampled from the central North Sea';
bibkey.LR = 'SichKior2011';

% ingestion rate - egg production as C
data.JR = [ ... % ingestion rate (mug C/d), egg production (mug C/d)
    0.582959641	0.170967742 
    0.6367713	0.103225806
    0.744394619	0.083870968
    0.852017937	0.175806452
    0.923766816	0.05483871
    1.103139013	0.025806452
    1.30044843	0.030645161
    1.443946188	0.093548387
    1.695067265	0.2
    1.497757848	0.233870968
    2.304932735	0.146774194
    2.286995516	0.190322581
    2.286995516	0.224193548
    2.627802691	0.248387097
    2.986547085	0.185483871
    2.64573991	0.364516129
    2.627802691	0.412903226
    2.896860987	0.50483871
    2.627802691	0.572580645
    2.878923767	0.891935484
    3.506726457	0.712903226
    3.650224215	0.277419355
    4.116591928	0.34516129
    5.013452915	0.490322581
    5.35426009	0.470967742
    7.524663677	0.475806452
    7.560538117	0.683870968
    9.372197309	1.201612903
            ]; 
units.JR   = {'mug C/d', 'mug C/d'};  label.JR = {'ingestion rate', 'egg production rate'}; 
temp.JR    = C2K(15.5);  units.temp.JR = 'K'; label.temp.JR = 'temperature';
bibkey.JR = 'DamLope2003';
comment.JR = 'Population from Long Island Sound (USA)';

% f-R data
% egg production (#/d) as a function of the food density (mug C/L) for
% different temperatures
% at 2 C
data.fR_2C = [
    42.69662921	0
    66.29213483	0
    84.26966292	0
    106.741573	0
    102.247191	5.670411985
    %108.988764	8.900124844
    %67.41573034	12.29837703
    161.7977528	0
    176.4044944	3.8639201
    210.1123596	5.679151061
    217.9775281	4.799001248
    230.3370787	3.479400749
    375.2808989	1.307116105
    458.4269663	5.066167291 
          ];
units.fR_2C   = {'mug C/L','#/d'};  label.fR_2C = {'food density' ,'egg production', '2 degrees C'}; 
temp.fR_2C = C2K(2); units.temp.fR_2C = 'K'; label.temp.fR_2C = 'temperature';
bibkey.fR_2C = 'MapsRung2005';
comment.fR_2C = 'Population in the Gulf of St. Lawrence (CA)';


%%% THIS DATASET IS STRANGE %%%

% at 6 C
data.fR_6C = [
    37.77777778	7.260923845
    60          5.550561798
    71.11111111	7.111111111
    63.33333333	7.56928839
    103.3333333	9.322097378
    47.77777778	15.90137328
    92.22222222	18.77278402
    88.88888889	21.5855181
    141.1111111	27.81897628
    192.2222222	28.88514357
    131.1111111	15.69538077
    146.6666667	15.45318352
    164.4444444	16.66916355
    172.2222222	12.278402
    293.3333333	13.37827715
    298.8888889	26.74282147 
          ];
units.fR_6C   = {'mug C/L','#/d'};  label.fR_6C = {'food density' ,'egg production', '6 degrees C'}; 
temp.fR_6C = C2K(6); units.temp.fR_6C = 'K'; label.temp.fR_6C = 'temperature';
bibkey.fR_6C = 'MapsRung2005';
comment.fR_6C = 'Population in the Gulf of St. Lawrence (CA)';

% at 10 C
data.fR_10C = [  % food density (mug C/L), egg production (#/d)
    55.55555556	4.320848939
    72.22222222	0.706616729
    82.22222222	6.425717853
    77.77777778	18.34082397
    141.1111111	17.14606742
    113.3333333	22.57053683
    96.66666667	27.30836454
    181.1111111	28.4494382
    162.2222222	35.54931336
    275.5555556	44.29837703
    303.3333333	49.66042447
    293.3333333	26.30087391
    315.5555556	29.64669164
    385.5555556	30.69163546
    455.5555556	26.6803995
];
units.fR_10C   = {'mug C/L','#/d'};  label.fR_10C = {'food density' ,'egg production', '10 degrees C'}; 
temp.fR_10C = C2K(10); units.temp.fR_10C = 'K'; label.temp.fR_10C = 'temperature';
bibkey.fR_10C = 'MapsRung2005';
comment.fR_10C = 'Population in the Gulf of St. Lawrence (CA)';

% at 14 C
data.fR_14C = [
    102.2988506	4.545454545
    117.2413793	8.295454545
    154.0229885	9.772727273
    77.01149425	11.47727273
    64.36781609	12.95454545
    77.01149425	15.45454545
    226.4367816	9.659090909
    255.1724138	14.65909091
    225.2873563	22.27272727
    243.6781609	27.38636364
    174.7126437	35.79545455
    301.1494253 27.95454545
    339.0804598	34.65909091
    396.5517241	40.68181818 
          ];
units.fR_14C   = {'mug C/L','#/d'};  label.fR_14C = {'food density' ,'egg production', '14 degrees C'}; 
temp.fR_14C = C2K(14); units.temp.fR_14C = 'K'; label.temp.fR_14C = 'temperature';
bibkey.fR_14C = 'MapsRung2005';
comment.fR_14C = 'Population in the Gulf of St. Lawrence (CA)';

% at 18 C
data.fR_18C = [
    96.62921348	1.780274657
    103.3707865	2.106117353
    156.1797753	1.491885144
    166.2921348	7.480649189
    210.1123596	0
    229.2134831	0
    239.3258427	2.732833958
    379.7752809	23.02122347
    296.6292135	28.55805243
    325.8426966	31.08114856
    321.3483146	32.75280899
    352.8089888	36.94007491
    373.0337079	39.80649189
    488.7640449	43.56679151
    556.1797753	51.49188514 
          ];  
units.fR_18C   = {'mug C/L','#/d'};  label.fR_18C = {'food density', 'egg production', '18 degrees C'}; 
temp.fR_18C = C2K(18); units.temp.fR_18C = 'K'; label.temp.fR_18C = 'temperature';
bibkey.fR_18C = 'MapsRung2005';
comment.fR_18C = 'Population in the Gulf of St. Lawrence (CA)';



% set weights for all real data
weights = setweights(data, []);
% weights.tLX_2080 = 3 * weights.tLX_2080;
% weights.tLX_1398 = 3 * weights.tLX_1398;
% weights.tLX_478 = 3 * weights.tLX_478;
% weights.tLX_300 = 3 * weights.tLX_300;
% weights.fR_14C = 3 * weights.fR_14C;
% weights.fR_6C = 3 * weights.fR_6C;
% weights.fR_18C = 3 * weights.fR_18C;


%% set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);
weights.psd.p_M = 0 * weights.psd.p_M;      % p_M for waste to hurry strategists doesn't have to be similar to te other entries
weights.psd.kap = 10 * weights.psd.kap;     % kappa was deviating from realism due to large growth datasets

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;
txtData.comment = comment;

%% Group plots
set1 = {'tW1','tW2','tW3','tW4'}; subtitle1 = {'Food density 200, 100, 50, 25 25 mug/L'};
set2 = {'tL_Pete1994','tL_Klei1999'}; subtitle2 = {'Time-Length at different locations'};
set3 = {'tLX_2080','tLX_1398','tLX_478','tLX_300'}; subtitle3 = {'Time-length at different food concentrations 2080, 1398, 478 and 300'};
set4 = {'tLX_165', 'tLX_92', 'tLX_47', 'tLX_29'}; subtitle4 = {'Time-length at different food concentrations 165, 92, 47 and 29'};
set5 = {'tpX_5C','tpX_10C','tpX_15C','tpX_20C'}; subtitle5 = {'Time to puberty at food and temperature'};
set6 = {'fR_2C', 'fR_6C'}; subtitle6 = {'Egg production at food and temperature 2 and 10 degrees'};
set7 = {'fR_10C', 'fR_14C', 'fR_18C'}; subtitle7 = {'Egg production at food and temperature 14, 16 and 18 degrees C'};

metaData.grp.sets = {set1, set2, set3, set4, set5, set6, set7};
metaData.grp.subtitle = {subtitle1, subtitle2, subtitle3, subtitle4, subtitle5, subtitle6, subtitle7};

%% Facts
F1 = 'sexual reproduction in last copepodite stage; 11 moults: 5 naupliar stages, 6 copepodite stages';
metaData.bibkey.F1 = 'Wiki'; 
metaData.facts = struct('F1',F1);

%% Discussion points
D1 = 'mu_X_JR is estimated from EJT_C';
D2 = '5 parameter estimated for TC';   
D3 = 'X_K calculated for each phytoplankton community used in tLX, tpX and f-R experiments';   
D4 = 'X_K_tpX Rhodomonas sp., Isochrysis galbana, traces of Oxyrrhis marina';   
D5 = 'X_K_tLX Oxyrrhis marina, Rhodomonas sp., Isochrysis galbana';  
D6 = 'X_K_fR Oxyrrhis marina, some Isochrysis galbana'; 
metaData.discussion = struct('D1', D1, 'D2', D2, 'D3', D3, 'D4', D4, 'D5', D5, 'D6', D6);

%% Links
metaData.links.id_CoL = '7C33G';                % Cat of Life
metaData.links.id_ITIS = '85877';               % ITIS
metaData.links.id_EoL = '46534191';             % Ency of Life
metaData.links.id_Wiki = 'Temora_longicornis';  % Wikipedia
metaData.links.id_ADW = 'Temora_longicornis';   % ADW
metaData.links.id_Taxo = '71029';               % Taxonomicon
metaData.links.id_WoRMS = '104878';             % WoRMS


%% References
bibkey = 'Wiki'; type = 'Misc'; bib = ...
'howpublished = {\url{https://en.wikipedia.org/wiki/Temora_longicornis}}';
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...  % used in setting of chemical parameters and pseudodata
'author = {Kooijman, S.A.L.M.}, ' ...
'year = {2010}, ' ...
'title  = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
'pages = {Table 4.2 (page 150), 8.1 (page 300)}, ' ...
'howpublished = {\url{../../../bib/Kooy2010.html}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'BakkRijs1987'; type = 'Article'; bib = [ ... 
'author = {Bakker, C. and Rijswijk, P. van}, ' ... 
'year = {1987}, ' ...
'title = {Development time and growth rate of the marina calanoid copepod \emph{Temora longicornis} as related to food conditions in the {O}osterschelde estuary ({S}outhern {N}orth {S}ea)}, ' ...
'journal = {Netherlands Journal of Sea Research}, ' ...
'volume = {21}, ' ...
'number = {2}, '...
'doi = {}, '...
'pages = {125-144}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'SichKior2011'; type = 'Article'; bib = [ ... 
'author = {Sichlau, M. H. and Kiorboe, T.}, ' ... 
'year = {2011}, ' ...
'title = {Age- and size-dependent mating performance and fertility in a pelagic copepod, \emph{Temora longicornis}}, ' ...
'journal = {Marine Ecology Progress Series}, ' ...
'volume = {442}, ' ...
'doi = {10.3354/meps09402}, '...
'pages = {123-132}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
% bibkey = 'JonaViss2009'; type = 'Article'; bib = [ ... 
% 'author = {Jonasdottir, S. H. and Visser, A. W. and Jespersen, C.}, ' ... 
% 'year = {2009}, ' ...
% 'title = {Assessing the role of food quality in the production and hatching of \emph{Temora longicornis} eggs}, ' ...
% 'journal = {Netherlands Journal of Sea Research}, ' ...
% 'volume = {382}, ' ...
% 'doi = {10.3354/meps07985}, '...
% 'pages = {139-150}'];
% metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'BakkRijs1976'; type = 'Article'; bib = [ ... 
'author = {Bakker, C. and Van Rijswijk, P.}, ' ... 
'year = {1976}, ' ...
'title = {Feeding, growth and reproduction of the marine planktonic copepod \emph{Temora longicornis} {M}\"{u}ller}, ' ...
'journal = {Journal of the Marine Biological Association of the United Kingdom}, ' ...
'volume = {56}, ' ...
'pages = {675-690}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'DamLope2003'; type = 'Article'; bib = [ ... 
'author = {Dam, H. G. and Lopes, R. M.}, ' ... 
'year = {2003}, ' ...
'title = {Omnivory in the calanoid copepod \emph{Temora longicornis}: feeding, egg production and egg hatching rates}, ' ...
'journal = {Journal of Experimental Marine Biology and Ecology}, ' ...
'volume = {292}, ' ...
'pages = {119-137}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'MapsRung2005'; type = 'Article'; bib = [ ... 
'author = {Maps, F. and Runge, J. A. and Zakardjian, B. and Joly, P.}, ' ... 
'year = {2005}, ' ...
'title = {Egg production and hatching success of \emph{Temora longicornis} ({C}opepoda, {C}alanoida) in the southern {G}ulf of {S}t. {L}awrence}, ' ...
'journal = {Marine Ecology Progress Series}, ' ...
'volume = {285}, ' ...
'pages = {117-128}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'TiteKior2003'; type = 'Article'; bib = [ ... 
'author = {Titelman, J. and Kiorboe, T.}, ' ... 
'year = {2003}, ' ...
'title = {Motility of copepod nauplii and implications for food encounter}, ' ...
'journal = {Marine Ecology Progress Series}, ' ...
'volume = {247}, ' ...
'pages = {123-135}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Klei1999'; type = 'Article'; bib = [ ... 
'author = {Klein Breteler, W.C.M. and Schogt, N. and Baas, M. and Schouten, S. and Kraay, G.W.}, ' ... 
'year = {1999}, ' ...
'title = {Trophic upgrading of food quality by protozoans enhancing copepod growth: role of essential lipids}, ' ...
'journal = {Marine Biology}, ' ...
'volume = {135}, ' ...
'pages = {191-198}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Klei1982a'; type = 'Article'; bib = [ ... 
'author = {Klein Breteler, W.C.M. and Gonzalez, S.R.}, ' ... 
'year = {1982}, ' ...
'title = {Influence of cultivation and food concentration on body length of calanoid copepods}, ' ...
'journal = {Marine Biology}, ' ...
'volume = {71}, ' ...
'pages = {157-161}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Pete1994'; type = 'Article'; bib = [ ... 
'author = {Peterson, William T. and Kimmerer, William J.}, ' ... 
'year = {1994}, ' ...
'title = {Processes controlling recruitment of the marine calanoid copepod Temora longicornis in Long Island Sound: egg production, egg mortality, and cohort survival rates}, ' ...
'journal = {Limnology and Oceanography}, ' ...
'volume = {39}, ' ...
'pages = {1594-1605}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Dzie2011'; type = 'Article'; bib = [ ... 
'author = {Dzierzbicka-G{\l}owacka, Lidia and Lemieszek, Anna and {\.Z}mijewska, Iwona Maria}, ' ... 
'year = {2011}, ' ...
'title = {Development and growth of Temora longicornis: numerical simulations using laboratory culture data}, ' ...
'journal = {Oceanologia}, ' ...
'volume = {53}, ' ...
'pages = {137-161}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Klei1982b'; type = 'Article'; bib = [ ... 
'author = {Klein Breteler, W.C.M.  and Fransz, H.G. and Gonzalez, S.R.}, ' ... 
'year = {1982}, ' ...
'title = {Growth and development of four calanoid copepod species under experimental and natural conditions}, ' ...
'journal = {Netherlands Journal of Sea Research}, ' ...
'volume = {16}, ' ...
'pages = {195-207}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
