use northwind;

create user IF NOT exists 'User1' identified by 'password';

GRANT SELECT ON northwind.* TO 'User1';

GRANT DELETE ON northwind.* TO 'User1';


