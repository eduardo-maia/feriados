#!/usr/bin/perl
use Date::Calc qw(Add_Delta_Days);

##############################################################
# OBJETIVO: CRIAR HASH COM FERIADOS MÓVEIS E FIXOS
# ASSIM, CALCULAR FERIADOS MÓVEIS (QUE VARIAM CONFORME A LUA)
##############################################################


# FERIADOS FIXOS NACIONAIS E DO RIO DE JANEIRO, EXCETO FERIADOS MÓVEIS
# FONTE: http://pt.wikipedia.org/wiki/Feriados_no_Brasil
$fixos={
	'01-01' => 'Confraternizacao Universal',
	'04-21' => 'Tiradentes',
	'05-01' => 'Dia do trabalho',
	'09-07' => 'Independencia do Brasil',
	'10-12' => 'Nossa Senhora Aparecida',
	'11-02' => 'Finados',
	'11-15' => 'Proclamacao da Republica',
	'12-25' => 'Natal',
	# abaixo, feriados da cidade do Rio de Janeiro
	'01-20' => 'Sao Sebastiao do Rio de Janeiro',
	'04-23' => 'Sao Jorge',
	'10-17' => 'Dia do comercio',
	'10-28' => 'Dia do Funcionario Publico',
	'11-20' => 'Dia da Consciencia Negra'
	};


# os feriados serão impressos entre os anos do loop abaixo
for ($Y=1980; $Y<=2050; $Y++)
	{
	# BEGIN CÁLCULO DE FERIADOS MÓVEIS, QUE VARIAM CONFORME O ANO / A LUA
	$G = ($Y % 19) + 1; # Numero Áureo
	$C = sprintf("%d",  (($Y/100) + 1)  ); # Seculo
	$X=  sprintf("%d",  (((3*$C)/4) - 12) ); # Primeira Correção
	$Z = sprintf("%d",  ((((8*$C)+5)/25) -5) );#Epacta
	$E = ((11*$G) + 20 + $Z - $X) % 30;
	 
	$E+=1 if((($E == 25) && ($G > 11)) || ($E == 24));
	 
	$N=44-$E; # Lua Cheia
	 
	$N+=30 if($N < 21);
	 
	$D=sprintf("%d",  (((5*$Y)/4)) -($X + 10) );#Domingo
	$N=($N+7)-($D+$N)%7;
	 
	if($N > 31)
		{
		$diapascoa=$N-31;
		$mes=4;
		}
		else
		{
		$diapascoa=$N;
		$mes=3;
		}
	# END CÁLCULO DE FERIADOS MÓVEIS


	# IMPRESSÃO DOS FERIADOS MÓVEIS
	$diapascoa=sprintf("%02d",$diapascoa);
	$mes=sprintf("%02d",$mes);
	print "\$feriado['$Y-$mes-$diapascoa']='Pascoa';\n";

	($year,$month,$day) = Add_Delta_Days($Y,$mes,$diapascoa, -2);
	$day=sprintf("%02d",$day);
	$month=sprintf("%02d",$month);
	print "\$feriado['$year-$month-$day']='Sexta-feira santa';\n";

	($year,$month,$day) = Add_Delta_Days($Y,$mes,$diapascoa, 60);
	$day=sprintf("%02d",$day);
	$month=sprintf("%02d",$month);
	print "\$feriado['$year-$month-$day']='Corpus Christi';\n";


	# IMPRESSÃO DOS FERIADOS FIXOS
	foreach my $key (keys %$fixos)
		{
		print "\$feriado['$Y-$key']=\"$fixos->{$key}\";\n";
		}
	print "\n";
	}