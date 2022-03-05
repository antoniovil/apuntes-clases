use publications;

describe jobs; -- entender la tabla, el field son las columnas. 

describe titles;

select au_id, length(au_id) from authors; -- length es como len, y le pones la columna

select * from authors;

select concat(au_lname," ", au_fname) as "Nombre Completo" , phone as "Phone" from authors;



select state, group_concat(au_fname) from authors -- medio inutil por que te da el resultado de todos. 
group by state;

select concat(address," - ", (select concat_ws(", ",city, state))) as "Address" from authors; -- concat sobre concat

-- mucho más facil:

create temporary table direcciones
select concat(address, " - ", city, ", ",state) as direccion_completa, au_lname, au_fname from authors;-- esto es lo mejor, ya que acá se le mete todos los separadores

-- buscar nulos 
update titles
set price = avg(price)
where isnull(price) =
	(select isnull(price) as prize_zero from titles -- buscar valores nulos por columna
	where isnull(price) = 1);
    
-- REGEX para SQL 

select * from jobs as j
	where job_desc like "%Man%"  -- aca le estoy diciendo que me busque todo que tenga "Man"
order by job_id;

select * from jobs as j
where job_desc regexp "^Man"; -- misma mierda que antes pero usando el regexp, no entiendo la confusuón

select * from jobs as j
where job_desc regexp "Manager$";

select * from jobs as j
where job_desc regexp "Mark|Man|^Man";

-- FECHAS !!!!!!

select * from titles;
describe titles;

select avg(price)  as "Media de Precio", year(pubdate) as Año from titles
group by Año; -- pero tengo nulos. 

select year(pubdate), price from titles
where year(pubdate) = 2014; -- aca veo a los nulos, que todos los 2014 tienen nulos. 

select round(avg(price),1 ) as "Media de Precio", year(pubdate) as Año from titles
where price is not null -- aca le quiero decir que no me cuenten los nulos
group by Año;-- 

-- EJERCICIO!!

select dayname(t.pubdate) as día, sum(s.qty) as cantidad, round(sum(t.price), 2) as precio, round((sum(s.qty) * sum(t.price)), 2) as precio_total
	from sales as s
	inner join titles as t on s.title_id = t.title_id
	group by día
	order by cantidad desc;
    
-- EJERCICIO 2!! 

-- ¿Cuál es el precio medio por tipo de libro para aquellos libros que tengan un royalty sea mayor que 10?

select type, round(avg(price),2) as Precio_Promedio from titles 
where royalty > 10 
group by type
order by Precio_Promedio desc;

-- cuanto ha vendido cada editorial por año, sin tomar en cuenta los nulos del precio. 


select pub.pub_name as nombre_pub, year(t.pubdate) as Año, (sum(t.price) * sum(s.qty))as ventas_año
from publishers as pub
	inner join titles as t on pub.pub_id = t.pub_id
	inner join sales as s on t.title_id = s.title_id
group by Año, pub.pub_name
order by ventas_año desc;

-- seleccionamos aquello libros que hayan sido vendidos por editoriales que tengan empleados que hayan sido contratados entre 1990 y 1992

create temporary table test
select emp_id, year(hire_date), pub_id from employee
where year(hire_date) between 1990 and 1992;

select pub.pub_id, emp_id
from publishers as pub 
inner join test as em on pub.pub_id = em.pub_id
inner join titles as t on pub.pub_id = t.pub_id
group by pub_id;

-- como lo hizo ANA! 

SELECT title FROM titles
WHERE pub_id IN
(SELECT DISTINCT pub_id FROM employee
WHERE YEAR(hire_date) BETWEEN 1990 and 1992);








