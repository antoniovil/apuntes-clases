use publications;

-- ejercicios de My SQL Advance review44

select t.title_id as "Title ID", Price, Royalty, t2.au_id as "Author ID", (t.price * s.qty * t.royalty / 100 * t2.royaltyper / 100) as royalties from titles as t
inner join titleauthor as t2 on t.title_id = t2.title_id
inner join sales as s on t2.title_id = s.title_id;

select title_id, au_id, title, advance, sum(royalties) as royalties from
	(select t.title_id, Price, Royalty, title, royaltyper, advance, t2.au_id, (t.price * s.qty * t.royalty / 100 * t2.royaltyper / 100) as royalties from titles as t
		inner join titleauthor as t2 on t.title_id = t2.title_id
		inner join sales as s on t2.title_id = s.title_id) as tmp
	group by title_id, au_id;

select au_id, round(sum(royalties + advance),2) as profit from (select title_id, au_id, title, advance, sum(royalties) as royalties from
	(select t.title_id, Price, Royalty, title, royaltyper, advance, t2.au_id, (t.price * s.qty * t.royalty / 100 * t2.royaltyper / 100) as royalties from titles as t
		inner join titleauthor as t2 on t.title_id = t2.title_id
		inner join sales as s on t2.title_id = s.title_id) as tmp
		group by title_id, au_id) as tmp2
	group by au_id
    order by profit desc
    limit 3;
    
-- ahora con tablas temporales !! 

create temporary table temp1
select t.title_id, Price, Royalty, title, royaltyper, advance, t2.au_id, (t.price * s.qty * t.royalty / 100 * t2.royaltyper / 100) as royalties from titles as t
inner join titleauthor as t2 on t.title_id = t2.title_id
inner join sales as s on t2.title_id = s.title_id;

drop temporary table if exists temp2;

create temporary table temp2
select sum(royalties) as royalties, title_id, au_id from temp1 
group by title_id, au_id;

select t2.au_id, round(sum(royalties + advance),2) as proft from temp2 as t2
inner join titles as t on t2.title_id = t.title_id
group by au_id
order by proft desc
limit 3;

-- ejercicios 
-- 1
select title, year(pubdate) as año from titles where (year(pubdate) between 1990 and 2000) and price > 10 order by año desc;

-- 2
select t.title, year(max(t.pubdate)) as año, group_concat(a.au_fname," ", a.au_lname separator " - ") as autores, count(a.au_id) as n_autores from titles as t
inner join titleauthor as ta on t.title_id = ta.title_id
inner join authors as a on ta.au_id = a.au_id
group by t.title
order by año desc;

-- 3 
select title, ventas from 
(select st.stor_name as store, t.title, s.qty as ventas from titles as t
	inner join sales as s on t.title_id = s.title_id
	inner join stores as st on s.stor_id = st.stor_id) as tp1
where ventas > 30
order by ventas desc;


