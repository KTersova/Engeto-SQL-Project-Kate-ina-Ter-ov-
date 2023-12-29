-- OTÁZKA 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom 
-- roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

-- PRO SELECT NÍŽE JE JIŽ TŘEBA MÍT VYTVOŘENY POMOCNÉ, PRIMÁRNÍ A SEKUNDÁRNÍ TABULKY - viz. Tables / SQL_script_complete
-- t_katerina_tersova_rocni_zmeny_mezd 
-- t_katerina_tersova_rocni_zmeny_cen
-- t_katerina_tersova_project_sql_primary_final
-- t_katerina_tersova_project_sql_secondary_final

SELECT
    hdp.Rok,
    hdp.Země,
    -- LAG(hdp.HDP) OVER (PARTITION BY hdp.Země ORDER BY hdp.Rok) AS Predchozi_rok_HDP,
    ROUND((hdp.HDP - LAG(hdp.HDP) 
    	OVER (PARTITION BY hdp.Země ORDER BY hdp.Rok)) / LAG(hdp.HDP) 
    	OVER (PARTITION BY hdp.Země ORDER BY hdp.Rok) * 100, 2) 
    		AS Mezirocni_rozdil_HDP,
    mzdy.Roční_procentuální_změna AS Meziroční_procentuální_změna_mezd,
    ROUND(AVG(ceny.Roční_procentuální_změna), 2) AS Meziroční_procentuální_změna_cen
FROM
    t_katerina_tersova_project_sql_secondary_final AS hdp
JOIN
    t_katerina_tersova_rocni_zmeny_mezd mzdy ON hdp.Rok = mzdy.Rok
JOIN
    t_katerina_tersova_rocni_zmeny_cen ceny ON hdp.Rok = ceny.Rok
WHERE
    hdp.Země = 'Czech Republic'
GROUP BY
    hdp.Rok, hdp.Země, hdp.HDP
ORDER BY
    hdp.Rok
;
    
-- ODPOVĚĎ: Jak vidíme, meziroční změny HDP se v nadcházejícím roce vždy projevily na růstu mezd. V případě propadu 
-- HDP v následujícím roce mzdy rostly oproti předcházejícím letům pomaleji. Naopak v případě rychle rostoucího HDP 
-- (například v roce 2015) můžeme v následujícím roce pozorovat veliký nárůst mezd, a to o 5.9%. 
-- Naproti tomu vztah mezi HDP a cenami potravin již tak zřejmý není. V některých letech by se mohlo zdát, že rostoucí
-- HDP má za důsledek zlevňování (roky 2014 až 2016), nicméně toto nám vyvrací hned rok 2017, kdy je nárůst HDP sice 
-- značný, ale ceny vyrostly o více než 7%. Zde bych tedy žádnou vazbu na základě těchto dat nehledala.
