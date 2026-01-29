# Travel Planner App – Flutter Implementation Plan

> **Scope**: This document defines *what needs to be built* (requirements, structure, decisions) for a Travel Planner mobile app in **Flutter**, based on the provided UI designs (Sign In & Sign Up), color palette, and architectural constraints.  
> **Important**: This is an implementation plan only — **no code samples** are included.

---

## 1. Product Overview

The Travel Planner app enables users to:
- Create an account and sign in
- Plan and manage trips
- Explore destinations and itineraries
- Maintain a clean, premium, glassmorphism-inspired UI

Initial phase focuses on:
- Authentication UI (Sign In / Sign Up)
- App architecture foundations
- Navigation and state handling setup

Backend integration and real authentication logic are **out of scope for now**.

---

## 2. Design System Requirements

### 2.1 Color Palette (Mandatory)

#### Primary Colors
- **Royal Blue (#2563EB)**  
  Used for:
  - Primary CTA buttons (Sign In, Create Account)
  - Active navigation states
  - Primary icons

- **Sky Blue (#60A5FA)**  
  Used for:
  - Secondary accents
  - Icons
  - Highlight and focus states

- **Light Azure (#DBEAFE)**  
  Used for:
  - Subtle background tints
  - Input focus backgrounds
  - Section separation

#### Typography & Surface
- **Primary Text**: Deep Navy `#1E293B`
- **Secondary Text**: Slate Gray `#64748B`
- **Main App Surface**: Off‑white `#F8FAFC`

All colors must be centralized in a **design tokens / theme configuration**.

---

### 2.2 Glassmorphism Standards

Glass UI must be visually consistent across all auth screens:

- **Card Background**: `rgba(255,255,255,0.6)`
- **Card Border**: `rgba(255,255,255,0.4)`
- **Backdrop Blur**: 12–20px

Glass components must:
- Sit above background imagery or gradients
- Include subtle shadows for depth
- Respect platform performance limits (avoid excessive blur stacking)

---

## 3. Typography Requirements

- Font Family: **Plus Jakarta Sans**
- Font Weights Required:
  - Regular (400)
  - Medium (500)
  - SemiBold (600)
  - Bold (700)
  - ExtraBold (800)

Typography hierarchy must clearly differentiate:
- Screen titles
- Section headers
- Input labels
- Helper / legal text

---

## 4. UI Screen Requirements

### 4.1 Sign In Screen

Must visually and structurally match the provided HTML design.

#### Required UI Elements
- Full‑screen travel-themed background image
- Gradient overlay for contrast
- Glassmorphic card container

Inside the card:
- App icon (flight / travel symbol)
- Title: "Welcome Back"
- Subtitle text
- Email input field
- Password input field with visibility toggle icon
- "Forgot Password" link (UI only)
- Primary "Sign In" button

Additional sections:
- Divider with "or continue with"
- Google Sign‑In button (UI only)
- Apple Sign‑In button (UI only)
- Footer text linking to Sign Up screen

No validation or authentication logic is required at this stage.

---

### 4.2 Sign Up Screen

Must replicate the visual hierarchy and layout of the provided design.

#### Required UI Elements
- Mesh / gradient background
- Rounded container with glass effect
- Back navigation icon

Form contents:
- Full Name input
- Email input
- Password input with visibility icon
- Primary "Create Account" button

Additional UI:
- Link to Sign In screen
- Google & Apple sign‑up buttons (UI only)
- Terms of Service & Privacy Policy disclaimer

Decorative blur elements must be included to match depth and style.

---

## 5. Flutter Architecture Requirements

### 5.1 Architectural Pattern

The app **must follow Clean Architecture**, strictly aligned with **SOLID principles**.

#### Layer Separation

1. **Presentation Layer**
   - Screens (Pages)
   - Widgets
   - UI state using `setState`

2. **Domain Layer**
   - Entities (User, Trip, Destination, etc.)
   - Use cases (SignIn, SignUp, CreateTrip, etc.)
   - Repository abstractions (interfaces only)

3. **Data Layer**
   - Repository implementations (future)
   - Data sources (API / local – placeholders for now)

Each layer must:
- Depend only on the layer below it
- Communicate via abstractions

---

### 5.2 SOLID Enforcement

- **Single Responsibility**: Each class handles one concern
- **Open/Closed**: UI and logic extensible without modification
- **Liskov Substitution**: Domain abstractions interchangeable
- **Interface Segregation**: Small, purpose‑specific interfaces
- **Dependency Inversion**: UI depends on abstractions, not implementations

---

## 6. State Management Rules

- **Allowed**: `setState`
- **Not Allowed**:
  - Riverpod
  - Provider
  - Bloc
  - Redux

State handling scope:
- Form field values
- Password visibility toggle
- Navigation triggers

State must be:
- Local to the screen where possible
- Reset on screen disposal

---

## 7. Navigation Requirements

- Navigation must use **Named Routes ONLY**

Required routes:
- `/sign-in`
- `/sign-up`
- `/home` (placeholder)

Navigation rules:
- No anonymous routes
- No imperative navigation shortcuts
- Centralized route registration

---

## 8. Authentication (Current Phase)

- Email/Password: **UI only**
- Google Sign‑In: **UI only**

No:
- Firebase
- OAuth logic
- Token handling

Buttons must be visually complete and tappable, but perform no real authentication.

---

## 9. Asset & Resource Requirements

- Background travel images (high resolution)
- Google & Apple logos (SVG or PNG)
- Material Icons / Symbols equivalent in Flutter

Assets must be:
- Optimized for mobile
- Centralized in an assets directory

---

## 10. Quality & UX Expectations

- Smooth animations on press & focus
- Consistent spacing and alignment
- Platform‑adaptive safe areas (iOS & Android)
- No layout overflow on small screens

The app should feel:
- Premium
- Airy
- Modern
- Travel‑inspired

---

## 11. Out of Scope (For This Phase)

- Backend integration
- Real authentication
- Persistent storage
- Trip CRUD logic
- Maps & geolocation

---

## 12. Deliverables Summary

- Flutter project scaffolded with Clean Architecture
- Fully styled Sign In screen
- Fully styled Sign Up screen
- Centralized theme & design tokens
- Named route navigation
- UI‑only Google sign‑in buttons

---

## 13. Extra Notes

- Use absolute imports for all files
- the common widgets should be in common folders
- avoid the logic in the UI files
- use constants in general, avoid magic numbers and strings
- save the gradients in the extension

**This plan defines everything required to build the first foundation of the Travel Planner Flutter app, ready for future feature expansion without architectural refactors.**

