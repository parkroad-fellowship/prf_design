---
name: PRF Design
description: The shared visual system for PRF Missions and PRF Leadership — deep navy roots, lime signs of life.
colors:
  root-navy: "#1A2253"
  root-navy-deep: "#090B1F"
  root-navy-night: "#0D112A"
  navy-mist: "#EDF1FF"
  navy-dawn: "#B6C6F6"
  growth-lime: "#9DE35D"
  growth-lime-bright: "#AFE964"
  paper: "#FFFFFF"
  paper-cool: "#F7F9FC"
  paper-shade: "#F0F3F8"
  hairline: "#E6EAF2"
  rule: "#D6DDE9"
  ink-quiet: "#6B758D"
  ink: "#171C29"
  ink-night: "#F0F3F8"
  ink-night-quiet: "#B5C0D3"
  status-success: "#0C7F5B"
  status-info: "#245FD1"
  status-warning: "#F59E0B"
  status-warning-text: "#8A5300"
  status-pending: "#EB8B2D"
  status-progress: "#12B886"
  status-error: "#D14343"
typography:
  display:
    fontFamily: "Manrope"
    fontSize: "38px"
    fontWeight: 800
    lineHeight: 1.1
    letterSpacing: "-0.9px"
  headline:
    fontFamily: "Manrope"
    fontSize: "24px"
    fontWeight: 700
    lineHeight: 1.25
  title:
    fontFamily: "Manrope"
    fontSize: "18px"
    fontWeight: 700
    lineHeight: 1.35
  body:
    fontFamily: "Manrope"
    fontSize: "15px"
    fontWeight: 500
    lineHeight: 1.5
  label:
    fontFamily: "Manrope"
    fontSize: "14px"
    fontWeight: 700
    lineHeight: 1.35
rounded:
  xs: "4px"
  sm: "8px"
  smd: "12px"
  md: "16px"
  lg: "20px"
  xl: "24px"
  xxl: "32px"
  full: "999px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "12px"
  lg: "16px"
  xl: "24px"
  xxl: "32px"
  xxxl: "40px"
components:
  button-primary:
    backgroundColor: "{colors.root-navy}"
    textColor: "{colors.paper}"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    padding: "12px 24px"
    height: "52px"
  button-secondary:
    backgroundColor: "{colors.growth-lime}"
    textColor: "{colors.root-navy-deep}"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    padding: "12px 24px"
    height: "52px"
  button-outlined:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.root-navy}"
    typography: "{typography.label}"
    rounded: "{rounded.md}"
    padding: "12px 24px"
    height: "52px"
  input:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    typography: "{typography.body}"
    rounded: "{rounded.md}"
    padding: "0 16px"
    height: "52px"
  card:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    rounded: "{rounded.lg}"
    padding: "16px"
  chip:
    backgroundColor: "{colors.paper-shade}"
    textColor: "{colors.ink-quiet}"
    typography: "{typography.label}"
    rounded: "{rounded.sm}"
    height: "48px"
  branded-navbar:
    backgroundColor: "{colors.root-navy}"
    textColor: "{colors.paper}"
    typography: "{typography.headline}"
    height: "96px"
---

# Design System: PRF Design

## Overview

**Creative North Star: "The Living Root"**

PRF is a fellowship's tool for sending people out and caring for them while they are there. The visual system grows from one image already drawn into the product: organic growth arcs rising across deep navy, tipped with small lime nodes (`PRFRootMotifPainter`). Navy is the root: steady, deep, trustworthy, present on every brand surface. Lime is the new growth: rare, alive, and only ever a point of emphasis. Everything else is calm paper and quiet ink so that the content (missions, people, money, prayers) carries the screen.

The system is built for people aged 18 to 90, most of them non-technical, often on a phone in a church hall or a school compound with patchy signal. That audience sets the density: generous 48dp targets, labels in words rather than icon riddles, body text that scales with the phone's own text size without clipping, and errors that always say what happened and offer a way to try again. Expression lives in the brand panels, the navbar, and the lime accents; working screens stay plain and legible.

Every surface ships a handset layout; PRF Missions also ships tablet layouts (split list/detail on the navy brand panel). PRF Leadership is handset-only by decision.

**Key Characteristics:**
- Deep navy brand surfaces with the Living Root motif; white working surfaces.
- Lime as a sparing accent and fill, never as text on white.
- Manrope everywhere, weight-led hierarchy (500 body, 600–800 headings).
- Soft, generous corners (16dp controls, 20dp cards) and soft navy-tinted shadows.
- Accessibility as a floor, not a feature: AA contrast, 48dp targets, reduced-motion fallbacks, scalable type.

## Colors

A two-anchor palette: one deep navy that grounds every screen and one bright lime that marks life and action, set on cool near-white paper.

### Primary
- **Root Navy** (#1A2253): the brand. Primary buttons, the branded navbar, brand side panels, selected states, links. In dark mode the primary role lifts to **Navy Dawn** (#B6C6F6) so it stays visible on night surfaces.
- **Root Navy Deep** (#090B1F): text and icons placed on lime; the dark-mode page.
- **Navy Mist** (#EDF1FF): primary containers and selected-row tints on light surfaces.

### Secondary
- **Growth Lime** (#9DE35D): secondary buttons, the Living Root nodes, positive highlights. In dark mode it brightens to **Growth Lime Bright** (#AFE964). Always paired with Root Navy Deep text (12.6:1).

### Neutral
- **Paper** (#FFFFFF): page and card background in light mode.
- **Paper Cool** (#F7F9FC) / **Paper Shade** (#F0F3F8): low and default surface containers, filled chips.
- **Hairline** (#E6EAF2) / **Rule** (#D6DDE9): dividers and decorative outlines only.
- **Ink** (#171C29): primary text. **Ink Quiet** (#6B758D): secondary text, labels and the stroke of enabled inputs (4.6:1 on paper).
- **Ink Night** (#F0F3F8) / **Ink Night Quiet** (#B5C0D3): text on dark surfaces.

### Status
Each status is a set: a `main` fill with a guaranteed `onColor`, a soft `background` tint with a guaranteed `foreground`. Success (#0C7F5B), info (#245FD1), warning (#F59E0B, text tone #8A5300), pending/scheduled (#EB8B2D), in-progress (#12B886) and error (#D14343). Dark mode uses bright tones with navy text. Every pair is held at 4.5:1 or better by `test/theme/contrast_test.dart`.

### Named Rules
**The Lime Is Never Ink Rule.** Lime is a fill and an accent. Never set lime text or thin lime icons on white or paper (1.55:1). On navy or as a fill with navy text, it sings.

**The Pair, Not the Paint Rule.** Status colours are used as sets. Text on a status `main` fill uses that set's `onColor`; text on its `background` tint uses its `foreground`. Picking a status hex and putting white on it is how the old badges failed AA.

**The Theme Owns Colour Rule.** Widget code reads colour from `colorScheme`, `context.prfColors` or `context.statusColors`. Raw `PRFColors.*`, `Colors.*` and hex literals live only in the theme layer, so dark mode keeps working.

## Typography

**Display Font:** Manrope (bundled offline)
**Body Font:** Manrope (bundled offline)

**Character:** One geometric-humanist family carries everything; hierarchy comes from weight and size, not from a second face. It reads cleanly at small sizes on budget Android screens and feels modern without being cold.

### Hierarchy
All sizes are multiplied by `DeviceHelper.getScaleFactor` (0.92–1.4× on phones, up to 1.6× on tablets) and then by the user's system text size.
- **Display** (800, 38 / 32 / 28, line-height 1.1–1.2, tight tracking): Brand panels, onboarding, campaign moments ("Wrapped").
- **Headline** (700, 24 / 20, 600 at 18; line-height 1.25–1.35): Screen titles and the branded navbar.
- **Title** (700 at 18, 600 at 16 / 14; line-height 1.35–1.4): Card titles, section headers, list primaries.
- **Body** (500, 16 / 15 / 13, line-height 1.45–1.5): Reading text, descriptions, form values.
- **Label** (700 at 14 / 13, 600 at 12; line-height 1.3–1.35): Buttons, chips, badges, field labels.

### Named Rules
**The Twelve Floor Rule.** Nothing renders below `labelSmall` (12sp base, never under 11sp after scaling). No raw `fontSize:` in widget code; take a `textTheme` style and `copyWith` colour or weight.

**The Grow, Don't Clip Rule.** Text containers use minimum heights, never fixed heights. Titles that can run long get `maxLines` and an ellipsis. Test new widgets at 2× text scale.

## Layout

A 4dp-based spacing scale (4, 8, 12, 16, 24, 32, 40) drives every gap and inset. Handset screens use a single column with 24dp (`xl`) side padding and full-width buttons. Tablet screens (600–1023dp) use `PRFTabletSplitScaffold`: a centred, max-width stage with a content column beside a navy `PRFBrandPanel`, 40dp (`xxxl`) padding, and buttons capped near 320dp and centred. Desktop (≥1024dp, in practice a large iPad in landscape) uses the tablet layout.

Every widget routes through `PRFAdaptive` with a shell, a shared builder file and per-device variants. Variants differ in layout, spacing and size, never in logic.

**The Forty-Eight Rule.** Every tappable thing is at least 48×48dp, including secondary actions such as delete, clear and retry. No `VisualDensity.compact`, no `shrinkWrap` tap targets.

## Elevation & Depth

A soft hybrid: surfaces are mostly flat white on cool paper, lifted by low, diffuse, navy-tinted shadows rather than by hard borders. Material elevation stays at 0 for buttons; depth comes from the shadow vocabulary.

### Shadow Vocabulary
- **Card** (`0 4px 16px navy/8%, 0 2px 8px navy/4%`): Content cards and list rows at rest.
- **Elevated** (`0 8px 24px navy/12%, 0 4px 12px navy/6%`): Floating surfaces: sheets, sticky bars, popovers.
- **Raised** (`0 6px 16px primary/8%`): Interactive action cards that invite a tap.
- **Badge** (`0 4px 8px accent/30%`): Coloured glow under status and date badges only.
- **Hero glow**: Brand panels and campaign moments.

### Named Rules
**The Token Shadow Rule.** Shadows come from `PRFShadowTokens` only. A hand-written `BoxShadow` is drift.

## Shapes

Gently rounded and friendly, never sharp, never pill-everything. Controls (buttons, inputs, snackbars) use 16dp (`md`); cards and FABs use 20dp (`lg`); bottom sheets and dialogs round their top or all corners at 20–24dp; chips, tooltips and list tiles use 8dp (`sm`); checkboxes 4dp. Full pills (`full`) are reserved for status badges, stat pills and avatars. Borders are 1–1.2dp hairlines; focus thickens to 1.8dp in the primary colour.

## Components

### Buttons
Confident and unmissable: full-width on handset, generous height, words before icons.
- **Shape:** 16dp radius, minimum height 52dp handset / 62dp tablet, grows with text size and wraps up to three lines.
- **Primary:** Root Navy fill, white label (Navy Dawn fill with navy text in dark mode).
- **Secondary:** Growth Lime fill with Root Navy Deep label.
- **Outlined / Text:** `PRFButtonVariant.outlined` (navy label, 1.5dp navy outline) and `.text` (navy label, no outline) for secondary, cancel and low-emphasis actions. Any variant can carry an optional leading icon.
- **Press:** scales to 0.985 with a fast 160ms ease (instant under reduced motion). Loading swaps the label for an 18dp spinner without changing size.

### Chips
- **Style:** Paper Shade fill, Ink Quiet label, hairline border; at least 48dp tall.
- **State:** selected chips take the primary fill with the matching on-colour label; rows grow with text size.

### Cards / Containers
- **Corner Style:** 20dp.
- **Background:** Paper (light), Night Navy container (dark).
- **Shadow Strategy:** Card shadow at rest, Raised for tappable action cards.
- **Border:** none, or a Hairline outline on flat lists.
- **Internal Padding:** 16dp handset, 24dp tablet.

### Inputs / Fields
- **Style:** white fill, 16dp radius, Ink Quiet stroke at rest (≥3:1 against the fill), 16dp horizontal padding, label above the field in Ink Quiet with "(optional)" in the same tone.
- **Focus:** 1.8dp primary stroke.
- **Error / Disabled:** error stroke and helper text in the error set's foreground; disabled fades the stroke to a faint hairline.

### Navigation
- **Branded navbar:** a 96dp Root Navy bar (plus status-bar inset) with a 48dp back button, a headline-weight white title that ellipsises, and labelled `PRFNavBarAction` buttons on the right (lime primary or neutral).
- **Bottom navigation:** Material navigation bar with a Navy Mist (primary container) indicator behind the selected item.

### Feedback & States
- **Errors:** `PRFErrorView` (full screen) or `PRFErrorView.inline` (inside sections) with a plain-language title, one sentence of help and a labelled "Try again" button. Errors are never dressed up as empty states.
- **Empty:** `PRFEmptyView` says what belongs here and how to add the first one.
- **Sync:** `PRFSyncStatusBar` explains offline uploads in plain words ("3 items waiting to upload") with a 48dp retry.
- **Snackbars:** `PRFSnackbar` success, error, info and warning variants using the status pairs.

### The Living Root Panel (signature)
`PRFBrandPanel` paints the Living Root motif behind navy, used on sign-in, home headers and the tablet split side panel. The lime node tips are the panel's only accent; content on it uses white and Navy Dawn text.

## Do's and Don'ts

### Do:
- **Do** take every colour from `colorScheme`, `context.prfColors` or `context.statusColors`, and pair status fills with their `onColor`.
- **Do** keep every tappable element at 48dp or larger and give icon-only buttons a localised `tooltip`.
- **Do** route every animation duration and delay through `PRFMotionTokens.resolve(context, …)`, and cap list staggers (eight items, 400ms).
- **Do** use spacing, radius, size, opacity and shadow tokens for every value.
- **Do** write user-facing copy in plain words: say what happened and what to do next ("Couldn't load missions. Check your connection and try again.").
- **Do** test new widgets in dark mode and at 2× text scale.

### Don't:
- **Don't** put lime text on white or white text on lime.
- **Don't** set raw `fontSize:` or build a `TextStyle` from scratch; nothing below 12sp.
- **Don't** wrap text in fixed-height boxes.
- **Don't** show an error as an empty state, or show raw exception text or HTTP codes to users.
- **Don't** fork a design-system widget inside an app. If it is missing a feature, add the feature to `prf_design`.
- **Don't** use `PRFColors.*`, `Colors.*` or hex literals in widget code.
