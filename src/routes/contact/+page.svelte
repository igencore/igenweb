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
	<title>iGenCore - {t(currentLang, 'nav.contact')}</title>
	<meta name="description" content={t(currentLang, 'contact.subtitle')} />
</svelte:head>

<ContactSection />
