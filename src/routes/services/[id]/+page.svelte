<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { services } from '$lib/data/services.js';
	import { base } from '$app/paths';
	import { page } from '$app/stores';

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	let service = $derived(services.find((s) => s.id === $page.params.id));
	let title = $derived(service ? (currentLang === 'ES' ? service.titleES : service.titleEN) : '');
	let summary = $derived(service ? (currentLang === 'ES' ? service.summaryES : service.summaryEN) : '');
</script>

<svelte:head>
	<title>iGenCore - {title}</title>
	<meta name="description" content={summary} />
</svelte:head>

{#if service}
	<!-- Breadcrumb -->
	<div class="bg-[#eef2f8] border-b border-[#d0dce8] py-4">
		<div class="max-w-4xl mx-auto px-4 sm:px-6">
			<a href="{base}/services" class="text-primary-celeste hover:text-secondary-azulprofundo transition text-sm flex items-center gap-1">
				← {t(currentLang, 'nav.services')}
			</a>
		</div>
	</div>

	<!-- Hero imagen de servicio (si tiene imagen) -->
	{#if service.image}
		<div class="relative w-full h-[320px] md:h-[400px] overflow-hidden bg-[#0f2c65]">
			<img
				src="{base}/images/{service.image}"
				alt={title}
				class="w-full h-full object-cover"
			/>
			<div class="absolute inset-0 bg-gradient-to-r from-[#0f2c65]/75 via-[#0f2c65]/40 to-transparent"></div>
			<div class="absolute inset-0 flex items-end">
				<div class="max-w-4xl mx-auto px-6 sm:px-10 w-full pb-10">
					<span class="inline-block px-3 py-1 bg-accent-amarillo text-black rounded-full text-xs font-bold mb-3 uppercase tracking-wide">
						{currentLang === 'ES' ? 'Servicio' : 'Service'} {service.id}
					</span>
					<h1 class="text-3xl md:text-5xl font-black text-white leading-tight">
						{title}
					</h1>
				</div>
			</div>
		</div>
	{/if}

	<!-- Contenido del servicio -->
	<section class="py-20 bg-[#f4f7fb]">
		<div class="max-w-4xl mx-auto px-4 sm:px-6">
			<!-- Sin imagen: mostrar título aquí -->
			{#if !service.image}
				<div class="mb-12 text-center md:text-left">
					<span class="material-icons block mb-4" style="font-size: 3rem; color: #F6BD20;">{service.icon}</span>
					<span class="inline-block px-3 py-1 bg-primary-celeste/10 border border-primary-celeste text-primary-celeste rounded-full text-sm font-semibold mb-5">
						{currentLang === 'ES' ? 'Servicio' : 'Service'} {service.id}
					</span>
					<h1 class="text-4xl md:text-5xl font-bold text-secondary-azulprofundo mb-5">
						{title}
					</h1>
				</div>
			{/if}

			<!-- Icono + descripción -->
			<div class="mb-12">
				{#if service.image}
					<div class="flex items-center gap-3 mb-6">
						<span class="material-icons" style="font-size: 2rem; color: #F6BD20;">{service.icon}</span>
					</div>
				{/if}
				<p class="text-xl text-[#4a6080] leading-relaxed">
					{summary}
				</p>
			</div>

			<!-- CTA -->
			<div class="pt-8 border-t border-[#d0dce8] text-center">
				<h3 class="text-2xl font-bold mb-6 text-secondary-azulprofundo">
					{currentLang === 'ES' ? '¿Interesado en este servicio?' : 'Interested in this service?'}
				</h3>
				<a
					href="{base}/contact"
					class="inline-block px-10 py-4 bg-accent-amarillo text-black font-bold rounded-lg hover:brightness-110 transition text-base"
				>
					{currentLang === 'ES' ? 'Contáctanos' : 'Get in Touch'}
				</a>
			</div>
		</div>
	</section>

{:else}
	<section class="py-20 text-center bg-[#f4f7fb]">
		<p class="text-xl text-[#4a6080]">
			{currentLang === 'ES' ? 'Servicio no encontrado' : 'Service not found'}
		</p>
	</section>
{/if}
