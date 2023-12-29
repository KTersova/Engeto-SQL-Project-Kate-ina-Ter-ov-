-- OTÁZKA 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

-- PRO SELECT NÍŽE JE JIŽ TŘEBA MÍT VYTVOŘENU PRIMÁRNÍ TRABULKU t_katerina_tersova_project_sql_primary_final - viz. Tables / SQL_script_complete

-- Pro zodpovězení otázky máme k dispozici data z let 2006-2018. Rozhodla jsem se tedy porovnat data na počátku, 
-- vprostředku, a na konci tohoto období (roky 2006, 2012 a 2018).

SELECT 
	t_rok_2006.Název_odvětví,
	ROUND(AVG(t_rok_2006.Průměrná_mzda_2006),2) AS Průměrná_mzda_2006,
	ROUND(AVG(t_rok_2012.Průměrná_mzda_2012),2) AS Průměrná_mzda_2012,
	ROUND(AVG(t_rok_2018.Průměrná_mzda_2018),2) AS Průměrná_mzda_2018,
CASE 
	WHEN AVG(t_rok_2018.Průměrná_mzda_2018)>AVG(t_rok_2012.Průměrná_mzda_2012) THEN '+'
	ELSE '-'
END AS 'Změna mzdy 2012-2018',
CASE 
	WHEN AVG(t_rok_2012.Průměrná_mzda_2012)>AVG(t_rok_2006.Průměrná_mzda_2006) THEN '+'
	ELSE '-'
END AS 'Změna mzdy 2006-2012',
CASE 
	WHEN AVG(t_rok_2018.Průměrná_mzda_2018)>AVG(t_rok_2006.Průměrná_mzda_2006) THEN '+'
	ELSE '-'
END AS 'Změna mzdy 2006-2018'
FROM(
	SELECT DISTINCT 
		Název_odvětví,
		Průměrná_mzda AS Průměrná_mzda_2006,
		Rok
	FROM t_katerina_tersova_project_sql_primary_final
	WHERE Rok = '2006') AS t_rok_2006
JOIN( 
	SELECT DISTINCT 
		Název_odvětví,
		Průměrná_mzda AS Průměrná_mzda_2012,
		Rok
	FROM t_katerina_tersova_project_sql_primary_final
	WHERE Rok = '2012') AS t_rok_2012
ON t_rok_2006.Název_odvětví = t_rok_2012.Název_odvětví
JOIN( 
	SELECT DISTINCT 
		Název_odvětví,
		Průměrná_mzda AS Průměrná_mzda_2018,
		Rok
	FROM t_katerina_tersova_project_sql_primary_final
	WHERE Rok = '2018') AS t_rok_2018
ON t_rok_2012.Název_odvětví = t_rok_2018.Název_odvětví
GROUP BY 
	t_rok_2006.Rok,
	t_rok_2006.Název_odvětví;
;

-- ODPOVĚĎ: Jak vidíme, změna ve všech odvětvích ve odvětvích sledovaných časových úsecích je kladná, tedy mzdy vždy rostly. 
