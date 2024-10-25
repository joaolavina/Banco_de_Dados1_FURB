-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-09-06 00:13:28.038

-- tables
-- Table: categoria
CREATE TABLE categoria (
    cd_categoria int  NOT NULL,
    nm_categoria varchar(30)  NOT NULL,
    CONSTRAINT categoria_pk PRIMARY KEY (cd_categoria)
);

-- Table: cliente
CREATE TABLE cliente (
    cd_cliente int  NOT NULL,
    nm_cliente varchar(50)  NOT NULL,
    nr_telefone varchar(15)  NOT NULL,
    ds_email varchar(50)  NOT NULL,
    vl_limite_credito decimal(8,2)  NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (cd_cliente)
);

-- Table: endereco
CREATE TABLE endereco (
    cd_endereco int  NOT NULL,
    nm_logradouro varchar(50)  NOT NULL,
    ds_complemento varchar(20)  NOT NULL,
    nm_bairro varchar(30)  NOT NULL,
    nr_cep char(8)  NOT NULL,
    cd_municipio int  NOT NULL,
    cd_cliente int  NOT NULL,
    CONSTRAINT endereco_pk PRIMARY KEY (cd_endereco)
);

-- Table: item_pedido
CREATE TABLE item_pedido (
    nr_pedido int  NOT NULL,
    cd_produto int  NOT NULL,
    qt_vendida int  NOT NULL,
    vl_produto decimal(8,2)  NOT NULL,
    CONSTRAINT item_pedido_pk PRIMARY KEY (nr_pedido,cd_produto)
);

-- Table: municipio
CREATE TABLE municipio (
    cd_municipio int  NOT NULL,
    nm_municipio varchar(50)  NOT NULL,
    sg_uf char(2)  NOT NULL,
    CONSTRAINT municipio_pk PRIMARY KEY (cd_municipio)
);

-- Table: pedido
CREATE TABLE pedido (
    nr_pedido int  NOT NULL,
    dt_emissao date  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    cd_cliente int  NOT NULL,
    CONSTRAINT pedido_pk PRIMARY KEY (nr_pedido)
);

-- Table: produto
CREATE TABLE produto (
    cd_produto int  NOT NULL,
    nm_produto varchar(50)  NOT NULL,
    qt_estoque int  NOT NULL,
    vl_produto decimal(8,2)  NOT NULL,
    cd_categoria int  NOT NULL,
    CONSTRAINT produto_pk PRIMARY KEY (cd_produto)
);

-- foreign keys
-- Reference: Table_7_pedido (table: item_pedido)
ALTER TABLE item_pedido ADD CONSTRAINT Table_7_pedido FOREIGN KEY Table_7_pedido (nr_pedido)
    REFERENCES pedido (nr_pedido);

-- Reference: Table_7_produto (table: item_pedido)
ALTER TABLE item_pedido ADD CONSTRAINT Table_7_produto FOREIGN KEY Table_7_produto (cd_produto)
    REFERENCES produto (cd_produto);

-- Reference: endereco_cliente (table: endereco)
ALTER TABLE endereco ADD CONSTRAINT endereco_cliente FOREIGN KEY endereco_cliente (cd_cliente)
    REFERENCES cliente (cd_cliente);

-- Reference: endereco_municipio (table: endereco)
ALTER TABLE endereco ADD CONSTRAINT endereco_municipio FOREIGN KEY endereco_municipio (cd_municipio)
    REFERENCES municipio (cd_municipio);

-- Reference: pedido_cliente (table: pedido)
ALTER TABLE pedido ADD CONSTRAINT pedido_cliente FOREIGN KEY pedido_cliente (cd_cliente)
    REFERENCES cliente (cd_cliente);

-- Reference: produto_categoria (table: produto)
ALTER TABLE produto ADD CONSTRAINT produto_categoria FOREIGN KEY produto_categoria (cd_categoria)
    REFERENCES categoria (cd_categoria);

-- End of file.

