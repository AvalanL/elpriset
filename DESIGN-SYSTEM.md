# Elpriset Design System

> Definitive visual and interaction specification for the Elpriset iOS app.
> Every screen, component, and pixel decision should reference this document.

---

## 1. Design Philosophy

**Clean energy dashboard with Scandinavian minimalism.**

The app draws from the reference aesthetic: generous whitespace, a light and airy base, deliberate pops of muted green and soft lavender, and dark cards that ground the layout. It should feel like a premium smart-home control panel -- not a finance app, not a weather app. Calm, confident, data-forward.

**Core principles:**
1. **Light-dominant:** White and off-white backgrounds create breathing room. Dark elements are used sparingly for emphasis (hero cards, summary pills, bottom sections).
2. **Soft color accents:** Muted sage green and soft lavender -- never loud or saturated. The palette whispers, it doesn't shout.
3. **Bold data, quiet chrome:** Numbers and prices are large, heavy, and black. Supporting UI (labels, dividers, icons) recedes into light gray.
4. **Rounded everything:** All containers, cards, pills, buttons, and chart elements use generous corner radii. No sharp edges anywhere.
5. **Flat with depth hints:** No drop shadows on cards. Depth comes from background fill contrast (white card on gray background, dark card on white background). Exception: the hero price card may use a very subtle shadow (see Section 6).

---

## 2. Color Palette

### 2.1 Foundation Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `background.primary` | `#FFFFFF` | 255, 255, 255 | Main screen background |
| `background.secondary` | `#F5F5F7` | 245, 245, 247 | Section backgrounds, grouped table bg |
| `background.tertiary` | `#EEEEEF` | 238, 238, 239 | Dividers, input field fills |
| `surface.dark` | `#1A1A1A` | 26, 26, 26 | Dark cards, summary pills, onboarding bottom |
| `surface.darkElevated` | `#2C2C2E` | 44, 44, 46 | Elevated dark elements (tooltips, callouts) |

### 2.2 Accent Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `accent.green` | `#8FD5A6` | 143, 213, 166 | Primary accent -- stat cards, positive trends, active bars, CTA fills |
| `accent.greenLight` | `#D4EFDD` | 212, 239, 221 | Light green fills, low-opacity chart bars, tag backgrounds |
| `accent.greenDark` | `#3A7D52` | 58, 125, 82 | Positive trend text, icon tints on green cards |
| `accent.lavender` | `#EDE5F5` | 237, 229, 245 | Chart card background, highlight sections |
| `accent.lavenderMid` | `#D8CCE8` | 216, 204, 232 | Lavender pressed state, deeper chart fills |

### 2.3 Text Colors

| Token | Hex | RGB | Usage |
|-------|-----|-----|-------|
| `text.primary` | `#000000` | 0, 0, 0 | Headlines, large numbers, bold labels |
| `text.secondary` | `#6E6E73` | 110, 110, 115 | Subtitles, dates, descriptions |
| `text.tertiary` | `#AEAEB2` | 174, 174, 178 | Placeholders, axis labels, disabled |
| `text.onDark` | `#FFFFFF` | 255, 255, 255 | Text on dark cards/pills |
| `text.onDarkSecondary` | `#A1A1A6` | 161, 161, 166 | Secondary text on dark surfaces |
| `text.onGreen` | `#1A1A1A` | 26, 26, 26 | Text on green accent cards |

### 2.4 Price-Level Colors

These are used for the electricity price chart bars, hero price backgrounds, and price level indicators. They blend with the overall muted aesthetic -- not the pure system colors from iOS.

| Level | Token | Hex | RGB | Usage |
|-------|-------|-----|-----|-------|
| Very Cheap | `price.veryCheap` | `#8FD5A6` | 143, 213, 166 | Same as accent green -- full opacity bar |
| Cheap | `price.cheap` | `#B8E6C8` | 184, 230, 200 | Lighter green bar |
| Normal | `price.normal` | `#D4EFDD` | 212, 239, 221 | Very light green bar (barely tinted) |
| Expensive | `price.expensive` | `#F5C882` | 245, 200, 130 | Muted warm amber |
| Very Expensive | `price.veryExpensive` | `#E88F8F` | 232, 143, 143 | Muted soft red (not aggressive) |

**Accessible alternative palette** (toggled in Settings for color-blind users):

| Level | Token suffix `.accessible` | Hex |
|-------|---------------------------|-----|
| Very Cheap | | `#004488` (deep teal) |
| Cheap | | `#6699CC` (steel blue) |
| Normal | | `#BBBBBB` (neutral gray) |
| Expensive | | `#EE7733` (burnt orange) |
| Very Expensive | | `#CC3311` (deep crimson) |

### 2.5 Semantic Colors

| Token | Hex | Usage |
|-------|-----|-------|
| `semantic.positive` | `#3A7D52` | Upward trend arrows, savings, cheap indicators |
| `semantic.negative` | `#D94545` | Downward trend arrows (cost increase), expensive indicators |
| `semantic.warning` | `#E8A640` | Caution states |
| `semantic.info` | `#7B8FCC` | Informational badges |

---

## 3. Typography

### 3.1 Typeface

| Context | Font | Fallback |
|---------|------|----------|
| Price numbers, large data values | **SF Pro Rounded** | System rounded |
| All other text (headings, body, labels, UI) | **SF Pro** | System default |

SF Pro Rounded is used exclusively for numerical data display (prices, kWh values, percentages, chart labels). Its rounded terminals match the soft, friendly aesthetic. Everything else uses standard SF Pro for clarity and legibility.

### 3.2 Type Scale

| Token | Font | Weight | Size | Line Height | Tracking | Usage |
|-------|------|--------|------|-------------|----------|-------|
| `display.hero` | SF Pro Rounded | Bold (700) | 48pt | 52pt | -0.5pt | Hero price on dashboard ("1.87") |
| `display.large` | SF Pro Rounded | Bold (700) | 34pt | 38pt | -0.3pt | Large stat numbers ("380 kWh", "65%") |
| `display.medium` | SF Pro Rounded | Semibold (600) | 28pt | 32pt | -0.2pt | Secondary stat numbers, card values |
| `display.small` | SF Pro Rounded | Semibold (600) | 22pt | 26pt | 0pt | Tertiary numbers, chart tooltip values |
| `heading.large` | SF Pro | Bold (700) | 24pt | 28pt | 0pt | Screen titles ("Power Usages") |
| `heading.medium` | SF Pro | Semibold (600) | 20pt | 24pt | 0pt | Section headers ("Statistics", "Spendings") |
| `heading.small` | SF Pro | Semibold (600) | 17pt | 22pt | 0pt | Card titles ("Total Power Input") |
| `body.large` | SF Pro | Regular (400) | 17pt | 22pt | 0pt | Primary body text |
| `body.medium` | SF Pro | Regular (400) | 15pt | 20pt | 0pt | Card descriptions, secondary body |
| `body.small` | SF Pro | Regular (400) | 13pt | 18pt | 0pt | Captions, timestamps, axis labels |
| `label.large` | SF Pro | Medium (500) | 15pt | 20pt | 0pt | Button text, tab labels, segment titles |
| `label.medium` | SF Pro | Medium (500) | 13pt | 18pt | 0.3pt | Pill text, badges, chip labels |
| `label.small` | SF Pro | Medium (500) | 11pt | 14pt | 0.5pt | Overlines, micro labels |
| `unit` | SF Pro Rounded | Regular (400) | 17pt | 22pt | 0pt | Unit suffixes ("SEK/kWh", "öre") -- slightly smaller than the number they follow |

### 3.3 Number Formatting

- **Prices:** Always use comma as decimal separator for Swedish locale: `1,87 SEK/kWh`
- **Large numbers:** Use space as thousands separator: `1 234 kWh`
- **Percentages:** No space before %: `65%`
- **Trends:** Prefix with arrow: `↑ 6,2%` (positive/green), `↓ 2,3%` (negative/red)
- **Currency:** `SEK` after number with space, or `kr` for informal: `149 SEK/år`, `12 kr/mån`

---

## 4. Spacing & Layout

### 4.1 Spacing Scale

Based on a 4pt grid. All spacing values are multiples of 4.

| Token | Value | Usage |
|-------|-------|-------|
| `space.xxs` | 2pt | Hairline gaps, icon-to-text micro spacing |
| `space.xs` | 4pt | Inner padding of tight elements |
| `space.sm` | 8pt | Gap between related items (icon + label), inner card padding tight |
| `space.md` | 12pt | Standard gap between list items |
| `space.base` | 16pt | Standard content padding (horizontal screen margins) |
| `space.lg` | 20pt | Gap between cards, section spacing |
| `space.xl` | 24pt | Large section separators |
| `space.xxl` | 32pt | Major section breaks, top/bottom safe area padding |
| `space.xxxl` | 48pt | Hero element top padding, onboarding vertical gaps |

### 4.2 Screen Layout

```
┌─────────────────────────────────┐
│         Safe Area Top           │  (dynamic, ~59pt with notch)
│                                 │
│  ├── 16pt horizontal padding    │
│  │                              │
│  │   [Navigation / Header]      │
│  │                              │  20pt gap
│  │   [Hero Card]                │
│  │                              │  20pt gap
│  │   [Chart Section]            │
│  │                              │  24pt gap
│  │   [Section Header]           │
│  │                              │  12pt gap
│  │   [Grid Cards]               │
│  │                              │
│  ├── 16pt horizontal padding    │
│                                 │
│         Tab Bar                 │  (49pt standard + safe area bottom)
└─────────────────────────────────┘
```

- **Horizontal content padding:** 16pt on each side (32pt total margin)
- **Card internal padding:** 16pt on all sides (20pt for hero/large cards)
- **Section gap:** 20-24pt between distinct content sections
- **Card gap:** 12pt between cards in a grid
- **Scroll behavior:** Vertical scrolling only. No horizontal card carousels in v1.0.

### 4.3 Grid System

- **Single column:** Full-width cards (hero price, chart, smart tips)
- **Two-column grid:** Equal-width cards side by side (spending cards, statistics cards). 12pt gap between columns.
- **Three-column grid:** Equal-width stat cells (Solar Resources breakdown: Lights/Water/Energy). 8pt gap between columns.

---

## 5. Corner Radii

| Token | Value | Usage |
|-------|-------|-------|
| `radius.sm` | 8pt | Small tags, inline badges, segmented control background |
| `radius.md` | 12pt | Buttons, input fields, small cards, chart tooltip |
| `radius.lg` | 16pt | Standard cards, stat cards, spending cards |
| `radius.xl` | 20pt | Hero cards, chart container card, onboarding image |
| `radius.xxl` | 24pt | Full-width modals, bottom sheets |
| `radius.pill` | 9999pt (fully rounded) | Pills, summary bars, tab bar items active state, segmented control selected |

---

## 6. Cards & Surfaces

### 6.1 Card Types

**Hero Price Card (Lavender)**
```
Background:     accent.lavender (#EDE5F5)
Corner Radius:  radius.xl (20pt)
Padding:        20pt all sides
Shadow:         none
Border:         none
Content:        Title (heading.small, text.primary)
                Subtitle date (body.small, text.secondary)
                Large value (display.large, text.primary)
                Icon (dark circle with lightning bolt)
                Chart area (within card, see Charts section)
```

**Dark Summary Card**
```
Background:     surface.dark (#1A1A1A)
Corner Radius:  radius.lg (16pt)
Padding:        16pt all sides
Shadow:         none
Border:         none
Text Color:     text.onDark (#FFFFFF) for values
                text.onDarkSecondary (#A1A1A6) for labels
Icon Tint:      accent.green for active icons, text.onDarkSecondary for inactive
```

**Green Accent Card**
```
Background:     accent.green (#8FD5A6)
Corner Radius:  radius.lg (16pt)
Padding:        16pt all sides
Shadow:         none
Border:         none
Text Color:     text.onGreen (#1A1A1A) for all text
Used for:       Positive stat highlights (yearly cost, solar production)
```

**White Bordered Card**
```
Background:     background.primary (#FFFFFF)
Corner Radius:  radius.lg (16pt)
Padding:        16pt all sides
Shadow:         none
Border:         1pt solid background.tertiary (#EEEEEF)
Text Color:     text.primary for values, text.secondary for labels
Used for:       Secondary stats, solar resource breakdown cells
```

**Dark Summary Pill (wide)**
```
Background:     surface.dark (#1A1A1A)
Corner Radius:  radius.pill (fully rounded)
Padding:        12pt vertical, 16pt horizontal
Height:         ~56pt
Layout:         Two sections side by side, divided by a subtle vertical line (surface.darkElevated)
                Left: icon + label + value
                Right: icon + label + value
Icon style:     Small circle with icon (green accent for active)
Used for:       "This Week / This Month" summary bar
```

### 6.2 Card Hierarchy (screen composition)

A typical dashboard screen stacks cards in this order:
1. **Header area** (no card -- just text on background)
2. **Hero card** (lavender or dark, largest visual weight)
3. **Chart card** (white or lavender fill, contains the price chart)
4. **Summary pill** (dark, full-width)
5. **Section header** (text only)
6. **Grid cards** (2-column, mix of green and white-bordered)

---

## 7. Charts & Data Visualization

### 7.1 Price Bar Chart (Primary View)

This is the main chart showing 96 fifteen-minute price intervals.

```
Container:
  Background:       background.primary or accent.lavender (depending on card context)
  Corner Radius:    radius.xl (20pt) if in a card
  Padding:          16pt horizontal, 12pt vertical
  Height:           220pt

Bars:
  Width:            Calculated to fill available width with 1pt gap between bars
  Corner Radius:    radius.sm (top corners only, 4pt)
  Fill:             price.veryCheap through price.veryExpensive based on price level
  Opacity:
    Future hours:   1.0 (full)
    Past hours:     0.4 (dimmed -- the "dimming layer" effect)
    Tomorrow:       0.6 with dashed top border (1pt dashed, text.tertiary)
  Selected bar:     Highlighted with surface.dark stroke (2pt)

Current Time Marker:
  Style:            Vertical dashed line
  Color:            surface.dark (#1A1A1A)
  Dash pattern:     4pt on, 3pt off
  Width:            1pt
  Point marker:     8pt circle, fill surface.dark, 2pt white stroke

X-Axis:
  Font:             body.small (SF Pro, 13pt)
  Color:            text.tertiary (#AEAEB2)
  Labels:           Every 3 hours (00, 03, 06, 09, 12, 15, 18, 21)
  Tick marks:       none
  Grid lines:       none

Y-Axis:
  Font:             body.small (SF Pro, 13pt)
  Color:            text.tertiary (#AEAEB2)
  Labels:           3-4 values (0, 1.00, 2.00, 3.00 SEK/kWh)
  Grid lines:       Horizontal, 0.5pt, background.tertiary (#EEEEEF), dashed
  Position:         Left side

Tooltip (on tap/drag):
  Background:       surface.dark (#1A1A1A)
  Corner radius:    radius.md (12pt)
  Padding:          8pt vertical, 12pt horizontal
  Arrow:            6pt triangle pointing down to the bar
  Content:
    Price:          display.small (SF Pro Rounded, 22pt, semibold, white)
    Time:           label.small (SF Pro, 11pt, text.onDarkSecondary)
    Example:        "1,87 SEK" / "14:15-14:30"
  Connector line:   0.5pt vertical line from tooltip to bar, text.tertiary
```

### 7.2 Line Chart (Secondary View / Trend)

Used as an alternative toggle to the bar chart and for the lavender hero card.

```
Line:
  Color:            surface.dark (#1A1A1A)
  Width:            2.5pt
  Interpolation:    Catmull-Rom (smooth curves, matching the reference)
  End caps:         Round

Fill (area under line):
  Color:            surface.dark (#1A1A1A) at 0.06 opacity (barely visible)
  Or:               accent.lavender gradient from top (0.3 opacity) to bottom (0.0)

Axis styling:       Same as bar chart
Tooltip:            Same as bar chart (dark pill with arrow)
```

### 7.3 Monthly Bar Chart (History View)

Vertical bars grouped by month, as shown in the reference.

```
Bars:
  Width:            32pt fixed
  Gap:              16pt between bars
  Corner radius:    6pt (top corners only)
  Fill colors:
    Below average:  accent.greenLight (#D4EFDD) -- low opacity green
    Average:        accent.green (#8FD5A6) at 0.6 opacity
    Above average:  accent.green (#8FD5A6) at 1.0 opacity -- full green
    Peak month:     accent.green (#8FD5A6) at 1.0 with dark tooltip above

Tooltip (peak value):
  Same dark pill style as 7.1 but positioned above the bar
  Small green downward-pointing triangle as connector

X-Axis labels:      Month abbreviations (Jan, Feb, Mar...)
                     Font: body.small, color: text.secondary
```

### 7.4 Widget Sparkline

Minimal line chart for small widgets. No axes, no labels, no grid.

```
Line:
  Color:            accent.green (#8FD5A6)
  Width:            1.5pt
  Interpolation:    Catmull-Rom

Fill (area under):
  Gradient:         accent.green at 0.2 opacity (top) to 0.0 (bottom)

Size:               Fills available widget space minus padding
Clip:               Clipped to container bounds (no overflow)
```

---

## 8. Icons

### 8.1 Icon Style

- **System:** SF Symbols (Apple's icon library)
- **Weight:** Regular for most icons, Medium for tab bar active state
- **Size:** 20pt for inline icons, 24pt for navigation/tab bar, 28pt for hero card icons
- **Rendering:** Monochrome by default. Hierarchical for multi-layer icons where emphasis is needed.

### 8.2 Icon Set

| Context | SF Symbol Name | Fallback Description |
|---------|---------------|---------------------|
| Lightning bolt (price/energy) | `bolt.fill` | Filled lightning bolt |
| Settings gear | `gearshape` | Outlined gear |
| Trend up | `arrow.up.right` | Diagonal arrow up-right |
| Trend down | `arrow.down.right` | Diagonal arrow down-right |
| Chart/stats | `chart.bar.fill` | Filled bar chart |
| Search | `magnifyingglass` | Magnifying glass |
| Home | `house.fill` | Filled house |
| Profile | `person` | Outlined person |
| Notification bell | `bell` | Outlined bell |
| Download/export | `arrow.down.to.line` | Download arrow |
| Solar/sun | `sun.max.fill` | Filled sun |
| EV/plug | `ev.plug.dc.ccs1` or `powerplug.portrait` | Plug icon |
| Clock/time | `clock` | Outlined clock |
| Location | `location.fill` | Filled location pin |
| Checkmark (cheap) | `checkmark.circle.fill` | Filled checkmark circle |
| Warning (expensive) | `exclamationmark.triangle.fill` | Filled warning triangle |
| Info | `info.circle` | Outlined info circle |
| Close/dismiss | `xmark` | X mark |
| Back arrow | `chevron.left` | Left chevron |

### 8.3 Icon Containers

For icons placed inside dark circles (like the lightning bolt on the hero card):

```
Container:
  Shape:            Circle
  Size:             40pt diameter (hero), 32pt (standard), 24pt (compact)
  Background:       surface.dark (#1A1A1A)
  Icon color:       text.onDark (#FFFFFF)
  Icon size:        60% of container diameter
```

For icons on green accent backgrounds:
```
Container:
  Shape:            Circle
  Size:             32pt diameter
  Background:       accent.greenDark (#3A7D52) at 0.15 opacity
  Icon color:       accent.greenDark (#3A7D52)
```

---

## 9. Buttons & Interactive Elements

### 9.1 Primary Button

```
Background:         surface.dark (#1A1A1A)
Corner Radius:      radius.pill (fully rounded)
Height:             52pt
Horizontal Padding: 24pt
Text:               label.large (SF Pro, 15pt, Medium, #FFFFFF)
Icon (optional):    Leading, 20pt, white, 8pt gap to text

Pressed state:      opacity 0.8
Disabled state:     opacity 0.4
```

### 9.2 Secondary Button

```
Background:         accent.green (#8FD5A6)
Corner Radius:      radius.pill (fully rounded)
Height:             52pt
Horizontal Padding: 24pt
Text:               label.large (SF Pro, 15pt, Medium, #1A1A1A)

Pressed state:      background darkens to accent.greenDark at 0.3 opacity overlay
Disabled state:     opacity 0.4
```

### 9.3 Tertiary / Ghost Button

```
Background:         transparent
Corner Radius:      radius.pill
Height:             44pt
Horizontal Padding: 16pt
Text:               label.large (SF Pro, 15pt, Medium, text.secondary)
Border:             1pt solid background.tertiary (#EEEEEF)

Pressed state:      background fills with background.secondary
```

### 9.4 Segmented Control

Matches the reference "Daily | Weekly | **Monthly** | Yearly" control:

```
Container:
  Background:       background.secondary (#F5F5F7)
  Corner Radius:    radius.sm (8pt)
  Height:           36pt
  Padding:          2pt internal

Segments (unselected):
  Background:       transparent
  Text:             label.medium (SF Pro, 13pt, Medium, text.secondary)

Segment (selected):
  Background:       background.primary (#FFFFFF)
  Corner Radius:    radius.sm (8pt) -- slightly inset from container
  Shadow:           0pt x 1pt blur 3pt, #000000 at 0.08 opacity
  Text:             label.medium (SF Pro, 13pt, Semibold, text.primary)

Animation:          Spring transition (damping 0.8, response 0.3s) for selection change
```

### 9.5 Dropdown / Picker

Matches the reference "Week" dropdown:

```
Background:         background.primary (#FFFFFF)
Border:             1pt solid background.tertiary (#EEEEEF)
Corner Radius:      radius.pill (fully rounded)
Height:             32pt
Padding:            8pt vertical, 12pt horizontal
Text:               label.medium (SF Pro, 13pt, Medium, text.primary)
Chevron:            chevron.down, 10pt, text.secondary, 4pt gap from text
```

---

## 10. Tab Bar

Follows the reference exactly -- 4 tabs with simple icons.

```
Container:
  Background:       background.primary (#FFFFFF)
  Top border:       0.5pt solid background.tertiary (#EEEEEF)
  Height:           49pt (+ safe area bottom inset)
  Padding:          0pt horizontal (icons distribute evenly)

Tab Item (inactive):
  Icon:             24pt, SF Symbol, Regular weight
  Color:            text.tertiary (#AEAEB2)
  Label:            hidden (icon-only tabs, matching the reference)

Tab Item (active):
  Icon:             24pt, SF Symbol, fill variant (e.g., house.fill)
  Color:            text.primary (#000000)
  Label:            hidden

Tabs (left to right):
  1. Home:          house / house.fill
  2. Search:        magnifyingglass / magnifyingglass (same, weight changes)
  3. Statistics:    chart.bar / chart.bar.fill
  4. Profile:       person / person.fill
```

No text labels under icons. The reference uses icon-only tabs for a cleaner look.

---

## 11. Navigation

### 11.1 Header / Top Bar

Not a standard iOS navigation bar. Custom layout matching the reference:

```
Layout:
  Left:             Title text (heading.large or greeting)
  Right:            Icon button(s) (settings gear, download, etc.)
  Vertical position: Below safe area, 16pt top padding
  Bottom:           Subtitle text (body.medium, text.secondary) -- e.g., date

No background blur. No divider line. Just text on the white background.
```

**Dashboard greeting variant:**
```
  Line 1:           "Hej" + user name if available, else "Elpriset" (heading.large, text.primary)
  Line 2:           "Måndag, 26 feb" (body.medium, text.secondary)
  Right:            Settings gear icon (gearshape, 24pt, text.secondary)
```

**Screen title variant:**
```
  Line 1:           Screen name "Prishistorik" (heading.large, text.primary)
  Line 2:           Subtitle "Din elkonsumtionsrapport" (body.medium, text.secondary)
  Right:            Action icon if applicable (download, share, etc.)
```

### 11.2 Back Navigation

```
  Icon:             chevron.left, 20pt, text.primary
  Label:            Previous screen name (body.large, text.primary) -- iOS default behavior
  Position:         Top-left, aligned with horizontal content padding
```

---

## 12. Screen Specifications

### 12.1 Onboarding Screen

Matches the reference left screen's structure: image at top, text in middle, dark section at bottom.

```
┌─────────────────────────────────┐
│                                 │
│  ┌─────────────────────────┐    │  16pt horizontal margin
│  │                         │    │
│  │    [Hero Image]         │    │  Rounded image (radius.xl, 20pt)
│  │    Swedish home /       │    │  Aspect ratio: 4:3
│  │    energy visual        │    │  Height: ~45% of screen
│  │                         │    │
│  └─────────────────────────┘    │
│                                 │  32pt gap
│  "Se vad din el              "  │  heading.large (24pt, bold, text.primary)
│  "verkligen kostar --"       "  │  Multi-line, left-aligned
│  "inte bara spotpriset"      "  │
│                                 │  16pt gap
│  [● ● ○]                       │  Pagination dots (green active, gray inactive)
│                                 │
│  ╭─────────────────────────╮    │  Smooth upward curve transition to dark
│  │                         │    │
│  │  "Svep uppåt för att"   │    │  body.medium, text.onDarkSecondary
│  │  "börja"                │    │  Centered
│  │                         │    │
│  │    [⚡ Icon Circle]      │    │  48pt dark circle with green border (2pt)
│  │                         │    │  Lightning bolt icon, white
│  ╰─────────────────────────╯    │
└─────────────────────────────────┘
```

**Dark bottom section curve:**
The transition from white to dark uses a smooth concave curve (not a straight line). Implement with a custom `Shape` in SwiftUI using a `QuadCurve` -- the curve dips down at the horizontal center and rises at the edges, creating a gentle "valley" effect. Background: `surface.dark`.

**Pagination dots:**
```
Active:     8pt circle, accent.green (#8FD5A6)
Inactive:   8pt circle, background.tertiary (#EEEEEF)
Gap:        8pt between dots
```

### 12.2 Dashboard Screen (Home)

```
┌─────────────────────────────────┐
│  Hej                    ⚙       │  Greeting (heading.large) + settings icon
│  Måndag, 26 feb                 │  Date (body.medium, text.secondary)
│                                 │  20pt gap
│  ┌─────────────────────────┐    │
│  │  accent.lavender bg     │    │  Hero card -- lavender background
│  │                         │    │
│  │  Aktuellt elpris        │    │  heading.small, text.primary
│  │  Uppdaterat 14:15   ⚡  │    │  body.small + icon container
│  │                         │    │
│  │  1,87 SEK/kWh          │    │  display.hero (48pt, bold) -- THE NUMBER
│  │                         │    │
│  │  Spot 42 + Nät 35 +    │    │  body.small, text.secondary
│  │  Skatt 42,8 öre        │    │  Cost breakdown
│  │  ↓ 12% vs igår         │    │  Trend (semantic.positive or .negative)
│  │                         │    │
│  └─────────────────────────┘    │
│                                 │  20pt gap
│  Idag          [Spot│Total]     │  Section header + segmented toggle
│                                 │  8pt gap
│  ┌─────────────────────────┐    │
│  │                         │    │  Chart card (white or light bg)
│  │  ▐▐ ▐▐ ▐▐▐▐▐ ▐▐ ▐▐    │    │  Bar chart -- 96 bars, color-coded
│  │  ▐▐ ▐▐ ▐▐▐▐▐ ▐▐ ▐▐    │    │  Current time marker (dashed vertical)
│  │  ▐▐ ▐▐ ▐▐▐▐▐ ▐▐ ▐▐    │    │  Height: 220pt
│  │                         │    │
│  │  00  03  06  09  12...  │    │  X-axis labels
│  └─────────────────────────┘    │
│                                 │  20pt gap
│  ┌──────────┐ ┌──────────┐      │  Dark summary pill (full width)
│  │ ⚡ Billig │ │ 🔴 Dyr   │      │  Cheapest remaining + most expensive
│  │ 14:15    │ │ 18:00    │      │  Two sections in one dark pill
│  │ 0,89 SEK │ │ 3,42 SEK │      │
│  └──────────┘ └──────────┘      │
│                                 │  24pt gap
│  Smarta tips                    │  Section header (heading.medium)
│                                 │  12pt gap
│  ┌─────────────────────────┐    │  Green accent card
│  │ 🫧 Bästa tid för disk:  │    │  body.medium, text.onGreen
│  │ 14:00 (spara ~2,50 SEK) │    │
│  └─────────────────────────┘    │
│                                 │
│  [🏠] [🔍] [📊] [👤]           │  Tab bar
└─────────────────────────────────┘
```

### 12.3 Statistics / History Screen

```
┌─────────────────────────────────┐
│  Prishistorik              ↓    │  heading.large + download icon
│  Din elkonsumtionsrapport       │  body.medium, text.secondary
│                                 │  16pt gap
│  [Dag│Vecka│ Månad │År]        │  Segmented control ("Månad" selected)
│                                 │  16pt gap
│  ┌─────────────────────────┐    │
│  │        [1,45 SEK]       │    │  Dark tooltip above peak bar
│  │  ▐  ▐▐  ▐  ▐  ▐  ▐  ▐ │    │  Monthly average bars
│  │  ▐  ▐▐  ▐  ▐  ▐  ▐  ▐ │    │  Color: green gradient (light to dark)
│  │  ▐  ▐▐  ▐  ▐  ▐  ▐  ▐ │    │
│  │  Jan Feb Mar Apr May... │    │  Month labels
│  └─────────────────────────┘    │
│                                 │  16pt gap
│  ┌─────────────────────────┐    │  Dark summary pill
│  │ Denna vecka  │ Denna mån│    │
│  │ 93 kWh       │ 793 kWh  │    │
│  └─────────────────────────┘    │
│                                 │  24pt gap
│  Statistik                      │  Section header
│                                 │  12pt gap
│  ┌───────────┐ ┌───────────┐    │  Two-column grid
│  │ Green bg  │ │ White bg  │    │
│  │ Elkostnad │ │ Förbrukn. │    │
│  │ (Årlig)   │ │ (Månad)   │    │
│  │ 4 982 SEK │ │ 250 kWh   │    │  display.medium numbers
│  │ ↑ 6,2%    │ │ ↓ 2,3%    │    │  Trends
│  └───────────┘ └───────────┘    │
│                                 │
│  [🏠] [🔍] [📊] [👤]           │  Tab bar
└─────────────────────────────────┘
```

---

## 13. Motion & Animation

### 13.1 Transitions

| Transition | Duration | Curve | Description |
|-----------|----------|-------|-------------|
| Screen push | 0.35s | `easeInOut` | Standard iOS navigation push |
| Card appear | 0.3s | `spring(damping: 0.85)` | Cards fade in + slight scale (0.97 -> 1.0) |
| Tab switch | 0.25s | `easeInOut` | Cross-fade between tab content |
| Segmented control | 0.3s | `spring(damping: 0.8, response: 0.3)` | Selection indicator slides with spring |

### 13.2 Micro-Interactions

| Element | Animation | Details |
|---------|-----------|---------|
| Hero price update | Counting transition | Number rolls from old value to new (0.6s, easeOut). Color cross-fades if price level changes. |
| Price pulse | Subtle scale pulse | When price changes to a new 15-min interval: scale 1.0 -> 1.03 -> 1.0 over 0.8s with spring. |
| Chart bar selection | Highlight + tooltip | Selected bar brightens to full opacity. Tooltip appears with spring animation (0.2s). Other bars dim to 0.6 opacity. |
| Chart scrub | Real-time tracking | Tooltip follows finger position. Haptic feedback (`selectionChanged`) when crossing bar boundaries. |
| Trend arrow | Entrance | Slides in from left + fades (0.3s delay after price appears). |
| Paywall reveal | Bottom sheet | Slides up from bottom with spring (damping: 0.85). Background dims to 0.4 opacity black overlay. |

### 13.3 Haptics

| Event | Haptic Type |
|-------|-------------|
| Chart bar boundary crossing (scrub) | `.selectionChanged` (light tick) |
| Price level change (15-min update) | `.notification(.warning)` if expensive, `.notification(.success)` if cheap |
| Button tap | `.impact(.light)` |
| Toggle / segmented control change | `.impact(.medium)` |
| Paywall dismiss | `.impact(.light)` |

---

## 14. Dark Mode

While the reference shows a light-mode app, the PRD specifies dark mode as primary. The design system supports both. The tokens above describe light mode. Dark mode inverts as follows:

| Light Mode Token | Dark Mode Value |
|-----------------|-----------------|
| `background.primary` #FFFFFF | `#000000` |
| `background.secondary` #F5F5F7 | `#1C1C1E` |
| `background.tertiary` #EEEEEF | `#2C2C2E` |
| `surface.dark` #1A1A1A | `#2C2C2E` (slightly lighter than bg) |
| `surface.darkElevated` #2C2C2E | `#3A3A3C` |
| `text.primary` #000000 | `#FFFFFF` |
| `text.secondary` #6E6E73 | `#98989D` |
| `text.tertiary` #AEAEB2 | `#636366` |
| `accent.lavender` #EDE5F5 | `#2D2640` (deep muted purple) |
| `accent.green` #8FD5A6 | `#8FD5A6` (unchanged) |
| `accent.greenLight` #D4EFDD | `#1A3D26` (deep muted green) |

**Key rule:** Accent colors (green, lavender) maintain their hue but shift lightness to work on dark backgrounds. The green stays vibrant. The lavender deepens.

---

## 15. Paywall Screen

```
┌─────────────────────────────────┐
│                          [✕]    │  Close button (xmark, top right)
│                                 │
│         ⚡                       │  Large icon (48pt, accent.green)
│                                 │
│  Elpriset Pro                   │  heading.large, text.primary, centered
│                                 │  8pt gap
│  Se din totalkostnad            │  body.large, text.secondary, centered
│  varje dag                      │
│                                 │  32pt gap
│  ┌─────────────────────────┐    │
│  │ ✓ Totalkostnad per kWh  │    │  Feature list -- checkmarks in green
│  │ ✓ Alla widgets          │    │  body.medium, left-aligned
│  │ ✓ Apple Watch            │    │  Checkmark: accent.green
│  │ ✓ Imorgons priser       │    │  Text: text.primary
│  │ ✓ Smarta tips            │    │  12pt vertical gap between items
│  │ ✓ Prishistorik          │    │
│  └─────────────────────────┘    │
│                                 │  32pt gap
│  ┌─────────────────────────┐    │  Price option cards (radio select)
│  │  ○  Vecka    19 kr/v    │    │  White bordered card, unselected
│  └─────────────────────────┘    │  4pt gap
│  ┌─────────────────────────┐    │
│  │  ○  Månad    29 kr/mån  │    │  White bordered card, unselected
│  └─────────────────────────┘    │  4pt gap
│  ┌═════════════════════════┐    │
│  │  ●  År  149 kr/år       │    │  Green accent border (2pt), selected
│  │       "Bara 12 kr/mån"  │    │  label.small, accent.greenDark
│  │              BÄST VÄRDE  │    │  Badge: green pill, label.small
│  └═════════════════════════┘    │  4pt gap
│  ┌─────────────────────────┐    │
│  │  ○  Livstid  349 kr     │    │  White bordered card, unselected
│  └─────────────────────────┘    │
│                                 │  24pt gap
│  ┌═════════════════════════┐    │
│  │   Prova gratis i 3 dagar│    │  Primary button (dark), full width
│  └═════════════════════════┘    │
│                                 │  12pt gap
│  Återställ köp                  │  Tertiary text link, centered
│                                 │  body.small, text.secondary
│  Villkor  •  Integritet         │  Links, body.small, text.tertiary
│                                 │
└─────────────────────────────────┘
```

**Selected pricing card:**
```
Border:         2pt solid accent.green (#8FD5A6)
Background:     accent.greenLight (#D4EFDD) at 0.3 opacity
Radio dot:      Filled circle in accent.green
```

**Unselected pricing card:**
```
Border:         1pt solid background.tertiary (#EEEEEF)
Background:     background.primary (#FFFFFF)
Radio dot:      Empty circle, 1pt border, text.tertiary
```

---

## 16. Widget Design

### 16.1 Lock Screen (Circular)

```
Size:           Circular widget slot
Background:     System widget material (translucent)
Content:
  Center:       Price number (SF Pro Rounded, 16pt, Bold)
                "1,87" (no unit -- space constrained)
  Ring:         Circular progress ring showing where current price falls
                in today's range (min to max). Color: price level color.
```

### 16.2 Home Screen Small

```
Size:           ~170 x 170pt (system small widget)
Background:     White (light mode) or #1C1C1E (dark mode)
Corner radius:  System widget radius (~22pt)
Padding:        12pt all sides

Layout:
  Top-left:     "Elpriset" label (label.small, text.secondary)
  Top-right:    Color dot (8pt circle, price level color)
  Center:       "1,87" (SF Pro Rounded, 34pt, Bold, text.primary)
  Below number: "SEK/kWh" (label.small, text.tertiary)
  Bottom:       Sparkline of remaining today's prices
                (accent.green line, 1.5pt, no axes, ~40pt tall)
```

### 16.3 Home Screen Medium

```
Size:           ~364 x 170pt (system medium widget)
Background:     White / dark
Corner radius:  System widget radius
Padding:        16pt all sides

Layout (two-column):
  Left column (40% width):
    "Just nu" label (label.small, text.secondary)
    "1,87" (SF Pro Rounded, 34pt, Bold)
    "SEK/kWh" (label.small, text.tertiary)
    Trend: "↓12%" (label.medium, semantic.positive)

  Right column (60% width):
    Mini bar chart (remaining today's hours)
    Color-coded bars, no axes labels
    Below chart: "Billigast: 14:15 (0,89)" (label.small, text.secondary)
```

### 16.4 Home Screen Large

```
Size:           ~364 x 382pt (system large widget)
Background:     White / dark
Corner radius:  System widget radius
Padding:        16pt all sides

Layout:
  Top:          "Elpriset" (label.medium) + price zone badge "SE3" (pill, dark bg)
  Hero:         "1,87 SEK/kWh" (SF Pro Rounded, 28pt, Bold)
                Price breakdown: "Spot 42 + Nät 35 + Skatt 43 öre" (label.small, secondary)

  Chart:        Full 24-hour bar chart (today)
                Color-coded, current time marker
                ~160pt tall
                X-axis: 00, 06, 12, 18 (only 4 labels)

  Tomorrow:     If available: "Imorgon" label + mini sparkline of tomorrow
                If not: "Imorgons priser kl 13:00" (label.small, text.tertiary)

  Bottom:       "Billigast kvar: 14:15 -- 0,89 SEK" in a dark pill
```

---

## 17. Accessibility

### 17.1 Dynamic Type

All text must scale with the user's Dynamic Type setting. Use SwiftUI's `.font()` modifiers with the text styles mapped to:

| Design Token | iOS Text Style |
|-------------|---------------|
| display.hero | `.largeTitle` (custom scaled) |
| display.large | `.title` |
| display.medium | `.title2` |
| heading.large | `.title3` |
| heading.medium | `.headline` |
| body.large | `.body` |
| body.medium | `.callout` |
| body.small | `.footnote` |
| label.medium | `.subheadline` |
| label.small | `.caption` |

### 17.2 VoiceOver

- Every price display must read as: "Aktuellt elpris: en krona och åttiosju öre per kilowattimme. Prisnivå: normalt."
- Chart bars must be navigable with VoiceOver. Each bar announces: "Klockan fjorton femton till fjorton trettio: nittioåtta öre per kilowattimme. Billigt."
- Color-coded indicators must have a text equivalent always present (not hidden from sighted users -- visible labels alongside colors, as specified in Section 5).

### 17.3 Minimum Tap Targets

All interactive elements: minimum 44 x 44pt hit area, per Apple HIG.

### 17.4 Reduce Motion

When `UIAccessibility.isReduceMotionEnabled`:
- Replace spring animations with simple opacity fades (0.2s)
- Disable the price pulse animation
- Disable chart scrub haptics
- Replace slide transitions with cross-fades

---

## 18. Implementation Notes for SwiftUI

### 18.1 Color Definitions

```swift
extension Color {
    // Foundation
    static let elBackground = Color(hex: "#FFFFFF")
    static let elBackgroundSecondary = Color(hex: "#F5F5F7")
    static let elBackgroundTertiary = Color(hex: "#EEEEEF")
    static let elSurfaceDark = Color(hex: "#1A1A1A")
    static let elSurfaceDarkElevated = Color(hex: "#2C2C2E")

    // Accents
    static let elGreen = Color(hex: "#8FD5A6")
    static let elGreenLight = Color(hex: "#D4EFDD")
    static let elGreenDark = Color(hex: "#3A7D52")
    static let elLavender = Color(hex: "#EDE5F5")
    static let elLavenderMid = Color(hex: "#D8CCE8")

    // Price levels
    static let priceVeryCheap = Color(hex: "#8FD5A6")
    static let priceCheap = Color(hex: "#B8E6C8")
    static let priceNormal = Color(hex: "#D4EFDD")
    static let priceExpensive = Color(hex: "#F5C882")
    static let priceVeryExpensive = Color(hex: "#E88F8F")

    // Semantic
    static let elPositive = Color(hex: "#3A7D52")
    static let elNegative = Color(hex: "#D94545")
}
```

### 18.2 Font Definitions

```swift
extension Font {
    static let elDisplayHero = Font.system(.largeTitle, design: .rounded).weight(.bold)
    static let elDisplayLarge = Font.system(size: 34, weight: .bold, design: .rounded)
    static let elDisplayMedium = Font.system(size: 28, weight: .semibold, design: .rounded)
    static let elDisplaySmall = Font.system(size: 22, weight: .semibold, design: .rounded)
    static let elHeadingLarge = Font.system(size: 24, weight: .bold)
    static let elHeadingMedium = Font.system(size: 20, weight: .semibold)
    static let elHeadingSmall = Font.system(size: 17, weight: .semibold)
    static let elBodyLarge = Font.system(size: 17, weight: .regular)
    static let elBodyMedium = Font.system(size: 15, weight: .regular)
    static let elBodySmall = Font.system(size: 13, weight: .regular)
    static let elLabelLarge = Font.system(size: 15, weight: .medium)
    static let elLabelMedium = Font.system(size: 13, weight: .medium)
    static let elLabelSmall = Font.system(size: 11, weight: .medium)
    static let elUnit = Font.system(size: 17, weight: .regular, design: .rounded)
}
```

### 18.3 Spacing Constants

```swift
enum ElSpacing {
    static let xxs: CGFloat = 2
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let base: CGFloat = 16
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 32
    static let xxxl: CGFloat = 48
}
```

### 18.4 Corner Radius Constants

```swift
enum ElRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let pill: CGFloat = 9999
}
```
