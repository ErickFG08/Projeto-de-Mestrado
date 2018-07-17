set AC;       					# Conjuno de ACs
set BAT;      					# Conjunto de baterias
set PFV;      					# Conjunto de painéis fotovoltáicos
set Ot;       					# Conjunto de tempo de planejamento
set Of = 1 .. 3 by 1;   		# Conjunto de fases

param dT := 15/60;         		# Detal t = 15 min * 60 segundos (48 pontos)
param neper := 2.71828;
param z;

# Parâmetros de carga

param fdem{Ot}; 				# Fator de demanda dos períodos de tempo
param tarifa_branca{Ot};		# Fator que multiplica o preco da energia de acordo com o horario (tarifa branca) [%]
param preco_energia := 0.36448; # Preco da energia R$/kWh

# Parâmetros do ambiente

param Tout{Ot};       					# Temperatura externa
param Irradiacao_sem_nuvem{Ot};			# Irradiacao solar [kW/m2]

# Parâmetros e variáveis térmicas das casas

var Tin{AC,Ot,Of};    							# Temperatura interna da casa
var Tparede{AC,Ot,Of};   						# Temperatura da parede
var Taux{AC,Ot,Of};
var Taux1{AC,Ot,Of} >= 0;
var Taux2{AC,Ot,Of} >= 0;
var Pac{AC,Ot,Of} >= 0;				# Potência do AC [kW]
var Qac{AC,Ot,Of} >= 0;

# APARELHOS DE AC

param Tset_casa{AC};				# Temperature Setpoint
param Tmax{AC};
param Tmin{AC};

var var_a{AC};
var var_b{AC};

param Ra{AC};
param Ca{AC};
param Rm{AC};
param Cm{AC};
param Pnom_ac{AC};
param COP_nom{AC};

var desconforto{AC,Ot,Of};			# Medida de desconforto térmico do usuário
var frequency_ac{AC,Ot,Of} >= 0;	# Potência de refrigeração do AC [kW]
var on_off{AC,Ot,Of} binary;		# Variável que determina se o AC está ligado ou desligado

var mod_Pac_freq{AC,Ot,Of};
var mod_Pac_Tout{Ot};
var mod_Qac_freq{AC,Ot,Of};
var mod_Qac_Tout{Ot};

param AC_Fase_a{AC};   				# Determina operação do AC na Fase A
param AC_Fase_b{AC};   				# Determina operação do AC na Fase B
param AC_Fase_c{AC};   				# Determina operação do AC na Fase C

# BATERIAS

var pot_bateria{BAT,Ot,Of};  		# Potência ativa da bateria
var carga_bateria{BAT,Ot,Of} >= 0; 		# Carga da bateria em determinado intervalo de tempo [kWh]

param potencia_nom_bat{BAT}; 		# Potência de carragamento e descarregamento NOMINAIS da bateria [kW]
param eficiencia_bat{BAT};  		# Eficiência de carregamento e descarregamento NOMINAIS da bateria
param capacidade_bat{BAT};  		# Capacidade NOMINAL da bateria [kWh]

param BAT_Fase_a{BAT};  			# Determina operação da BAT na Fase A
param BAT_Fase_b{BAT};  			# Determina operação da BAT na Fase B
param BAT_Fase_c{BAT};  			# Determina operação da BAT na Fase C

#############################################################################

# PAINEIS

param potencia_nom_pfv{PFV};		# Potência nominal do painel [kW]
param eficiencia_pfv{PFV};  		# Eficiência do painel
param num_placas_pfv{PFV};  		# Número de placas solares
param area_pfv{PFV};				# Área dos painéis fotovoltaicos

var pot_pfv{PFV,Ot,Of};

param PFV_Fase_a{PFV};  			# Determina operação dos PFV da Fase A
param PFV_Fase_b{PFV};  			# Determina operação dos PFV da Fase B
param PFV_Fase_c{PFV};  			# Determina operação dos PFV da Fase C

##################################################### 
  
# FUNÇÕES OBJETIVO

minimize fo_desconforto: 
						sum {t in Ot, f in Of} (desconforto[z,t,f])/card(Ot)/card(AC);

minimize fo_consumo_ac:
						sum {t in Ot, f in Of} Pac[z,t,f] * dT * tarifa_branca[t] * preco_energia;

minimize fo_consumo_pfv: 
						sum {t in Ot, f in Of} pot_pfv[z,t,f] * dT * tarifa_branca[t] * preco_energia;

minimize fo_consumo_bat: 
						sum {t in Ot, f in Of} pot_bateria[z,t,f] * dT * tarifa_branca[t] * preco_energia;

minimize fo_consumo_aparelhos:  
						sum {t in Ot, f in Of} (Pac[z,t,f] + pot_bateria[z,t,f] + pot_pfv[z,t,f]) * dT * 1 * preco_energia;

minimize fo_gasto_sem_bateria: 
						sum {t in Ot, f in Of} Pac[z,t,f] * tarifa_branca[t] * dT * preco_energia;
				
minimize fo_gasto_com_bateria: 
						sum {t in Ot, f in Of} (Pac[z,t,f] + pot_bateria[z,t,f]) * tarifa_branca[t] * dT * preco_energia;
						
minimize fo_gasto_com_bateria_e_paineis: 
						sum{t in Ot, f in Of} (Pac[z,t,f] + pot_bateria[z,t,f] + pot_pfv[z,t,f]) * tarifa_branca[t] * dT * preco_energia;

minimize fo_perdas: 
						sum{t in Ot, f in Of} (Pac[z,t,f] + pot_bateria[z,t,f] + pot_pfv[z,t,f])^2 * tarifa_branca[t] * dT * preco_energia;

#############################################################################					
					
# BEGIN AC

## Tin ##

param Tinicial = 2.0;

	subject to Tin_1_a {t in Ot : t = 1 and AC_Fase_a[z] = 1}:
	 Tin[z,t,1] = Tset_casa[z] + Tinicial;    

	subject to Tin_1_b {t in Ot : t = 1 and AC_Fase_b[z] = 1}:
	 Tin[z,t,2] = Tset_casa[z] + Tinicial;    

	subject to Tin_1_c {t in Ot : t = 1 and AC_Fase_c[z] = 1}:
	 Tin[z,t,3] = Tset_casa[z] + Tinicial;    

	subject to Tin_1_a0 {t in Ot  : t = 1 and AC_Fase_a[z] = 0}:
	 Tin[z,t,1] = 0;                     

	subject to Tin_1_b0 {t in Ot  : t = 1 and AC_Fase_b[z] = 0}:
	 Tin[z,t,2] = 0;                     

	subject to Tin_1_c0 {t in Ot  : t = 1 and AC_Fase_c[z] = 0}:
	 Tin[z,t,3] = 0;
	 
## Parede ##
	subject to Tparede_1_a {t in Ot : t = 1 and AC_Fase_a[z] = 1}:
	 Tparede[z,t,1] = Tset_casa[z] + Tinicial;
	 
	subject to Tparede_1_b {t in Ot : t = 1 and AC_Fase_b[z] = 1}:
	 Tparede[z,t,2] = Tset_casa[z] + Tinicial;
	 
	subject to Tparede_1_c {t in Ot : t = 1 and AC_Fase_c[z] = 1}:
	 Tparede[z,t,3] = Tset_casa[z] + Tinicial;
	 
	subject to Tparede_1_a0 {t in Ot : t = 1 and AC_Fase_a[z] = 0}:
	 Tparede[z,t,1] = 0;
	 
	subject to Tparede_1_b0 {t in Ot : t = 1 and AC_Fase_b[z] = 0}:
	 Tparede[z,t,2] = 0;
	 
	subject to Tparede_1_c0 {t in Ot : t = 1 and AC_Fase_c[z] = 0}:
	 Tparede[z,t,3] = 0;
	  
## Tin 2 ##
 
param dTemp = 2;

	subject to Tin_2a {t in Ot : t > 1 and AC_Fase_a[z] = 1}:
	Tin[z,t,1] <= Tset_casa[z] + dTemp;
	
	subject to Tin_2b {t in Ot : t > 1 and AC_Fase_b[z] = 1}:
	Tin[z,t,2] <= Tset_casa[z] + dTemp;
	
	subject to Tin_2c {t in Ot : t > 1 and AC_Fase_c[z] = 1}:
	Tin[z,t,3] <= Tset_casa[z] + dTemp;
 
## Tin 3 ##
		 
	subject to Tin_3a {t in Ot : t > 1 and AC_Fase_a[z] = 1}:
	Tin[z,t,1] >= Tset_casa[z] - dTemp;
	
	subject to Tin_3b {t in Ot : t > 1 and AC_Fase_b[z] = 1}:
	Tin[z,t,2] >= Tset_casa[z] - dTemp;  
	
	subject to Tin_3c {t in Ot : t > 1 and AC_Fase_c[z] = 1}:
	Tin[z,t,3] >= Tset_casa[z] - dTemp;

## Frequency Min ##

	subject to frequency_ac_min_a{t in Ot : AC_Fase_a[z] = 1}:
		frequency_ac[z,t,1] >= 20 * on_off[z,t,1];
#		frequency_ac[z,t,1] >= 20;

	subject to frequency_ac_min_b{t in Ot : AC_Fase_b[z] = 1}:
		frequency_ac[z,t,2] >= 20 * on_off[z,t,2];
#		frequency_ac[z,t,2] >= 20;

	subject to frequency_ac_min_c{t in Ot : AC_Fase_c[z] = 1}:
		frequency_ac[z,t,3] >= 20 * on_off[z,t,3];
#		frequency_ac[z,t,3] >= 20;

	subject to frequency_ac_min_a0{t in Ot : AC_Fase_a[z] = 0}:
		frequency_ac[z,t,1] = 0;

	subject to frequency_ac_min_b0{t in Ot : AC_Fase_b[z] = 0}:
		frequency_ac[z,t,2] = 0;
		
	subject to frequency_ac_min_c0{t in Ot : AC_Fase_c[z] = 0}:
		frequency_ac[z,t,3] = 0;

## Frequency Max ##
	
	subject to frequency_ac_max{t in Ot, f in Of}:
		frequency_ac[z,t,f] <= 90 * on_off[z,t,f];
#		frequency_ac[z,t,f] <= 90;
	   
## Mod Pac Freq ##
 
	subject to modificador_Pac_freq_a{t in Ot : AC_Fase_a[z] = 1}:
	 mod_Pac_freq[z,t,1] = (0.0136 * frequency_ac[z,t,1] - 0.0456 * on_off[z,t,1]);
#	 mod_Pac_freq[z,t,1] = (0.0136 * frequency_ac[z,t,1] - 0.0456);
	 
	subject to modificador_Pac_freq_b{t in Ot : AC_Fase_b[z] = 1}:
	 mod_Pac_freq[z,t,2] = (0.0136 * frequency_ac[z,t,2] - 0.0456 * on_off[z,t,2]);
#	 mod_Pac_freq[z,t,2] = (0.0136 * frequency_ac[z,t,2] - 0.0456);
	 
	subject to modificador_Pac_freq_c{t in Ot : AC_Fase_c[z] = 1}:
	 mod_Pac_freq[z,t,3] = (0.0136 * frequency_ac[z,t,3] - 0.0456 * on_off[z,t,3]);
#	 mod_Pac_freq[z,t,3] = (0.0136 * frequency_ac[z,t,3] - 0.0456);


## Mod Pac Tout ##	 
	 
	subject to modificador_Pac_Tout{t in Ot}: 
	 mod_Pac_Tout[t] = (0.0384 * Tout[t] - 0.3436);
 
## Mod Qac Freq ##
 
	subject to modificador_Qac_freq_a{t in Ot : AC_Fase_a[z] = 1}:
	 mod_Qac_freq[z,t,1] = (0.0121 * frequency_ac[z,t,1] + 0.0199 * on_off[z,t,1]);
#	 mod_Qac_freq[z,t,1] = (0.0121 * frequency_ac[z,t,1] + 0.0199);
	 
	subject to modificador_Qac_freq_b{t in Ot : AC_Fase_b[z] = 1}:
	 mod_Qac_freq[z,t,2] = (0.0121 * frequency_ac[z,t,2] + 0.0199 * on_off[z,t,2]);
#	 mod_Qac_freq[z,t,2] = (0.0121 * frequency_ac[z,t,2] + 0.0199);
	 
	subject to modificador_Qac_freq_c{t in Ot : AC_Fase_c[z] = 1}:
	 mod_Qac_freq[z,t,3] = (0.0121 * frequency_ac[z,t,3] + 0.0199 * on_off[z,t,3]);
#	 mod_Qac_freq[z,t,3] = (0.0121 * frequency_ac[z,t,3] + 0.0199);

# Mod Qac Tout ##
		 
	subject to modificador_Qac_Tout{t in Ot}: 
	 mod_Qac_Tout[t] = (-0.008 * Tout[t] + 1.28);
 
## Pac ##
 
	subject to restricao_Pac_a{t in Ot : AC_Fase_a[z] = 1}:
	Pac[z,t,1] = 0.86 * Pnom_ac[z] * mod_Pac_freq[z,t,1] * mod_Pac_Tout[t];
	
	subject to restricao_Pac_b{t in Ot : AC_Fase_b[z] = 1}:
	Pac[z,t,2] = 0.86 * Pnom_ac[z] * mod_Pac_freq[z,t,2] * mod_Pac_Tout[t];
	
	subject to restricao_Pac_c{t in Ot : AC_Fase_c[z] = 1}:
	Pac[z,t,3] = 0.86 * Pnom_ac[z] * mod_Pac_freq[z,t,3] * mod_Pac_Tout[t];
 
## Qac ##

	subject to restricao_Qac_a{t in Ot : AC_Fase_a[z] = 1}:
	Qac[z,t,1] =  1.20 * Pnom_ac[z] * COP_nom[z] * mod_Qac_freq[z,t,1] * mod_Qac_Tout[t];
	
	subject to restricao_Qac_b{t in Ot : AC_Fase_b[z] = 1}:
	Qac[z,t,2] =  1.20 * Pnom_ac[z] * COP_nom[z] * mod_Qac_freq[z,t,2] * mod_Qac_Tout[t];
	
	subject to restricao_Qac_c{t in Ot : AC_Fase_c[z] = 1}:
	Qac[z,t,3] =  1.20 * Pnom_ac[z] * COP_nom[z] * mod_Qac_freq[z,t,3] * mod_Qac_Tout[t];
	
	subject to restricao_a{t in Ot}:
	var_a[z] = neper ^ ( - (Ra[z]+Rm[z])/(Ra[z]*Rm[z]*Ca[z]) * dT );
	
	subject to restricao_b{t in Ot}:
	var_b[z] = neper ^ ( - 1 / (Rm[z] * Cm[z]) * dT );
	
	subject to restricao_Tin_a{t in Ot : t > 1 and AC_Fase_a[z] = 1}:
	Tin[z,t,1] = var_a[z] * Tin[z,t-1,1] + (1 - var_a[z]) * Ra[z]/(Ra[z] + Rm[z]) * Tparede[z,t-1,1] +
	(1 - var_a[z])*(Rm[z]/(Ra[z] + Rm[z])*Tout[t-1] - (Ra[z]*Rm[z])/(Ra[z]+Rm[z]) * Qac[z,t-1,1]);
	
	subject to restricao_Tin_b{t in Ot : t > 1 and AC_Fase_b[z] = 1}:
	Tin[z,t,2] = var_a[z] * Tin[z,t-1,2] + (1 - var_a[z]) * Ra[z]/(Ra[z] + Rm[z]) * Tparede[z,t-1,2] +
	(1 - var_a[z])*(Rm[z]/(Ra[z] + Rm[z])*Tout[t-1] - (Ra[z]*Rm[z])/(Ra[z]+Rm[z]) * Qac[z,t-1,2]);
	
	subject to restricao_Tin_c{t in Ot : t > 1 and AC_Fase_c[z] = 1}:
	Tin[z,t,3] = var_a[z] * Tin[z,t-1,3] + (1 - var_a[z]) * Ra[z]/(Ra[z] + Rm[z]) * Tparede[z,t-1,3] +
	(1 - var_a[z])*(Rm[z]/(Ra[z] + Rm[z])*Tout[t-1] - (Ra[z]*Rm[z])/(Ra[z]+Rm[z]) * Qac[z,t-1,3]);
	
	subject to restricao_Tin_a0{t in Ot : t > 1 and AC_Fase_a[z] = 0}:
	Tin[z,t,1] = 0;
	
	subject to restricao_Tin_b0{t in Ot : t > 1 and AC_Fase_b[z] = 0}:
	Tin[z,t,2] = 0;
	
	subject to restricao_Tin_c0{t in Ot : t > 1 and AC_Fase_c[z] = 0}:
	Tin[z,t,3] = 0;
	
	subject to restricao_Tparede{t in Ot, f in Of : t > 1}:
	Tparede[z,t,f] = var_b[z] * Tparede[z,t-1,f] + (1 - var_b[z]) * Tin[z,t-1,f];

# Restrições de desconforto

	subject to conforto_1a{t in Ot : AC_Fase_a[z] == 1}:
	desconforto[z,t,1] = Taux1[z,t,1] + Taux2[z,t,1];
	
	subject to conforto_1b{t in Ot : AC_Fase_b[z] == 1}:
	desconforto[z,t,2] = Taux1[z,t,2] + Taux2[z,t,2];
	
	subject to conforto_1c{t in Ot : AC_Fase_c[z] == 1}:
	desconforto[z,t,3] = Taux1[z,t,3] + Taux2[z,t,3];
	
	subject to conforto_2a{t in Ot : AC_Fase_a[z] = 0}:
	desconforto[z,t,1] = 0;
	
	subject to conforto_2b{t in Ot : AC_Fase_b[z] = 0}:
	desconforto[z,t,2] = 0;
	
	subject to conforto_2c{t in Ot : AC_Fase_c[z] = 0}:
	desconforto[z,t,3] = 0;
	
	subject to conforto_3{t in Ot, f in Of}:
	Tin[z,t,f] - Tset_casa[z] = Taux1[z,t,f] - Taux2[z,t,f]; 

# END AC

#############################################################################

# BEGIN BATTERY

	subject to restricao_bat_0_1{b in BAT, t in Ot, f in Of : t = 1}:
	carga_bateria[b,t,f] = 0;
	
	subject to restricao_bat_0_2{b in BAT, t in Ot, f in Of : t = card(Ot)}:
	carga_bateria[b,t,f] = carga_bateria[b,1,f]; 
	
	subject to restricao_bat_1{b in BAT, t in Ot, f in Of : t > 1}:
	carga_bateria[b,t,f] = carga_bateria[b,t-1,f] + eficiencia_bat[b] * pot_bateria[b,t-1,f] * dT;
	
	subject to restricao_bat_2{b in BAT, t in Ot, f in Of}:
	0 <= carga_bateria[b,t,f];
	
	subject to restricao_bat_3{b in BAT, t in Ot, f in Of}:
	carga_bateria[b,t,f] <= capacidade_bat[b];
	
	subject to restricao_bat_4{b in BAT, t in Ot, f in Of}:
	- potencia_nom_bat[b] <= pot_bateria[b,t,f];
	
	subject to restricao_bat_5{b in BAT, t in Ot, f in Of}:
	pot_bateria[b,t,f] <= potencia_nom_bat[b];
	
	subject to restricao_bat_6 {b in BAT, t in Ot : BAT_Fase_a[b] == 0}:
	pot_bateria[b,t,1] = 0;
	
	subject to restricao_bat_7 {b in BAT, t in Ot : BAT_Fase_b[b] == 0}:
	pot_bateria[b,t,2] = 0;	

	subject to restricao_bat_8 {b in BAT, t in Ot : BAT_Fase_c[b] == 0}:
	pot_bateria[b,t,3] = 0;
	
# END BATTERY

# BEGIN PAINEL

	subject to restricao_pfv_0_a1{p in PFV, t in Ot : PFV_Fase_a[p] == 1}:
	pot_pfv[p,t,1] = - num_placas_pfv[p] * area_pfv[p] * eficiencia_pfv[p] *
	(1 - 0.00375 * (Tout[t] - 24)) * Irradiacao_sem_nuvem[t];
	
	subject to restricao_pfv_0_a0{p in PFV, t in Ot : PFV_Fase_a[p] == 0}:
	pot_pfv[p,t,1] = 0;
	
	subject to restricao_pfv_0_b1{p in PFV, t in Ot : PFV_Fase_b[p] == 1}:
	pot_pfv[p,t,2] = - num_placas_pfv[p] * area_pfv[p] * eficiencia_pfv[p] *
	(1 - 0.00375 * (Tout[t] - 24)) * Irradiacao_sem_nuvem[t];
	
	subject to restricao_pfv_0_b0{p in PFV, t in Ot : PFV_Fase_b[p] == 0}:
	pot_pfv[p,t,2] = 0;
	
	subject to restricao_pfv_0_c1{p in PFV, t in Ot : PFV_Fase_c[p] == 1}:
	pot_pfv[p,t,3] = - num_placas_pfv[p] * area_pfv[p] * eficiencia_pfv[p] *
	(1 - 0.00375 * (Tout[t] - 24)) * Irradiacao_sem_nuvem[t];
	
	subject to restricao_pfv_0_c0{p in PFV, t in Ot : PFV_Fase_c[p] == 0}:
	pot_pfv[p,t,3] = 0;

# END PAINEL