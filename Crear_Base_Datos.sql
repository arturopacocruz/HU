IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TallerTextilDB')
BEGIN
    CREATE DATABASE TallerTextilDB;
END
GO

USE TallerTextilDB;
GO

IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TipoTela]') 
    AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TipoTela](
        IdTipoTela INT PRIMARY KEY IDENTITY(1,1),
        Nombre NVARCHAR(100) NOT NULL,
        StockMinimo DECIMAL(10,2) NOT NULL
    );
END
GO

IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Tela]') 
    AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[Tela](
        IdTela INT PRIMARY KEY IDENTITY(1,1),
        IdTipoTela INT NOT NULL,
        Nombre NVARCHAR(100) NOT NULL,
        MetrosDisponibles DECIMAL(10,2) NOT NULL,
        CostoPorMetro DECIMAL(10,2) NOT NULL,
        CONSTRAINT FK_Tela_TipoTela
        FOREIGN KEY (IdTipoTela) 
        REFERENCES TipoTela(IdTipoTela)
    );
END
GO

IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Cliente]') 
    AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[Cliente](
        IdCliente INT PRIMARY KEY IDENTITY(1,1),
        Nombre NVARCHAR(150) NOT NULL,
        Telefono NVARCHAR(20)
    );
END
GO

IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Pedido]') 
    AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[Pedido](
        IdPedido INT PRIMARY KEY IDENTITY(1,1),
        IdCliente INT NOT NULL,
        Fecha DATETIME NOT NULL DEFAULT GETDATE(),
        Estado NVARCHAR(50) NOT NULL,
        Total DECIMAL(10,2) NULL,
        CONSTRAINT FK_Pedido_Cliente
        FOREIGN KEY (IdCliente)
        REFERENCES Cliente(IdCliente)
    );
END
GO

IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[MovimientoInventario]') 
    AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[MovimientoInventario](
        IdMovimiento INT PRIMARY KEY IDENTITY(1,1),
        IdTela INT NOT NULL,
        TipoMovimiento NVARCHAR(20) NOT NULL,
        CantidadMetros DECIMAL(10,2) NOT NULL,
        Fecha DATETIME NOT NULL DEFAULT GETDATE(),
        IdPedido INT NULL,
        CONSTRAINT FK_Movimiento_Tela
        FOREIGN KEY (IdTela)
        REFERENCES Tela(IdTela),
        CONSTRAINT FK_Movimiento_Pedido
        FOREIGN KEY (IdPedido)
        REFERENCES Pedido(IdPedido)
    );
END
GO

IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[ConsumoTela]') 
    AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[ConsumoTela](
        IdConsumo INT PRIMARY KEY IDENTITY(1,1),
        IdPedido INT NOT NULL,
        IdTela INT NOT NULL,
        MetrosConsumidos DECIMAL(10,2) NOT NULL,
        CostoCalculado DECIMAL(10,2) NOT NULL,
        CONSTRAINT FK_Consumo_Pedido
        FOREIGN KEY (IdPedido)
        REFERENCES Pedido(IdPedido),
        CONSTRAINT FK_Consumo_Tela
        FOREIGN KEY (IdTela)
        REFERENCES Tela(IdTela)
    );
END
GO

IF NOT EXISTS (
    SELECT * FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[Pago]') 
    AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[Pago](
        IdPago INT PRIMARY KEY IDENTITY(1,1),
        IdPedido INT NOT NULL,
        Fecha DATETIME NOT NULL DEFAULT GETDATE(),
        Monto DECIMAL(10,2) NOT NULL,
        CONSTRAINT FK_Pago_Pedido
        FOREIGN KEY (IdPedido)
        REFERENCES Pedido(IdPedido)
    );
END
GO
