-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-09-26 22:39:57.077

-- tables
-- Table: cliente
CREATE TABLE cliente (
    cd_cliente int  NOT NULL,
    nm_cliente varchar(50)  NOT NULL,
    ds_logradouro varchar(50)  NOT NULL,
    ds_complemento varchar(30)  NOT NULL,
    nm_bairro varchar(30)  NOT NULL,
    nr_cep char(8)  NOT NULL,
    nr_telefone varchar(15)  NOT NULL,
    ds_email varchar(50)  NOT NULL,
    vl_limite_credito decimal(8,2)  NOT NULL,
    cd_municipio int  NOT NULL,
    cd_ramo int  NOT NULL,
    CONSTRAINT cliente_pk PRIMARY KEY (cd_cliente)
);

-- Table: condicao_pagamento
CREATE TABLE condicao_pagamento (
    cd_condicao_pagto int  NOT NULL,
    ds_condicao_pagto varchar(50)  NOT NULL,
    vl_expressao varchar(30)  NOT NULL,
    CONSTRAINT condicao_pagamento_pk PRIMARY KEY (cd_condicao_pagto)
);

-- Table: fornecedor
CREATE TABLE fornecedor (
    cd_fornecedor int  NOT NULL,
    nm_fornecedor varchar(50)  NOT NULL,
    ds_logradouro varchar(50)  NOT NULL,
    ds_complemento varchar(30)  NOT NULL,
    nm_bairro varchar(30)  NOT NULL,
    nr_cep char(8)  NOT NULL,
    nr_telefone varchar(15)  NOT NULL,
    ds_email varchar(50)  NOT NULL,
    ds_website varchar(50)  NOT NULL,
    cd_municipio int  NOT NULL,
    CONSTRAINT fornecedor_pk PRIMARY KEY (cd_fornecedor)
);

-- Table: item_nf_entrada
CREATE TABLE item_nf_entrada (
    qt_produto int  NOT NULL,
    vl_produto decimal(8,2)  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    cd_produto int  NOT NULL,
    nr_nf_entrada int  NOT NULL,
    CONSTRAINT item_nf_entrada_pk PRIMARY KEY (cd_produto,nr_nf_entrada)
);

-- Table: item_nf_saida
CREATE TABLE item_nf_saida (
    qt_produto int  NOT NULL,
    vl_produto decimal(8,2)  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    cd_produto int  NOT NULL,
    nr_nf_saida int  NOT NULL,
    CONSTRAINT item_nf_saida_pk PRIMARY KEY (cd_produto,nr_nf_saida)
);

-- Table: item_pedido_compra
CREATE TABLE item_pedido_compra (
    nr_pedido_compra int  NOT NULL,
    cd_produto int  NOT NULL,
    qt_produto int  NOT NULL,
    vl_produto decimal(8,2)  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    CONSTRAINT item_pedido_compra_pk PRIMARY KEY (nr_pedido_compra,cd_produto)
);

-- Table: municipio
CREATE TABLE municipio (
    cd_municipio int  NOT NULL,
    nm_municipio varchar(50)  NOT NULL,
    sg_uf char(2)  NOT NULL,
    cd_regiao int  NOT NULL,
    CONSTRAINT municipio_pk PRIMARY KEY (cd_municipio)
);

-- Table: nota_fiscal_entrada
CREATE TABLE nota_fiscal_entrada (
    nr_nf_entrada int  NOT NULL,
    dt_emissao date  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    cd_fornecedor int  NOT NULL,
    CONSTRAINT nota_fiscal_entrada_pk PRIMARY KEY (nr_nf_entrada)
);

-- Table: nota_fiscal_saida
CREATE TABLE nota_fiscal_saida (
    nr_nf_saida int  NOT NULL,
    dt_emissao date  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    nr_pedido_compra int  NOT NULL,
    cd_cliente int  NOT NULL,
    CONSTRAINT nota_fiscal_saida_pk PRIMARY KEY (nr_nf_saida)
);

-- Table: pedido_compra
CREATE TABLE pedido_compra (
    nr_pedido_compra int  NOT NULL,
    dt_emissao date  NOT NULL,
    vl_total decimal(8,2)  NOT NULL,
    cd_cliente int  NOT NULL,
    cd_vendedor int  NOT NULL,
    cd_condicao_pagto int  NOT NULL,
    CONSTRAINT pedido_compra_pk PRIMARY KEY (nr_pedido_compra)
);

-- Table: produto
CREATE TABLE produto (
    cd_produto int  NOT NULL,
    ds_produto varchar(50)  NOT NULL,
    qt_estoque int  NOT NULL,
    qt_minima int  NOT NULL,
    vl_produto decimal(8,2)  NOT NULL,
    cd_fornecedor int  NOT NULL,
    CONSTRAINT produto_pk PRIMARY KEY (cd_produto)
);

-- Table: ramo_atuacao
CREATE TABLE ramo_atuacao (
    cd_ramo int  NOT NULL,
    ds_ramo Varchar(50)  NOT NULL,
    CONSTRAINT ramo_atuacao_pk PRIMARY KEY (cd_ramo)
);

-- Table: regiao
CREATE TABLE regiao (
    cd_regiao int  NOT NULL,
    nm_regiao varchar(50)  NOT NULL,
    CONSTRAINT regiao_pk PRIMARY KEY (cd_regiao)
);

-- Table: titulo_pagar
CREATE TABLE titulo_pagar (
    nr_titulo int  NOT NULL,
    dt_emissao date  NOT NULL,
    dt_vencimento date  NOT NULL,
    dt_pagamento date  NOT NULL,
    vl_titulo decimal(8,2)  NOT NULL,
    vl_multa decimal(8,2)  NOT NULL,
    nr_nf_entrada int  NOT NULL,
    cd_fornecedor int  NOT NULL,
    CONSTRAINT titulo_pagar_pk PRIMARY KEY (nr_titulo)
);

-- Table: titulo_receber
CREATE TABLE titulo_receber (
    nr_titulo int  NOT NULL,
    dt_emissao date  NOT NULL,
    dt_vencimento date  NOT NULL,
    dt_pagamento date  NOT NULL,
    vl_titulo decimal(8,2)  NOT NULL,
    vl_multa decimal(8,2)  NOT NULL,
    vl_juros decimal(8,2)  NOT NULL,
    nr_nf_saida int  NOT NULL,
    cd_cliente int  NOT NULL,
    CONSTRAINT titulo_receber_pk PRIMARY KEY (nr_titulo)
);

-- Table: vendedor
CREATE TABLE vendedor (
    cd_vendedor int  NOT NULL,
    nm_vendedor varchar(50)  NOT NULL,
    ds_logradouro varchar(50)  NOT NULL,
    ds_complemento varchar(30)  NOT NULL,
    nm_bairro varchar(30)  NOT NULL,
    nr_cep char(8)  NOT NULL,
    nr_telefone varchar(15)  NOT NULL,
    ds_email varchar(50)  NOT NULL,
    vl_salario_base decimal(8,2)  NOT NULL,
    pc_comissao decimal(8,2)  NOT NULL,
    cd_municipio int  NOT NULL,
    cd_regiao int  NOT NULL,
    CONSTRAINT vendedor_pk PRIMARY KEY (cd_vendedor)
);

-- foreign keys
-- Reference: cliente_municipio (table: cliente)
ALTER TABLE cliente ADD CONSTRAINT cliente_municipio
    FOREIGN KEY (cd_municipio)
    REFERENCES municipio (cd_municipio)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: cliente_ramo_atuacao (table: cliente)
ALTER TABLE cliente ADD CONSTRAINT cliente_ramo_atuacao
    FOREIGN KEY (cd_ramo)
    REFERENCES ramo_atuacao (cd_ramo)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: fornecedor_municipio (table: fornecedor)
ALTER TABLE fornecedor ADD CONSTRAINT fornecedor_municipio
    FOREIGN KEY (cd_municipio)
    REFERENCES municipio (cd_municipio)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: item_nf_entrada_nota_fiscal_entrada (table: item_nf_entrada)
ALTER TABLE item_nf_entrada ADD CONSTRAINT item_nf_entrada_nota_fiscal_entrada
    FOREIGN KEY (nr_nf_entrada)
    REFERENCES nota_fiscal_entrada (nr_nf_entrada)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: item_nf_entrada_produto (table: item_nf_entrada)
ALTER TABLE item_nf_entrada ADD CONSTRAINT item_nf_entrada_produto
    FOREIGN KEY (cd_produto)
    REFERENCES produto (cd_produto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: item_nf_saida_nota_fiscal_saida (table: item_nf_saida)
ALTER TABLE item_nf_saida ADD CONSTRAINT item_nf_saida_nota_fiscal_saida
    FOREIGN KEY (nr_nf_saida)
    REFERENCES nota_fiscal_saida (nr_nf_saida)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: item_nf_saida_produto (table: item_nf_saida)
ALTER TABLE item_nf_saida ADD CONSTRAINT item_nf_saida_produto
    FOREIGN KEY (cd_produto)
    REFERENCES produto (cd_produto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: item_pedido_compra_pedido_compra (table: item_pedido_compra)
ALTER TABLE item_pedido_compra ADD CONSTRAINT item_pedido_compra_pedido_compra
    FOREIGN KEY (nr_pedido_compra)
    REFERENCES pedido_compra (nr_pedido_compra)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: item_pedido_compra_produto (table: item_pedido_compra)
ALTER TABLE item_pedido_compra ADD CONSTRAINT item_pedido_compra_produto
    FOREIGN KEY (cd_produto)
    REFERENCES produto (cd_produto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: municipio_regiao (table: municipio)
ALTER TABLE municipio ADD CONSTRAINT municipio_regiao
    FOREIGN KEY (cd_regiao)
    REFERENCES regiao (cd_regiao)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: nota_fiscal_entrada_fornecedor (table: nota_fiscal_entrada)
ALTER TABLE nota_fiscal_entrada ADD CONSTRAINT nota_fiscal_entrada_fornecedor
    FOREIGN KEY (cd_fornecedor)
    REFERENCES fornecedor (cd_fornecedor)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: nota_fiscal_saida_cliente (table: nota_fiscal_saida)
ALTER TABLE nota_fiscal_saida ADD CONSTRAINT nota_fiscal_saida_cliente
    FOREIGN KEY (cd_cliente)
    REFERENCES cliente (cd_cliente)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: nota_fiscal_saida_pedido_compra (table: nota_fiscal_saida)
ALTER TABLE nota_fiscal_saida ADD CONSTRAINT nota_fiscal_saida_pedido_compra
    FOREIGN KEY (nr_pedido_compra)
    REFERENCES pedido_compra (nr_pedido_compra)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: pedido_compra_cliente (table: pedido_compra)
ALTER TABLE pedido_compra ADD CONSTRAINT pedido_compra_cliente
    FOREIGN KEY (cd_cliente)
    REFERENCES cliente (cd_cliente)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: pedido_compra_condicao_pagamento (table: pedido_compra)
ALTER TABLE pedido_compra ADD CONSTRAINT pedido_compra_condicao_pagamento
    FOREIGN KEY (cd_condicao_pagto)
    REFERENCES condicao_pagamento (cd_condicao_pagto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: pedido_compra_vendedor (table: pedido_compra)
ALTER TABLE pedido_compra ADD CONSTRAINT pedido_compra_vendedor
    FOREIGN KEY (cd_vendedor)
    REFERENCES vendedor (cd_vendedor)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: produto_fornecedor (table: produto)
ALTER TABLE produto ADD CONSTRAINT produto_fornecedor
    FOREIGN KEY (cd_fornecedor)
    REFERENCES fornecedor (cd_fornecedor)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: titulo_pagar_fornecedor (table: titulo_pagar)
ALTER TABLE titulo_pagar ADD CONSTRAINT titulo_pagar_fornecedor
    FOREIGN KEY (cd_fornecedor)
    REFERENCES fornecedor (cd_fornecedor)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: titulo_pagar_nota_fiscal_entrada (table: titulo_pagar)
ALTER TABLE titulo_pagar ADD CONSTRAINT titulo_pagar_nota_fiscal_entrada
    FOREIGN KEY (nr_nf_entrada)
    REFERENCES nota_fiscal_entrada (nr_nf_entrada)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: titulo_receber_cliente (table: titulo_receber)
ALTER TABLE titulo_receber ADD CONSTRAINT titulo_receber_cliente
    FOREIGN KEY (cd_cliente)
    REFERENCES cliente (cd_cliente)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: titulo_receber_nota_fiscal_saida (table: titulo_receber)
ALTER TABLE titulo_receber ADD CONSTRAINT titulo_receber_nota_fiscal_saida
    FOREIGN KEY (nr_nf_saida)
    REFERENCES nota_fiscal_saida (nr_nf_saida)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: vendedor_municipio (table: vendedor)
ALTER TABLE vendedor ADD CONSTRAINT vendedor_municipio
    FOREIGN KEY (cd_municipio)
    REFERENCES municipio (cd_municipio)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: vendedor_regiao (table: vendedor)
ALTER TABLE vendedor ADD CONSTRAINT vendedor_regiao
    FOREIGN KEY (cd_regiao)
    REFERENCES regiao (cd_regiao)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

