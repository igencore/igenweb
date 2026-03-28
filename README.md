# iGenCore Web App

SvelteKit + Tailwind CSS web application for iGenCore, a Chilean mining company.

## Overview

This is a complete rewrite of the iGenCore website from Flutter Web to **SvelteKit**. It features:

- **Framework**: SvelteKit with static site adapter for GitHub Pages
- **Styling**: Tailwind CSS v4
- **Internationalization**: Spanish (ES) and English (EN) support
- **Dark Mode**: Theme toggle with localStorage persistence
- **Components**: Reusable Svelte components for consistent UI
- **Forms**: Contact form with Pocketbase API integration
- **SEO**: Meta tags and proper heading hierarchy

## Technology Stack

- **Node.js 20+**
- **SvelteKit 2.50+**
- **Svelte 5.54+**
- **Tailwind CSS 4.1+**
- **Vite 7.3+**

## Project Structure

```
src/
├── lib/
│   ├── components/      # Reusable Svelte components
│   ├── stores/          # Svelte stores (theme, language)
│   └── data/            # Content data (services, publishings, translations)
└── routes/              # File-based routing
    ├── +layout.svelte   # Root layout with Header/Footer
    ├── +page.svelte     # Home page
    ├── about/           # About page
    ├── services/        # Services listing and detail pages
    ├── publishings/     # Publications listing and detail pages
    └── contact/         # Contact page
```

## Getting Started

### Prerequisites

- Node.js 20+
- npm or similar package manager

### Development

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Open in browser
npm run dev -- --open
```

### Build for Production

```bash
# Build static site
npm run build

# Preview production build
npm run preview
```

## Deployment

### GitHub Pages

This site is deployed to GitHub Pages at `https://igencore.github.io/igenweb/`.

The deployment is automated via GitHub Actions on every push to `main` branch:

1. Build runs: `npm run build`
2. Output folder: `build/`
3. Deploys to: `gh-pages` branch

### Environment Variables

Create a `.env` file for local development:

```env
VITE_POCKETBASE_URL=https://your-pocketbase-instance.com
```

For production, add this variable to GitHub Actions secrets.

## Features

### 1. Multi-language Support
- Spanish (ES) and English (EN)
- Language preference persisted in localStorage
- Dynamic translation of all content via `t()` function

### 2. Theme Toggle
- Light and dark modes
- CSS custom properties for theming
- Theme class applied to `<html>` element
- Preference persisted in localStorage
- No flash on page load

### 3. Responsive Design
- Mobile-first approach
- Tailwind CSS breakpoints
- Hamburger menu for mobile navigation

### 4. Contact Form
- Name, email, message fields
- Submission to Pocketbase API
- Success/error handling
- Loading states

### 5. Static Site Generation
- All pages prerendered
- `@sveltejs/adapter-static` for GitHub Pages
- Base path: `/igenweb/`

## Content

### Services
- 4 main service categories
- Sub-services with parent relationships
- Detailed service pages

### Publications
- 4 featured publications
- Publication detail pages with images

### About
- Anchor-linked sections:
  - Purpose & Vision
  - Integral Approach
  - Trajectory & Achievements

## Design System

### Color Palette
- Primary (Celeste): `#1671D8`
- Secondary (Azul Profundo): `#0F2C65`
- Accent (Amarillo): `#F6BD20`
- Light BG: `#FAFAFA`
- Dark BG: `#081C45`

### Typography
- Font Family: Lato (Google Fonts)
- Sizes: sm, base, lg, xl, 2xl, 3xl, 4xl, 5xl

## Development Commands

- `npm run dev` - Start dev server
- `npm run build` - Build production
- `npm run preview` - Preview production build
- `npm run check` - Type checking
- `npm run check:watch` - Watch mode type checking

## File Reference

### Key Components
- `Header.svelte` - Navigation with theme/language toggles
- `Footer.svelte` - Footer with links and copyright
- `HeroSlider.svelte` - Image carousel
- `ContactSection.svelte` - Contact form and info
- `ServiceCard.svelte` - Service card component
- `LogoCarousel.svelte` - Client logos display

### Stores
- `theme.js` - Dark/light mode state
- `language.js` - ES/EN language state

### Data Files
- `translations.js` - All ES/EN content strings
- `services.js` - Service data with parent relationships
- `publishings.js` - Publication data

## License

Copyright © 2024 iGenCore. All rights reserved.
