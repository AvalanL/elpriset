# Elpriset Mascot Specification

> Complete specification for the Elpriset app mascot: concept, personality, touchpoints,
> animation states, notification strategy, and production pipeline.

---

## 1. The Mascot: Gnistan

**Name:** Gnistan (Swedish for "The Spark")
**Species:** An energy spark -- a small, round, glowing orb-creature
**Gender:** None (referred to as "den" in Swedish, "it" in English -- a genderless spark)
**Personality in one line:** A calm, helpful little spark that quietly glows beside you, lighting up when electricity is cheap and dimming nervously when it's expensive.

### 1.1 Why "Gnistan"

| Criteria | Assessment |
|----------|-----------|
| **Semantic fit** | "Gnista" = spark. Electricity, energy, light -- directly on-brand. |
| **Swedish identity** | Swedish word, feels local and charming, not corporate-international. |
| **Design fit** | Round, soft, glowing -- matches the design system's "rounded everything" principle and muted color palette. |
| **Simplicity** | A glowing orb with a face is one of the simplest shapes to illustrate, vectorize, and animate. No limbs, no complex anatomy. |
| **Emotional range** | The glow can shift color (green to red), the face can express 10+ emotions, the body can pulse/bounce/shrink -- all with minimal geometry changes. |
| **Memorability** | A glowing spark character for an electricity app is intuitive but nobody else has it. Ownable. |
| **Wordplay** | "Gnistan hittade billig el!" (The Spark found cheap electricity!) works naturally in Swedish notification copy. |

### 1.2 Visual Description

```
Shape:      Soft, rounded teardrop/flame silhouette. NOT a circle -- slightly
            taller than wide, with a gentle upward taper at the top, like a
            candle flame or water droplet (inverted). The bottom is fully
            rounded, the top narrows to a soft point (never sharp).

Size:       About 1.3:1 height-to-width ratio.
            Standard display: 48pt tall in-app.
            Notification icon: 24pt.
            Widget: 20pt (small), 32pt (large).

Body fill:  Gradient from accent.green (#8FD5A6) at bottom to a lighter
            tint (#D4EFDD) at the top. The gradient direction creates a
            "lit from below" glow effect. Color shifts with price level
            (see Section 3).

Glow:       Subtle outer glow (CSS: box-shadow / SwiftUI: .shadow).
            Color matches body fill but at 30% opacity, 8pt radius.
            The glow pulses gently in idle state (0.95 -> 1.05 opacity,
            2-second cycle, easeInOut).

Face:       Positioned in the lower 60% of the body (the wider part).

  Eyes:     Two small, slightly oval dots. Close together horizontally
            (~30% of body width apart). Placed ~40% from top of body.
            Fill: #1A1A1A (surface.dark).
            Size: ~6pt wide, ~7pt tall each (slightly taller than wide).

  Mouth:    Simple arc below the eyes. Default: gentle upward curve (smile).
            Line weight: 2pt.
            Color: #1A1A1A (surface.dark).
            Width: ~40% of body width.

  No nose, no ears, no eyebrows in default state. Eyebrows appear only
  in specific expressions (worried, surprised) as simple arcs above the eyes.

No limbs:   Gnistan has no arms or legs. It floats. Movement is achieved
            through body position changes (bouncing, tilting, rising/falling).
            This keeps the design dead simple and distinctly "energy orb,"
            not "cartoon character."

Sparkles:   In excited/celebrating states, 2-4 tiny diamond-shaped sparkle
            particles (4pt) appear around the body, fading in and out
            with staggered timing. Color: white (#FFFFFF) at 60% opacity.
```

### 1.3 Visual Reference (ASCII Approximation)

```
        Default (happy)         Alarmed            Sleeping
        ╱  ╲                   ╱  ╲               ╱  ╲
       ╱    ╲                 ╱    ╲             ╱    ╲
      │  ● ●  │             │  ◉ ◉  │          │  ━ ━  │
      │   ◡   │             │  ╱╲   │          │       │
       ╲    ╱               │  ~~   │           ╲    ╱
        ╲╱                   ╲    ╱              ╲╱
                              ╲╱                z z z

      Celebrating            Surprised
    ✦   ╱  ╲   ✦            ╱  ╲
       ╱    ╲              ╱    ╲
  ✦  │  ● ●  │  ✦        │  ● ●  │
      │  ◠◠  │           │   ○   │
       ╲    ╱              ╲    ╱
        ╲╱                  ╲╱
```

---

## 2. Personality & Voice

### 2.1 Character Traits

| Trait | Description | How It Manifests |
|-------|-------------|-----------------|
| **Calm** | Gnistan is never manic or overwhelming. It matches the Scandinavian minimalist vibe. | Movements are smooth, never jerky. Idle state is a gentle breathing glow. |
| **Helpful** | Its primary role is to surface useful information, not to entertain. | Points toward cheap windows, warns about expensive spikes. Information first, personality second. |
| **Warm** | Literally glows. Figuratively reassuring. | Green glow when prices are good. Encouraging expressions when users save money. |
| **Quietly proud** | Takes subtle pride in finding good prices, like a friend who found a great deal. | Small bounce + sparkles when it discovers the cheapest window of the day. |
| **Empathetic** | Understands expensive electricity is stressful. Never guilt-trips. | When prices are high, Gnistan looks concerned too -- shared frustration, not judgment. |
| **Low-key** | Never demands attention. Never interrupts the data. Appears in margins and transitions. | Small size, peripheral placement, fades in rather than popping up. |

### 2.2 What Gnistan Is NOT

- **NOT Duolingo's owl.** Gnistan never guilt-trips users for not opening the app. Checking electricity prices is not a daily habit to be enforced -- it's a utility used when needed.
- **NOT a narrator or teacher.** It doesn't explain things in speech bubbles. It reacts with expressions.
- **NOT hyperactive.** No dancing, no flipping, no extreme animations. This is a calm utility app, not a game.
- **NOT ever blocking content.** Gnistan never overlaps the price number, chart, or any data element. It lives in the margins.

### 2.3 Voice (for notifications and copy)

When Gnistan "speaks" in notifications, the tone is:

- **First person but brief:** "Hittade billig el!" (Found cheap electricity!) not "Jag har hittat billig el till dig!" (I have found cheap electricity for you!)
- **Swedish, casual but not slang:** "lagom" informal
- **Helpful, not pushy:** "Imorgons priser är här" not "Kolla imorgons priser NU!"
- **Warm, not corporate:** "Bra jobbat, du sparade 47 kr!" not "Din veckorapport visar besparingar på 47 SEK"

---

## 3. Price-Level States

Gnistan's appearance changes based on the current electricity price level. The body color shifts, the expression changes, and the glow adapts. This is the core mechanic -- the mascot IS a price indicator.

| Price Level | Body Color | Glow Color | Expression | Behavior |
|-------------|-----------|------------|------------|----------|
| **Very Cheap** | `#8FD5A6` (bright sage green) | Green glow, strong (40% opacity) | Big smile, eyes slightly closed (content) | Gentle upward float, sparkles appear occasionally |
| **Cheap** | `#B8E6C8` (soft green) | Green glow, medium (30% opacity) | Smile, normal eyes | Normal idle, gentle pulse |
| **Normal** | `#D4EFDD` (very light green) | Neutral glow, subtle (20% opacity) | Neutral mouth (straight line), normal eyes | Standard idle breathing |
| **Expensive** | `#F5C882` (warm amber) | Amber glow (25% opacity) | Slight frown, eyebrows angled inward slightly | Subtle shrink (body contracts 5%), glow dims |
| **Very Expensive** | `#E88F8F` (soft red) | Red glow (30% opacity) | Worried mouth (wavy line), eyes wider | Body contracts 10%, glow pulses faster (warning rhythm) |

**Color transitions:** When price level changes, body color cross-fades over 0.6 seconds (`easeInOut`). Expression changes simultaneously. This should feel like a mood lamp slowly shifting, not a sudden state switch.

---

## 4. Expression Sheet (Full Set)

### 4.1 MVP Expressions (5 states -- ship in v1.0)

| Expression | Eyes | Mouth | Eyebrows | Used When |
|------------|------|-------|----------|-----------|
| **Neutral** | Two dots, standard size | Gentle upward curve (subtle smile) | None | Default idle state, normal prices |
| **Happy** | Two dots, slightly squinted (content) | Wider upward curve | None | Cheap prices, savings found |
| **Worried** | Dots slightly larger (wider) | Wavy/wobbly line | Two small angled arcs (concern) | Expensive prices, price spike |
| **Sleeping** | Two horizontal dashes (closed eyes) | None (mouth disappears) | None | Nighttime (22:00-06:00), no data state, loading |
| **Celebrating** | Two dots, squinted (joy) | Wide smile (arc opening upward) | None | Milestone, weekly summary, first use |

### 4.2 Extended Expressions (add in v1.1)

| Expression | Eyes | Mouth | Used When |
|------------|------|-------|-----------|
| **Surprised** | Two larger circles (wide open) | Small open circle (O shape) | Sudden price drop, negative prices, tomorrow's prices just arrived |
| **Encouraging** | Normal dots with a subtle "wink" (one eye slightly closed) | Upward curve | Cheapest window approaching, "now is a good time" |
| **Thinking** | Dots shifted slightly to the upper-right (looking up) | Flat line, slightly off-center | Calculating total cost, loading prices |
| **Proud** | Squinted (content), slightly upward | Confident closed smile | Weekly savings displayed, user saved money |
| **Shivering** | Dots wobbling slightly | Teeth chattering (zigzag line) | Winter cold + expensive prices (seasonal) |

### 4.3 Expression Construction Method

All expressions share the same body shape. Only the face changes. This means:

```
Base body SVG:          1 file (the teardrop shape with gradient)
Eye variants:           5 files (dots, squinted, wide, closed, winking)
Mouth variants:         6 files (smile, wide smile, flat, wavy, O, none)
Eyebrow variants:       2 files (none / worried arcs)
Sparkle overlay:        1 file (toggle on/off)

Total SVG components:   15 files
Composite expressions:  Mix and match = 60+ possible combinations
Actually needed for MVP: 5 composites
```

---

## 5. Where Gnistan Appears (Touchpoint Map)

### 5.1 High-Priority Touchpoints (MVP)

**Onboarding -- Welcome**
```
Placement:    Centered, above the "Se vad din el verkligen kostar" text
Size:         64pt (larger than normal -- this is the introduction)
Expression:   Neutral -> Happy (transitions as screen loads)
Animation:    Gentle float up from below + fade in (0.5s spring)
Purpose:      First impression. "Hi, I'm your electricity companion."
```

**Onboarding -- Live Price Reveal**
```
Placement:    Next to the live price number on Screen 2
Size:         40pt
Expression:   Matches current price level (green/happy if cheap, etc.)
Animation:    Appears alongside the price with a small bounce
Purpose:      Immediately demonstrates that Gnistan reacts to prices.
              This is the "aha" -- the mascot IS a price indicator.
```

**Empty State -- Prices Loading**
```
Placement:    Centered in the chart area while data loads
Size:         48pt
Expression:   Sleeping (eyes closed, gentle breathing glow)
Animation:    Slow pulse (glow 0.7 -> 1.0 opacity, 1.5s cycle)
Text below:   "Gnistan hämtar priserna..." (Gnistan is fetching prices...)
Purpose:      Turns a loading spinner into a branded moment.
```

**Empty State -- API Error / No Data**
```
Placement:    Centered in the chart area
Size:         48pt
Expression:   Sleeping or Worried (depending on error type)
Animation:    Subtle wobble (±2 degrees rotation, 0.8s)
Text below:   "Gnistan hittar inga priser just nu. Försök igen snart."
Purpose:      Softens error states. A worried spark is friendlier than "Error 500."
```

**Notification Icon**
```
Placement:    App icon in notification center (iOS notification payload: image attachment)
Size:         Notification icon size (varies by iOS version)
Expression:   Matches notification content (happy for cheap, worried for spike)
Purpose:      Instant brand recognition in notification center. Users see the
              spark face and know it's Elpriset without reading the app name.
```

**Tomorrow's Prices Available (in-app banner)**
```
Placement:    Top of chart area, inline banner
Size:         32pt, left-aligned beside text
Expression:   Surprised -> Excited (two-state transition)
Text:         "Imorgons priser är här!"
Animation:    Slides in from right, small bounce
Purpose:      Draws attention to new data without being a modal/popup.
```

### 5.2 Medium-Priority Touchpoints (v1.0 if time allows, else v1.1)

**Dashboard -- Ambient Presence**
```
Placement:    Small, in the corner of the hero price card (bottom-right)
Size:         24pt (tiny -- intentionally subtle)
Expression:   Matches current price level
Animation:    Idle only (breathing glow). No movement that draws eye from the price.
Purpose:      Persistent brand presence without competing with data. Users who
              notice it get a "price at a glance" from the color. Those who
              don't notice it aren't distracted.
```

**Smart Tips Section**
```
Placement:    Left of each smart tip text
Size:         20pt
Expression:   Encouraging (for cheap window), Worried (for expensive warning)
Animation:    None (static for tips to keep the section clean)
Purpose:      Adds warmth to what is otherwise a plain text list.
```

**Weekly Savings Summary**
```
Placement:    Centered above the savings number
Size:         56pt (this is a celebration moment)
Expression:   Celebrating (sparkles active)
Animation:    Bounces up, sparkles burst outward, then settles
Text:         "Du sparade 47 kr denna vecka!"
Purpose:      The payoff. Users see their savings AND a happy spark celebrating
              with them. This is the Duolingo "lesson complete" equivalent.
```

**Price Alert Notification (push)**
```
Placement:    Notification with rich content (image attachment)
Size:         64pt in expanded notification view
Expression:   Happy (price drop below threshold) or Worried (spike above threshold)
Purpose:      Makes price alerts feel personal, not robotic.
```

### 5.3 Low-Priority Touchpoints (v1.1+)

| Context | Size | Expression | Notes |
|---------|------|------------|-------|
| Large widget (corner) | 16pt | Static, matches price level | Tiny brand mark, adds life to the widget |
| Settings screen header | 32pt | Neutral with subtle wink on scroll | Easter egg: pull-to-refresh triggers a wink |
| About screen | 48pt | Celebrating | "Gnistan v1.0 -- Made in Sweden" |
| App Store screenshots | 64pt | Various | Key differentiator in ASO visuals |
| Social share cards | 48pt | Matches price | "Elen kostar bara 0.12 SEK just nu!" + happy Gnistan |
| Paywall screen | 40pt | Happy, wearing tiny crown | "Gnistan Pro" -- subtle upgrade indicator |
| Widget loading | 16pt | Sleeping | While widget data refreshes |

### 5.4 Where Gnistan NEVER Appears

| Zone | Reason |
|------|--------|
| **Over the hero price number** | The price is sacred. Nothing obscures it. |
| **On top of the chart** | Data visualization must be clean. |
| **During chart interaction (scrub/tap)** | User is focused on data, mascot would distract. |
| **As a blocking modal** | Gnistan never interrupts. No "Gnistan says..." popups. |
| **In every notification** | Some notifications are purely informational. Overuse dilutes the mascot. |

---

## 6. Notification Strategy

### 6.1 Core Principle: Value First, Personality Second

Unlike Duolingo (where the mascot IS the message), Elpriset notifications lead with actionable price information and wrap it in Gnistan's personality. The spark is the messenger, not the message.

### 6.2 Notification Types with Mascot Integration

**Tomorrow's Prices Available (daily, ~13:00)**
```
Icon:       Gnistan (surprised/excited expression)
Title:      Gnistan hittade imorgons priser!
Body:       Billigaste kvarten: 03:15 (0,12 SEK/kWh). Dyrast: 18:00 (3,42 SEK)
Category:   .tomorrowPrices
Frequency:  1x per day, only when prices publish
```

**Price Drop Alert (event-triggered)**
```
Icon:       Gnistan (happy expression)
Title:      Billig el just nu!
Body:       Bara 0,45 SEK/kWh -- nu är det smart att köra tvättmaskinen.
Category:   .priceAlert
Frequency:  Max 2x per day
```

**Price Spike Warning (event-triggered)**
```
Icon:       Gnistan (worried expression)
Title:      Elpriset stiger snart
Body:       Kl 18:00-19:00 kostar elen 4,20 SEK/kWh. Undvik tunga förbrukare.
Category:   .priceAlert
Frequency:  Max 1x per day
```

**Weekly Savings Summary (weekly, Sunday evening)**
```
Icon:       Gnistan (celebrating expression)
Title:      Din vecka med Gnistan
Body:       Du sparade 47 kr genom att använda el vid rätt tid! Se hela rapporten.
Category:   .weeklySummary
Frequency:  1x per week
```

**Cheapest Window Approaching (event-triggered, opt-in)**
```
Icon:       Gnistan (encouraging expression)
Title:      Om 30 min: billigaste elen idag
Body:       Kl 14:15 kostar elen 0,89 SEK/kWh. Perfekt tid för disk och tvätt.
Category:   .cheapWindow
Frequency:  Max 1x per day
```

### 6.3 What Gnistan NEVER Does in Notifications

| Anti-pattern | Why |
|-------------|-----|
| "Du har inte öppnat appen på 3 dagar!" | This is not a habit app. No guilt-tripping for not checking prices. |
| "Gnistan saknar dig!" | Manipulative for a utility. Users check prices when they need to. |
| More than 3 notifications per day | Utility app users have low tolerance. Price alerts + tomorrow's prices = max 2-3. |
| Generic "Open the app!" CTAs | Every notification must contain actionable price information. |

### 6.4 Notification Mascot Image Implementation

```swift
// Attach Gnistan expression as notification image
let content = UNMutableNotificationContent()
content.title = "Gnistan hittade imorgons priser!"
content.body = "Billigaste kvarten: 03:15 (0,12 SEK/kWh)"

// Attach mascot expression image
if let imageURL = Bundle.main.url(forResource: "gnistan-excited", withExtension: "png") {
    let attachment = try UNNotificationAttachment(identifier: "mascot", url: imageURL)
    content.attachments = [attachment]
}
```

---

## 7. Driving Engagement (Without Being Annoying)

### 7.1 The Rules

Research shows character-based notifications increase 30-day retention by 22%, but ONLY when frequency stays below 1-2 per day. Beyond that, retention gains diminish and uninstalls increase.

**Elpriset's rules:**

1. **Maximum 2 mascot-accompanied notifications per day.** Tomorrow's prices (1x) + one price alert (1x). That's it.
2. **Gnistan earns the right to warn by celebrating first.** The first 10 Gnistan appearances should all be positive (welcome, cheap price found, celebrating savings). Only after positive rapport is established does Gnistan deliver warnings.
3. **Users can disable Gnistan in notifications** without disabling notifications themselves. Settings: "Visa Gnistan i notiser" toggle.
4. **Users can disable Gnistan entirely.** Settings: "Visa Gnistan i appen" toggle. When off, empty states use standard loading indicators and all mascot placements are hidden. The app works perfectly without the mascot.
5. **The weekly summary is the retention anchor.** This is the one notification users actively look forward to. "Du sparade X kr" is the Elpriset equivalent of Duolingo's streak celebration. Make it delightful.

### 7.2 Engagement Mechanics

**Passive price indicator (daily use)**
- Gnistan's color on the dashboard card is a glanceable price level indicator
- Users develop a reflex: green spark = good time to use electricity, amber spark = wait
- This is subconscious engagement -- users don't "interact" with Gnistan, they read it

**Savings celebration (weekly)**
- Sunday evening notification with animated Gnistan celebrating
- In-app: savings summary card with Gnistan + sparkles
- This creates a positive association with the app every week
- Over time, "I wonder how much I saved" becomes a Sunday habit

**Tomorrow's prices ritual (daily)**
- The ~13:00 "imorgons priser" notification becomes a daily touchpoint
- Gnistan as the messenger makes it feel like a friend sharing news, not a system alert
- Users plan their evening/next-day electricity use around this

**Social sharing (v1.1)**
- "Share this price" cards include Gnistan at the appropriate expression
- Happy Gnistan on a share card saying "Elen kostar 0,03 SEK just nu!" is inherently more shareable than a plain text card
- Gnistan becomes the face of price-sharing on Swedish social media

### 7.3 What NOT to Gamify

- **No streaks.** Checking electricity prices is not a habit to enforce. Streaks would feel absurd.
- **No XP or points.** This is not a game.
- **No leaderboards.** Comparing savings between users creates perverse incentives.
- **No "feed Gnistan" mechanics.** The mascot doesn't have needs. It reacts to prices, not user behavior.

---

## 8. Production Pipeline

### 8.1 Phase 1: Concept Generation (Day 1, 2-3 hours)

**Tool:** Midjourney v6 (or DALL-E 3 / Ideogram for alternatives)

**Prompt strategy:**

Round 1 -- Explore shapes:
```
cute energy spark mascot, simple round teardrop shape, soft mint green color,
two small dot eyes, gentle smile, glowing aura, minimal design, flat vector
illustration, white background, no limbs, kawaii style --ar 1:1 --style raw
```

Round 2 -- Expression sheet:
```
character expression sheet of a cute green spark mascot, 6 expressions in a
row: happy, worried, sleeping, surprised, celebrating, neutral, same character,
consistent style, simple round teardrop shape, dot eyes, flat vector,
white background --ar 3:1 --style raw
```

Round 3 -- In-context mockup:
```
mobile app UI mockup, clean white background, electricity price dashboard,
small cute green glowing spark mascot character in the corner, Scandinavian
minimal design, SF Pro font, muted sage green accent color --ar 9:19
```

**Use Midjourney's `--cref` (character reference)** to maintain consistency across generations once you have a design you like.

**Deliverable:** 3-5 finalist concepts as PNG exports.

### 8.2 Phase 2: Vectorization (Day 1, 2-3 hours)

**Step 1: Auto-vectorize**
- Upload chosen PNG to [vectorizer.ai](https://vectorizer.ai) (free, 15-second conversion)
- Or use Figma plugin "Image Tracer" for more control
- Export as SVG

**Step 2: Clean up in Figma (free)**
- Import SVG into Figma
- Simplify paths (Figma: Edit > Path > Simplify)
- Reduce node count (aim for < 50 nodes for the body shape)
- Ensure colors match design system tokens exactly:
  - Body fill: `#8FD5A6` -> `#D4EFDD` gradient
  - Eyes: `#1A1A1A`
  - Mouth: `#1A1A1A`, 2pt stroke
- **Separate into layers:**
  - `body` (the teardrop shape)
  - `glow` (outer glow ellipse at low opacity)
  - `eye-left`, `eye-right`
  - `mouth`
  - `eyebrow-left`, `eyebrow-right` (hidden by default)
  - `sparkle-1`, `sparkle-2`, `sparkle-3` (hidden by default)

**Step 3: Create expression variants**
- Duplicate the base Figma frame 5 times (one per MVP expression)
- Swap face components for each expression:
  - Neutral: dot eyes + subtle smile
  - Happy: squinted eyes + wide smile
  - Worried: wide eyes + wavy mouth + eyebrow arcs
  - Sleeping: dash eyes + no mouth
  - Celebrating: squinted eyes + wide smile + sparkles visible
- Export each as: `gnistan-neutral.svg`, `gnistan-happy.svg`, etc.

**Deliverable:** 5 SVG files + 1 Figma component with variants.

### 8.3 Phase 3: Asset Export (Day 2, 1-2 hours)

Export from Figma in multiple formats for different contexts:

```
/Assets/Mascot/
├── SVG/                          (for web, scalable, source of truth)
│   ├── gnistan-neutral.svg
│   ├── gnistan-happy.svg
│   ├── gnistan-worried.svg
│   ├── gnistan-sleeping.svg
│   └── gnistan-celebrating.svg
├── PNG/                          (for notifications, share cards)
│   ├── @1x/
│   ├── @2x/
│   └── @3x/
│       ├── gnistan-neutral.png    (144x187 @3x for 48pt display)
│       ├── gnistan-happy.png
│       ├── gnistan-worried.png
│       ├── gnistan-sleeping.png
│       └── gnistan-celebrating.png
└── Xcode.xcassets/               (for Xcode asset catalog)
    ├── gnistan-neutral.imageset/
    ├── gnistan-happy.imageset/
    ├── gnistan-worried.imageset/
    ├── gnistan-sleeping.imageset/
    └── gnistan-celebrating.imageset/
```

### 8.4 Phase 4: SwiftUI Integration (Day 2, 3-4 hours)

**MVP approach: Static SVGs with animated transitions**

```swift
// MascotView.swift

enum GnistanExpression: String {
    case neutral = "gnistan-neutral"
    case happy = "gnistan-happy"
    case worried = "gnistan-worried"
    case sleeping = "gnistan-sleeping"
    case celebrating = "gnistan-celebrating"
}

struct GnistanView: View {
    let expression: GnistanExpression
    let size: CGFloat

    @State private var glowOpacity: Double = 0.3
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Image(expression.rawValue)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: size)
            .shadow(
                color: glowColor.opacity(glowOpacity),
                radius: 8
            )
            .scaleEffect(scale)
            .onAppear {
                // Idle breathing animation
                withAnimation(
                    .easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
                ) {
                    glowOpacity = expression == .sleeping ? 0.15 : 0.45
                    scale = 1.02
                }
            }
            .animation(.easeInOut(duration: 0.6), value: expression)
            // Cross-fade between expressions when state changes
    }

    private var glowColor: Color {
        switch expression {
        case .neutral: return .elGreen
        case .happy: return .elGreen
        case .worried: return Color(hex: "#E88F8F")
        case .sleeping: return .elGreenLight
        case .celebrating: return .elGreen
        }
    }
}

// Usage on dashboard:
GnistanView(
    expression: priceLevel.gnistanExpression,
    size: 24
)
```

**Mapping price levels to expressions:**
```swift
extension PriceLevel {
    var gnistanExpression: GnistanExpression {
        switch self {
        case .veryCheap: return .happy
        case .cheap: return .happy
        case .normal: return .neutral
        case .expensive: return .worried
        case .veryExpensive: return .worried
        }
    }
}
```

### 8.5 Phase 5: Rive Upgrade (Post-launch, 2-3 days)

After validating the mascot concept with static SVGs, upgrade to Rive for smooth animated transitions:

**Rive State Machine:**
```
Inputs:
  - priceLevel: Number (0-4)
  - isNighttime: Boolean
  - isCelebrating: Boolean (trigger)

States:
  - Idle_VeryCheap   (green glow, happy face, gentle float)
  - Idle_Cheap       (green glow, smile)
  - Idle_Normal      (neutral glow, neutral face)
  - Idle_Expensive   (amber glow, slight frown, body contracts)
  - Idle_VeryExpensive (red glow, worried face, faster pulse)
  - Sleeping         (dim glow, closed eyes, slow breathing)
  - Celebrating      (sparkles burst, bounce, wide smile) -> returns to Idle

Transitions:
  - priceLevel changes: 0.6s blend to new state
  - isNighttime true: 1.0s fade to Sleeping
  - isCelebrating trigger: play Celebrating, then auto-return to current Idle
```

**File:** Single `gnistan.riv` (~50-100KB), contains all states and transitions.

**SwiftUI integration with Rive:**
```swift
import RiveRuntime

struct GnistanRiveView: View {
    let priceLevel: Int
    let isNighttime: Bool

    @StateObject private var riveVM = RiveViewModel(fileName: "gnistan")

    var body: some View {
        riveVM.view()
            .frame(height: 48)
            .onChange(of: priceLevel) { _, newValue in
                riveVM.setInput("priceLevel", value: Double(newValue))
            }
            .onChange(of: isNighttime) { _, newValue in
                riveVM.setInput("isNighttime", value: newValue)
            }
    }

    func celebrate() {
        riveVM.triggerInput("isCelebrating")
    }
}
```

---

## 9. Rollout Plan

| Phase | When | What Ships | Gnistan Touchpoints |
|-------|------|-----------|-------------------|
| **MVP** | v1.0 launch | 5 static SVG expressions, SwiftUI cross-fade animations | Onboarding, empty states, notification icons, dashboard corner (24pt) |
| **Polish** | v1.0.1 (2 weeks post-launch) | Idle breathing/glow animation | All MVP touchpoints + subtle dashboard presence |
| **Expand** | v1.1 | 5 additional expressions, Rive upgrade | Smart tips, savings celebration, share cards, large widget |
| **Personality** | v1.2 | Seasonal variants, social sharing face | Holiday Gnistan (jul, midsommar), "share price" cards |
| **Depth** | v2.0 | Full Rive state machine with smooth transitions between all states | Everywhere, fully reactive to all app state changes |

### 9.1 Seasonal Variants (v1.2)

| Season | Variant | Visual Change |
|--------|---------|--------------|
| **Jul (Christmas)** | Tomte-Gnistan | Tiny red Santa hat on top of the spark |
| **Midsommar** | Blomster-Gnistan | Small flower crown wreath |
| **Winter** | Vinter-Gnistan | Tiny scarf, slightly blue-tinted glow |
| **Lucia (Dec 13)** | Lucia-Gnistan | Tiny candle crown (perfect for a spark!) |

These are simple SVG overlays on the base character. One additional asset per season.

---

## 10. Measuring Mascot Impact

### 10.1 A/B Test Plan

Before investing in Rive animations, validate the mascot concept:

**Test:** 50% of users see Gnistan, 50% see standard UI (loading spinners, plain empty states, text-only notifications)

**Metrics to compare:**

| Metric | Hypothesis |
|--------|-----------|
| Notification open rate | Gnistan notifications open 15-25% more than plain notifications |
| Day-7 retention | Gnistan users retain 5-10% better (empty states feel friendlier, less frustration on errors) |
| Trial-to-paid conversion | Gnistan on the paywall screen increases conversion 3-5% (emotional connection) |
| NPS / App Store rating | Higher for Gnistan group (app feels more "alive" and polished) |
| Time in app | Slightly higher for Gnistan group (celebrations on savings are engaging) |

### 10.2 Settings Toggle

```
Settings > Utseende > Visa Gnistan
  [Toggle: On by default]
  "Gnistan är din lilla elsparkskompis som reagerar på elpriset."
```

Users who disable Gnistan get tracked as a segment. If > 15% disable it, the mascot is too intrusive and needs to be dialed back.

---

## 11. Summary: The One-Page Gnistan Brief

**What:** A small, round, glowing spark character named Gnistan (Swedish for "The Spark").

**Look:** Soft teardrop/flame shape in sage green (#8FD5A6), two dot eyes, simple mouth. No limbs. Floats and glows.

**Core mechanic:** Gnistan's color and expression change with the electricity price level. It IS a price indicator that happens to have a face.

**Where:** Empty states, onboarding, notifications, dashboard corner (small), savings celebrations (large). Never on top of the price number or chart.

**Personality:** Calm, helpful, warm. Like a friend who quietly tells you when electricity is cheap. Never guilt-trips, never interrupts, never demands attention.

**Notifications:** Value first ("Billigast: 03:15, 0.12 SEK"), personality second (Gnistan's face as the icon). Maximum 2 per day.

**Production:** AI-generate concept (Midjourney) -> vectorize (vectorizer.ai) -> clean up (Figma) -> export SVGs -> SwiftUI with cross-fade animations. Upgrade to Rive post-launch.

**Timeline:** 2 days from concept to shipped MVP mascot.

**Kill switch:** Settings toggle to hide. A/B test to validate. If users don't engage better with Gnistan, dial it back to notifications-only.
