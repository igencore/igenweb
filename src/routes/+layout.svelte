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
	<!-- Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
	<link
		href="https://fonts.googleapis.com/css2?family=Lato:wght@400;700;900&display=swap"
		rel="stylesheet"
	/>

	<!-- Meta tags globales -->
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="robots" content="index, follow" />
	<meta name="author" content="iGenCore" />
	<meta name="theme-color" content="#0f2c65" />

	<!-- Open Graph global (sobreescrito por página) -->
	<meta property="og:site_name" content="iGenCore" />
	<meta property="og:type" content="website" />
	<meta property="og:image" content="https://igencore.github.io/igenweb/images/banner1.jpg" />
	<meta property="og:image:width" content="1200" />
	<meta property="og:image:height" content="630" />
	<meta property="og:locale" content="es_CL" />

	<!-- Twitter Card global -->
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@igencore" />
	<meta name="twitter:image" content="https://igencore.github.io/igenweb/images/banner1.jpg" />

	<!-- Search Console verification (reemplazar con el ID real al verificar) -->
	<!-- <meta name="google-site-verification" content="REEMPLAZAR_CON_ID_SEARCH_CONSOLE" /> -->

	<!-- Google Analytics 4 (reemplazar G-XXXXXXXXXX con el ID real de la propiedad GA4) -->
	<!-- <script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());
		gtag('config', 'G-XXXXXXXXXX');
	</script> -->
</svelte:head>

<Header />
<main>
	{@render children()}
</main>
<Footer />
