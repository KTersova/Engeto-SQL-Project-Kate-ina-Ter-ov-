-- OTÁZKA 2: Kolik je možné si koupit litrů mléka a koupit chleba za první a koupit srovnatelné období v dostupných 
-- datech cen a mezd?

-- PRO SELECT NÍŽE JE JIŽ TŘEBA MÍT VYTVOŘENU PRIMÁRNÍ TRABULKU t_katerina_tersova_project_sql_primary_final - viz. Tables / SQL_script_complete

SELECT Produkt,
	Rok,
        ROUND(AVG(Průměrná_mzda), 2) AS Průměrná_mzda,
        ROUND(AVG(Cena),2) AS Cena,
        ROUND(AVG(Průměrná_mzda)/AVG(Cena),0) AS Zakoupitelné_množství
FROM t_katerina_tersova_project_sql_primary_final
WHERE Produkt IN ('Chléb konzumní kmínový','Mléko polotučné pasterované') 
	AND Rok IN ('2006','2018')
GROUP BY 
	Produkt,
	Rok
;

-- ODPOVĚĎ: Vidíme, že zakoupitelné množství se v případě obou sledovaných produktů zvýšílo. V případě kmínového chleba o 57 
-- bochníků, u mléka potom o 205 litrů.
