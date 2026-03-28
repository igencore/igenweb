import { writable } from 'svelte/store';
import { browser } from '$app/environment';

function createThemeStore() {
	const initialTheme =
		browser && localStorage.getItem('theme') ? localStorage.getItem('theme') : 'light';

	const { subscribe, set, update } = writable(initialTheme);

	function setDark() {
		if (browser) {
			localStorage.setItem('theme', 'dark');
			document.documentElement.classList.add('dark');
		}
		set('dark');
	}

	function setLight() {
		if (browser) {
			localStorage.setItem('theme', 'light');
			document.documentElement.classList.remove('dark');
		}
		set('light');
	}

	function toggle() {
		update((current) => {
			if (current === 'dark') {
				if (browser) {
					localStorage.setItem('theme', 'light');
					document.documentElement.classList.remove('dark');
				}
				return 'light';
			} else {
				if (browser) {
					localStorage.setItem('theme', 'dark');
					document.documentElement.classList.add('dark');
				}
				return 'dark';
			}
		});
	}

	return { subscribe, setDark, setLight, toggle };
}

export const themeStore = createThemeStore();
