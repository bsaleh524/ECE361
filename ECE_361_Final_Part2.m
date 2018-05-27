%% Final Project: Part 2
%% Basem Saleh
%% John Bucceririrerireiri
%% Nicholas Srylylolo

clear
close all
clc
%% Import Data

data = xlsread('final_data_group3.xls');
Absent = data(1:70);
Present = data(71:100);

%% Rayleigh (Absent)

pdR_Absent = fitdist(Absent, 'rayleigh');
rayA_B=pdR_Absent.B;
[RAh, RAp, stats] = chi2gof(Absent, 'CDF', pdR_Absent);
rayA_chi = stats.chi2stat;
rayA_df = stats.df;

%% Nakagami (Absent)

pdN_Absent = fitdist(Absent, 'nakagami');
nakaA_mu=pdN_Absent.mu; nakaA_omega=pdN_Absent.omega;
[NAh, NAp, stats] = chi2gof(Absent, 'CDF', pdN_Absent);
nakaA_chi = stats.chi2stat;
nakaA_df = stats.df;

%% Rician (Absent)

pdRi_Absent = fitdist(Absent, 'rician');
ricA_s=pdRi_Absent.s; ricA_sigma=pdRi_Absent.sigma;
[RiAh, RiAp, stats] = chi2gof(Absent, 'CDF', pdRi_Absent);
ricA_chi = stats.chi2stat;
ricA_df = stats.df;

%% Gamma (Absent)

pdG_Absent = fitdist(Absent, 'gam');
gammaA_a=pdG_Absent.a; gammaA_b=pdG_Absent.b;
[GAh, GAp, stats] = chi2gof(Absent, 'CDF', pdG_Absent);
gammaA_chi = stats.chi2stat;
gammaA_df = stats.df;


%% Rayleigh (Present)

pdR_Present = fitdist(Present, 'rayleigh');
rayP_B=pdR_Present.B;
[RPh, RPp, stats] = chi2gof(Present, 'CDF', pdR_Present, 'Nbins', 7, 'Emin', 1);
rayP_chi = stats.chi2stat;
rayP_df = stats.df;

%% Nakagami (Present)

pdN_Present = fitdist(Present, 'nakagami');
nakaP_mu=pdN_Present.mu; nakaP_omega=pdN_Present.omega;
[NPh, NPp, stats] = chi2gof(Present, 'CDF', pdN_Present, 'Nbins', 7, 'Emin', 1);
nakaP_chi = stats.chi2stat;
nakaP_df = stats.df;
%% Rician (Present)

pdRi_Present = fitdist(Present, 'rician');
ricP_s=pdRi_Present.s; ricP_sigma=pdRi_Present.sigma;
[RiPh, RiPp, stats] = chi2gof(Present, 'CDF', pdRi_Present, 'Nbins', 7, 'Emin', 1);
ricP_chi = stats.chi2stat;
ricP_df = stats.df;

%% Gamma (Present)

pdG_Present = fitdist(Present, 'gam');
gammaP_a=pdG_Present.a; gammaP_b=pdG_Present.b;
[GPh, GPp, stats] = chi2gof(Present, 'CDF', pdG_Present, 'Nbins', 7, 'Emin', 1);
gammaP_chi = stats.chi2stat;
gammaP_df = stats.df;

%% Analysis

conf_mat_TA = sprintf('         Hypothesis testing-Target Absent (70)\n');
conf_mat_TA_1 = sprintf('gamma hypothesis not rejected, h = %g with x^2 stat = %.2f, Deg. Freedom = %f', GAh, gammaA_chi, gammaA_df);
conf_mat_TA_2 = sprintf('gamma parameters: a = %f, b = %f\n', gammaA_a, gammaA_b);

conf_mat_TP = sprintf('         Hypothesis testing-Target Present (30)\n');
conf_mat_TP_1 = sprintf('rician hypothesis not rejected, h = %g with x^2 stat = %.2f, Deg. Freedom = %f', RiPh, ricP_chi, ricP_df);
conf_mat_TP_2 = sprintf('rician parameters: s = %f, sigma = %f\n', ricP_s, ricP_sigma);

conf_mat_x_title = sprintf('                            Summary of all x^2 tests');
conf_mat_underline = sprintf('==============================================|=========================================');
conf_mat_sub_heading = sprintf('             Target Absent                    |                Target Present');
conf_mat_header_1 = sprintf('%-8s\t %-8s\t %-4s\t %-8s\t %-8s\t %-4s\t %-8s\n',' ', 'h', 'x^2', 'Deg. Freedom |', 'h', 'x^2', 'Deg. Freedom');

conf_mat_x_row1 = sprintf('%-6s\t %-8g\t %.2f\t %-10g\t  |  %-8g\t %.2f\t %-8g\n','Rayleigh', RAh, rayA_chi, rayA_df, RPh, rayP_chi, rayP_df);
conf_mat_x_row2 = sprintf('%-8s\t %-8g\t %.2f\t %-10g\t  |  %-8g\t %.2f\t %-8g\n','Nakagami', NAh, nakaA_chi, nakaA_df, NPh, nakaP_chi, nakaP_df);
conf_mat_x_row3 = sprintf('%-8s\t %-8g\t %.2f\t %-10g\t  |  %-8g\t %.2f\t %-8g\n','Gamma', GAh, gammaA_chi, gammaA_df, GPh, gammaP_chi, gammaP_df);
conf_mat_x_row4 = sprintf('%-8s\t %-8g\t %.2f\t %-10g\t  |  %-8g\t %.2f\t %-8g\n','Rician', RiAh, ricA_chi, ricA_df, RiPh, ricP_chi, ricP_df);


disp(conf_mat_TA)
disp(conf_mat_TA_1)
disp(conf_mat_TA_2)
disp(conf_mat_TP)
disp(conf_mat_TP_1)
disp(conf_mat_TP_2)
disp(conf_mat_x_title);
disp(conf_mat_underline);
disp(conf_mat_sub_heading);
disp(conf_mat_underline);
disp(conf_mat_header_1);
disp(conf_mat_x_row1);
disp(conf_mat_x_row2);
disp(conf_mat_x_row3);
disp(conf_mat_x_row4);

%% Fitted Absent (70)

[f, xi] = ksdensity(Absent); %ksdensity of absent values
plot(xi, f, 'r', 'LineWidth', 1);
xlabel('Values')
ylabel('pdf')
axis([0 20 0 0.25])
hold on

%% Fitted Present (30)

[g, yi] = ksdensity(Present); %ksdensity of present values
plot(yi, g, 'g--', 'LineWidth', 1)
hold on
%% Gamma Absent Plot
x_range = linspace(-2, 18, 100);
y = pdf(pdG_Absent, x_range);
plot(x_range, y, 'k', 'LineWidth', 1);
GName = sprintf('theoretical fit (Target Absent):gamma(%f, %f)', gammaA_a, gammaA_b);
hold on
%% Rician Present Plot
x_range = linspace(0, 18, 100);
y = pdf(pdRi_Present, x_range);
plot(x_range, y, 'b', 'LineWidth', 1);
RiName = sprintf('theoretical fit (Target Present):rician(%f, %f)', ricP_s, ricP_sigma);
legend('data(Target Absent)', 'data(Target Present)', GName, RiName)