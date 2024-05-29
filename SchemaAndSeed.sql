--Persona 
CREATE TABLE [dbo].[Personas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](max) NOT NULL,
	[Apellido] [nvarchar](max) NULL,
	[TipoDocumento] [nvarchar](max) NULL,
	[Documento] [nvarchar](max) NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--Insertar datos 

INSERT INTO [FacturacionDB].[dbo].[Personas] ([Nombre], [Apellido], [TipoDocumento], [Documento]) VALUES ('John', 'Doe', 'Passport', 'A12345678');
INSERT INTO [FacturacionDB].[dbo].[Personas] ([Nombre], [Apellido], [TipoDocumento], [Documento]) VALUES ('Jane', 'Smith', 'ID Card', 'B87654321');
INSERT INTO [FacturacionDB].[dbo].[Personas] ([Nombre], [Apellido], [TipoDocumento], [Documento]) VALUES ('Alice', 'Johnson', 'Driver License', 'C12345678');
INSERT INTO [FacturacionDB].[dbo].[Personas] ([Nombre], [Apellido], [TipoDocumento], [Documento]) VALUES ('Bob', 'Brown', 'Passport', 'D87654321');
INSERT INTO [FacturacionDB].[dbo].[Personas] ([Nombre], [Apellido], [TipoDocumento], [Documento]) VALUES ('Charlie', 'Davis', 'ID Card', 'E12345678');


--Factura

CREATE TABLE [dbo].[Facturas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Numero] [int] NOT NULL,
	[Fecha] [datetime2](7) NULL,
	[PersonaId] [int] NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Facturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Personas_PersonaId] FOREIGN KEY([PersonaId])
REFERENCES [dbo].[Personas] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Facturas] CHECK CONSTRAINT [FK_Facturas_Personas_PersonaId]
GO

--insertar datos

INSERT INTO [FacturacionDB].[dbo].[Facturas] ([Numero], [Fecha], [PersonaId]) VALUES (1000, '2024-01-15', 1);
INSERT INTO [FacturacionDB].[dbo].[Facturas] ([Numero], [Fecha], [PersonaId]) VALUES (2000, '2024-01-16', 3);
INSERT INTO [FacturacionDB].[dbo].[Facturas] ([Numero], [Fecha], [PersonaId]) VALUES (3000, '2024-01-17', 4);
INSERT INTO [FacturacionDB].[dbo].[Facturas] ([Numero], [Fecha], [PersonaId]) VALUES (4000, '2024-01-18', 5);
INSERT INTO [FacturacionDB].[dbo].[Facturas] ([Numero], [Fecha], [PersonaId]) VALUES (5000, '2024-01-19', 6);

--Producto

CREATE TABLE [dbo].[Productos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [nvarchar](max) NOT NULL,
	[Precio] [decimal](18, 2) NULL,
	[Costo] [decimal](18, 2) NULL,
	[UnidadMedida] [nvarchar](max) NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--Insertar datos 

INSERT INTO [FacturacionDB].[dbo].[Productos] ([Descripcion], [Precio], [Costo], [UnidadMedida]) VALUES ('Laptop', 1000.00, 800.00, 'Unidad');
INSERT INTO [FacturacionDB].[dbo].[Productos] ([Descripcion], [Precio], [Costo], [UnidadMedida]) VALUES ('Mouse', 25.00, 15.00, 'Unidad');
INSERT INTO [FacturacionDB].[dbo].[Productos] ([Descripcion], [Precio], [Costo], [UnidadMedida]) VALUES ('Teclado', 45.00, 30.00, 'Unidad');
INSERT INTO [FacturacionDB].[dbo].[Productos] ([Descripcion], [Precio], [Costo], [UnidadMedida]) VALUES ('Monitor', 200.00, 150.00, 'Unidad');
INSERT INTO [FacturacionDB].[dbo].[Productos] ([Descripcion], [Precio], [Costo], [UnidadMedida]) VALUES ('Impresora', 150.00, 100.00, 'Unidad');

--Detalle factura

CREATE TABLE [dbo].[DetallesFactura](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Linea] [int] NULL,
	[ProductoId] [int] NULL,
	[FacturaId] [int] NULL,
 CONSTRAINT [PK_DetallesFactura] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
--Insertar datos 


INSERT INTO [FacturacionDB].[dbo].[DetallesFactura] ([ProductoId], [FacturaId], [Linea], [Cantidad]) VALUES (1, 1, 7000, 2);
INSERT INTO [FacturacionDB].[dbo].[DetallesFactura] ([ProductoId], [FacturaId], [Linea], [Cantidad]) VALUES (3, 3, 2, 1);
INSERT INTO [FacturacionDB].[dbo].[DetallesFactura] ([ProductoId], [FacturaId], [Linea], [Cantidad]) VALUES (4, 4, 3, 1);
INSERT INTO [FacturacionDB].[dbo].[DetallesFactura] ([ProductoId], [FacturaId], [Linea], [Cantidad]) VALUES (5 ,5, 4, 1);

--Vista del proyectos
--1.
CREATE VIEW [dbo].[VistaMargenGananciaPorProducto] AS
SELECT 
    prod.Id AS ProductoId,
    prod.Descripcion AS DEscripcion,
    CASE 
        WHEN SUM(defa.Cantidad * prod.Costo) = 0 THEN 0
        ELSE SUM(defa.Cantidad * (prod.Precio - prod.Costo)) / SUM(defa.Cantidad * prod.Costo) 
    END AS MargenGanancia
FROM 
    Productos prod
LEFT JOIN 
    DetallesFactura defa ON defa.ProductoId = prod.Id
GROUP BY 
    prod.Id, prod.Descripcion;
--2.
CREATE VIEW [dbo].[VistaPersonaProductoMasCaro] AS
SELECT TOP 1 
    P.Id AS PersonaId,
    P.Nombre AS NombrePersona,
    prod.Id AS ProductoId,
    prod.Descripcion AS Descripcion,
    prod.Precio AS PrecioProducto
FROM 
    Personas P
INNER JOIN 
    Facturas F ON P.Id = F.PersonaId
INNER JOIN 
    DetallesFactura defa ON defa.FacturaId = F.Id
INNER JOIN 
    Productos prod ON defa.ProductoId = prod.Id
ORDER BY 
    prod.Precio DESC;
--3.
CREATE VIEW [dbo].[VistaProductosPorCantidad] AS
SELECT 
    prod.Id AS ProductoId,
    prod.Descripcion AS NombreProducto,
    SUM(defa.Cantidad) AS CantidadTotal
FROM 
    Productos prod
LEFT JOIN 
    DetallesFactura defa ON defa.ProductoId = prod.Id
GROUP BY 
    prod.Id, prod.Descripcion;
--4.
CREATE VIEW [dbo].[VistaTotalFacturadoPorPersona] AS
SELECT 
    P.Id AS PersonaId,
    P.Nombre AS NombrePersona,
    ISNULL(SUM(defa.Cantidad * prod.Precio), 0) AS TotalFacturado
FROM 
    Personas P
LEFT JOIN 
    Facturas F ON P.Id = F.PersonaId
LEFT JOIN 
    DetallesFactura defa ON defa.FacturaId = F.Id
LEFT JOIN 
    Productos prod ON defa.ProductoId = prod.Id
GROUP BY 
    P.Id, P.Nombre;
--5.
CREATE VIEW [dbo].[VistaUtilidadGeneradaPorProducto] AS
SELECT 
    prod.Id AS ProductoId,
    prod.Descripcion AS NombreProducto,
    SUM(defa.Cantidad * (prod.Precio - prod.Costo)) AS UtilidadGenerada
FROM 
    Productos prod
LEFT JOIN 
    DetallesFactura defa ON defa.ProductoId = prod.Id
GROUP BY 
    prod.Id, prod.Descripcion;


