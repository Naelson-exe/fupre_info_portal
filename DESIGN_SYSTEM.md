# FUPRE Information Portal Design System

## Brand Context
- Nigerian petroleum-focused university
- Professional, academic institution
- Users transitioning from WhatsApp to web platform
- Mobile-first audience (80%+ mobile usage expected)

---

## Color Palette

| Color Name       | Hex       | Usage Guidelines                                    |
|------------------|-----------|----------------------------------------------------|
| Deep Blue        | #003366   | Primary color for headers, navigation, and CTAs   |
| Gold Accent      | #C49A6C   | Accent color for highlights, buttons, icons        |
| Soft Gray        | #F5F5F5   | Backgrounds, secondary surfaces                     |
| Charcoal         | #333333   | Text color, primary body text                        |

**Contrast:** All colors ensure a minimum 4.5:1 contrast ratio for accessibility.

---

## Typography

- **Headings:** Montserrat
- **Body Text:** Roboto

### Typography Scale (all sizes in rem, base 16px)

| Element   | Font Size | Line Height | Weight  |
|-----------|-----------|-------------|---------|
| H1        | 2.25rem   | 2.75rem     | 700     |
| H2        | 1.75rem   | 2.25rem     | 700     |
| H3        | 1.5rem    | 2rem        | 600     |
| Body      | 1rem      | 1.5rem      | 400     |
| Caption   | 0.75rem   | 1rem        | 400     |

---

## Spacing System

- Base unit: 1rem (16px)
- Spacing increments: 0.5rem, 1rem, 1.5rem, 2rem, 3rem, 4rem

Use spacing consistently for margins, paddings, and gaps.

---

## Component Styles

### Buttons
- Minimum touch target: 2.75rem x 2.75rem
- Primary Button: Background Deep Blue (#003366), Text White (#FFFFFF), Border none, Border-radius 0.375rem
- Secondary Button: Background Gold Accent (#C49A6C), Text Charcoal (#333333), Border none, Border-radius 0.375rem
- Disabled: Background Soft Gray (#F5F5F5), Text Charcoal (#333333), Opacity 0.5

### Cards
- Background: White (#FFFFFF)
- Border: 1px solid Soft Gray (#F5F5F5)
- Border-radius: 0.5rem
- Padding: 1.5rem
- Box-shadow: 0 2px 4px rgba(0,0,0,0.1)

### Forms
- Input background: White (#FFFFFF)
- Border: 1px solid Soft Gray (#F5F5F5)
- Border-radius: 0.375rem
- Padding: 0.75rem 1rem
- Focus border: Deep Blue (#003366)
- Label font-weight: 600

---

## Responsive Breakpoints

| Breakpoint | Min Width  | Usage                   |
|------------|------------|-------------------------|
| Mobile     | 0          | Default, mobile-first    |
| Tablet     | 48rem (768px) | Tablets and small screens |
| Desktop    | 64rem (1024px) | Desktop and larger screens |

---

## Accessibility Guidelines

- Ensure all text and interactive elements meet minimum 4.5:1 contrast ratio
- Touch targets minimum size 2.75rem (44px) for all clickable elements
- Use semantic HTML elements for structure
- Provide keyboard navigation and focus states
- Use ARIA roles and labels where appropriate

---

This design system ensures a modern, professional, and petroleum industry-appropriate experience for the FUPRE Information Portal, optimized for mobile-first users transitioning from WhatsApp.
