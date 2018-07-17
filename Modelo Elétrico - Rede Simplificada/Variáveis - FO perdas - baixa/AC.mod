# Conjuntos

set Ob;       					# Conjunto de nós
set Ol within Ob cross Ob;  	# Conjunto de ramos
set Ot;       					# Conjunto de intervalos de tempo
set AC;       					# Conjuno de ACs
set BAT;      					# Conjunto de baterias
set PFV;      					# Conjunto de painéis fotovoltáicos
set Of = 1 .. 3 by 1;   		# Conjunto de fases

# Parâmetros do sistema

param dT := 15/60;         		# Detal t = 15 min * 60 segundos (48 pontos)

param Vmino;      				# Tensão mínima do sistema
param Vmaxo;  					# Tensão máxima do sistema

param th1 := 10 * 3.1416/180; 	# Ângulo de desvio máximo negativo (10º)
param th2 := 5 * 3.1416/180; 	# Ângulo de desvio máximo positivo (10º)

param tha := 0;    				# Ângulo da fase a
param thb := -2.0944;   		# Ângulo da fase b (120º)
param thc := 2.0944;   			# Ângulo da fase c (120º)

param neper := 2.71828;

# Parâmetros de carga

param fdem{Ot}; 				# Fator de demanda dos períodos de tempo
param tarifa_branca{Ot};		# Fator que multiplica o preco da energia de acordo com o horario (tarifa branca) [%]
param preco_energia := 0.36448; # Preco da energia R$/kWh

# Nós

param Tipo{Ob};     			# Tipo de barra 1: carga, 0: SE

param Nivel_b{Ob};  			# Nivel de tensão do nó
param Nivel_l{Ol};				# Identifica se o ramo l é primário (Nivel_l = 1), secundário (Nivel_l = 2), ou trafo (Nivel_l = 999)

param at{Ol};     				# Relação de transformação da linha

param PDa{Ob};     				# Potência Ativa de Demanda no nó i na fase A p.u.
param QDa{Ob};     				# Potência Reativa de Demanda no nó i na fase A p.u.
param PDb{Ob};     				# Potência Ativa de Demanda no nó i na fase B p.u.
param QDb{Ob};     				# Potência Reativa de Demanda no nó i na fase B p.u.
param PDc{Ob};     				# Potência Ativa de Demanda no nó i na fase C p.u.
param QDc{Ob};     				# Potência Reativa de Demanda no nó i na fase C p.u.

param Vnom{Ob};     			# Magnitude de tensão nominal do nó
param Vmin{Ob};     			# Magnitude de tensão mínima do nó
param Vmax{Ob};     			# Magnitude de tensão máxima do nó

param Vrae{Ob};     			# Estimação da tensão Fase A
param Viae{Ob};     			# Estimação da tensão Fase A
param Vrbe{Ob};     			# Estimação da tensão Fase B
param Vibe{Ob};     			# Estimação da tensão Fase B
param Vrce{Ob};     			# Estimação da tensão Fase C
param Vice{Ob};     			# Estimação da tensão Fase C

param alfa_a{Ob};   			# Coeficiente da carga ativa Fase A
param alfa_b{Ob};   			# Coeficiente da carga ativa Fase B
param alfa_c{Ob};   			# Coeficiente da carga ativa Fase C

param beta_a{Ob};   			# Coeficiente da carga reativa Fase A
param beta_b{Ob};   			# Coeficiente da carga reativa Fase B
param beta_c{Ob};   			# Coeficiente da carga reativa Fase C

# Ramos

param Raa{Ol};    				# Resistência no circuito na fase A p.u.
param Xaa{Ol};    				# Reatância no circuito na fase A p.u.
param Rbb{Ol};    				# Resistência no circuito na fase B p.u.
param Xbb{Ol};    				# Reatância no circuito na fase B p.u.
param Rcc{Ol};    				# Resistência no circuito na fase C p.u.
param Xcc{Ol};    				# Reatância no circuito na fase C p.u.
param Xab{Ol};    				# Reatância no circuito na fase AB p.u.
param Xbc{Ol};    				# Reatância no circuito na fase BC p.u.
param Xac{Ol};    				# Reatância no circuito na fase AC p.u.
param Rab{Ol};    				# Reatância no circuito na fase AB p.u.
param Rbc{Ol};    				# Reatância no circuito na fase BC p.u.
param Rac{Ol};    				# Reatância no circuito na fase AC p.u.

param Imax{Ol};   				# Magnitude máxima de corrente permitido pelo ramo

# Variáveis do estado

# Tensões

var Vra{Ob,Ot};    				# Parte real da tensão V[i,j] na fase A inicial
var Via{Ob,Ot};    				# Parte imaginaria da tensão  V[i,j] na fase A inicial
var Vrb{Ob,Ot};    				# Parte real da tensão V[i,j] na fase B inicial
var Vib{Ob,Ot};    				# Parte imaginaria da tensão  V[i,j] na fase B inicial
var Vrc{Ob,Ot};    				# Parte real da tensão V[i,j] na fase C inicial
var Vic{Ob,Ot};    				# Parte imaginaria da tensão  V[i,j] na fase C inicial

# Fluxos de Corrente
 
var Ira{Ol,Ot};    				# Parte real do fluxo de corrente I[i,j] na fase A inicial
var Iia{Ol,Ot};    				# Parte imaginaria do fluxo de corrente I[i,j] na fase A inicial
var Irb{Ol,Ot};    				# Parte real do fluxo de corrente I[i,j] na fase B inicial
var Iib{Ol,Ot};    				# Parte imaginaria do fluxo de corrente I[i,j] na fase B inicial
var Irc{Ol,Ot};    				# Parte real do fluxo de corrente I[i,j] na fase C inicial
var Iic{Ol,Ot};    				# Parte imaginaria do fluxo de corrente I[i,j] na fase C inicial
				
# Geração				
				
var ISra{Ob,Ot};   				# Corrente real gerada na subestação na fase A
var ISia{Ob,Ot};   				# Corrente imaginaria gerada na subestação na fase A
var ISrb{Ob,Ot};   				# Corrente real gerada na subestação na fase B
var ISib{Ob,Ot};   				# Corrente imaginaria gerada na subestação na fase B
var ISrc{Ob,Ot};   				# Corrente real gerada na subestação na fase C
var ISic{Ob,Ot};   				# Corrente imaginaria gerada na subestação na fase C

# Parâmetros do ambiente

param Tout{Ot};							# Temperatura externa
param Irradiacao_sem_nuvem{Ot};			# Irradiacao solar [kW/m2]

# Parâmetros e variáveis térmicas das casas

var Tin{AC,Ot,Of};						# Temperatura interna da casa
var Tparede{AC,Ot,Of};					# Temperatura da parede

var Taux{AC,Ot,Of};						# Variáveis auxiliares para cálculo do valor absoluto do "conforto térmico dos usuários"
var Taux1{AC,Ot,Of} >= 0;
var Taux2{AC,Ot,Of} >= 0;

var Pac{AC,Ot,Of} >= 0;					# Potência elétrica de entrada do AC [kW]
var Qac{AC,Ot,Of} >= 0;					# Capacidade de refrigeração do AC [kW]

var on_off{AC,Ot,Of} binary;			# Variável que determina se o AC está ligado ou desligado
var frequency_ac{AC,Ot,Of} >= 0;		# Potência de refrigeração do AC [kW]
var pot_bateria{BAT,Ot,Of};  		# Potência ativa da bateria (+/-)
param deltaT = 2;

###################################################
###################################################

# Aparelhos de Ar Condicionado

param Tset_casa{AC};		# Temperature Setpoint
param Tmax{AC};
param Tmin{AC};

var var_a{AC};
var var_b{AC};

param Ra{AC};				# Resistência térmica da casa
param Ca{AC};				# Capacidade térmica da casa
param Rm{AC};				# Resistência térmica da parede
param Cm{AC};				# Capacidade térmica da parede

param Pnom_ac{AC};			# Potência nominal do aparelho de AC
param COP_nom{AC};			# Coeficiente de performance nominal do aparelho de AC

var pot_min_ac{AC};			# Potência mínima dos aparelhos de AC
var pot_max_ac{AC};			# Potência máxima dos aparelhos de AC

var desconforto{AC,Ot,Of};	# Medida de desconforto térmico do usuário

# Modificadores Pac

var mod_Pac_freq{AC,Ot,Of};	# Modificador de performance dos aparelhos de AC (Pac(freq))
var mod_Pac_Tout{Ot};		# Modificador de performance dos aparelhos de AC (Pac(Tout))	

# Modificadores Qac

var mod_Qac_freq{AC,Ot,Of};	# Modificador de performance dos aparelhos de AC (Qac(freq))	
var mod_Qac_Tout{Ot};		# Modificador de performance dos aparelhos de AC (Qac(Tout))
   
var Iac_re_a{AC,Ot};   				# Corrente real do AC da fase A
var Iac_re_b{AC,Ot};   				# Corrente real do AC da fase B
var Iac_re_c{AC,Ot};   				# Corrente real do AC da fase C
				
var Iac_im_a{AC,Ot};   				# Corrente imag do AC da fase A
var Iac_im_b{AC,Ot};   				# Corrente imag do AC da fase B
var Iac_im_c{AC,Ot};   				# Corrente imag do AC da fase C
				
param AC_Fase_a{AC};   				# Determina operação do AC na Fase A
param AC_Fase_b{AC};   				# Determina operação do AC na Fase B
param AC_Fase_c{AC};   				# Determina operação do AC na Fase C

# BATERIA

var carga_bateria{BAT,Ot,Of} >= 0; 	# Carga da bateria em determinado intervalo de tempo [kWh]

param potencia_nom_bat{BAT}; 		# Potência de carragamento e descarregamento NOMINAIS da bateria [kW]
param eficiencia_bat{BAT};  		# Eficiência de carregamento e descarregamento NOMINAIS da bateria
param capacidade_bat{BAT};  		# Capacidade NOMINAL da bateria [kWh]

param BAT_Fase_a{BAT};  			# Determina operação das BAT da Fase A
param BAT_Fase_b{BAT};  			# Determina operação das BAT da Fase B
param BAT_Fase_c{BAT};  			# Determina operação das BAT da Fase C
			
var Ibat_re_a{BAT,Ot};  			# Corrente real das BAT da Fase A
var Ibat_re_b{BAT,Ot};  			# Corrente real das BAT da Fase B
var Ibat_re_c{BAT,Ot};  			# Corrente real das BAT da Fase C
			
var Ibat_im_a{BAT,Ot};  			# Corrente imag das BAT da Fase A
var Ibat_im_b{BAT,Ot};  			# Corrente imag das BAT da Fase B
var Ibat_im_c{BAT,Ot};  			# Corrente imag das BAT da Fase C   
    
# PAINEIS

param potencia_nom_pfv{PFV};		# Potência nominal do painel [kW]
param eficiencia_pfv{PFV};  		# Eficiência do painel
param num_placas_pfv{PFV};  		# Número de placas solares
param area_pfv{PFV};				# Área dos painéis fotovoltaicos

var pot_pfv{PFV,Ot,Of};

param PFV_Fase_a{PFV};  			# Determina operação dos PFV da Fase A
param PFV_Fase_b{PFV};  			# Determina operação dos PFV da Fase B
param PFV_Fase_c{PFV};  			# Determina operação dos PFV da Fase C
    
var Ipfv_re_a{PFV,Ot}; 				# Corrente real dos PFV da Fase A
var Ipfv_re_b{PFV,Ot}; 				# Corrente real dos PFV da Fase B
var Ipfv_re_c{PFV,Ot}; 				# Corrente real dos PFV da Fase C
				
var Ipfv_im_a{PFV,Ot}; 				# Corrente imag dos PFV da Fase A
var Ipfv_im_b{PFV,Ot}; 				# Corrente imag dos PFV da Fase B
var Ipfv_im_c{PFV,Ot}; 				# Corrente imag dos PFV da Fase C   

#####################################################      
    
# Linearização dos Fluxos de Corrente

var Isqra{Ol,Ot} >= 0;  			# Quadrado das correntes da Fase A
var Isqrb{Ol,Ot} >= 0;  			# Quadrado das correntes da Fase B
var Isqrc{Ol,Ot} >= 0;  			# Quadrado das correntes da Fase C

param lambda;     					# Quantidade de intervalos em que a linearização da corrente é dividida
param m{Ol,1..lambda};
param delmax{Ol};    				# Variável auxiliar para o limite máximo do passo da corrente

var delra{Ol,Ot,1..lambda}>=0;
var delia{Ol,Ot,1..lambda}>=0;
var Irap{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Iram{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Iiap{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Iiam{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos

var delrb{Ol,Ot,1..lambda}>=0;
var delib{Ol,Ot,1..lambda}>=0;
var Irbp{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Irbm{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Iibp{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Iibm{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos

var delrc{Ol,Ot,1..lambda}>=0;
var delic{Ol,Ot,1..lambda}>=0;
var Ircp{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Ircm{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Iicp{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos
var Iicm{Ol,Ot}>=0;    				# Variáveis auxiliares para o cálculo da corrente nos ramos

# Variávies de Demanda

var IDra{Ob,Ot};   					# Corrente real demandada na subestação na fase A inicial
var IDia{Ob,Ot};   					# Corrente imaginaria demandada na subestação na fase A inicial
var IDrb{Ob,Ot};   					# Corrente real demandada na subestação na fase B inicial
var IDib{Ob,Ot};   					# Corrente imaginaria demandada na subestação na fase B inicial
var IDrc{Ob,Ot};   					# Corrente real demandada na subestação na fase C inicial
var IDic{Ob,Ot};   					# Corrente imaginaria demandada na subestação na fase C inicial

#-------------------------------------------- Função Objetivo -----------------------------------------------------------

# Funções objetivo

# Desconforto
	minimize fo_desconforto: 
						(sum {w in AC, t in Ot : AC_Fase_a[w] == 1} (desconforto[w,t,1]))/card(AC)/card(Ot) + 
                        (sum {w in AC, t in Ot : AC_Fase_b[w] == 1} (desconforto[w,t,2]))/card(AC)/card(Ot) + 
                        (sum {w in AC, t in Ot : AC_Fase_c[w] == 1} (desconforto[w,t,3]))/card(AC)/card(Ot) ;

# Consumo de energia

	minimize fo_consumo_potencia_ativa_com_tarifa:
						sum {i in Ob, t in Ot : Tipo[i] == 1} (dT * tarifa_branca[t] * preco_energia) *
							(ISra[i,t] * Vra[i,t] + ISrb[i,t] * Vrb[i,t] + ISrc[i,t] * Vrc[i,t]);
							
	minimize fo_consumo_potencia_reativa_com_tarifa:
						sum {i in Ob, t in Ot : Tipo[i] == 1} (dT * tarifa_branca[t] * preco_energia) *
							(ISia[i,t] * Via[i,t] + ISib[i,t] * Vib[i,t] + ISic[i,t] * Vic[i,t]);
	
	minimize fo_consumo_potencia_ativa_sem_tarifa:
						sum {i in Ob, t in Ot : Tipo[i] == 1} (dT * preco_energia) *
							(ISra[i,t] * Vra[i,t] + ISrb[i,t] * Vrb[i,t] + ISrc[i,t] * Vrc[i,t]);
							
	minimize fo_consumo_potencia_reativa_sem_tarifa:
						sum {i in Ob, t in Ot : Tipo[i] == 1} (dT * preco_energia) *
							(ISia[i,t] * Via[i,t] + ISib[i,t] * Vib[i,t] + ISic[i,t] * Vic[i,t]);

# Consumo de energia dos aparelhos de AC
	minimize fo_consumo_ac_com_tarifa: (sum {w in AC, t in Ot, f in Of} Pac[w,t,f] * dT * tarifa_branca[t] * preco_energia);
	minimize fo_consumo_ac_sem_tarifa: (sum {w in AC, t in Ot, f in Of} Pac[w,t,f] * dT * preco_energia);

# Geração de energia dos PFVs
	minimize fo_consumo_pfv_com_tarifa: (sum {w in AC, t in Ot, f in Of} pot_pfv[w,t,f] * dT * tarifa_branca[t] * preco_energia);
	minimize fo_consumo_pfv_sem_tarifa: (sum {w in AC, t in Ot, f in Of} pot_pfv[w,t,f] * dT * preco_energia);

# Consumo de energia das Baterias
	minimize fo_consumo_bat_com_tarifa: (sum {w in AC, t in Ot, f in Of} pot_bateria[w,t,f] * dT * tarifa_branca[t] * preco_energia);
	minimize fo_consumo_bat_sem_tarifa: (sum {w in AC, t in Ot, f in Of} pot_bateria[w,t,f] * preco_energia);

# Consumo de energia daos Aparelhos
	minimize fo_consumo_aparelhos_com_tarifa:  (sum {w in AC, t in Ot, f in Of} (Pac[w,t,f] + pot_bateria[w,t,f] + pot_pfv[w,t,f]) * dT * tarifa_branca[t] * preco_energia);
	minimize fo_consumo_aparelhos_sem_tarifa:  (sum {w in AC, t in Ot, f in Of} (Pac[w,t,f] + pot_bateria[w,t,f] + pot_pfv[w,t,f]) * dT * preco_energia);

# Perdas ativas								
	minimize fo_perdas_ativas_baixa: sum {(j,i) in Ol, t in Ot : Nivel_l[j,i] != 1} dT * tarifa_branca[t] * preco_energia * 
				(	( (Ira[j,i,t])^2 * Raa[j,i] + (Irb[j,i,t])^2 * Rab[j,i] + (Irc[j,i,t])^2 * Rac[j,i]) +
					( (Ira[j,i,t])^2 * Rab[j,i] + (Irb[j,i,t])^2 * Rbb[j,i] + (Irc[j,i,t])^2 * Rbc[j,i]) +
					( (Ira[j,i,t])^2 * Rac[j,i] + (Irb[j,i,t])^2 * Rbc[j,i] + (Irc[j,i,t])^2 * Rcc[j,i]) );
					 
	minimize fo_perdas_ativas_media: sum {(j,i) in Ol, t in Ot : Nivel_l[j,i] == 1} dT * tarifa_branca[t] * preco_energia * 
					( ( (Ira[j,i,t])^2 * Raa[j,i] + (Irb[j,i,t])^2 * Rab[j,i] + (Irc[j,i,t])^2 * Rac[j,i]) +
					  ( (Ira[j,i,t])^2 * Rab[j,i] + (Irb[j,i,t])^2 * Rbb[j,i] + (Irc[j,i,t])^2 * Rbc[j,i]) +
					  ( (Ira[j,i,t])^2 * Rac[j,i] + (Irb[j,i,t])^2 * Rbc[j,i] + (Irc[j,i,t])^2 * Rcc[j,i]) );					 
					 
					 
					 
#--------------------------------------------- Balanço de fluxos de correntes --------------------------------------
# Balanço de corrente da fase A
 
subject to corrente_balanco_real_a {i in Ob, t in Ot}:
 sum {(j,i) in Ol}(Ira[j,i,t]) - sum {(i,j) in Ol}((1/at[i,j])*Ira[i,j,t]) + 
 ISra[i,t] = IDra[i,t] 
 + sum{w in AC  :  AC_Fase_a[w] == 1 && w == i}(Iac_re_a[w,t])      # Componente de corrente real do AC
 + sum{b in BAT : BAT_Fase_a[b] == 1 && b == i}(Ibat_re_a[b,t])     # Componente de corrente real da BAT
 + sum{p in PFV : PFV_Fase_a[p] == 1 && p == i}(Ipfv_re_a[p,t]);    # Componente de corrente real da PFV

subject to corrente_balanco_imag_a {i in Ob, t in Ot}:
 sum {(j,i) in Ol}(Iia[j,i,t]) - sum {(i,j) in Ol}((1/at[i,j])*Iia[i,j,t]) + 
 ISia[i,t] = IDia[i,t]
 + sum{w in AC  :  AC_Fase_a[w] == 1 && w == i}(Iac_im_a[w,t])      # Componente de corrente imag do AC
 + sum{b in BAT : BAT_Fase_a[b] == 1 && b == i}(Ibat_im_a[b,t])     # Componente de corrente imag da BAT
 + sum{p in PFV : PFV_Fase_a[p] == 1 && p == i}(Ipfv_im_a[p,t]);    # Componente de corrente imag da PFV

# Balanço de corrente da fase B

subject to corrente_balanco_real_b {i in Ob, t in Ot}:
 sum {(j,i) in Ol}(Irb[j,i,t]) - sum {(i,j) in Ol}((1/at[i,j])*Irb[i,j,t]) + 
 ISrb[i,t] = IDrb[i,t]
 + sum{w in AC  :  AC_Fase_b[w] == 1 && w == i}(Iac_re_b[w,t])      # Componente de corrente real do AC
 + sum{b in BAT : BAT_Fase_b[b] == 1 && b == i}(Ibat_re_b[b,t])     # Componente de corrente real da BAT
 + sum{p in PFV : PFV_Fase_b[p] == 1 && p == i}(Ipfv_re_b[p,t]);    # Componente de corrente real da PFV
 
subject to corrente_balanco_imag_b {i in Ob, t in Ot}:
 sum {(j,i) in Ol}(Iib[j,i,t]) - sum {(i,j) in Ol}((1/at[i,j])*Iib[i,j,t]) +
 ISib[i,t] = IDib[i,t]
 + sum{w in AC  :  AC_Fase_b[w] == 1 && w == i}(Iac_im_b[w,t])      # Componente de corrente imag do AC
 + sum{b in BAT : BAT_Fase_b[b] == 1 && b == i}(Ibat_im_b[b,t])     # Componente de corrente imag da BAT
 + sum{p in PFV : PFV_Fase_b[p] == 1 && p == i}(Ipfv_im_b[p,t]);    # Componente de corrente imag da PFV
 
# Balanço de corrente da fase C

subject to corrente_balanco_real_c {i in Ob, t in Ot}:
 sum {(j,i) in Ol}(Irc[j,i,t]) - sum {(i,j) in Ol}((1/at[i,j])*Irc[i,j,t]) + 
 ISrc[i,t] = IDrc[i,t]
 + sum{w in AC  :  AC_Fase_c[w] == 1 && w == i}(Iac_re_c[w,t])      # Componente de corrente real do AC
 + sum{b in BAT : BAT_Fase_c[b] == 1 && b == i}(Ibat_re_c[b,t])     # Componente de corrente real da BAT
 + sum{p in PFV : PFV_Fase_c[p] == 1 && p == i}(Ipfv_re_c[p,t]);    # Componente de corrente real da PFV
 
subject to corrente_balanco_imag_c {i in Ob, t in Ot}:
 sum {(j,i) in Ol}(Iic[j,i,t]) - sum {(i,j) in Ol}((1/at[i,j])*Iic[i,j,t]) + 
 ISic[i,t] = IDic[i,t]
 + sum{w in AC  :  AC_Fase_c[w] == 1 && w == i}(Iac_im_c[w,t])      # Componente de corrente imag do AC
 + sum{b in BAT : BAT_Fase_c[b] == 1 && b == i}(Ibat_im_c[b,t])     # Componente de corrente imag da BAT
 + sum{p in PFV : PFV_Fase_c[p] == 1 && p == i}(Ipfv_im_c[p,t]);    # Componente de corrente imag da PFV
 
#--------------------------------------------- Queda de tensão -------------------------------------------------------------------------------

subject to queda_tensao_real_a {(i,j) in Ol, t in Ot}:
 Vra[i,t]-(at[i,j])*Vra[j,t]=Raa[i,j]*Ira[i,j,t]-Xaa[i,j]*Iia[i,j,t]+Rab[i,j]*Irb[i,j,t]-Xab[i,j]*Iib[i,j,t]+Rac[i,j]*Irc[i,j,t]-Xac[i,j]*Iic[i,j,t];

subject to queda_tensao_imag_a {(i,j) in Ol, t in Ot}:
 Via[i,t]-(at[i,j])*Via[j,t]=Xaa[i,j]*Ira[i,j,t]+Raa[i,j]*Iia[i,j,t]+Xab[i,j]*Irb[i,j,t]+Rab[i,j]*Iib[i,j,t]+Xac[i,j]*Irc[i,j,t]+Rac[i,j]*Iic[i,j,t];

subject to queda_tensao_real_b {(i,j) in Ol, t in Ot}:
 Vrb[i,t]-(at[i,j])*Vrb[j,t]=Rbb[i,j]*Irb[i,j,t]-Xbb[i,j]*Iib[i,j,t]+Rab[i,j]*Ira[i,j,t]-Xab[i,j]*Iia[i,j,t]+Rbc[i,j]*Irc[i,j,t]-Xbc[i,j]*Iic[i,j,t];

subject to queda_tensao_imag_b {(i,j) in Ol, t in Ot}:
 Vib[i,t]-(at[i,j])*Vib[j,t]=Xbb[i,j]*Irb[i,j,t]+Rbb[i,j]*Iib[i,j,t]+Xab[i,j]*Ira[i,j,t]+Rab[i,j]*Iia[i,j,t]+Xbc[i,j]*Irc[i,j,t]+Rbc[i,j]*Iic[i,j,t];

subject to queda_tensao_real_c {(i,j) in Ol, t in Ot}:
 Vrc[i,t]-(at[i,j])*Vrc[j,t]=Rcc[i,j]*Irc[i,j,t]-Xcc[i,j]*Iic[i,j,t]+Rac[i,j]*Ira[i,j,t]-Xac[i,j]*Iia[i,j,t]+Rbc[i,j]*Irb[i,j,t]-Xbc[i,j]*Iib[i,j,t];

subject to queda_tensao_imag_c {(i,j) in Ol, t in Ot}:
 Vic[i,t]-(at[i,j])*Vic[j,t]=Xcc[i,j]*Irc[i,j,t]+Rcc[i,j]*Iic[i,j,t]+Xac[i,j]*Ira[i,j,t]+Rac[i,j]*Iia[i,j,t]+Xbc[i,j]*Irb[i,j,t]+Rbc[i,j]*Iib[i,j,t];

# --------------------------- Demanda de potência ativa e reativa dependente da tensão (Linearização) ---------------------------------------------------------

# Calculo da corrente de carga na fase a
subject to corrente_carga_real_a {i in Ob, t in Ot}:
 IDra[i,t] = fdem[t]*((PDa[i]/(Vnom[i]^alfa_a[i])*Vrae[i])*((Vrae[i]^2 + Viae[i]^2)^(alfa_a[i]/2-1)) + (QDa[i]/(Vnom[i]^beta_a[i])*Viae[i])*((Vrae[i]^2 + Viae[i]^2)^(beta_a[i]/2-1))+
    (PDa[i]/(Vnom[i]^alfa_a[i])*((Vrae[i]^2+Viae[i]^2)-2*Vrae[i]^2*(1-alfa_a[i]/2))*((Vrae[i]^2+Viae[i]^2)^(alfa_a[i]/2-2)) + QDa[i]/(Vnom[i]^beta_a[i])*(-2*(1-beta_a[i]/2)*Vrae[i]*Viae[i])*((Vrae[i]^2+Viae[i]^2)^(beta_a[i]/2-2)))*(Vra[i,t]-Vrae[i]) +
    (QDa[i]/(Vnom[i]^beta_a[i])*((Vrae[i]^2+Viae[i]^2)-2*Viae[i]^2*(1-beta_a[i]/2))*((Vrae[i]^2+Viae[i]^2)^(beta_a[i]/2-2)) + PDa[i]/(Vnom[i]^alfa_a[i])*(-2*(1-alfa_a[i]/2)*Vrae[i]*Viae[i])*((Vrae[i]^2+Viae[i]^2)^(alfa_a[i]/2-2)))*(Via[i,t]-Viae[i]));
 
subject to corrente_carga_imag_a {i in Ob, t in Ot}:
 IDia[i,t] = fdem[t]*((PDa[i]/(Vnom[i]^alfa_a[i])*Viae[i])*((Vrae[i]^2 + Viae[i]^2)^(alfa_a[i]/2-1)) - (QDa[i]/(Vnom[i]^beta_a[i])*Vrae[i])*((Vrae[i]^2 + Viae[i]^2)^(beta_a[i]/2-1))+
    (-QDa[i]/(Vnom[i]^beta_a[i])*((Vrae[i]^2+Viae[i]^2)-2*Vrae[i]^2*(1-beta_a[i]/2))*((Vrae[i]^2+Viae[i]^2)^(beta_a[i]/2-2)) + PDa[i]/(Vnom[i]^alfa_a[i])*(-2*(1-alfa_a[i]/2)*Vrae[i]*Viae[i])*((Vrae[i]^2+Viae[i]^2)^(alfa_a[i]/2-2)))*(Vra[i,t]-Vrae[i]) +
    ( PDa[i]/(Vnom[i]^alfa_a[i])*((Vrae[i]^2+Viae[i]^2)-2*Viae[i]^2*(1-alfa_a[i]/2))*((Vrae[i]^2+Viae[i]^2)^(alfa_a[i]/2-2)) - QDa[i]/(Vnom[i]^beta_a[i])*(-2*(1-beta_a[i]/2)*Vrae[i]*Viae[i])*((Vrae[i]^2+Viae[i]^2)^(beta_a[i]/2-2)))*(Via[i,t]-Viae[i]));

# Calculo da corrente de carga na fase b
subject to corrente_carga_real_b {i in Ob, t in Ot}:
 IDrb[i,t] = fdem[t]*((PDb[i]/(Vnom[i]^alfa_b[i])*Vrbe[i])*((Vrbe[i]^2 + Vibe[i]^2)^(alfa_b[i]/2-1)) + (QDb[i]/(Vnom[i]^beta_b[i])*Vibe[i])*((Vrbe[i]^2 + Vibe[i]^2)^(beta_b[i]/2-1))+
    (PDb[i]/(Vnom[i]^alfa_b[i])*((Vrbe[i]^2+Vibe[i]^2)-2*Vrbe[i]^2*(1-alfa_b[i]/2))*((Vrbe[i]^2+Vibe[i]^2)^(alfa_b[i]/2-2)) + QDb[i]/(Vnom[i]^beta_b[i])*(-2*(1-beta_b[i]/2)*Vrbe[i]*Vibe[i])*((Vrbe[i]^2+Vibe[i]^2)^(beta_b[i]/2-2)))*(Vrb[i,t]-Vrbe[i]) +
    (QDb[i]/(Vnom[i]^beta_b[i])*((Vrbe[i]^2+Vibe[i]^2)-2*Vibe[i]^2*(1-beta_b[i]/2))*((Vrbe[i]^2+Vibe[i]^2)^(beta_b[i]/2-2)) + PDb[i]/(Vnom[i]^alfa_b[i])*(-2*(1-alfa_b[i]/2)*Vrbe[i]*Vibe[i])*((Vrbe[i]^2+Vibe[i]^2)^(alfa_b[i]/2-2)))*(Vib[i,t]-Vibe[i]));
 
subject to corrente_carga_imag_b {i in Ob, t in Ot}:
 IDib[i,t] = fdem[t]*((PDb[i]/(Vnom[i]^alfa_b[i])*Vibe[i])*((Vrbe[i]^2 + Vibe[i]^2)^(alfa_b[i]/2-1)) - (QDb[i]/(Vnom[i]^beta_b[i])*Vrbe[i])*((Vrbe[i]^2 + Vibe[i]^2)^(beta_b[i]/2-1))+
    (-QDb[i]/(Vnom[i]^beta_b[i])*((Vrbe[i]^2+Vibe[i]^2)-2*Vrbe[i]^2*(1-beta_b[i]/2))*((Vrbe[i]^2+Vibe[i]^2)^(beta_b[i]/2-2)) + PDb[i]/(Vnom[i]^alfa_b[i])*(-2*(1-alfa_b[i]/2)*Vrbe[i]*Vibe[i])*((Vrbe[i]^2+Vibe[i]^2)^(alfa_b[i]/2-2)))*(Vrb[i,t]-Vrbe[i]) +
    ( PDb[i]/(Vnom[i]^alfa_b[i])*((Vrbe[i]^2+Vibe[i]^2)-2*Vibe[i]^2*(1-alfa_b[i]/2))*((Vrbe[i]^2+Vibe[i]^2)^(alfa_b[i]/2-2)) - QDb[i]/(Vnom[i]^beta_b[i])*(-2*(1-beta_b[i]/2)*Vrbe[i]*Vibe[i])*((Vrbe[i]^2+Vibe[i]^2)^(beta_b[i]/2-2)))*(Vib[i,t]-Vibe[i]));

# Calculo da corrente de carga na fase c
subject to corrente_carga_real_c {i in Ob, t in Ot}:
 IDrc[i,t] = fdem[t]*((PDc[i]/(Vnom[i]^alfa_c[i])*Vrce[i])*((Vrce[i]^2 + Vice[i]^2)^(alfa_c[i]/2-1)) + (QDc[i]/(Vnom[i]^beta_c[i])*Vice[i])*((Vrce[i]^2 + Vice[i]^2)^(beta_c[i]/2-1))+
    (PDc[i]/(Vnom[i]^alfa_c[i])*((Vrce[i]^2+Vice[i]^2)-2*Vrce[i]^2*(1-alfa_c[i]/2))*((Vrce[i]^2+Vice[i]^2)^(alfa_c[i]/2-2)) + QDc[i]/(Vnom[i]^beta_c[i])*(-2*(1-beta_c[i]/2)*Vrce[i]*Vice[i])*((Vrce[i]^2+Vice[i]^2)^(beta_c[i]/2-2)))*(Vrc[i,t]-Vrce[i]) +
    (QDc[i]/(Vnom[i]^beta_c[i])*((Vrce[i]^2+Vice[i]^2)-2*Vice[i]^2*(1-beta_c[i]/2))*((Vrce[i]^2+Vice[i]^2)^(beta_c[i]/2-2)) + PDc[i]/(Vnom[i]^alfa_c[i])*(-2*(1-alfa_c[i]/2)*Vrce[i]*Vice[i])*((Vrce[i]^2+Vice[i]^2)^(alfa_c[i]/2-2)))*(Vic[i,t]-Vice[i]));
 
subject to corrente_carga_imag_c {i in Ob, t in Ot}:
 IDic[i,t] = fdem[t]*((PDc[i]/(Vnom[i]^alfa_c[i])*Vice[i])*((Vrce[i]^2 + Vice[i]^2)^(alfa_c[i]/2-1)) - (QDc[i]/(Vnom[i]^beta_c[i])*Vrce[i])*((Vrce[i]^2 + Vice[i]^2)^(beta_c[i]/2-1))+
    (-QDc[i]/(Vnom[i]^beta_c[i])*((Vrce[i]^2+Vice[i]^2)-2*Vrce[i]^2*(1-beta_c[i]/2))*((Vrce[i]^2+Vice[i]^2)^(beta_c[i]/2-2)) + PDc[i]/(Vnom[i]^alfa_c[i])*(-2*(1-alfa_c[i]/2)*Vrce[i]*Vice[i])*((Vrce[i]^2+Vice[i]^2)^(alfa_c[i]/2-2)))*(Vrc[i,t]-Vrce[i]) +
    ( PDc[i]/(Vnom[i]^alfa_c[i])*((Vrce[i]^2+Vice[i]^2)-2*Vice[i]^2*(1-alfa_c[i]/2))*((Vrce[i]^2+Vice[i]^2)^(alfa_c[i]/2-2)) - QDc[i]/(Vnom[i]^beta_c[i])*(-2*(1-beta_c[i]/2)*Vrce[i]*Vice[i])*((Vrce[i]^2+Vice[i]^2)^(beta_c[i]/2-2)))*(Vic[i,t]-Vice[i]));

# BEGIN AC

## Tin ##

param Tinicial = 2.0;

	subject to Tin_1_a {w in AC, t in Ot : t = 1 and AC_Fase_a[w] = 1}:
	 Tin[w,t,1] = Tset_casa[w] + Tinicial;    

	subject to Tin_1_b {w in AC, t in Ot : t = 1 and AC_Fase_b[w] = 1}:
	 Tin[w,t,2] = Tset_casa[w] + Tinicial;    

	subject to Tin_1_c {w in AC, t in Ot : t = 1 and AC_Fase_c[w] = 1}:
	 Tin[w,t,3] = Tset_casa[w] + Tinicial;    

	subject to Tin_1_a0 {w in AC, t in Ot  : t = 1 and AC_Fase_a[w] = 0}:
	 Tin[w,t,1] = 0;                     

	subject to Tin_1_b0 {w in AC, t in Ot  : t = 1 and AC_Fase_b[w] = 0}:
	 Tin[w,t,2] = 0;                     

	subject to Tin_1_c0 {w in AC, t in Ot  : t = 1 and AC_Fase_c[w] = 0}:
	 Tin[w,t,3] = 0;

## Parede ##

	subject to Tparede_1_a {w in AC, t in Ot : t = 1 and AC_Fase_a[w] = 1}:
	 Tparede[w,t,1] = Tset_casa[w] + Tinicial;
	 
	subject to Tparede_1_b {w in AC, t in Ot : t = 1 and AC_Fase_b[w] = 1}:
	 Tparede[w,t,2] = Tset_casa[w] + Tinicial;
	 
	subject to Tparede_1_c {w in AC, t in Ot : t = 1 and AC_Fase_c[w] = 1}:
	 Tparede[w,t,3] = Tset_casa[w] + Tinicial;
	 
	subject to Tparede_1_a0 {w in AC, t in Ot : t = 1 and AC_Fase_a[w] = 0}:
	 Tparede[w,t,1] = 0;
	 
	subject to Tparede_1_b0 {w in AC, t in Ot : t = 1 and AC_Fase_b[w] = 0}:
	 Tparede[w,t,2] = 0;
	 
	subject to Tparede_1_c0 {w in AC, t in Ot : t = 1 and AC_Fase_c[w] = 0}:
	 Tparede[w,t,3] = 0;
 
 
## Tin 2 ##
 
	subject to Tin_2a {w in AC, t in Ot : t > 1 and AC_Fase_a[w] = 1}:
	Tin[w,t,1] <= Tset_casa[w] + deltaT;
	
	subject to Tin_2b {w in AC, t in Ot : t > 1 and AC_Fase_b[w] = 1}:
	Tin[w,t,2] <= Tset_casa[w] + deltaT;
	
	subject to Tin_2c {w in AC, t in Ot : t > 1 and AC_Fase_c[w] = 1}:
	Tin[w,t,3] <= Tset_casa[w] + deltaT;
 
## Tin 3 ##
		 
	subject to Tin_3a {w in AC, t in Ot : t > 1 and AC_Fase_a[w] = 1}:
	Tin[w,t,1] >= Tset_casa[w] - deltaT;
	
	subject to Tin_3b {w in AC, t in Ot : t > 1 and AC_Fase_b[w] = 1}:
	Tin[w,t,2] >= Tset_casa[w] - deltaT;  
	
	subject to Tin_3c {w in AC, t in Ot : t > 1 and AC_Fase_c[w] = 1}:
	Tin[w,t,3] >= Tset_casa[w] - deltaT;
 
## Frequency Min ##

	subject to frequency_ac_min_a{w in AC, t in Ot : AC_Fase_a[w] = 1}:
		frequency_ac[w,t,1] >= 20 * on_off[w,t,1];
#		frequency_ac[w,t,1] >= 20;

	subject to frequency_ac_min_b{w in AC, t in Ot : AC_Fase_b[w] = 1}:
		frequency_ac[w,t,2] >= 20 * on_off[w,t,2];
#		frequency_ac[w,t,2] >= 20;

	subject to frequency_ac_min_c{w in AC, t in Ot : AC_Fase_c[w] = 1}:
		frequency_ac[w,t,3] >= 20 * on_off[w,t,3];
#		frequency_ac[w,t,3] >= 20;

	subject to frequency_ac_min_a0{w in AC, t in Ot : AC_Fase_a[w] = 0}:
		frequency_ac[w,t,1] = 0;

	subject to frequency_ac_min_b0{w in AC, t in Ot : AC_Fase_b[w] = 0}:
		frequency_ac[w,t,2] = 0;
		
	subject to frequency_ac_min_c0{w in AC, t in Ot : AC_Fase_c[w] = 0}:
		frequency_ac[w,t,3] = 0;

## Frequency Max ##
	
	subject to frequency_ac_max{w in AC, t in Ot, f in Of}:
		frequency_ac[w,t,f] <= 90 * on_off[w,t,f];
#		frequency_ac[w,t,f] <= 90;
	   
## Mod Pac Freq ##
 
	subject to modificador_Pac_freq_a{w in AC, t in Ot : AC_Fase_a[w] = 1}:
	 mod_Pac_freq[w,t,1] = (0.0136 * frequency_ac[w,t,1] - 0.0456 * on_off[w,t,1]);
	 
	subject to modificador_Pac_freq_b{w in AC, t in Ot : AC_Fase_b[w] = 1}:
	 mod_Pac_freq[w,t,2] = (0.0136 * frequency_ac[w,t,2] - 0.0456 * on_off[w,t,2]);
	 
	subject to modificador_Pac_freq_c{w in AC, t in Ot : AC_Fase_c[w] = 1}:
	 mod_Pac_freq[w,t,3] = (0.0136 * frequency_ac[w,t,3] - 0.0456 * on_off[w,t,3]);

## Mod Pac Tout ##	 
	 
	subject to modificador_Pac_Tout{t in Ot}: 
	 mod_Pac_Tout[t] = (0.0384 * Tout[t] - 0.3436);
 
## Mod Qac Freq ##
 
	subject to modificador_Qac_freq_a{w in AC, t in Ot : AC_Fase_a[w] = 1}:
	 mod_Qac_freq[w,t,1] = (0.0121 * frequency_ac[w,t,1] + 0.0199 * on_off[w,t,1]);
	 
	subject to modificador_Qac_freq_b{w in AC, t in Ot : AC_Fase_b[w] = 1}:
	 mod_Qac_freq[w,t,2] = (0.0121 * frequency_ac[w,t,2] + 0.0199 * on_off[w,t,2]);
 
	subject to modificador_Qac_freq_c{w in AC, t in Ot : AC_Fase_c[w] = 1}:
	 mod_Qac_freq[w,t,3] = (0.0121 * frequency_ac[w,t,3] + 0.0199 * on_off[w,t,3]);

# Mod Qac Tout ##
		 
	subject to modificador_Qac_Tout{t in Ot}: 
	 mod_Qac_Tout[t] = (-0.008 * Tout[t] + 1.28);
 
## Pac ##
 
	subject to restricao_Pac_a{w in AC, t in Ot : AC_Fase_a[w] = 1}:
	Pac[w,t,1] = 0.86 * Pnom_ac[w] * mod_Pac_freq[w,t,1] * mod_Pac_Tout[t];
	
	subject to restricao_Pac_b{w in AC, t in Ot : AC_Fase_b[w] = 1}:
	Pac[w,t,2] = 0.86 * Pnom_ac[w] * mod_Pac_freq[w,t,2] * mod_Pac_Tout[t];
	
	subject to restricao_Pac_c{w in AC, t in Ot : AC_Fase_c[w] = 1}:
	Pac[w,t,3] = 0.86 * Pnom_ac[w] * mod_Pac_freq[w,t,3] * mod_Pac_Tout[t];
 
## Qac ##

	subject to restricao_Qac_a{w in AC, t in Ot : AC_Fase_a[w] = 1}:
	Qac[w,t,1] =  1.20 * Pnom_ac[w] * COP_nom[w] * mod_Qac_freq[w,t,1] * mod_Qac_Tout[t];
	
	subject to restricao_Qac_b{w in AC, t in Ot : AC_Fase_b[w] = 1}:
	Qac[w,t,2] =  1.20 * Pnom_ac[w] * COP_nom[w] * mod_Qac_freq[w,t,2] * mod_Qac_Tout[t];
	
	subject to restricao_Qac_c{w in AC, t in Ot : AC_Fase_c[w] = 1}:
	Qac[w,t,3] =  1.20 * Pnom_ac[w] * COP_nom[w] * mod_Qac_freq[w,t,3] * mod_Qac_Tout[t];
	
	subject to restricao_a{w in AC}:
	var_a[w] = neper ^ ( - (Ra[w]+Rm[w])/(Ra[w]*Rm[w]*Ca[w]) * dT );
	
	subject to restricao_b{w in AC}:
	var_b[w] = neper ^ ( - 1 / (Rm[w] * Cm[w]) * dT );
	
	subject to restricao_Tin_a{w in AC, t in Ot : t > 1 and AC_Fase_a[w] = 1}:
	Tin[w,t,1] = var_a[w] * Tin[w,t-1,1] + (1 - var_a[w]) * Ra[w]/(Ra[w] + Rm[w]) * Tparede[w,t-1,1] +
	(1 - var_a[w])*(Rm[w]/(Ra[w] + Rm[w])*Tout[t-1] - (Ra[w]*Rm[w])/(Ra[w]+Rm[w]) * Qac[w,t-1,1]);
	
	subject to restricao_Tin_b{w in AC, t in Ot : t > 1 and AC_Fase_b[w] = 1}:
	Tin[w,t,2] = var_a[w] * Tin[w,t-1,2] + (1 - var_a[w]) * Ra[w]/(Ra[w] + Rm[w]) * Tparede[w,t-1,2] +
	(1 - var_a[w])*(Rm[w]/(Ra[w] + Rm[w])*Tout[t-1] - (Ra[w]*Rm[w])/(Ra[w]+Rm[w]) * Qac[w,t-1,2]);
	
	subject to restricao_Tin_c{w in AC, t in Ot : t > 1 and AC_Fase_c[w] = 1}:
	Tin[w,t,3] = var_a[w] * Tin[w,t-1,3] + (1 - var_a[w]) * Ra[w]/(Ra[w] + Rm[w]) * Tparede[w,t-1,3] +
	(1 - var_a[w])*(Rm[w]/(Ra[w] + Rm[w])*Tout[t-1] - (Ra[w]*Rm[w])/(Ra[w]+Rm[w]) * Qac[w,t-1,3]);
	
	subject to restricao_Tin_a0{w in AC, t in Ot : t > 1 and AC_Fase_a[w] = 0}:
	Tin[w,t,1] = 0;
	
	subject to restricao_Tin_b0{w in AC, t in Ot : t > 1 and AC_Fase_b[w] = 0}:
	Tin[w,t,2] = 0;
	
	subject to restricao_Tin_c0{w in AC, t in Ot : t > 1 and AC_Fase_c[w] = 0}:
	Tin[w,t,3] = 0;
	
	subject to restricao_Tparede{w in AC, t in Ot, f in Of : t > 1}:
	Tparede[w,t,f] = var_b[w] * Tparede[w,t-1,f] + (1 - var_b[w]) * Tin[w,t-1,f];

	
	subject to Ire_AC_aprox_linear_a {w in AC, t in Ot}:
	Pac[w,t,1] = Vrae[w] * Iac_re_a[w,t] + Viae[w] * Iac_im_a[w,t];
	
	subject to Ire_AC_aprox_linear_b {w in AC, t in Ot}:
	Pac[w,t,2] = Vrbe[w] * Iac_re_b[w,t] + Vibe[w] * Iac_im_b[w,t];
	
	subject to Ire_AC_aprox_linear_c {w in AC, t in Ot}:
	Pac[w,t,3] = Vrce[w] * Iac_re_c[w,t] + Vice[w] * Iac_im_c[w,t];
	
	
	subject to Iim_AC_aprox_linear_a {w in AC, t in Ot}:
	0 = -Vrae[w] * Iac_im_a[w,t] + Viae[w] * Iac_re_a[w,t];
	
	subject to Iim_AC_aprox_linear_b {w in AC, t in Ot}:
	0 = -Vrbe[w] * Iac_im_b[w,t] + Vibe[w] * Iac_re_b[w,t];
	
	subject to Iim_AC_aprox_linear_c {w in AC, t in Ot}:
	0 = -Vrce[w] * Iac_im_c[w,t] + Vice[w] * Iac_re_c[w,t];


	subject to Ire_AC_aprox_linear_a0 {w in AC, t in Ot : AC_Fase_a[w] == 0}:
	Pac[w,t,1] = 0;
	
	subject to Ire_AC_aprox_linear_b0 {w in AC, t in Ot : AC_Fase_b[w] == 0}:
	Pac[w,t,2] = 0;
	
	subject to Ire_AC_aprox_linear_c0 {w in AC, t in Ot : AC_Fase_c[w] == 0}:
	Pac[w,t,3] = 0;
	

# Restrições de desconforto

	subject to conforto_1a{w in AC, t in Ot : AC_Fase_a[w] == 1}:
	desconforto[w,t,1] = Taux1[w,t,1] + Taux2[w,t,1];
	
	subject to conforto_1b{w in AC, t in Ot : AC_Fase_b[w] == 1}:
	desconforto[w,t,2] = Taux1[w,t,2] + Taux2[w,t,2];
	
	subject to conforto_1c{w in AC, t in Ot : AC_Fase_c[w] == 1}:
	desconforto[w,t,3] = Taux1[w,t,3] + Taux2[w,t,3];
	
	subject to conforto_2a{w in AC, t in Ot : AC_Fase_a[w] = 0}:
	desconforto[w,t,1] = 0;
	
	subject to conforto_2b{w in AC, t in Ot : AC_Fase_b[w] = 0}:
	desconforto[w,t,2] = 0;
	
	subject to conforto_2c{w in AC, t in Ot : AC_Fase_c[w] = 0}:
	desconforto[w,t,3] = 0;
	
	subject to conforto_3{w in AC, t in Ot, f in Of}:
	Tin[w,t,f] - Tset_casa[w] = Taux1[w,t,f] - Taux2[w,t,f]; 

# END AC

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
	
	subject to Ire_BAT_aprox_linear_a {b in BAT, t in Ot}:
	pot_bateria[b,t,1] = Vrae[b] * Ibat_re_a[b,t] + Viae[b] * Ibat_im_a[b,t];
	
	subject to Ire_BAT_aprox_linear_b {b in BAT, t in Ot}:
	pot_bateria[b,t,2] = Vrbe[b] * Ibat_re_b[b,t] + Vibe[b] * Ibat_im_b[b,t];
	
	subject to Ire_BAT_aprox_linear_c {b in BAT, t in Ot}:
	pot_bateria[b,t,3] = Vrce[b] * Ibat_re_c[b,t] + Vice[b] * Ibat_im_c[b,t];
	
	
	subject to Iim_BAT_aprox_linear_a {b in BAT, t in Ot}:
	0 = -Vrae[b] * Ibat_im_a[b,t] + Viae[b] * Ibat_re_a[b,t];
	
	subject to Iim_BAT_aprox_linear_b {b in BAT, t in Ot}:
	0 = -Vrbe[b] * Ibat_im_b[b,t] + Vibe[b] * Ibat_re_b[b,t];
	
	subject to Iim_BAT_aprox_linear_c {b in BAT, t in Ot}:
	0 = -Vrce[b] * Ibat_im_c[b,t] + Vice[b] * Ibat_re_c[b,t];
	

	subject to Ire_BAT_aprox_linear_a0 {b in BAT, t in Ot : BAT_Fase_a[b] == 0}:
	pot_bateria[b,t,1] = 0;
	
	subject to Ire_BAT_aprox_linear_b0 {b in BAT, t in Ot : BAT_Fase_b[b] == 0}:
	pot_bateria[b,t,2] = 0;
	
	subject to Ire_BAT_aprox_linear_c0 {b in BAT, t in Ot : BAT_Fase_c[b] == 0}:
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
	
	subject to Ire_PFV_aprox_linear_a {p in PFV, t in Ot}:
	pot_pfv[p,t,1] = Vrae[p] * Ipfv_re_a[p,t] + Viae[p] * Ipfv_im_a[p,t];
	
	subject to Ire_PFV_aprox_linear_b {p in PFV, t in Ot}:
	pot_pfv[p,t,2] = Vrbe[p] * Ipfv_re_b[p,t] + Vibe[p] * Ipfv_im_b[p,t];
	
	subject to Ire_PFV_aprox_linear_c {p in PFV, t in Ot}:
	pot_pfv[p,t,3] = Vrce[p] * Ipfv_re_c[p,t] + Vice[p] * Ipfv_im_c[p,t];
	

	subject to Iim_PFV_aprox_linear_a {p in PFV, t in Ot}:
	0 = -Vrae[p] * Ipfv_im_a[p,t] + Viae[p] * Ipfv_re_a[p,t];
	
	subject to Iim_PFV_aprox_linear_b {p in PFV, t in Ot}:
	0 = -Vrbe[p] * Ipfv_im_b[p,t] + Vibe[p] * Ipfv_re_b[p,t];
	
	subject to Iim_PFV_aprox_linear_c {p in PFV, t in Ot}:
	0 = -Vrce[p] * Ipfv_im_c[p,t] + Vice[p] * Ipfv_re_c[p,t];

	
	subject to Ire_PFV_aprox_linear_a0 {p in PFV, t in Ot : PFV_Fase_a[p] == 0}:
	pot_pfv[p,t,1] = 0;
	
	subject to Ire_PFV_aprox_linear_b0 {p in PFV, t in Ot : PFV_Fase_b[p] == 0}:
	pot_pfv[p,t,2] = 0;
	
	subject to Ire_PFV_aprox_linear_c0 {p in PFV, t in Ot : PFV_Fase_c[p] == 0}:
	pot_pfv[p,t,3] = 0;
	
	
# END PAINEL
 
# -------- Limite de corrente pelos ramos (Linearização) ---------------------------------
# --------------- FASE A ------------------------------------------------------------------

subject to corrente_a1 {(i,j) in Ol, t in Ot}:
 Isqra[i,j,t] = sum{l in 1..lambda} ((m[i,j,l] * delra[i,j,t,l]) + (m[i,j,l] * delia[i,j,t,l]));

subject to corrente_a2 {(i,j) in Ol, t in Ot}:
 Ira[i,j,t] = Irap[i,j,t] - Iram[i,j,t];

subject to corrente_a3 {(i,j) in Ol, t in Ot}: 
 Iia[i,j,t] = Iiap[i,j,t] - Iiam[i,j,t];

subject to corrente_a4 {(i,j) in Ol, t in Ot}:
 Irap[i,j,t] + Iram[i,j,t] = sum{l in 1..lambda} delra[i,j,t,l];
 
subject to corrente_a5 {(i,j) in Ol, t in Ot}:
 Iiap[i,j,t] + Iiam[i,j,t] = sum{l in 1..lambda} delia[i,j,t,l];
 
subject to corrente_a6 {(i,j) in Ol, t in Ot, l in 1..lambda}:
 delra[i,j,t,l] <= delmax[i,j];
 
subject to corrente_a7 {(i,j) in Ol, t in Ot, l in 1..lambda}:
 delia[i,j,t,l] <= delmax[i,j];
 
subject to corrente_a8 {(i,j) in Ol, t in Ot}:
 0 <= Isqra[i,j,t] <= Imax[i,j]^2;
 
# ------------- FASE B ----------------------------------------------------------------

subject to corrente_b1 {(i,j) in Ol, t in Ot}:
 Isqrb[i,j,t] = sum{l in 1..lambda} (m[i,j,l] * delrb[i,j,t,l]) + sum{l in 1..lambda} (m[i,j,l] * delib[i,j,t,l]);

subject to corrente_b2 {(i,j) in Ol, t in Ot}:
 Irb[i,j,t] = Irbp[i,j,t] - Irbm[i,j,t];
 
subject to corrente_b3 {(i,j) in Ol, t in Ot}: 
 Iib[i,j,t] = Iibp[i,j,t] - Iibm[i,j,t];

subject to corrente_b4 {(i,j) in Ol, t in Ot}:
 Irbp[i,j,t] + Irbm[i,j,t] = sum{l in 1..lambda} delrb[i,j,t,l];
 
subject to corrente_b5 {(i,j) in Ol, t in Ot}:
 Iibp[i,j,t] + Iibm[i,j,t] = sum{l in 1..lambda} delib[i,j,t,l];
 
subject to corrente_b6 {(i,j) in Ol, l in 1..lambda, t in Ot}:
 delrb[i,j,t,l] <= delmax[i,j];
 
subject to corrente_b7 {(i,j) in Ol, l in 1..lambda, t in Ot}:
 delib[i,j,t,l] <= delmax[i,j];
 
subject to corrente_b8 {(i,j) in Ol, t in Ot}:
 0 <= Isqrb[i,j,t] <= Imax[i,j]^2;
 
# ----------- FASE C -------------------------------------------------------------------

subject to corrente_c1 {(i,j) in Ol, t in Ot}:
 Isqrc[i,j,t] = sum{l in 1..lambda} (m[i,j,l] * delrc[i,j,t,l]) + 
      sum{l in 1..lambda} (m[i,j,l] * delic[i,j,t,l]);

subject to corrente_c2 {(i,j) in Ol, t in Ot}:
 Irc[i,j,t] = Ircp[i,j,t] - Ircm[i,j,t];
 
subject to corrente_c3 {(i,j) in Ol, t in Ot}: 
 Iic[i,j,t] = Iicp[i,j,t] - Iicm[i,j,t];
 
subject to corrente_c4 {(i,j) in Ol, t in Ot}:
 Ircp[i,j,t] + Ircm[i,j,t] = sum{l in 1..lambda} delrc[i,j,t,l];
 
subject to corrente_c5 {(i,j) in Ol, t in Ot}:
 Iicp[i,j,t] + Iicm[i,j,t] = sum{l in 1..lambda} delic[i,j,t,l];
 
subject to corrente_c6 {(i,j) in Ol, l in 1..lambda, t in Ot}:
 delrc[i,j,t,l] <= delmax[i,j];
 
subject to corrente_c7 {(i,j) in Ol, l in 1..lambda, t in Ot}:
 delic[i,j,t,l] <= delmax[i,j];

subject to corrente_c8 {(i,j) in Ol, t in Ot}:
 0 <= Isqrc[i,j,t] <= Imax[i,j]^2;

#---------------------------------------- Limite de Tensão dos nós (Linearização) --------------------------------------------------------------

# ------- FASE A --------------------------

subject to limite_tensao_a1 {i in Ob, t in Ot}:
 Via[i,t] <= ((sin(tha+th2)-sin(tha-th1))/(cos(tha+th2)-cos(tha-th1)))*(Vra[i,t]-Vmin[i]*cos(tha+th2))+Vmin[i]*sin(tha+th2);

subject to limite_tensao_a2 {i in Ob, t in Ot}:
 Via[i,t] <= ((sin(tha+th2)-sin(tha))/(cos(tha+th2)-cos(tha)))*(Vra[i,t]-Vmax[i]*cos(tha))+Vmax[i]*sin(tha);
 
subject to limite_tensao_a3 {i in Ob, t in Ot}:
 Via[i,t] >= ((sin(tha-th1)-sin(tha))/(cos(tha-th1)-cos(tha)))*(Vra[i,t]-Vmax[i]*cos(tha))+Vmax[i]*sin(tha);

subject to limite_tensao_a4 {i in Ob, t in Ot}:
 Via[i,t] <= Vra[i,t]*tan(tha+th2);
 
subject to limite_tensao_a5 {i in Ob, t in Ot}:
 Via[i,t] >= Vra[i,t]*tan(tha-th1);
 
#-------- FASE B ------------------------

subject to limite_tensao_b1 {i in Ob, t in Ot}:
 Vib[i,t] <= ((sin(thb+th2)-sin(thb-th1))/(cos(thb+th2)-cos(thb-th1)))*(Vrb[i,t]-Vmin[i]*cos(thb+th2))+Vmin[i]*sin(thb+th2);
 
subject to limite_tensao_b2 {i in Ob, t in Ot}:
 Vib[i,t] >= ((sin(thb+th2)-sin(thb))/(cos(thb+th2)-cos(thb)))*(Vrb[i,t]-Vmax[i]*cos(thb))+Vmax[i]*sin(thb);
 
subject to limite_tensao_b3 {i in Ob, t in Ot}:
 Vib[i,t] >= ((sin(thb-th1)-sin(thb))/(cos(thb-th1)-cos(thb)))*(Vrb[i,t]-Vmax[i]*cos(thb))+Vmax[i]*sin(thb);

subject to limite_tensao_b4 {i in Ob, t in Ot}:
 Vib[i,t] >= Vrb[i,t]*tan(thb+th2);
 
subject to limite_tensao_b5 {i in Ob, t in Ot}:
 Vib[i,t] <= Vrb[i,t]*tan(thb-th1);
 
#---------- FASE C --------------------

subject to limite_tensao_c1 {i in Ob, t in Ot}:
 Vic[i,t] >= ((sin(thc+th2)-sin(thc-th1))/(cos(thc+th2)-cos(thc-th1)))*(Vrc[i,t]-Vmin[i]*cos(thc+th2))+Vmin[i]*sin(thc+th2);

subject to limite_tensao_c2 {i in Ob, t in Ot}:
 Vic[i,t] <= ((sin(thc+th2)-sin(thc))/(cos(thc+th2)-cos(thc)))*(Vrc[i,t]-Vmax[i]*cos(thc))+Vmax[i]*sin(thc);
 
subject to limite_tensao_c3 {i in Ob, t in Ot}:
 Vic[i,t] <= ((sin(thc-th1)-sin(thc))/(cos(thc-th1)-cos(thc)))*(Vrc[i,t]-Vmax[i]*cos(thc))+Vmax[i]*sin(thc);

subject to limite_tensao_c4 {i in Ob, t in Ot}:
 Vic[i,t] >= Vrc[i,t]*tan(thc+th2);
 
subject to limite_tensao_c5 {i in Ob, t in Ot}:
 Vic[i,t] <= Vrc[i,t]*tan(thc-th1);
