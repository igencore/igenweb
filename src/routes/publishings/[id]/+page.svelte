<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { publishings } from '$lib/data/publishings.js';
	import { base } from '$app/paths';
	import { page } from '$app/stores';

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	let publishing = $derived(publishings.find((p) => p.id === $page.params.id));
	let title = $derived(publishing ? (currentLang === 'ES' ? publishing.titleES : publishing.titleEN) : '');
	let summary = $derived(publishing ? (currentLang === 'ES' ? publishing.summaryES : publishing.summaryEN) : '');
</script>

<svelte:head>
	<title>iGenCore - {title}</title>
	<meta name="description" content={summary} />
</svelte:head>

{#if publishing}
	<!-- Breadcrumb -->
	<div class="bg-[#eef2f8] border-b border-[#d0dce8] py-4">
		<div class="max-w-4xl mx-auto px-4 sm:px-6">
			<a href="{base}/publishings" class="text-primary-celeste hover:text-secondary-azulprofundo transition text-sm flex items-center gap-1">
				← {t(currentLang, 'nav.publishings')}
			</a>
		</div>
	</div>

	<!-- Contenido de la publicación -->
	<section class="py-20 bg-[#f4f7fb]">
		<div class="max-w-4xl mx-auto px-4 sm:px-6">
			<img
				src="{base}/images/{publishing.image}"
				alt={title}
				class="w-full rounded-xl shadow-sm mb-12"
			/>

			<h1 class="text-4xl md:text-5xl font-bold text-secondary-azulprofundo mb-5">
				{title}
			</h1>
			<p class="text-lg text-[#4a6080] leading-relaxed mb-12">
				{summary}
			</p>

			<div class="p-8 bg-white border border-[#d0dce8] rounded-xl mb-12">
				<p class="text-[#1a2a4a] leading-relaxed">
					{currentLang === 'ES'
						? 'Esta publicación representa parte de nuestro compromiso con la innovación en la industria minera.'
						: 'This publication represents part of our commitment to innovation in the mining industry.'}
				</p>
			</div>

			<!-- CTA -->
			<div class="pt-8 border-t border-[#d0dce8] text-center">
				<h3 class="text-2xl font-bold mb-6 text-secondary-azulprofundo">
					{currentLang === 'ES' ? '¿Deseas colaborar con nosotros?' : 'Want to collaborate with us?'}
				</h3>
				<a
					href="{base}/contact"
					class="inline-block px-10 py-4 bg-accent-amarillo text-black font-bold rounded-lg hover:brightness-110 transition text-base"
				>
					{currentLang === 'ES' ? 'Contáctanos Hoy' : 'Contact Us Today'}
				</a>
			</div>
		</div>
	</section>

{:else}
	<section class="py-20 text-center bg-[#f4f7fb]">
		<p class="text-xl text-[#4a6080]">
			{currentLang === 'ES' ? 'Publicación no encontrada' : 'Publication not found'}
		</p>
	</section>
{/if}
