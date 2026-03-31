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
	<title>{currentLang === 'ES' ? 'iGenCore | Excelencia Operacional en Minería Chile' : 'iGenCore | Mining Operational Excellence Chile'}</title>
	<meta name="description" content={currentLang === 'ES'
		? 'iGenCore: empresa chilena de ingeniería minera especializada en geometalurgia, flotación, automatización, metalmetánica y transporte de fluidos. Soluciones integrales para la minería.'
		: 'iGenCore: Chilean mining engineering company specializing in geometallurgy, flotation, automation, metal-mechanics and fluid transport. Comprehensive solutions for mining.'} />
	<meta name="keywords" content={currentLang === 'ES'
		? 'ingeniería minera Chile, geometalurgia, flotación minerales, automatización minera, metalmetánica, transporte fluidos minería, iGenCore'
		: 'mining engineering Chile, geometallurgy, mineral flotation, mining automation, metal mechanics, fluid transport mining, iGenCore'} />
	<link rel="canonical" href="https://igencore.github.io/igenweb/" />
	<!-- Open Graph -->
	<meta property="og:title" content={currentLang === 'ES' ? 'iGenCore | Excelencia Operacional en Minería Chile' : 'iGenCore | Mining Operational Excellence Chile'} />
	<meta property="og:description" content={currentLang === 'ES'
		? 'Empresa chilena de ingeniería minera: geometalurgia, flotación, automatización, metalmetánica y transporte de fluidos.'
		: 'Chilean mining engineering company: geometallurgy, flotation, automation, metal-mechanics and fluid transport.'} />
	<meta property="og:url" content="https://igencore.github.io/igenweb/" />
	<!-- Twitter -->
	<meta name="twitter:title" content={currentLang === 'ES' ? 'iGenCore | Excelencia Operacional en Minería Chile' : 'iGenCore | Mining Operational Excellence Chile'} />
	<meta name="twitter:description" content={currentLang === 'ES'
		? 'Empresa chilena de ingeniería minera: geometalurgia, flotación, automatización y más.'
		: 'Chilean mining engineering company: geometallurgy, flotation, automation and more.'} />
	<!-- Schema.org JSON-LD -->
	{@html `<script type="application/ld+json">
	{
		"@context": "https://schema.org",
		"@type": "Organization",
		"name": "iGenCore",
		"url": "https://igencore.github.io/igenweb/",
		"logo": "https://igencore.github.io/igenweb/images/logoigenblack.png",
		"description": "Empresa chilena de ingeniería minera especializada en geometalurgia, flotación, automatización industrial, metalmetánica y transporte de fluidos.",
		"foundingDate": "2021",
		"address": {
			"@type": "PostalAddress",
			"addressCountry": "CL",
			"addressRegion": "Chile"
		},
		"contactPoint": {
			"@type": "ContactPoint",
			"contactType": "customer service",
			"email": "info@igencore.cl",
			"telephone": "+56974591433",
			"availableLanguage": ["Spanish", "English"]
		},
		"sameAs": [
			"https://www.linkedin.com/company/igencore"
		],
		"hasOfferCatalog": {
			"@type": "OfferCatalog",
			"name": "Servicios de Ingeniería Minera",
			"itemListElement": [
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Geometalurgia y Procesamiento de Minerales",
						"description": "Soluciones en geometalurgia, flotación y procesamiento de minerales para la industria minera."
					}
				},
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Transporte de Fluidos",
						"description": "Ingeniería y diseño de sistemas de transporte de fluidos para procesos mineros."
					}
				},
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Metalmecánica Industrial",
						"description": "Fabricación y mantenimiento metalmecánico para la industria minera."
					}
				},
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Automatización de Procesos",
						"description": "Automatización industrial y control de procesos para operaciones mineras."
					}
				}
			]
		}
	}
	<\/script>`}
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
						image={service.image}
						isParent={true}
						showImage={true}
					/>
				{/each}
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

