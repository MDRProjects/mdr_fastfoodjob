INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_fastfood', 'FastFoody', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_fastfood', 'FastFoody', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_fastfood', 'FastFoody', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('fastfood', 'FastFoody'),
	('offdutyfastfood', 'Off-Duty')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('fastfood',0,'deliveryman','DeliveryMan',5000,'{}','{}'),
	('fastfood',1,'cashier','Cashier',10000,'{}','{}'),
	('fastfood',2,'cooker','Cook',50000,'{}','{}'),
	('fastfood',3,'boss','Patron',60000,'{}','{}'),
	('offdutyfastfood',0,'deliveryman','DeliveryMan',0,'{}','{}'),
	('offdutyfastfood',1,'cashier','Cashier',0,'{}','{}'),
	('offdutyfastfood',2,'cooker','Cook',0,'{}','{}'),
	('offdutyfastfood',3,'boss','Patron',0,'{}','{}')
;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('sausage', 'Sausage', 1),
	('bread', 'Bread', 1),
	('burger', 'Burger', 1),
	('drink', 'Drink', 1),
	('potato', 'Potato', 1),
	('packaged_burger', 'BurgerPackage', 1)
;
