
--Trabajar con la base de datos RRHH desde el Managment Studio de Sql Server
use rrhh

--1.Consulta que devuelva Apellido, dept_id, el salario de empleado. Una columna adicional que sume 1000 a cada salario.
--Coloque alias a las columnas de la consulta.
--Ordenar la consulta de mayor a menor seg�n el salario.
--Solo muestre los empleados que ganan entre $5000 y $12000. Y que sean de los siguientes departamentos 60,80 y 110.

SELECT e.empleado_apellido as 'Apellido', e.dept_id as 'Dept_ID', 
e.empleado_salario as 'Salario', (e.empleado_salario + 1000) as 'Salario mas 1000'
FROM empleados e
WHERE e.empleado_salario between 5000 and 12000 and e.dept_id in (60,80,110)
ORDER BY  e.empleado_salario desc;


--2. Consulta para mostrar el nombre de los deprtamentos, y promedio de los salarios de los empleados de ese departamento
--Solo muestre aquellos departamentos que tienen mas de 2 empleados.

SELECT d.dept_nom as 'Nombre de dpto', ROUND(AVG(e.empleado_salario), 2) as 'Salario promedio'
FROM departamentos d
JOIN empleados e 
on d.dept_id = e.dept_id
GROUP BY d.dept_nom
HAVING count (e.empleado_ID) >2

--3. Listado de los nombres de los paises con sus respectivas cantidad de empleados.
--Verifique su resultado, debe coincididr lo mostrado con la cantidad total de empleados de la empresa.

SELECT p.pais_nom as 'Pais', count(e.empleado_id) as 'Cantidad de empleados'
FROM empleados e
LEFT JOIN departamentos d
on e.dept_id = d.dept_id
LEFT JOIN localidades l
on d.loc_id = l.loc_id
LEFT JOIN paises p
on l.pais_id = p.pais_id
GROUP BY p.pais_nom;

--Verificacion de la cantidad de empleados
SELECT count(e.empleado_id) 'Cantidad de empleados'
FROM empleados e;

--4. Listar los nombres de departamentos que no tienen asignados empleados.

SELECT d.dept_nom as 'Departamento'
FROM departamentos d
LEFT JOIN empleados e
on e.dept_id = d.dept_id
WHERE e.empleado_id is null;


--Trabajar con la base de datos Northwind

use Northwind

--5. listado que muestre nombre del producto, supplierid, unitprice y una columna con el prcio mas un 10% (unitprice + 10% del unitprice)
--Coloque alias a las columnas de la consulta.
--Ordenar la consulta de menor a mayor seg�n el precio unitario.
--Solo muestre los articulos que no sean de los siguientes Supplierid 1,2,3.

SELECT p.productname as 'Producto', p.supplierid as 'Proveedor',
p.unitprice as 'Precio Unitario', (p.unitprice + ((p.unitprice * 10)/100)) as 'Precio +10%'
FROM products p
WHERE p.supplierid not in (1,2,3)
ORDER BY p.unitprice asc;

--6. listado de Companyname de la tabla Customers, contacttitle y Fax
--Deben tener en contact title la palabra Manager y mostrar solo los clientes que tienen registrados numeros de Fax

SELECT c.companyname 'Cliente', c.contacttitle 'Contacto', c.fax 'Fax'
FROM customers c
WHERE c.contacttitle like '%Manager%' 
and c.fax is not null;

--7. Listado de las 3 primeras categor�as de productos (categoryname), con mayor cantidad de unidades vendidas
--en el a�o 1998, muestre ordenado de menor a mayor por la cantidad de productos vendidos.

SELECT TOP 3 c.categoryname 'Categorias'  --,sum(od.quantity), year(o.orderdate)
FROM orders o
LEFT JOIN [Order Details] od
on o.orderid = od.orderid
LEFT JOIN products p
on od.productid = p.productid
LEFT JOIN categories c
on p.categoryid = c.categoryid
WHERE year(o.orderdate) = 1998
GROUP BY c.categoryname, year(o.orderdate)
ORDER BY sum(od.quantity) desc;

--8. Listar todos los nombre de articulos con su respectiva cantidad vendida de las ordenes con orderdate del a�o 1996.

SELECT p.productname 'Articulos', sum(od.quantity) 'Cantidad'
FROM orders o
LEFT JOIN [Order Details] od
on o.orderid = od.orderid
LEFT JOIN products p
on od.productid = p.productid
WHERE year(o.orderdate) = 1996
GROUP BY p.productname, year(o.orderdate);

--9. listado de Proveedores Company name y su HomePage
--El pais (country) del proveedor, no debe figurar en el listado de paises (country) donde est�n registrado los clientes
--si el proveedor no tiene registrado HomePage mostrar en esa columna 'en construccion'

SELECT s.companyname 'Proveedores',
CASE 
	WHEN s.homepage is null then 'En Contruccion'
	ELSE s.homepage
END as 'Home Page'
FROM suppliers s
WHERE s.country not in (
SELECT DISTINCT c.country
FROM customers c);

--10 Listado de los productos, cuyo precio unitario supere a todo los precios unitarios de los productos 
-- que son provisto por proveedores de country USA.

SELECT p.productname 'Productos'
FROM products p 
WHERE p.unitprice > all (
SELECT p.unitprice
FROM products p
JOIN suppliers s
on p.supplierid = s.supplierid
WHERE s.country = 'USA');