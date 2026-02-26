# PRD: Elpriset - Swedish Electricity Price Optimizer

## 1. Overview

**App Name:** Elpriset
**Tagline:** Se vad din el kostar -- just nu.
**Platform:** iOS 17+ (iPhone, iPad, Apple Watch)
**Language:** Swedish (primary), English (secondary)
**Category:** App Store > Utilities

---

## 2. Problem Statement

Sweden transitioned to 15-minute electricity pricing on October 1, 2025. With 4 price zones (SE1-SE4), wildly fluctuating spot prices, and growing solar panel + home battery adoption, Swedish households need real-time visibility into what their electricity actually costs.

Existing apps are weak:
- **Elpriser Live / Elpris idag:** Show spot price only (not the total cost users actually pay)
- **Tibber / Greenely:** Require expensive contracts (49-69 SEK/month) and lock you into their electricity provider
- **None** combine spot price + grid fee + VAT into the actual total cost
- **None** offer smart scheduling advice ("run your dishwasher at 14:15")
- **None** integrate solar production forecasts for homeowners with panels

---

## 3. Market Analysis & Opportunity

### 3.1 Market Size

| Segment | Estimated Households | Notes |
|---------|---------------------|-------|
| Total Swedish households | ~5M | All electricity-connected |
| Monthly variable contracts (rörligt månadspris) | ~2.5-2.9M (~55%) | Benefit from price awareness |
| Hourly/quarterly dynamic (timpris/kvartspris) | ~1.0-1.25M (~22%) | Core target -- need 15-min price visibility |
| Fixed price contracts | ~0.75-1.0M (~18%) | Not primary audience |
| Default/assigned (anvisat) | ~0.25-0.4M (~6%) | Not primary audience |

**Key trend:** As of January 2025, timpris agreements slightly exceeded fixed-term deals for the first time. In southern Sweden (SE3/SE4), ~45% of households have transitioned to hourly contracts. The broader addressable market (timpris + monthly variable) is **3.5-4 million households**.

**Growth catalysts:**
- 15-minute pricing transition (Oct 2025) increases complexity -- users need better tools
- 200,000+ solar installations in Sweden, growing rapidly
- Sweden has one of Europe's highest EV penetration rates
- Home battery market emerging (Tibber and Greenely offer virtual power plant integration)

Sources: [SCB](https://www.scb.se/en/finding-statistics/statistics-by-subject-area/energy/price-trends-in-the-energy-sector/electricity-prices-and-electricity-contracts/), [Energimarknadsinspektionen](https://ei.se/om-oss/statistik-och-oppna-data/kunder-per-avtalstyp---elhandel)

### 3.2 Competition Analysis

| App | Type | Monthly Cost | Shows Total Cost? | Requires Contract? | Rating |
|-----|------|-------------|-------------------|-------------------|--------|
| **Tibber** | Electricity provider | 49 SEK/mo | Partial (own customers only) | Yes -- must switch provider | 4.5+ |
| **Greenely** | Electricity provider | 49-69 SEK/mo | Partial (own customers only) | Yes -- must switch provider | Mixed |
| **Elpris idag** | Info app | Free (ads) / $0.99 | No | No | 1.0/5 |
| **Elpriser Live** | Info app | Free / 39 SEK/mo | No | No | No ratings |
| **Elen** (Android) | Info app | Free | No | No | -- |
| **Elpriset (us)** | **Info app** | **Free / Premium** | **Yes (spot+grid+tax+VAT)** | **No** | -- |

**Tibber (300-500K Swedish customers):** Full electricity provider, not just an app. 49 SEK/month. Good app but requires contract switch. User complaints: broken integrations (Nibe heat pumps), Pulse device connectivity, slow customer service, AI support can't handle complex queries.

**Greenely (~200K users):** Also requires contract switch. 49-69 SEK/month. User complaints: "full of bugs and immature functions," marketed features not released, 7+ day customer service wait, billing discrepancies.

**Free apps (Elpris idag, Elpriser Live):** Only show spot price. Elpris idag described as "way too busy, too many ads, impossible to navigate." Elpriser Live has zero ratings.

**Critical gap:** No free, provider-agnostic app shows total cost. Tibber requires contract. Our app fills this gap.

### 3.3 Is This Worth Building? -- Honest Assessment

**Yes, with caveats.**

**FOR:**
1. Clear, verifiable market gap -- no free app shows total cost (spot + grid + tax + VAT)
2. Large and growing market (1.25M timpris households, trending toward 2M in 2-3 years)
3. Extremely low competition quality (Elpris idag: 1.0 stars; Elpriser Live: no ratings)
4. Near-zero operating costs -- all APIs (elprisetjustnu.se, Sourceful) are free, no auth, app is client-side
5. Daily-use utility apps are subscription fatigue exceptions -- users check prices every day
6. The Sourceful Eltariff API (194 tariffs, 39 DSOs) is the technical enabler that didn't exist a few years ago

**AGAINST:**
1. Tibber/Greenely could add free price viewing (unlikely -- their model depends on contract lock-in)
2. Niche Swedish market limits scale (max 5M households). Not venture-scale, but excellent indie app
3. Total cost accuracy depends on Sourceful API coverage -- gaps for some DSOs mean bad data and bad reviews
4. App Store may reject subscription for utility app if premium features feel thin (mitigate: total cost, Watch, widgets, alerts are substantial)

**Window of opportunity:** 12-24 months before a larger player replicates total cost for non-customers.

---

## 4. Target Audience

- **Primary:** Swedish homeowners on variable-rate electricity contracts (timpris/kvartspris) -- approximately 1-1.25 million households today, growing toward 2 million
- **Secondary:** Monthly variable contract holders who benefit from price awareness (~2.5M households), renters, EV owners optimizing charging
- **Tertiary:** Solar panel owners (200,000+ installations in Sweden, growing rapidly)
- **Total addressable:** 3.5-4M Swedish households benefit from electricity price visibility

---

## 5. Design & Style

### Visual Identity
- **Design system:** Data-forward, dashboard-style. Think: Apple Weather meets a Bloomberg terminal, simplified for consumers.
- **Color palette:** Dark mode primary (electricity = nighttime associations). Price-based color coding:
  - Very cheap: bright green (#34C759)
  - Cheap: soft green (#8FD5A6)
  - Normal: neutral gray (#8E8E93)
  - Expensive: warm orange (#FF9500)
  - Very expensive: red (#FF3B30)
- **Background:** Deep charcoal (#1C1C1E) in dark mode. Clean white (#F2F2F7) in light mode.
- **Typography:** SF Pro Rounded for price numbers (feels modern, approachable). SF Pro for body text.
- **Charts:** Use Swift Charts framework. Color-coded bar chart as primary view (one bar per 15-min interval), smooth area chart as secondary toggle. See section 6.2 for details.
- **Animations:** Subtle price transitions. The current price should pulse gently when it changes.

### Accessibility: Color-Blind Safe Design
The green-to-red spectrum is problematic for red-green color blindness (~8% of males). **Never rely on color alone** to convey price level. Every color indicator must have a redundant encoding:

- **Text labels** alongside colors ("Billigt", "Dyrt")
- **Icon indicators** in charts (checkmark for cheap, warning triangle for expensive)
- **Position/size** as secondary cue (bar height already encodes price)
- **Settings option** for accessible color palette (blue-to-orange diverging scheme):

| Level | Default Color | Accessible Alt | Hex |
|-------|--------------|---------------|-----|
| Very Cheap | Bright Green (#34C759) | Deep Teal | #004488 |
| Cheap | Soft Green (#8FD5A6) | Light Blue | #6699CC |
| Normal | Gray (#8E8E93) | Neutral Gray | #BBBBBB |
| Expensive | Orange (#FF9500) | Orange | #EE7733 |
| Very Expensive | Red (#FF3B30) | Crimson | #CC3311 |

Test with the Sim Daltonism macOS tool during development.

### UX Principles
1. **Current price in < 0.5 seconds** -- the app opens to the number that matters
2. **Color = understanding** -- green means cheap, red means expensive, no reading required (but never color-only -- always pair with text/icons)
3. **Actionable, not just informational** -- don't just show price, tell users what to DO
4. **Widget-first** -- many users will never open the app, they'll use widgets
5. **No account required** -- works immediately on first launch

---

## 6. Killer Feature

**"Totalkostnad" (Total Cost)**

The app calculates and displays the user's actual total electricity cost per kWh by combining:
1. **Spot price** (from elprisetjustnu.se, 15-min resolution)
2. **Grid fee** (nätavgift, from Sourceful Eltariff-API based on user's location)
3. **Electricity tax** (energiskatt, currently 42.8 öre/kWh)
4. **VAT** (25% on everything above)

No other free app does this. Users see: "Right now, your electricity costs **1.87 SEK/kWh**" instead of just the spot price (which might be 0.42 SEK/kWh -- misleading on its own). The difference can be 4-5x.

---

## 7. MVP Features (v1.0 -- App Store Launch)

### 7.1 Onboarding (2-3 screens)

**Screen 1: Value Proposition + Location Permission**
- Hero text: "Se vad din el verkligen kostar"
- Show compelling example: "Spotpris 42 öre vs. Totalkostnad 1.87 SEK" (side-by-side, color-coded)
- Explain why location is needed: "För att visa rätt elpris och nätavgift för ditt område"
- CTA button: "Visa mitt elpris" (triggers iOS location permission dialog)
- "Välj manuellt" link for users who decline location

**Screen 2: Zone + Grid Operator Confirmation + Live Price**
- Auto-detected result: "Du är i SE3 - Stockholm. Din nätförbindelse är Ellevio."
- **Show live price immediately** -- this is the "aha moment": "Just nu kostar din el: 1.87 SEK/kWh"
- Cost breakdown below: Spotpris 42 öre + Nät 35 öre + Skatt 42.8 öre + Moms = 1.87 SEK
- Manual override option for zone and grid operator
- CTA: "Fortsätt" (Done)

**No account needed. No notifications asked yet. Total time: < 30 seconds.**

**Key principles applied:**
- Show value (the live total price) BEFORE the paywall -- this creates the "aha moment"
- Explain WHY permissions are needed (custom screen before system dialog)
- Don't ask for notifications during onboarding -- defer to contextual moment (see 7.3)
- Don't ask for electricity provider -- app is provider-agnostic (competitive advantage)
- If location denied, fall back to manual zone + DSO picker (never dead-end users)

### 7.2 Home Screen (Price Dashboard)

**Top section: Current Price (hero element)**
- Large number: current 15-minute total cost in SEK/kWh (or öre/kWh, user preference)
- Color-coded background based on price level
- Small label: "Spotpris: X öre + Nät: Y öre + Skatt: Z öre"
- Trend arrow: up/down compared to same time yesterday

**Middle section: Today's Price Chart**

Primary view: **Color-coded bar chart** (one `BarMark` per 15-min interval, 96 bars total). Research shows bar charts score 22.7% higher in understandability vs. enhanced visualizations for energy data on smartphones. Each bar's color maps to `PriceLevel`.

Secondary view (toggle): **Smooth area chart** with line for understanding the day's price shape/trend.

Chart interactions:
- **Current time marker:** `RuleMark` vertical line + `PointMark` at current price. Use "dimming layer" pattern -- past hours rendered at reduced saturation with semi-transparent overlay, future hours at full brightness (technique from nilcoalescing.com)
- **Tap to reveal:** Tap any bar to see exact price, time window, and cost breakdown in a tooltip
- **Drag/scrub:** Horizontal drag scrubs through time, updating a floating detail overlay (like iOS Stocks app). Implemented via `ChartProxy` and gesture location mapping
- **Toggle:** Segmented control for "Spotpris" / "Totalkostnad"
- **Tomorrow separator:** When tomorrow's prices are available, show them with dashed outlines or reduced opacity, separated by a subtle vertical dashed line at midnight

**Bottom section: Smart Tips**
- "Cheapest time remaining today: 14:15 - 14:30 (0.89 SEK/kWh)"
- "Most expensive: 18:00 - 18:15 (3.42 SEK/kWh)"
- "Best time to run dishwasher: 14:00 (saves ~2.50 SEK vs running now)"

### 7.3 Tomorrow's Prices
- Available from ~13:00 CET each day
- Same chart view as today (dashed/reduced opacity to distinguish from today)
- **Notification permission request (contextual):** The FIRST time tomorrow's prices become available, show a custom dialog: "Imorgons priser är här! Vill du få en notis varje dag när de publiceras?" This is the optimal moment to ask -- the user understands the value.
- Push notification (if granted): "Imorgons priser är här. Billigaste kvarten: 03:15 (0.12 SEK/kWh)"

### 7.4 Price History
- 7-day view with daily average, min, max
- 30-day view with trend line (use `chartScrollableAxes(.horizontal)` with pinch-to-zoom)
- Monthly cost estimate based on average consumption input

### 7.5 Widgets (Critical for this app type)

**Lock Screen Widget (Inline/Circular):**
- Current price as number with color-coded circular background
- Tiny trend arrow (up/down vs. previous hour)
- No chart -- just the number

**Home Screen Widget (small):**
- Current price (large, prominent) at top
- Mini sparkline of remaining hours today (no axes, just shape and color)
- Color-coded background shifts with price level
- Updated via `BGAppRefreshTask` every 15 minutes

**Home Screen Widget (medium):**
- Current price (left side) + mini bar chart of today's remaining prices (right side)
- Cheapest remaining hour shown as text below chart
- Toggle between "Spot" and "Total" directly in widget (interactive widgets)

**Home Screen Widget (large):**
- Full 24-hour simplified bar chart (shape + color, minimal axis labels)
- Current price prominent at top
- Tomorrow preview strip if available (smaller bars below today's)
- Smart tip text at bottom: "Billigaste kvarten: 14:15"

**iOS 26 considerations:** Test color coding under the new glass presentation tinting system. Consider push-based widget updates (`WidgetPushHandler` with APNs) since prices change on a known schedule.

### 7.6 Apple Watch Complication
- Current price with color
- Complication updates every 15 minutes

### 7.7 Settings
- Price zone (SE1/SE2/SE3/SE4)
- Grid operator (auto-detected by location, or manual override from list)
- Display preference: öre/kWh or SEK/kWh
- Include/exclude VAT in display
- Include/exclude grid fee in display
- Accessible color palette toggle (blue-to-orange for color blindness)
- Monthly consumption estimate (kWh, for cost projections)
- Notification preferences

---

## 8. Features NOT in MVP (Future Versions)

### v1.1 (1-2 months post-launch)
- **Solar production overlay** -- yellow `AreaMark` at 40% opacity behind price bars, showing estimated PV production. Highlight zones where solar + expensive price overlap (maximum self-consumption value). Summary: "Your panels could save you X SEK today."
- **CO2 intensity indicator** -- show carbon intensity (gCO2eq/kWh) alongside price using Electricity Maps API. "Your electricity is 95% carbon-free right now." Green badge when mix is clean.
- **Swedish energy mix display** -- current production breakdown (hydro, nuclear, wind, solar) from eSett Open Data
- **Monthly cost reports** with savings estimate vs. fixed-price contract. Side-by-side bars: "What you paid" vs. "Fixed contract would cost." Cumulative savings line: "You've saved 847 SEK since you started using Elpriset."
- **Price alerts** -- push notification when price drops below / rises above user-defined threshold
- **EV charging optimizer** -- "plug in now, cheapest charging window is 02:00-05:00"
- **iPad dashboard mode** -- always-on price display for kitchen counter
- **Share price** -- "electricity is super cheap right now!" share card for social media
- **Compare your contract** -- input current contract details, see how much you'd save on timpris vs. fixed (viral sharing feature + natural upsell moment)

### v1.2+
- **Home battery optimization** -- when to charge/discharge based on price forecast
- **Consumption tracking** -- manual input or Tibber Pulse integration
- **Multi-zone support** -- e.g., cabin in SE1, home in SE3

### v2.0
- **HomeKit integration** -- trigger automations based on price level
- **Shortcuts/Siri** -- "Hey Siri, what's the electricity price right now?"

---

## 9. Technical Architecture

### Platform
- **Language:** Swift 6
- **UI Framework:** SwiftUI
- **Charts:** Swift Charts
- **Minimum iOS:** 17.0
- **Widgets:** WidgetKit (Lock Screen + Home Screen)
- **Watch:** WatchKit with SwiftUI
- **Persistence:** SwiftData for settings + cached price data
- **Networking:** async/await with URLSession
- **Background refresh:** BGAppRefreshTask for widget updates
- **Architecture:** MVVM with @Observable

### Data Flow

```
[elprisetjustnu.se API] ---(15-min prices)---> [PriceService]
[Sourceful Eltariff-API] ---(grid tariffs)---> [TariffService]
[Hardcoded: tax + VAT rates] ---> [CostCalculator]

PriceService + TariffService + CostCalculator ---> [PriceViewModel]
PriceViewModel ---> [SwiftUI Views / Widgets / Watch]
```

### Data Models

```swift
struct SpotPrice: Codable, Identifiable {
    var id: String { timeStart.ISO8601Format() }
    let sekPerKwh: Decimal
    let eurPerKwh: Decimal
    let exchangeRate: Decimal
    let timeStart: Date
    let timeEnd: Date

    enum CodingKeys: String, CodingKey {
        case sekPerKwh = "SEK_per_kWh"
        case eurPerKwh = "EUR_per_kWh"
        case exchangeRate = "EXR"
        case timeStart = "time_start"
        case timeEnd = "time_end"
    }
}

struct GridTariff {
    let dsoName: String // e.g., "Ellevio"
    let energyPricePerKwh: Decimal // öre/kWh, varies by time
    let powerPricePerKw: Decimal? // effektavgift (optional)
    let fixedMonthlyFee: Decimal
}

struct TotalPrice {
    let spotPrice: Decimal // SEK/kWh
    let gridFee: Decimal // SEK/kWh
    let electricityTax: Decimal // 0.428 SEK/kWh (2026)
    let vatMultiplier: Decimal // 1.25

    var total: Decimal {
        (spotPrice + gridFee + electricityTax) * vatMultiplier
    }

    var priceLevel: PriceLevel {
        // K-means clustering or percentile-based
        switch total {
        case ..<0.80: return .veryCheap
        case ..<1.20: return .cheap
        case ..<2.00: return .normal
        case ..<3.00: return .expensive
        default: return .veryExpensive
        }
    }
}

enum PriceLevel: String {
    case veryCheap, cheap, normal, expensive, veryExpensive

    var color: Color {
        switch self {
        case .veryCheap: return .green
        case .cheap: return Color(hex: "#8FD5A6")
        case .normal: return .gray
        case .expensive: return .orange
        case .veryExpensive: return .red
        }
    }
}

enum PriceZone: String, CaseIterable {
    case SE1, SE2, SE3, SE4

    var displayName: String {
        switch self {
        case .SE1: return "SE1 - Luleå (Norra Sverige)"
        case .SE2: return "SE2 - Sundsvall (Mellersta Sverige)"
        case .SE3: return "SE3 - Stockholm (Södra Mellansverige)"
        case .SE4: return "SE4 - Malmö (Södra Sverige)"
        }
    }
}
```

### Caching Strategy
- Cache today's prices locally after first fetch (they don't change)
- Cache tomorrow's prices once available (~13:00 CET)
- Grid tariff: cache for 24 hours (changes rarely -- monthly/seasonally)
- Background app refresh every 15 minutes for widget updates
- Offline: always show cached data, display "last updated" timestamp

### Zone Detection from Location
```swift
// Approximate latitude boundaries for Swedish price zones
func detectZone(latitude: Double) -> PriceZone {
    switch latitude {
    case 65.0...: return .SE1    // North of ~Luleå
    case 62.0..<65.0: return .SE2 // Sundsvall area
    case 56.0..<62.0: return .SE3 // Stockholm/Gothenburg
    default: return .SE4          // South (Malmö, Skåne)
    }
}
// Note: This is approximate. Actual zone boundaries follow
// municipality borders. Allow manual override in settings.
```

---

## 10. APIs & External Dependencies

### Primary: elprisetjustnu.se (Spot Prices)

```
Base URL: https://www.elprisetjustnu.se/api/v1/prices

GET /{year}/{month}-{day}_{zone}.json

Example: https://www.elprisetjustnu.se/api/v1/prices/2026/02-26_SE3.json

Response: JSON array of SpotPrice objects (96 items for 15-min, 24 for hourly pre-Oct 2025)

Auth: None (completely open, static JSON files served from CDN)
Rate Limits: None documented
Availability: Data from Nov 2022 onward
Tomorrow's prices: Available from ~13:00 CET
RSS feed: /rss/prices/{zone}
```

### Secondary: Sourceful Eltariff-API (Grid Fees + Spot Price Fallback)

```
Base URL (Tariffs): https://mainnet.srcful.dev/price/tariffs
Base URL (Spot):    https://mainnet.srcful.dev/price/electricity
Docs:               https://docs.sourceful.energy/developer/price-api/

Tariff Endpoints:
  GET /price/tariffs/lookup?lon={lon}&lat={lat}    -> Find DSO + tariffs by coordinates
  GET /price/tariffs/providers                      -> List all 39 Swedish DSOs
  GET /price/tariffs/{provider_id}                  -> Tariffs for specific DSO
  GET /price/tariffs/tariff/{tariff_id}             -> Full tariff details
  GET /price/tariffs/tariff/{id}/energyPrice/{ISO8601_datetime} -> Grid energy price at time
  GET /price/tariffs/tariff/{id}/powerPrice/{ISO8601_datetime}  -> Power component at time
  GET /price/tariffs/tariff/{id}/fixedPrice/{ISO8601_datetime}  -> Fixed component at time
  GET /price/tariffs/health                          -> Service health check

Spot Price Endpoints (secondary fallback):
  GET /price/electricity/{area}                     -> Current day spot prices (e.g., /electricity/SE3)
  GET /price/electricity/{area}?date=YYYY-MM-DD     -> Historical spot prices
  GET /price/electricity/areas                      -> All 39 supported European areas
  GET /price/electricity/health                     -> Health check

Auth: None documented
Coverage: 194 tariffs from 39 Swedish DSOs
Spot price format: EUR/MWh, PT60M resolution
```

### Fallback 1: Energi Data Service (Spot Prices)

```
Base URL: https://api.energidataservice.dk

GET /dataset/Elspotprices?limit=96&filter={"PriceArea":"SE3"}&start=2026-02-26

Key parameters:
  start / end     -- date range (supports now-P1D syntax)
  filter          -- JSON, e.g., {"PriceArea":["SE3","SE4"]}
  sort            -- e.g., HourUTC desc
  limit / offset  -- pagination
  columns         -- specific fields only

Response fields: HourUTC, HourDK, PriceArea, SpotPriceDKK, SpotPriceEUR

Auth: None (completely free and open)
Rate limit: 1 request per IP per dataset per minute
Coverage: All Nordic + Baltic zones (SE1-SE4, DK1-2, NO1-5, FI, EE, LT, LV)
Operator: Energinet (Danish TSO)
Docs: https://www.energidataservice.dk/guides/api-guides
```

### Fallback 2: ENTSO-E Transparency Platform

```
Base URL: https://web-api.tp.entsoe.eu/api

Required params:
  securityToken={token}
  documentType=A44
  processType=A01
  in_Domain={EIC_code}
  out_Domain={EIC_code}
  periodStart={YYYYMMDDHHMM}
  periodEnd={YYYYMMDDHHMM}

Sweden EIC codes:
  SE1: 10Y1001A1001A44P
  SE2: 10Y1001A1001A45N
  SE3: 10Y1001A1001A46L
  SE4: 10Y1001A1001A47J

Auth: Free security token (register at transparency.entsoe.eu, email transparency@entsoe.eu)
Response: XML (not JSON -- requires XML parsing)
Rate limit: 400 requests/minute per IP/token. Exceeding triggers 10-minute ban.
```

### Future: Solar & Weather (v1.1)

```
Forecast.Solar (PV production estimate):
  GET https://api.forecast.solar/estimate/{lat}/{lon}/{declination}/{azimuth}/{kwp}
  Sub-endpoints: /estimate/watts/..., /estimate/watthours/..., /estimate/watthours/day/...
  Auth: None (free tier: 12 req/hour, 1-hour resolution)
  Paid tiers: 15-min resolution, 720 req/60 min
  Response: JSON (also XML, CSV, YAML)
  Forecast range: Up to 7 days

Open-Meteo (free alternative/complement to Forecast.Solar):
  GET https://api.open-meteo.com/v1/forecast?latitude=59.33&longitude=18.07&hourly=shortwave_radiation,direct_radiation,diffuse_radiation,global_tilted_irradiance&tilt=30&azimuth=0&forecast_days=7&timezone=Europe/Stockholm
  Auth: None (free for non-commercial use)
  Supports custom tilt + azimuth via global_tilted_irradiance parameter
  No API key needed -- recommended as primary solar data source or Forecast.Solar fallback

SMHI PMP3G (weather forecast / cloud cover):
  GET https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/{lon}/lat/{lat}/data.json
  Auth: None
  Useful params: tcc_mean (total cloud cover), t (temperature), ws (wind speed)
  Forecast range: Up to 10 days

SMHI STRANG (solar radiation historical):
  GET https://opendata-download-metanalys.smhi.se/api/category/strang1g/version/1/geotype/point/lon/{lon}/lat/{lat}/parameter/117/data.txt?from={YYYYMMDDHH}&to={YYYYMMDDHH}&interval=hourly
  Auth: None
  Parameter 117: Global horizontal irradiance (W/m2)
  Data range: 1999 to present
```

### Future: CO2 & Energy Mix (v1.1)

```
Electricity Maps (carbon intensity):
  Base URL: https://api.electricitymaps.com/v3/
  GET /carbon-intensity/latest?zone=SE-SE3      -> Current gCO2eq/kWh
  GET /carbon-intensity/history?zone=SE-SE3     -> Last 24 hours
  GET /carbon-intensity/forecast?zone=SE-SE3    -> Forecast
  GET /power-breakdown/latest?zone=SE-SE3       -> Generation mix (wind, solar, hydro, nuclear)
  GET /renewable-energy/latest?zone=SE-SE3      -> Renewable percentage
  Auth: API key (header: auth-token). Free tier: 1 zone, 50 req/hour
  Signup: https://www.electricitymaps.com/free-tier-api
  Zones: SE, SE-SE1, SE-SE2, SE-SE3, SE-SE4
  Granularity: 5_minutes, 15_minutes, hourly, daily, monthly

eSett Open Data (Swedish energy production):
  Portal: https://opendata.esett.com
  API: https://api.opendata.esett.com
  Coverage: Nordic (SE, FI, NO, DK)
  Data: Production totals by type, consumption, market prices, imbalance settlement
  Auth: Not documented (likely free)
  Note: Official source for Swedish production data since March 2025 (replaced Svenska Kraftnät Mimer)

mgrey.se espot (K-means price classification reference):
  GET https://mgrey.se/espot?format=json
  GET https://mgrey.se/espot?format=json&date=2026-02-26
  Auth: None
  Response includes pre-calculated K-means price categories (0-3) -- useful reference for price level classification
  Coverage: SE1-SE4, data from 2022-09-01
```

### Future: Statistics & Benchmarks (v1.2)

```
SCB PxWebApi 2.0 (average consumption benchmarks):
  Base URL: https://statistikdatabasen.scb.se/api/v2/
  Auth: None for GET
  Relevant datasets:
    EN0105 -- Electricity consumption by county and sector (annual)
    ElanvM  -- Monthly electricity consumption by usage area (from 1990)
    SSDHalvarElHus -- Electricity prices for households (half-year)
  Useful for: Average consumption profiles, monthly cost estimate defaults

Energimyndigheten (solar installation statistics):
  Database: https://pxexternal.energimyndigheten.se/pxweb/en/Energimyndighetens_statistikdatabas/
  Data: Grid-connected solar installations count + capacity by municipality and year
  Format: PxWeb (tables downloadable as Excel, CSV)
```

### Hardcoded Constants (update annually)

```swift
struct ElectricityConstants {
    // Updated for 2026
    static let electricityTaxPerKwh: Decimal = 0.428 // SEK/kWh (energiskatt)
    static let vatRate: Decimal = 0.25 // 25% moms
    static let vatMultiplier: Decimal = 1.25

    // Price level thresholds (SEK/kWh total cost, adjust seasonally)
    static let veryCheapThreshold: Decimal = 0.80
    static let cheapThreshold: Decimal = 1.20
    static let normalThreshold: Decimal = 2.00
    static let expensiveThreshold: Decimal = 3.00
}
```

### Spot Price Fallback Chain

```
1. elprisetjustnu.se (primary -- free, no auth, JSON, 15-min resolution)
     |
     v  (if down)
2. Sourceful /price/electricity/{area} (free, no auth, JSON, hourly EUR/MWh)
     |
     v  (if down)
3. Energi Data Service (free, no auth, JSON, 1 req/min rate limit)
     |
     v  (if down)
4. ENTSO-E (free, requires token, XML, 400 req/min)
```

---

## 11. Monetization

### Model: Freemium with subscription

**Free tier:**
- Current price (spot only, no total cost)
- Today's price chart (spot prices)
- 1 small widget
- Totalkostnad shown **once** during onboarding (demonstrates value, creates loss aversion)

**Premium tier ("Elpriset Pro"):**
- Total cost calculation (spot + grid + tax + VAT) -- the killer feature
- Tomorrow's prices with push notification
- All widget sizes including Lock Screen
- Apple Watch complication
- Smart tips (cheapest/most expensive windows)
- Price history (7-day, 30-day)
- Monthly cost estimates
- Price alerts

**Pricing:**
- Weekly: 19 SEK/week (with 3-day free trial) -- anchor price to make annual look cheap
- Monthly: 29 SEK/month -- 86% of Scandinavian consumers prefer monthly billing
- Annual: 149 SEK/year (promoted as best value -- "bara 12 kr/månad")
- Lifetime: 349 SEK

**Pricing rationale:**
- Weekly at 19 SEK annualizes to 988 SEK -- intentionally high as an anchor. The European average weekly app price is ~88 SEK ($8.3), so 19 SEK is actually below average but high relative to the annual price. This makes 149 SEK/year feel like a steal. Be prepared for some negative reviews about the weekly price.
- Monthly at 29 SEK fills a gap -- Scandinavians strongly prefer monthly billing (86% preference). Without this tier, you lose users who won't commit to annual.
- Annual at 149 SEK/year is 3-5x cheaper than Tibber/Greenely monthly fees (though those are electricity contracts, not just apps). Competitive vs. Elpriser Live at 349 SEK/year.
- Lifetime at 349 SEK = ~2.3 years of annual. Note: annual/lifetime subscriptions are declining (annual dropped from 28% to 15% of global app revenue since 2023). Offer it but don't expect it to be the primary revenue driver.

**Revenue projection (sanity check):**
- 30,000 SEK MRR target = ~2,400 annual subscribers or ~1,030 monthly subscribers
- At 50,000 downloads, need ~2-5% conversion to paying (industry benchmark: 2.2% median for freemium)
- Achievable but requires active marketing (see section 14)

### Paywall Strategy

82% of trial starts happen on Day 0 (installation day). The paywall must appear during the first session, but AFTER demonstrating value.

```
1. Onboarding (2 screens) -> Show live total price immediately (FREE)
2. User explores today's chart (FREE -- spot price only view)
3. User taps "Totalkostnad" toggle -> Show it ONCE for free with full breakdown
4. Paywall appears: "För att se totalkostnaden varje dag, uppgradera till Pro"
   - 3-day free trial prominently shown
   - Frame annual: "149 SEK/år = bara 12 kr/månad"
   - Show what they get: Totalkostnad, Widgets, Watch, Notiser, Smarta tips
5. User can dismiss and continue using free tier (spot price only)
6. After trial ends: show total cost blurred/redacted ("XXX SEK/kWh") with unlock button
```

**Why this works:**
- "Try once free" creates loss aversion -- once you see the real cost vs. spot price, spot-only feels incomplete
- Paywall on Day 0 captures peak intent (apps with upfront paywalls convert at 12.1% vs. 2.2% for deferred)
- Free tier remains genuinely useful (spot prices, chart, 1 widget) so users don't rage-uninstall

---

## 12. App Store Optimization (ASO)

### Keywords (Swedish)
Primary: elpris, elpriser, spotpris, elpris idag, timpris el
Secondary: elområde, SE3, SE4, kvartspris, elpris imorgon, elpriset
Long-tail: elpris idag stockholm, billigaste elen idag, elpris widget

### App Name
`Elpriset - Spotpris & Totalkostnad`

### Subtitle
`15-minuters elpriser med nätavgift & moms`

### App Store Description (first lines)
```
Se vad din el verkligen kostar -- inte bara spotpriset. Elpriset är den enda appen som visar din totalkostnad inklusive nätavgift, energiskatt och moms, uppdaterad var 15:e minut.

Funktioner:
- Totalkostnad per kWh baserat på din nätägare
- 15-minuters prisuppdateringar (kvartspris)
- Imorgons priser från kl 13:00
- Widgets för hemskärm och låsskärm
- Apple Watch med aktuellt pris
- Smarta tips: bästa tid att köra tvätt, ladda elbil
```

---

## 13. Success Metrics

| Metric | Target (6 months) | Benchmark |
|--------|-------------------|-----------|
| Downloads | 50,000 | Requires active ASO + Swedish tech media coverage |
| DAU/MAU ratio | 40%+ | Daily price checking drives high engagement |
| Widget adoption | 60%+ of users | Core interaction for this app type |
| Trial-to-paid conversion | 10%+ | Industry median: 2.2% (freemium), 12.1% (hard paywall) |
| App Store rating | 4.6+ | Current competition: 1.0 stars (Elpris idag) |
| MRR | 30,000 SEK (~3,200 EUR) | ~1,030 monthly or ~2,400 annual subscribers |

---

## 14. Go-to-Market Strategy

50,000 downloads in 6 months for a Swedish-only utility app requires active marketing. Organic App Store discovery alone will not get there.

### Launch Channels
- **Swedish tech media:** Ny Teknik, Techworld, Breakit -- pitch the "total cost" angle
- **Swedish Reddit/forums:** r/sweden, r/privatekonomi, Flashback (ekonomi-forumet), Sweclockers
- **Energy/money blogs:** Swedish personal finance bloggers (RikaTillsammans, Ekonomifokus)
- **Social media:** Swedish Facebook groups for electricity (e.g., "Elpris - timpris" groups), Twitter/X Swedish tech community
- **Seasonal timing:** Launch before winter (Oct-Nov) when electricity prices spike and user attention peaks
- **PR hook:** "The only free app that shows your actual electricity cost, not just the spot price"

### Viral Features
- **Share card:** "Electricity is super cheap/expensive right now!" shareable image for social media
- **Compare-your-contract calculator** (v1.1): Users share savings comparisons -- organic word-of-mouth

---

## 15. Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| elprisetjustnu.se goes down | 3-tier fallback chain: Sourceful -> Energi Data Service -> ENTSO-E. Cache aggressively. Show "last updated" time. |
| Grid tariff API incomplete | Allow manual DSO selection. Hardcode the top 10 DSOs as fallback. Show "nätavgift ej tillgänglig" gracefully. |
| Apple rejects "utility" subscription | Ensure premium features are substantial (total cost calc, alerts, Watch, widgets). Follow Apple's subscription guidelines: transparent pricing, no dark patterns, restore mechanism in paywall. |
| Electricity tax rate changes | Centralized constants file. Push an app update or use remote config. |
| Competition from Tibber/Greenely | They require contracts. This app is provider-agnostic and free to start. Different market. Window: 12-24 months. |
| 15-min pricing reverted or changed | The app works with both hourly and 15-min data. Detect resolution from API response. |
| Weekly pricing negative reviews | Make annual price extremely prominent. Weekly exists only as an anchor. Monitor reviews and adjust if needed. |
| Color accessibility complaints | Ship with accessible alt palette from day 1. Always pair color with text/icons. |

---

## 16. Data Visualization Reference

### Chart Implementation Notes (Swift Charts)

**Primary bar chart:**
```swift
Chart(prices) { price in
    BarMark(
        x: .value("Time", price.timeStart),
        y: .value("Price", price.total)
    )
    .foregroundStyle(price.priceLevel.color)

    // Current time marker
    RuleMark(x: .value("Now", Date.now))
        .foregroundStyle(.white.opacity(0.6))
        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 3]))

    // Current price point
    PointMark(
        x: .value("Now", currentPrice.timeStart),
        y: .value("Price", currentPrice.total)
    )
    .foregroundStyle(.white)
    .symbolSize(40)
}
.chartOverlay { proxy in
    // Drag gesture for scrub-to-reveal
}
```

**"Dimming layer" for past hours:** Overlay a semi-transparent `RectangleMark` from chart start to current time, dimming past data while keeping future hours bright.

**Tomorrow's prices:** When available, append with dashed `BarMark` style or reduced opacity (0.5), separated by a midnight `RuleMark`.

### Solar Overlay (v1.1)
```swift
// Yellow area behind price bars
AreaMark(
    x: .value("Time", solarPoint.time),
    y: .value("Production", solarPoint.kwh)
)
.foregroundStyle(.yellow.opacity(0.4))
.interpolationMethod(.catmullRom)
```

### Widget Sparkline Pattern
For small widgets, use a simplified `LineMark` with no axes, labels, or grid -- just the price shape with color gradient fill. This gives maximum information in minimum space.
