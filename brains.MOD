

//Define variables
//****************************************************************************
var c       ${c}$ (long_name='consumo (intensive form)')
    k       ${k}$ (long_name='capital (intensive form)')
    h	    ${h}$ (long_name='capital humano (intensive form)')
    y       ${y}$ (long_name='producción (intensive form)')
    invest  ${i}$ (long_name='inversión (intensive form)')
    log_c       ${\log c}$ (long_name='log consumo(intensive form)')
    log_k       ${\log k}$ (long_name='log capital (intensive form)')
    log_y       ${\log y}$ (long_name='log producción (intensive form)')
    log_h	${\log h}$ (long_name='log capital humano (intensive form)')
    log_invest  ${\log i}$ (long_name='log inversión (intensive form)')
    g_k_aggregate       ${\Delta K}$ (long_name='tasa de crecimiento del capital agregada')
    g_k_per_capita      ${\Delta \tilde k}$ (long_name='tasa de crecimiento del capital per capita')
    g_k_intensive       ${\Delta k}$ (long_name='tasa de crecimiento del capital en unidades efectivas')
    g_h_aggregate       ${\Delta K}$ (long_name='tasa de crecimiento del capital humano agregada')
    g_h_per_capita      ${\Delta \tilde k}$ (long_name='tasa de crecimiento del capital  humano percapita ')
    g_h_intensive       ${\Delta k}$ (long_name='tasa de crecimiento del capital humano en unidades efectivas')
    	
	
        ;
//****************************************************************************
//bloque definiendo variables exogenas****************************************
//******************************************************************************
	varexo 
  
   e		${e}$ (long_name='tasa de emigrantes')
   j		${j}$ (long_name='tasa de inmigrantes')
;	
//****************************************************************************
//Define predetermined variables
//****************************************************************************
predetermined_variables k;
predetermined_variables h;
//****************************************************************************
//Define parameters
//****************************************************************************
parameters sk   ${sk}$ (long_name='tasa de ahorro en capital')
    sh    	${sh}$ (long_name='tasa de ahorro en capital humano')	
    alpha       ${\alpha}$ (long_name='participación del capital en la producción')
    delta       ${\delta}$ (long_name='tasa de dreciación')
    n           ${n}$ (long_name='tasa de crecimiento de la poblacion')
    g           ${g}$ (long_name='tasa de crecimiento de la teconologia')
    ji		${ji}$ (long_name='participacion del capital humano en la producion')	  
    fi_j_t    	${ fi_j_t}$ (long_name='proporcion de capital humano emigrantes')
    fi_e_t    	${fi_e_t}$ (long_name='proporcion de capital humano inmigrantes')	
    e_inicial
    j_inicial		
;
//****************************************************************************
//set parameters
//****************************************************************************
sk=0.22;
sh=0.42;
alpha=0.39;
delta=0.45;
n=0.01;
g=0.0114;
ji=0.54;
fi_j_t=0.88;
fi_e_t=1.12;
e_inicial=0.2;
j_inicial=0.014;

//****************************************************************************
//enter the model equations (model-block)
//****************************************************************************
model;
[name='ley de movimiento del capital']
k(+1)=sk*(k^alpha*h^ji)-(n+g+delta)*k-(j-e)*k+k;
[name='ley de movimiento del capital humano']
h(+1)=sh*(k^alpha*h^ji)-(n+g+delta)*h+j*(1-fi_j_t)*h+e*(1-fi_e_t)*h+h;
[name='resource constraint']
invest+c=y;
[name='behavioral rule savings']
c=(1-sk-sh)*y;
[name='funcion de produccion']
y=k^alpha*h^ji;
[name='Definition log output']
log_y=(log(y));
[name='Definition log consumption']
log_c=log(c);
[name='Definition log investment']
log_invest=log(invest);
[name='Definition capital decided upon today']
log_k=(log(k(+1)));
[name='Definition capital human decided upon today']
log_h=(log(h(+1)));
[name='Definition capital growth rate between today and tomorrow ']
g_k_intensive=(log(k(+1))-log(k)); //this is capital growth rate between today and tomorrow that is decided upon based on the growth rate of labor augmenting technology between today and tomorrow
[name='Definition capital per capita growth rate between today and tomorrow']
g_k_per_capita=g_k_intensive+g; 
[name='Definition aggregate capital growth rate between today and tomorrow']
g_k_aggregate=(g_k_intensive+g+n+j-e);
[name='Definition capital human growth rate between today and tomorrow ']
g_h_intensive=(log(h(+1))-log(h)); //this is capital growth rate between today and tomorrow that is decided upon based on the growth rate of labor augmenting technology between today and tomorrow
[name='Definition capital human per capita growth rate between today and tomorrow']
g_h_per_capita=(g_h_intensive+g); 
[name='Definition aggregate capital human growth rate between today and tomorrow']
g_h_aggregate=(g_h_intensive+g+n+j-e);  
end;
//****************************************************************************
 
//****************************************************************************
initval;
    k=(((sk*(sh/(n+g+delta+j*(1-fi_j_t)-e*(1-fi_e_t)))^(ji/(1-ji)))/(n+g+delta+j-e))^(1/(1-alpha)))^((1-ji)*(1-alpha)/((1-ji)*(1-alpha)-alpha*ji));
    h=((sh*((((sk*(sh/(n+g+delta+j*(1-fi_j_t)-e*(1-fi_e_t)))^(ji/(1-ji)))/(n+g+delta+j-e))^(1/(1-alpha)))^((1-ji)*(1-alpha)/((1-ji)*(1-alpha)-alpha*ji)))^alpha)/(n+g+delta+j*(1-fi_j_t)-e*(1-fi_e_t)))^(1/(1-alpha));
    y=k^alpha*h^ji;
    c=(1-sk-sh)*y;
    invest=y-c;
    log_y=log(y);
    log_c=log(c);
    log_invest=log(invest);
    log_k=log(k);
    log_h=log(h);	
    g_k_intensive=0;	
    g_k_per_capita=g_k_intensive+g; 
    g_k_aggregate=g_k_intensive+g+n+j-e;
    g_h_intensive=0;
    g_h_per_capita=g_h_intensive+g; 
    g_h_aggregate=g_h_intensive+g+n+j-e;
    e=e_inicial;
    j=j_inicial;
    	
end;

//****************************************************************************
//bloque de choques***********************************************************
//****************************************************************************
//shocks;
//var e;
//periods 1:10;
//values 0.3;
//end;
//****************************************************************************
//endval-block: set terminal condition to steady state value
//****************************************************************************
endval;
    k=(((sk*(sh/(n+g+delta+j*(1-fi_j_t)-e*(1-fi_e_t)))^(ji/(1-ji)))/(n+g+delta+j-e))^(1/(1-alpha)))^((1-ji)*(1-alpha)/((1-ji)*(1-alpha)-alpha*ji));
    h=((sh*((((sk*(sh/(n+g+delta+j*(1-fi_j_t)-e*(1-fi_e_t)))^(ji/(1-ji)))/(n+g+delta+j-e))^(1/(1-alpha)))^((1-ji)*(1-alpha)/((1-ji)*(1-alpha)-alpha*ji)))^alpha)/(n+g+delta+j*(1-fi_j_t)-e*(1-fi_e_t)))^(1/(1-alpha));
    y=k^alpha*h^ji;
    c=(1-sk-sh)*y;
    invest=y-c;
    log_y=log(y);
    log_c=log(c);
    log_invest=log(invest);
    log_k=log(k);
    g_k_intensive=0;
    g_k_per_capita=g_k_intensive+g; 
    g_k_aggregate=g_k_intensive+g+n+j-e;
    g_h_intensive=0;
    g_h_per_capita=g_h_intensive+g; 
    g_h_aggregate=g_h_intensive+g+n+j-e;
    e=0.4;
    j=j_inicial;	
end;
steady;
//****************************************************************************
//resid command: show residuals based on last entered block 
//(should be 0 if our SS was correct)
//****************************************************************************
resid;
//****************************************************************************
//perfect_foresight_setup: set up the simulation for 200 periods
//you can check the settings in oo_.endo_simul (and oo_.exo_simul if there 
//were exogenous variables)
//****************************************************************************
perfect_foresight_setup(periods=200);
//****************************************************************************
//perfect_foresight_solver: compute the solution
//****************************************************************************
perfect_foresight_solver;
//steady;

//****************************************************************************
//rplot command: display simulation results
//****************************************************************************
rplot  log_k;

rplot  log_y;
rplot  log_h;
rplot   g_k_intensive;
rplot   g_h_intensive;
figure('Name','Change in e')
subplot(4,1,1)
plot(log_k)
axis tight
title('Log k in intensive form')
        
subplot(4,1,2)
plot(g_k_intensive)
axis tight
title('Growth rate of per capita k')
subplot(4,1,3)
plot(g_h_intensive)
axis tight
title('Growth rate of per capita h')
subplot(4,1,4)
plot(log_h)
axis tight
title('Log h in intensive form')
