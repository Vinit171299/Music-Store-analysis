create database Music_database
use Music_database

create table album(
album_id int,
title varchar(100),
artist_id int
)

BULK INSERT album
FROM 'C:\Users\xyz\Desktop\music store data\album.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table album2(
album_id int,
title varchar(100),
artist_id int
)

BULK INSERT album2
FROM 'C:\Users\xyz\Desktop\music store data\album2.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table artist(
artist_id int,
Name varchar(100)
)

BULK INSERT artist
FROM 'C:\Users\xyz\Desktop\music store data\artist.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table customer(
customer_id int,
first_name varchar(100),
last_name varchar(100),
company varchar(100),
address varchar(250),
city varchar(100),
state varchar(100),
country varchar(100),
postal_code varchar(100),
phone varchar(100),
fax varchar(100),
email varchar(100),
support_rep_id int
)

BULK INSERT customer
FROM 'C:\Users\xyz\Desktop\music store data\customer.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table employee(
employee_id int,
last_name varchar(100),
first_name varchar(100),
title varchar(100),
reports_to int,
levels varchar(10),
birthdate datetime,
hire_date datetime,
address varchar(250),
city varchar(100),
state varchar(100),
country varchar(100),
postal_code varchar(50),
phone varchar(100),
fax varchar(100),
email varchar(100)
)

BULK INSERT employee
FROM 'C:\Users\xyz\Desktop\music store data\employee.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table genre(
genre_id int,
name varchar(100)
)

BULK INSERT genre
FROM 'C:\Users\xyz\Desktop\music store data\genre.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table invoice(
invoice_id int,
customer_id int,
invoice_date datetime,
billing_address varchar(250),
billing_city varchar(100),
billing_state varchar(100),
billing_country varchar(100),
billing_postal_code varchar(100),
total float,
)

BULK INSERT invoice
FROM 'C:\Users\xyz\Desktop\music store data\invoice.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table invoice_line(
invoice_line_id bigint,
invoice_id bigint,
track_id bigint,
unit_price float,
quantity int
)

BULK INSERT invoice_line
FROM 'C:\Users\xyz\Desktop\music store data\invoice_line.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table media_type(
media_type_id int,
name varchar(120)
)

BULK INSERT media_type
FROM 'C:\Users\xyz\Desktop\music store data\media_type.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table playlist(
playlist_id int,
name varchar(120)
)

BULK INSERT playlist
FROM 'C:\Users\xyz\Desktop\music store data\playlist.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')


create table playlist_track(
playlist_id int,
track_id bigint
)

BULK INSERT playlist_track
FROM 'C:\Users\xyz\Desktop\music store data\playlist_track.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

create table track(
track_id bigint,
name varchar(250),
album_id int,
media_type_id int,
genre_id int,
composer varchar(250),
milliseconds bigint,
bytes bigint,
unit_price float,
)

BULK INSERT track
FROM 'C:\Users\xyz\Desktop\music store data\track.csv'
	WITH (FORMAT ='csv',Firstrow=2,
	      FIELDTERMINATOR = ',',
          ROWTERMINATOR = '\n')

select * from album
select * from album2
select * from artist
select * from customer
select * from employee
select * from genre
select * from invoice
select * from invoice_line
select * from media_type
select * from playlist
select * from playlist_track
select * from track

                        /*	Question Set 1 - Easy */

/* Q1: Who is the senior most employee based on job title? */

select top 1 * from employee
order by levels desc

/* Q2: Which countries have the most Invoices? */

select count(*) as Count, billing_country
from invoice
group by billing_country
order by Count desc

/* Q3: What are top 3 values of total invoice? */

select top 3 *
from invoice
order by total desc

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select top 1 sum(total) as invoice_total,billing_city
from invoice
group by billing_city
order by invoice_total desc

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select * from customer
select * from invoice

select top 1 sum(a.total) as invoice_total,b.customer_id,b.first_name,b.last_name
from invoice a
inner join customer b
on b.customer_id = a.customer_id
group by b.customer_id,b.first_name,b.last_name
order by invoice_total desc


                         /* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select * from customer
select * from genre
select * from invoice
select * from invoice_line
select * from track

select a.first_name,a.last_name,a.email,e.name as Name
from customer a
inner join invoice b on a.customer_id = b.customer_id
inner join invoice_line c on c.invoice_id = b.invoice_id
inner join track d on  d.track_id = c.track_id
inner join genre e on d.genre_id = e.genre_id
where e.name = 'Rock'
order by email


/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select * from genre
select * from track
select * from album
select * from artist

select top 10 c.Name,count(c.artist_id) as Number_of_Songs
from track a
inner join album b on a.album_id = b.album_id
inner join artist c on c.artist_id = b.artist_id
inner join genre d on d.genre_id = a.genre_id
where d.name = 'Rock'
group by c.artist_id,c.Name
order by Number_of_Songs desc

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select * from track

select a.name,a.milliseconds
from track a
where a.milliseconds > (
       select avg(a.milliseconds) as Avg_track_length
	   from track a)
order by a.milliseconds desc

                            
                              /* Question Set 3 - Advance */


/* Q1: Find how much amount spent by each customer on artists? Write a query 
to return customer name, artist name and total spent */

select * from artist
select * from customer
select * from customer

with best_Selling_artist as (
     select top 1 c.artist_id,c.name ,sum(i.unit_price*i.quantity) as total_sales
	 from invoice_line i
     inner join track a on a.track_id = i.track_id
     inner join album b on a.album_id = b.album_id
     inner join artist c on c.artist_id = b.artist_id
	 group by c.artist_id,c.name 
	 order by total_sales desc
	 )
select d.customer_id,d.first_name,d.last_name,z.name,sum(i.unit_price*i.quantity) as amount_spent
from invoice K
inner join customer d on d.customer_id = k.customer_id
inner join invoice_line i on i.invoice_id = k.invoice_id
inner join track a on a.track_id = i.track_id
inner join album b on a.album_id = b.album_id
inner join artist c on c.artist_id = b.artist_id
inner join best_Selling_artist z on z.artist_id = b.artist_id
group by d.customer_id,d.first_name,d.last_name,z.name
order by amount_spent desc

/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */


with popular_genre as 
(
select count(invoice_line.quantity) as Purchases, customer.country, genre.name,
row_number() over(partition by customer.country order by count(invoice_line.quantity)desc) as Row_No
from invoice_line
join invoice on invoice.invoice_id=invoice_line.invoice_id
inner join customer on customer.customer_id = invoice.customer_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
group by customer.country,genre.name
)
select * from popular_genre where Row_No <= 1
