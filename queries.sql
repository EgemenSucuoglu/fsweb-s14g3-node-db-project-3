-- Multi-Table Sorgu Pratiği

-- Tüm ürünler(product) için veritabanındaki ProductName ve CategoryName'i listeleyin. (77 kayıt göstermeli)
select p.ProductName,c.CategoryName from product as p
join category as c on p.CategoryId = p.Id

-- 9 Ağustos 2012 öncesi verilmiş tüm siparişleri(order) için sipariş id'si (Id) ve gönderici şirket adını(CompanyName)'i listeleyin. (429 kayıt göstermeli)
select o.Id as 'OrderId', c.CompanyName as 'SirketAdi' from [Order] as o
join customer as c on c.Id =  o.CustomerId
where o.OrderDate<'2012-08-09'

-- Id'si 10251 olan siparişte verilen tüm ürünlerin(product) sayısını ve adını listeleyin. ProdcutName'e göre sıralayın. (3 kayıt göstermeli)
select Count(p.ProductName) as 'Urun Sayisi' from OrderDetail as od 
join product as p on p.Id = od.ProductId
where OrderId = 10251
order by p.ProductName

-- Her sipariş için OrderId, Müşteri'nin adını(Company Name) ve çalışanın soyadını(employee's LastName). Her sütun başlığı doğru bir şekilde isimlendirilmeli. (16.789 kayıt göstermeli)
select o.Id,c.CompanyName,e.LastName from [Order] as o
join customer as c on o.CustomerId = c.Id
join employee as e on o.EmployeeId = e.Id



-------ESNEK GÖREVLER-----------

--------------Her gönderici tarafından gönderilen gönderi sayısını bulun.-----------

select CustomerId, count(customerId) from [Order] 
group by CustomerId

-------------Sipariş sayısına göre ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.-----------
select e.FirstName,e.LastName,count(o.EmployeeId) 
from [order] as o 
join employee as e on e.Id = o.EmployeeId

group by o.EmployeeId
order by count(o.EmployeeId) desc
-------------Gelir olarak ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.--------------
select e.FirstName,e.LastName, sum(od.UnitPrice*od.Quantity*(1-od.Discount)) from OrderDetail as od
join [order] as o on o.Id = od.OrderId
join employee as e on e.Id = o.EmployeeId

group by o.EmployeeId
order by sum(od.UnitPrice*od.Quantity*(1-od.Discount)) desc
limit 5
----- En az gelir getiren kategoriyi bulun.-----
select categoryName,sum(od.UnitPrice*od.Quantity*(1-od.Discount)) from OrderDetail as od
join [Order] as o on o.Id = od.OrderId
join Product as p on p.Id = od.ProductId
join category as c on c.Id = p.CategoryId

group by p.CategoryId
order by sum(od.UnitPrice*od.Quantity*(1-od.Discount))
limit 1

-----En çok siparişi olan müşteri ülkesini bulun.-----
select c.Country,count(c.Country) from [order] as o
join customer as c on c.Id=o.CustomerId

group by c.Country
order by count(c.Country) desc
limit 1
