BEGIN;

CREATE TABLE IF NOT EXISTS aisles
(
    aisle_id serial PRIMARY KEY,
    aisle character varying COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS departments
(
    department_id serial PRIMARY KEY,
    department character varying COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS order_products
(
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    add_to_cart_order integer,
    reordered integer,
    CONSTRAINT order_products_pkey PRIMARY KEY (order_id, product_id)
);

CREATE TABLE IF NOT EXISTS orders
(
    order_id serial PRIMARY KEY,
    user_id integer,
    order_number integer,
    order_dow integer,
    order_hour_of_day integer,
    days_since_prior_order integer
);

CREATE TABLE IF NOT EXISTS products
(
    product_id serial PRIMARY KEY,
    product_name character varying COLLATE pg_catalog."default",
    aisle_id integer,
    department_id integer
);

ALTER TABLE IF EXISTS order_products
    ADD CONSTRAINT order_products_order_id_fkey FOREIGN KEY (order_id)
    REFERENCES orders (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS order_products
    ADD CONSTRAINT order_products_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES products (product_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS products
    ADD CONSTRAINT products_aisle_id_fkey FOREIGN KEY (aisle_id)
    REFERENCES aisles (aisle_id) MATCH SIMPLE
	ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE IF EXISTS products
    ADD CONSTRAINT products_department_id_fkey FOREIGN KEY (department_id)
    REFERENCES departments (department_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;