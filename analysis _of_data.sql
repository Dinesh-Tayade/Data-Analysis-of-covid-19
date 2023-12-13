 select *from covid_data;


-- Q.1) What are the percentage of deaths in each country infected by covid-19?
   select country,sum(dead) as sum_of_dead,
                  sum(infected) as sum_of_infected,
                  sum(dead)/sum(infected) *100 as death_percentage
                  from covid_data
                  group by country
                  order by death_percentage desc;
                  
-- Q.2) What are the percentage of deaths in each country even after being vaccinated?
   select country,sum(dead) as sum_of_dead,
                  sum(vaccinated) as sum_of_vaccinated,
                  sum(dead)/sum(vaccinated) *100 as death_percentage
                  from covid_data
                  group by country
                  order by death_percentage desc;
  
  -- Q.3) What is probability of a person would be infected in case of she/he has been vaccinated?
     select country,sum(infected) as sum_of_infected,
                    sum(vaccinated) as sum_of_infected,
                    sum(infected)/sum(vaccinated) *100 as infected_people
                    from covid_data
                    group by country
                    order by infected_people desc;
                    
  -- Q.4) Which country does have the highest death rate compare to population?
      select country,population,sum(dead) as sum_of_dead,
                                sum(dead)/population *100 as highest_death_rate
								from covid_data
								group by country,population
                                order by highest_death_rate desc;
                                
                                
  --  Q.5) Retrieve the top 5 countries with the highest number of confirmed cases.
      select country ,sum(infected) as highest_cases
                      from covid_data
                      group by country
                      order by highest_cases desc
                      limit 5;
                      
  -- Q.6) Retrieve the total number of infected, dead, and vaccinated individuals for each country on the latest date available.
      select country , max(date) as latest_date, 
                       sum(infected) as infected_case,
                       sum(dead) as dead,
                       sum(vaccinated) as vaccinated
                       from covid_data
                       group by country
                       ;
-- Q.7) Find the continents with the highest and lowest average vaccination rates.
     select continent,avg(vaccinated/population) * 100 as vaccination_rates
                      from covid_data
                      group by continent
                      order by vaccination_rates desc;

-- Q.8) Calculate the percentage of the population that is both infected and vaccinated for each country on the latest date available.
    select country , max(date) as latest_date,
                     (sum(infected/population) + sum(vaccinated/population)) * 100 as percent_population_infected_vaccinated
                     from covid_data
                     group by country
                     order by percent_population_infected_vaccinated desc;


-- Q.9) Calculate the 7-day rolling average of deaths for each country.
   select country,date,
   avg(dead) over(partition by country order by date  rows between 6 preceding and current row)
   as rolling_avg_deaths
   from covid_data;
   
-- Q.10) Identify countries where the vaccination rate is higher than the infection rate.
     SELECT country,
			AVG(vaccinated*100/population) AS avg_vaccination_rate,
			AVG(infected*100/population) AS avg_infection_rate
            FROM covid_data
			GROUP BY country
			HAVING avg_vaccination_rate > avg_infection_rate;
            
-- Q.11) Identify countries where the infection rate is higher than the death rate.
    SELECT country,
			AVG(dead*100/population) AS avg_death_rate,
			AVG(infected*100/population) AS avg_infection_rate
            FROM covid_data
			GROUP BY country
			HAVING avg_death_rate < avg_infection_rate;