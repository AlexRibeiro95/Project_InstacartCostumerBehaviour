
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Schema mydb
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- Table mydb.Products
CREATE TABLE IF NOT EXISTS `mydb`.`Products` (
  `product_id` INT NOT NULL,
  `product_name` VARCHAR(45) NULL,
  `aisle_id` INT NULL,
  `department_id` INT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE = InnoDB;

-- Table mydb.Customers_orders
CREATE TABLE IF NOT EXISTS `mydb`.`Customers_orders` (
  `order_id` VARCHAR(45) NOT NULL,
  `user_id` VARCHAR(45) NULL,
  `eval_set` VARCHAR(45) NULL,
  `order_number` INT NULL,
  `order_dow` INT NULL,
  `order_hour_of_day` INT NULL,
  `days_since_prior_order` INT NOT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE = InnoDB;

-- Table mydb.Aisles
CREATE TABLE IF NOT EXISTS `mydb`.`Aisles` (
  `aisle_id` INT NOT NULL,
  `aisle` VARCHAR(255) NULL,
  PRIMARY KEY (`aisle_id`)
) ENGINE = InnoDB;

-- Table mydb.Departments
CREATE TABLE IF NOT EXISTS `mydb`.`Departments` (
  `department_id` INT NOT NULL,
  `department` VARCHAR(255) NULL,
  PRIMARY KEY (`department_id`)
) ENGINE = InnoDB;

-- Table mydb.Product_orders
CREATE TABLE IF NOT EXISTS `mydb`.`Product_orders` (
  `order_id` VARCHAR(45) NOT NULL,
  `product_id` INT NOT NULL,
  `add_to_cart_order` INT NULL,
  `reordered` INT NULL,
  PRIMARY KEY (`order_id`, `product_id`)
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Adding back constraints and foreign keys after importing the data to each table

-- Disable foreign key checks
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- Table mydb.Products
ALTER TABLE `mydb`.`Products`
ADD CONSTRAINT `fk_products_aisles`
  FOREIGN KEY (`aisle_id`) REFERENCES `mydb`.`Aisles` (`aisle_id`),
ADD CONSTRAINT `fk_products_departments`
  FOREIGN KEY (`department_id`) REFERENCES `mydb`.`Departments` (`department_id`);

-- Table mydb.Product_orders
ALTER TABLE `mydb`.`Product_orders`
ADD CONSTRAINT `fk_product_orders_products`
  FOREIGN KEY (`product_id`) REFERENCES `mydb`.`Products` (`product_id`),
ADD CONSTRAINT `fk_product_orders_customers_orders`
  FOREIGN KEY (`order_id`) REFERENCES `mydb`.`Customers_orders` (`order_id`);  
  
-- Enable foreign key checks
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;