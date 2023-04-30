create database satender;
show databases;
use satender;

-- Create User table
CREATE TABLE User (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('owner', 'customer') NOT NULL
);

-- Create Parking_Lot table
CREATE TABLE Parking_Lot (
  lot_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255) NOT NULL,
  owner_id INT NOT NULL,
  FOREIGN KEY (owner_id) REFERENCES User(user_id)
);

-- Create Permit table
CREATE TABLE Permit (
  permit_id INT AUTO_INCREMENT PRIMARY KEY,
  vehicle_number varchar(15) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  customer_id INT NOT NULL,
  lot_id INT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES User(user_id),
  FOREIGN KEY (lot_id) REFERENCES Parking_Lot(lot_id)
);

-- Create Fine table
CREATE TABLE Fine (
  fine_id INT AUTO_INCREMENT PRIMARY KEY,
  amount DECIMAL(10,2) NOT NULL,
  description VARCHAR(255) NOT NULL,
  customer_id INT NOT NULL,
  lot_id INT NOT NULL,
  time_in DATETIME NOT NULL,
  time_out DATETIME,
  FOREIGN KEY (customer_id) REFERENCES User(user_id),
  FOREIGN KEY (lot_id) REFERENCES Parking_Lot(lot_id)
);

-- Insert dummy data into User table
INSERT INTO User (name, email, password, role) VALUES 
('Satender Singh', 'satendersingh@example.com', 'password', 'customer'),
('Ravinder', 'Ravinder@example.com', 'password', 'customer'),
('Ashish', 'Ashish@example.com', 'password', 'owner'),
('Shivam', 'Shivam@example.com', 'password', 'owner');

select * from user;

-- Insert dummy data into Parking_Lot table
INSERT INTO Parking_Lot (name, location, owner_id) VALUES 
('Lot A', 'Rk puram sector-9', 3),
('Lot B', 'Rk puram sector-8', 4),
('Lot C', 'Rk puram sector-7', 4);

select * from parking_lot;

-- Insert dummy data into Permit table
INSERT INTO Permit (start_date, end_date, customer_id, lot_id,vehicle_number) VALUES 
('2023-04-01', '2023-04-30', 1, 1,'ABC123'),
('2023-04-15', '2023-05-15', 2, 1,'XYZ456'),
('2023-04-01', '2023-04-30', 2, 2,'DEF789'),
('2023-04-01', '2023-05-31', 1, 3,'GHI101'),
('2023-04-15', '2023-05-15', 2, 3,'JKL234');

select * from permit;

-- Insert dummy data into Fine table
INSERT INTO Fine (amount, description, customer_id, lot_id,time_in,time_out) VALUES 
(25.00, 'Late fee', 1, 1,'2023-04-01 08:00:00','2023-04-01 17:00:00'),
(50.00, 'Expired permit', 2, 1,'2023-04-15 09:00:00','2023-04-15 18:00:00'),
(10.00, 'Parking in wrong spot', 2, 2,'2023-04-01 10:00:00','2023-04-01 19:00:00'),
(30.00, 'Overdue fine', 1, 3,'2023-04-01 08:30:00','2023-04-01 17:30:00'),
(20.00, 'Expired permit', 2, 3,'2023-04-15 09:00:00','2023-04-15 18:00:00'),
(30.00, 'Overdue fine',1,3,'2023-04-01 08:30:00','2023-04-01 17:30:00');

select * from fine;




