// theme.ts — single source of truth for every Remotion project.
// NEVER inline colors, easings, or spring configs in components.
import { Easing } from "remotion";

export const theme = {
  colors: {
    // Adjust to the user's brand. Defaults: dark tech.
    bg: "#0A0A0F",
    bgAlt: "#12121A",
    primary: "#7C3AED", // THE hero color — max one element per frame
    accent: "#22D3EE",
    text: "#F4F4F5",
    textDim: "#A1A1AA",
    glow: "rgba(124, 58, 237, 0.4)",
  },
  fonts: {
    display: "Clash Display", // load via @font-face + staticFile, or google-fonts
    body: "Inter",
    mono: "JetBrains Mono",
  },
  // THE easing curves. Linear is forbidden.
  ease: {
    out: Easing.bezier(0.16, 1, 0.3, 1), // easeOutExpo — entrances
    inOut: Easing.bezier(0.83, 0, 0.17, 1), // easeInOutQuint — moves, Ken Burns
    in: Easing.bezier(0.7, 0, 0.84, 0), // exits only
  },
  spring: {
    snappy: { damping: 14, stiffness: 160, mass: 0.6 }, // UI pops, words
    smooth: { damping: 20, stiffness: 90, mass: 1 }, // big elements
    bouncy: { damping: 11, stiffness: 170, mass: 0.7 }, // playful accents, logos
  },
} as const;
