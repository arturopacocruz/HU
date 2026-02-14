# HU
Desarrollando historias de usuario (HU).

Mi historia de usuario:

# 🧵 Entrevista – Digitalización de Taller de Confección

Perfecto, Ingeniero. Te hablo claro, como dueño de taller que ya está medio cansado del Excel y del cuadernito 😂.

---

## 🗣️ Entrevista

**Dueño (yo):**

Mira, te explico cómo estamos trabajando ahora… y por qué ya siento que se me está yendo el control.

Primero, el tema de las **telas**. Yo compro por rollos, a veces 50, 100 metros, depende del proveedor. El problema es que no tengo un control real de cuánto se está usando por pedido. Yo “más o menos” sé que para una polera usamos tanto, para un buzo tanto… pero no está registrado formalmente. Entonces pasa que acepto un pedido grande y cuando vamos a cortar… sorpresa, no alcanza la tela.

Y ahí vienen los apuros, compras de último momento, más caro, retrasos… y el cliente molesto. Yo necesito saber exactamente cuánto entra, cuánto sale y en qué se fue cada metro. Pero tampoco quiero algo súper complicado que me haga perder tiempo.

---

Después están los **pedidos de los clientes**.

Los pedidos los anoto en un cuaderno o a veces en WhatsApp. Algunos clientes me piden 100 prendas, otros 500, algunos con tallas mezcladas, otros con colores distintos… y la verdad, a veces se me cruzan las fechas.

No tengo una vista clara de:
- Qué pedidos están en producción.
- Cuáles ya se entregaron.
- Cuáles están atrasados.
- Cuáles todavía no empezamos.

Y peor aún, no tengo claro cuánto me debe cada cliente y cuánto ya pagó. A veces me dicen “ya te hice la transferencia” y tengo que ponerme a buscar en el banco. No está centralizado.

---

Otro problema grande: **las costureras**.

Yo tengo varias chicas trabajando. Cada una trabaja por producción. El problema es que no tengo un registro claro de quién hizo qué prenda. Si sale un lote con defecto, no sé quién lo cosió.

Entonces no puedo:
- Medir productividad real por persona.
- Detectar errores repetitivos.
- Pagar exactamente según rendimiento.

Yo pago “más o menos” por lo que creo que hicieron, pero no tengo datos exactos. Y eso no es bueno ni para mí ni para ellas.

---

Y lo más importante… el **dinero**.

Yo trabajo, vendo, cobro… pero si tú me preguntas ahora mismo cuánto gané la semana pasada, no lo sé con exactitud.

Sé cuánto entró en ventas… más o menos.
Sé cuánto pagué en sueldos… más o menos.
Sé cuánto gasté en tela e insumos… más o menos.

Pero utilidad real… no la tengo clara.

A veces siento que estoy facturando mucho pero no sé si estoy ganando bien o solo estoy moviendo dinero. Y eso ya me preocupa porque quiero crecer, pero no sé si realmente estoy siendo rentable.

---

Lo que yo quiero no es algo súper técnico. Quiero algo que me diga:

- Cuánta tela tengo.
- Qué pedidos están activos.
- Qué costurera hizo cada lote.
- Cuánto gané esta semana.
- Y si un pedido realmente me dejó ganancia o no.

Y si se puede, algo que me avise cuando me esté quedando sin tela o cuando un pedido esté por vencerse.

No sé si eso es un sistema grande o algo sencillo, tú dime. Pero ya siento que si sigo así, el taller crece y el desorden crece conmigo.

Bueno, Ingeniero… ¿por dónde empezamos?"

# 🗄️ Modelo de Base de Datos – TallerTextilDB

Como resultado del análisis de las Historias de Usuario, se diseñó un modelo relacional orientado a la digitalización del taller de confección, alineado al **ODS 9 (Industria, Innovación e Infraestructura)**.

La estructura de la base de datos permite gestionar inventario, pedidos, consumo de materiales y control de pagos, proporcionando información clara para la toma de decisiones y crecimiento sostenible del taller.

---

## 📋 Tablas Creadas

### 🧵 TipoTela
Permite clasificar los distintos tipos de tela utilizados en el taller.

**Campos principales:**
- `IdTipoTela` (PK)
- `Nombre`
- `StockMinimo`

El campo **StockMinimo** permite generar alertas cuando el inventario baja del nivel establecido.

---

### 🧶 Tela
Registra cada tela específica disponible en inventario.

**Campos principales:**
- `IdTela` (PK)
- `IdTipoTela` (FK)
- `Nombre`
- `MetrosDisponibles`
- `CostoPorMetro`

Se relaciona con **TipoTela** y permite llevar un control exacto del inventario disponible.

---

### 👤 Cliente
Contiene la información básica de los clientes del taller.

**Campos principales:**
- `IdCliente` (PK)
- `Nombre`
- `Telefono`

---

### 📦 Pedido
Registra cada orden realizada por un cliente.

**Campos principales:**
- `IdPedido` (PK)
- `IdCliente` (FK)
- `Fecha`
- `Estado`
- `Total`

Permite visualizar el estado del pedido:
- Pendiente  
- En producción  
- Terminado  
- Entregado  

---

### 📊 MovimientoInventario
Registra entradas y salidas de tela.

**Campos principales:**
- `IdMovimiento` (PK)
- `IdTela` (FK)
- `TipoMovimiento`
- `CantidadMetros`
- `Fecha`
- `IdPedido` (FK opcional)

Permite trazabilidad completa del inventario.

---

### ✂️ ConsumoTela
Registra la cantidad exacta de tela consumida por cada pedido.

**Campos principales:**
- `IdConsumo` (PK)
- `IdPedido` (FK)
- `IdTela` (FK)
- `MetrosConsumidos`
- `CostoCalculado`

Facilita el cálculo del costo real por orden.

---

### 💰 Pago
Registra pagos parciales o totales realizados por los clientes.

**Campos principales:**
- `IdPago` (PK)
- `IdPedido` (FK)
- `Fecha`
- `Monto`

Permite calcular automáticamente el saldo pendiente por pedido.

---

## 🔄 Enfoque DevOps e Idempotencia

El script SQL fue desarrollado bajo un enfoque de **integración continua**, aplicando el principio de **idempotencia**.

Cada instrucción `CREATE` está precedida por una validación de existencia (`IF NOT EXISTS`), lo que permite ejecutar el script múltiples veces sin generar errores.

### ✅ Beneficios

- Seguridad en despliegues repetidos  
- Compatibilidad con integración continua  
- Buenas prácticas de arquitectura de persistencia  
- Preparación para trabajo colaborativo  

---

## 🎯 Objetivo del Modelo

El diseño de esta base de datos permite:

- Controlar inventario en tiempo real  
- Visualizar el estado de los pedidos  
- Registrar consumo de materiales  
- Gestionar pagos y saldos pendientes  
- Analizar rentabilidad del taller  

---
