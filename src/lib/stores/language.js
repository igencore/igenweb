import { writable } from 'svelte/store';
import { browser } from '$app/environment';

function createLanguageStore() {
	const initialLanguage =
		browser && localStorage.getItem('language') ? localStorage.getItem('language') : 'ES';

	const { subscribe, set, update } = writable(initialLanguage);

	function setES() {
		if (browser) localStorage.setItem('language', 'ES');
		set('ES');
	}

	function setEN() {
		if (browser) localStorage.setItem('language', 'EN');
		set('EN');
	}

	function toggle() {
		update((current) => {
			const next = current === 'ES' ? 'EN' : 'ES';
			if (browser) localStorage.setItem('language', next);
			return next;
		});
	}

	return { subscribe, setES, setEN, toggle };
}

export const languageStore = createLanguageStore();
