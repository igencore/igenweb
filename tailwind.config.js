/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{html,js,svelte,ts}'],
	theme: {
		extend: {
			colors: {
				primary: {
					celeste: '#1671D8',
					DEFAULT: '#1671D8'
				},
				secondary: {
					azulprofundo: '#0F2C65',
					DEFAULT: '#0F2C65'
				},
				accent: {
					amarillo: '#F6BD20',
					DEFAULT: '#F6BD20'
				},
				button: {
					bg: '#FFEB3B'
				},
				light: {
					bg: '#FAFAFA'
				},
				dark: {
					bg: '#081C45'
				}
			},
			fontFamily: {
				sans: ['Lato', 'sans-serif']
			}
		}
	},
	plugins: [],
	darkMode: 'class'
};
