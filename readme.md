# CAP Mini - Orders Management Application

A sample application built with SAP Cloud Application Programming Model (CAP) demonstrating orders management with a modern UI5 frontend.

## 📋 Table of Contents

- [English](#english)
- [Deutsch](#deutsch)

---

## English

### Overview

**cap-mini** is a demonstration application showcasing the power of SAP Cloud Application Programming Model (CAP) for building enterprise-grade applications. The application provides a complete orders management system with:

- **Orders Management**: Create, read, update, and delete orders
- **Order Items**: Manage line items within orders with automatic total calculations
- **Draft-enabled UI**: Modern SAP Fiori Elements frontend with draft support
- **RESTful API**: OData V4 compliant service at `/orders-api`

### Features

✅ Full CRUD operations on Orders and OrderItems  
✅ Automatic calculation of line totals and order totals  
✅ Deep insert support (create order with items in one call)  
✅ Custom action for recalculating totals  
✅ Draft-enabled editing with SAP Fiori Elements  
✅ SQLite database for local development  
✅ Comprehensive REST API test examples  

### Architecture

```
cap-mini/
├── app/                    # UI Frontend
│   └── cap-mini/          # SAP Fiori Elements application
├── db/                     # Domain Model
│   ├── schema.cds         # Data model definitions
│   └── data/              # Initial data (CSV files)
├── srv/                    # Service Layer
│   ├── orders-service.cds # Service definition
│   └── orders-service.js  # Service implementation
└── test/                   # API Tests
    └── orders-service.http # REST Client test examples
```

### Data Model

#### Orders
| Field | Type | Description |
|-------|------|-------------|
| orderNumber | String(20) | Unique order identifier |
| customer | String(100) | Customer name |
| status | Association | Order status (CodeList) |
| totalAmount | Decimal(15,2) | Calculated total amount |
| items | Composition | Order line items |

#### OrderItems
| Field | Type | Description |
|-------|------|-------------|
| product | String(100) | Product name |
| quantity | Integer | Quantity (1-100) |
| unitPrice | Decimal(15,2) | Unit price |
| lineTotal | Decimal(15,2) | Calculated line total |

### Prerequisites

- [Node.js](https://nodejs.org/) (v18 or higher)
- [npm](https://www.npmjs.com/) (comes with Node.js)
- [SAP CAP SDK](https://cap.cloud.sap/) (installed via npm)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Nik-Jochberg/cap-mini.git
   cd cap-mini
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```
   
   > ⚠️ **Important**: The `node_modules` folder is not included in the repository (see `.gitignore`). You **must** run `npm install` before starting the application.

3. **Start the application**
   ```bash
   npm start
   ```
   
   Or use the watch mode for development:
   ```bash
   npm run watch-cap-mini
   ```

4. **Access the application**
   - UI: http://localhost:4004
   - API: http://localhost:4004/orders-api

### API Endpoints

The service is available at `http://localhost:4004/orders-api` and provides:

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/Orders` | List all orders |
| GET | `/Orders?$expand=items` | List orders with items |
| POST | `/Orders` | Create order (supports deep insert) |
| PATCH | `/Orders({id})` | Update order |
| DELETE | `/Orders({id})` | Delete order |
| GET | `/OrderItems` | List all order items |
| POST | `/OrderItems` | Create order item |
| PATCH | `/OrderItems({id})` | Update order item |
| DELETE | `/OrderItems({id})` | Delete order item |
| POST | `/recalculate` | Recalculate order totals |

### Testing

Use the REST Client extension in VS Code to test the API:

1. Open `test/orders-service.http`
2. Click "Send Request" on any request block
3. View the response

### Scripts

| Script | Description |
|--------|-------------|
| `npm start` | Start the CDS server |
| `npm run watch-cap-mini` | Start with watch mode and open UI |
| `npm run watch-mini-cap` | Alternative watch mode |

### Learn More

- [SAP CAP Documentation](https://cap.cloud.sap)
- [SAP Fiori Elements](https://experience.sap.com/fiori-design-web/)
- [OData V4](https://www.odata.org/documentation/)

---

## Deutsch

### Übersicht

**cap-mini** ist eine Demonstrationsanwendung, die die Leistungsfähigkeit des SAP Cloud Application Programming Model (CAP) für die Entwicklung von Unternehmensanwendungen zeigt. Die Anwendung bietet ein vollständiges Bestellverwaltungssystem mit:

- **Bestellverwaltung**: Erstellen, lesen, aktualisieren und löschen von Bestellungen
- **Bestellpositionen**: Verwaltung von Positionen innerhalb von Bestellungen mit automatischer Gesamtberechnung
- **Entwurfsfähige UI**: Modernes SAP Fiori Elements Frontend mit Entwurfsunterstützung
- **RESTful API**: OData V4 konformer Service unter `/orders-api`

### Funktionen

✅ Vollständige CRUD-Operationen für Bestellungen und Bestellpositionen  
✅ Automatische Berechnung von Positions- und Bestellgesamtbeträgen  
✅ Deep Insert Unterstützung (Bestellung mit Positionen in einem Aufruf erstellen)  
✅ Benutzerdefinierte Aktion zur Neuberechnung von Gesamtbeträgen  
✅ Entwurfsfähiges Bearbeiten mit SAP Fiori Elements  
✅ SQLite Datenbank für lokale Entwicklung  
✅ Umfassende REST API Testbeispiele  

### Architektur

```
cap-mini/
├── app/                    # UI Frontend
│   └── cap-mini/          # SAP Fiori Elements Anwendung
├── db/                     # Domänenmodell
│   ├── schema.cds         # Datenmodelldefinitionen
│   └── data/              # Anfangsdaten (CSV-Dateien)
├── srv/                    # Service-Schicht
│   ├── orders-service.cds # Servicedefinition
│   └── orders-service.js  # Serviceimplementierung
└── test/                   # API-Tests
    └── orders-service.http # REST Client Testbeispiele
```

### Datenmodell

#### Bestellungen (Orders)
| Feld | Typ | Beschreibung |
|-------|------|-------------|
| orderNumber | String(20) | Eindeutige Bestellnummer |
| customer | String(100) | Kundenname |
| status | Association | Bestellstatus (CodeList) |
| totalAmount | Decimal(15,2) | Berechneter Gesamtbetrag |
| items | Composition | Bestellpositionen |

#### Bestellpositionen (OrderItems)
| Feld | Typ | Beschreibung |
|-------|------|-------------|
| product | String(100) | Produktname |
| quantity | Integer | Menge (1-100) |
| unitPrice | Decimal(15,2) | Stückpreis |
| lineTotal | Decimal(15,2) | Berechneter Positionspreis |

### Voraussetzungen

- [Node.js](https://nodejs.org/) (v18 oder höher)
- [npm](https://www.npmjs.com/) (wird mit Node.js installiert)
- [SAP CAP SDK](https://cap.cloud.sap/) (wird über npm installiert)

### Installation

1. **Repository klonen**
   ```bash
   git clone https://github.com/Nik-Jochberg/cap-mini.git
   cd cap-mini
   ```

2. **Abhängigkeiten installieren**
   ```bash
   npm install
   ```
   
   > ⚠️ **Wichtig**: Der `node_modules` Ordner ist nicht im Repository enthalten (siehe `.gitignore`). Sie **müssen** `npm install` ausführen, bevor Sie die Anwendung starten können.

3. **Anwendung starten**
   ```bash
   npm start
   ```
   
   Oder verwenden Sie den Watch-Modus für die Entwicklung:
   ```bash
   npm run watch-cap-mini
   ```

4. **Auf die Anwendung zugreifen**
   - UI: http://localhost:4004
   - API: http://localhost:4004/orders-api

### API-Endpunkte

Der Service ist unter `http://localhost:4004/orders-api` verfügbar und bietet:

| Methode | Endpunkt | Beschreibung |
|--------|----------|-------------|
| GET | `/Orders` | Alle Bestellungen auflisten |
| GET | `/Orders?$expand=items` | Bestellungen mit Positionen auflisten |
| POST | `/Orders` | Bestellung erstellen (unterstützt Deep Insert) |
| PATCH | `/Orders({id})` | Bestellung aktualisieren |
| DELETE | `/Orders({id})` | Bestellung löschen |
| GET | `/OrderItems` | Alle Bestellpositionen auflisten |
| POST | `/OrderItems` | Bestellposition erstellen |
| PATCH | `/OrderItems({id})` | Bestellposition aktualisieren |
| DELETE | `/OrderItems({id})` | Bestellposition löschen |
| POST | `/recalculate` | Bestellgesamtbeträge neu berechnen |

### Testen

Verwenden Sie die REST Client Erweiterung in VS Code zum Testen der API:

1. Öffnen Sie `test/orders-service.http`
2. Klicken Sie auf "Send Request" bei einem beliebigen Anfrageblock
3. Sehen Sie sich die Antwort an

### Skripte

| Skript | Beschreibung |
|--------|-------------|
| `npm start` | CDS-Server starten |
| `npm run watch-cap-mini` | Mit Watch-Modus starten und UI öffnen |
| `npm run watch-mini-cap` | Alternativer Watch-Modus |

### Mehr Erfahren

- [SAP CAP Dokumentation](https://cap.cloud.sap)
- [SAP Fiori Elements](https://experience.sap.com/fiori-design-web/)
- [OData V4](https://www.odata.org/documentation/)

---

## 📝 License

This project is a sample application for educational purposes.

## 👤 Author

Nik Jochberg

## 🔗 Repository

https://github.com/Nik-Jochberg/cap-mini