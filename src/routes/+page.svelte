<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { services } from '$lib/data/services.js';
	import { publishings } from '$lib/data/publishings.js';
	import HeroSlider from '$lib/components/HeroSlider.svelte';
	import ServiceCard from '$lib/components/ServiceCard.svelte';
	import PointCloudAnimation from '$lib/components/PointCloudAnimation.svelte';
	import LogoCarousel from '$lib/components/LogoCarousel.svelte';
	import { base } from '$app/paths';

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	let mainServices = $derived(services.filter((s) => s.parent === null));
</script>

<svelte:head>
	<title>iGenCore - {currentLang === 'ES' ? 'Excelencia Operacional en Minería' : 'Mining Operational Excellence'}</title>
	<meta name="description" content={currentLang === 'ES' ? 'Impulsamos la eficiencia y la sostenibilidad en cada proceso.' : 'Driving efficiency and sustainability in every process.'} />
</svelte:head>

<!-- Hero: el componente maneja su propio fondo azul profundo -->
<HeroSlider />

<!-- Logo Carousel directamente debajo del hero -->
<LogoCarousel />

<!-- Services Section — animación + cards en un bloque continuo sin corte -->
<section class="relative bg-[#eef2f8]">
	<!-- Título -->
	<div class="relative z-10 pt-20 pb-2">
		<div class="max-w-6xl mx-auto px-4 sm:px-6 text-center">
			<h2 class="text-3xl md:text-4xl font-bold mb-3 text-secondary-azulprofundo">
				{t(currentLang, 'services_intro.title')}
			</h2>
			<p class="text-[#4a6080] max-w-2xl mx-auto">
				{t(currentLang, 'services_intro.subtitle')}
			</p>
		</div>
	</div>

	<!-- Animación de puntos con fade inferior -->
	<div class="relative" style="height: 340px; overflow: hidden;">
		<PointCloudAnimation />
		<div
			class="pointer-events-none absolute bottom-0 left-0 right-0"
			style="height: 200px; background: linear-gradient(to bottom, transparent, #eef2f8);"
		></div>
	</div>

	<!-- Cards superpuestas sobre la animación -->
	<div class="relative z-10 -mt-52 pb-20">
		<div class="max-w-6xl mx-auto px-4 sm:px-6">
			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
				{#each mainServices as service}
					<ServiceCard
						id={service.id}
						title={currentLang === 'ES' ? service.titleES : service.titleEN}
						summary={currentLang === 'ES' ? service.summaryES : service.summaryEN}
						icon={service.icon}
						isParent={true}
					/>
				{/each}
			</div>

			<div class="text-center mt-12">
				<a
					href="{base}/services"
					class="inline-block px-10 py-4 bg-accent-amarillo text-black font-bold rounded-lg hover:brightness-110 transition text-base"
				>
					{t(currentLang, 'services_intro.cta')}
				</a>
			</div>
		</div>
	</div>
</section>

<!-- Publications Section -->
<section class="py-20 bg-[#f4f7fb]">
	<div class="max-w-6xl mx-auto px-4 sm:px-6">
		<!-- Encabezado de sección -->
		<div class="mb-10">
			<h2 class="text-3xl md:text-4xl font-bold mb-3 text-secondary-azulprofundo">
				{t(currentLang, 'publishings_intro.main_title')}
			</h2>
			<p class="text-[#4a6080]">
				{t(currentLang, 'publishings_intro.main_subtitle')}
			</p>
		</div>

		<!-- Bloque destacado -->
		<div class="bg-white border border-[#d0dce8] p-8 rounded-xl mb-10">
			<h3 class="text-2xl font-bold text-secondary-azulprofundo mb-3">
				{t(currentLang, 'publishings_intro.content_title')}
			</h3>
			<p class="text-[#4a6080] mb-6">
				{t(currentLang, 'publishings_intro.content_body')}
			</p>
			<a
				href="{base}/publishings"
				class="inline-block px-10 py-4 bg-accent-amarillo text-black font-bold rounded-lg hover:brightness-110 transition text-base"
			>
				{t(currentLang, 'publishings_intro.content_button')}
			</a>
		</div>

		<!-- Cards de publicaciones -->
		<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
			{#each publishings as pub}
				<a href="{base}/publishings/{pub.id}" class="block">
					<div class="bg-white border border-[#d0dce8] rounded-xl overflow-hidden shadow-sm hover:shadow-md hover:border-primary-celeste transition">
						<img
							src="{base}/images/{pub.image}"
							alt={currentLang === 'ES' ? pub.titleES : pub.titleEN}
							class="w-full h-48 object-cover"
						/>
						<div class="p-5">
							<h3 class="font-bold text-base mb-2 text-secondary-azulprofundo">
								{currentLang === 'ES' ? pub.titleES : pub.titleEN}
							</h3>
							<p class="text-sm text-[#4a6080] line-clamp-2">
								{currentLang === 'ES' ? pub.summaryES : pub.summaryEN}
							</p>
						</div>
					</div>
				</a>
			{/each}
		</div>
	</div>
</section>

