const colors = require("tailwindcss/colors");
const plugin = require("tailwindcss/plugin");

/** @type {import("tailwindcss/tailwind-config").TailwindConfig} */
module.exports = {
	content: [
		"./app/views/**/*.html.{haml,erb}",
		"./app/helpers/**/*.rb",
		"./app/javascript/controllers/*.tsx",
	],
	theme: {
		extend: {
			fontFamily: {
				heading: ["Outfit", "sans-serif"],
			},
			// Fix for a Tailwind 3 change (https://tailwindcss.com/docs/upgrade-guide#removed-color-aliases)
			colors: {
				green: colors.emerald,
				yellow: colors.amber,
				purple: colors.violet,
			},
			screens: {
				xs: "475px",
			},
			animation: {
				toast: "5600ms forwards toast",
			},
			keyframes: {
				toast: {
					"0%": { opacity: "0", visibility: "visible" },
					"7%": { opacity: "100", visibility: "visible" },
					"93%": { opacity: "100", visibility: "visible" },
					"100%": { opacity: "0", visibility: "hidden" },
				},
			},
		},
	},
	plugins: [
		// janky code alert !!!!
		plugin(function ({ addVariant }) {
			addVariant("group-2-hover", ".group-2:hover &");
		}),
	],
};
