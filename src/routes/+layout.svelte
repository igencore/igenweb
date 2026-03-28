<script>
	import './layout.css';
	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import { themeStore } from '$lib/stores/theme.js';
	import { languageStore } from '$lib/stores/language.js';
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';

	let { children } = $props();

	onMount(() => {
		// Sincronizar stores con localStorage al montar
		// El script anti-flash en app.html ya añadió la clase 'dark' si era necesario
		const savedTheme = localStorage.getItem('theme') || 'light';
		const savedLang = localStorage.getItem('language') || 'ES';

		if (savedTheme === 'dark') {
			themeStore.setDark();
		} else {
			themeStore.setLight();
		}

		if (savedLang === 'EN') {
			languageStore.setEN();
		} else {
			languageStore.setES();
		}
	});
</script>

<svelte:head>
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
	<link
		href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700;900&display=swap"
		rel="stylesheet"
	/>
</svelte:head>

<Header />
<main>
	{@render children()}
</main>
<Footer />
