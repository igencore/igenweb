<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import ContactSection from '$lib/components/ContactSection.svelte';

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});
</script>

<svelte:head>
	<title>{currentLang === 'ES' ? 'Contacto | iGenCore - Ingeniería Minera Chile' : 'Contact | iGenCore - Mining Engineering Chile'}</title>
	<meta name="description" content={currentLang === 'ES'
		? 'Contáctanos para conversar sobre tu proyecto minero. Email: info@igencore.cl. WhatsApp disponible. iGenCore, ingeniería y soluciones para la minería chilena.'
		: 'Contact us to discuss your mining project. Email: info@igencore.cl. WhatsApp available. iGenCore, engineering and solutions for Chilean mining.'} />
	<meta name="keywords" content={currentLang === 'ES'
		? 'contacto iGenCore, consulta ingeniería minera, presupuesto servicios mineros Chile'
		: 'contact iGenCore, mining engineering inquiry, mining services quote Chile'} />
	<link rel="canonical" href="https://igencore.github.io/igenweb/contact" />
	<meta name="robots" content="index, follow, noarchive" />
	<meta property="og:title" content={currentLang === 'ES' ? 'Contacto | iGenCore' : 'Contact | iGenCore'} />
	<meta property="og:description" content={currentLang === 'ES'
		? 'Conversemos sobre tu próximo proyecto minero. info@igencore.cl'
		: "Let's talk about your next mining project. info@igencore.cl"} />
	<meta property="og:url" content="https://igencore.github.io/igenweb/contact" />
	<meta name="twitter:title" content={currentLang === 'ES' ? 'Contacto | iGenCore' : 'Contact | iGenCore'} />
	<meta name="twitter:description" content="info@igencore.cl" />
</svelte:head>

<ContactSection />
