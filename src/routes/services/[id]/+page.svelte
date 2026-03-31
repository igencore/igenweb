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

	// Sub-servicios (si este servicio es padre)
	let subServices = $derived(service ? services.filter((s) => s.parent === service.id) : []);

	// Servicio padre (si este es un sub-servicio)
	let parentService = $derived(service?.parent ? services.find((s) => s.id === service.parent) : null);
	let parentTitle = $derived(parentService ? (currentLang === 'ES' ? parentService.titleES : parentService.titleEN) : '');

	// Fotos adicionales de galería (solo para flotación 1a)
	const galleryImages = {
		'1a': [
			{ file: 'flotacion_sensores_1.jpg', captionES: 'Sensores de medición instalados en celdas de flotación', captionEN: 'Measurement sensors installed in flotation cells' },
			{ file: 'flotacion_sensores_2.jpg', captionES: 'Sistema de monitoreo continuo en banco de celdas', captionEN: 'Continuous monitoring system on cell bank' },
			{ file: 'flotacion_planta.jpg', captionES: 'Vista general del circuito de flotación instrumentado', captionEN: 'General view of the instrumented flotation circuit' },
		]
	};

	let serviceGallery = $derived(service ? (galleryImages[service.id] || []) : []);
</script>

<svelte:head>
	<title>{title} | iGenCore - Ingeniería Minera Chile</title>
	<meta name="description" content={summary} />
	<meta name="keywords" content={`${title}, iGenCore, ingeniería minera Chile, servicios mineros`} />
	<link rel="canonical" href={`https://igencore.github.io/igenweb/services/${service?.id}`} />
	<meta property="og:title" content={`${title} | iGenCore`} />
	<meta property="og:description" content={summary} />
	<meta property="og:url" content={`https://igencore.github.io/igenweb/services/${service?.id}`} />
	{#if service?.image}
	<meta property="og:image" content={`https://igencore.github.io/igenweb/images/${service.image}`} />
	<meta name="twitter:image" content={`https://igencore.github.io/igenweb/images/${service.image}`} />
	{/if}
	<meta name="twitter:title" content={`${title} | iGenCore`} />
	<meta name="twitter:description" content={summary} />
</svelte:head>

{#if service}
	<!-- Breadcrumb -->
	<div class="bg-[#eef2f8] border-b border-[#d0dce8] py-4">
		<div class="max-w-4xl mx-auto px-4 sm:px-6">
			<div class="flex items-center gap-2 text-sm text-[#4a6080]">
				<a href="{base}/" class="hover:text-primary-celeste transition">
					{t(currentLang, 'nav.home')}
				</a>
				<span>›</span>
				{#if parentService}
					<a href="{base}/services/{parentService.id}" class="hover:text-primary-celeste transition text-primary-celeste font-medium">
						{parentTitle}
					</a>
					<span>›</span>
					<span class="text-secondary-azulprofundo font-semibold">{title}</span>
				{:else}
					<span class="text-secondary-azulprofundo font-semibold">{title}</span>
				{/if}
			</div>
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
					<h1 class="text-3xl md:text-5xl font-black text-white leading-tight">
						{title}
					</h1>
				</div>
			</div>
		</div>
	{/if}

	<!-- Contenido del servicio -->
	<section class="py-16 bg-[#f4f7fb]">
		<div class="max-w-4xl mx-auto px-4 sm:px-6">
			<!-- Sin imagen: mostrar título aquí -->
			{#if !service.image}
				<div class="mb-12 text-center md:text-left">
					<span class="material-icons block mb-4" style="font-size: 3rem; color: #F6BD20;">{service.icon}</span>
					<h1 class="text-4xl md:text-5xl font-bold text-secondary-azulprofundo mb-5">
						{title}
					</h1>
				</div>
			{/if}

			<!-- Icono + descripción -->
			<div class="mb-10">
				{#if service.image}
					<div class="flex items-center gap-3 mb-6">
						<span class="material-icons" style="font-size: 2rem; color: #F6BD20;">{service.icon}</span>
					</div>
				{/if}
				<p class="text-xl text-[#4a6080] leading-relaxed">
					{summary}
				</p>
			</div>

			<!-- Galería de fotos (si existe para este servicio) -->
			{#if serviceGallery.length > 0}
				<div class="mb-12">
					<h2 class="text-2xl font-bold text-secondary-azulprofundo mb-6">
						{currentLang === 'ES' ? 'Trabajo en terreno' : 'Field Work'}
					</h2>
					<div class="grid grid-cols-1 md:grid-cols-3 gap-4">
						{#each serviceGallery as photo}
							<div class="rounded-xl overflow-hidden shadow-md border border-[#d0dce8]">
								<img
									src="{base}/images/{photo.file}"
									alt={currentLang === 'ES' ? photo.captionES : photo.captionEN}
									class="w-full h-56 object-cover"
								/>
								<div class="p-3 bg-white">
									<p class="text-xs text-[#4a6080] leading-snug">
										{currentLang === 'ES' ? photo.captionES : photo.captionEN}
									</p>
								</div>
							</div>
						{/each}
					</div>
				</div>
			{/if}

			<!-- Sub-servicios (si este es un padre con hijos) -->
			{#if subServices.length > 0}
				<div class="mb-12">
					<h2 class="text-2xl font-bold text-secondary-azulprofundo mb-2">
						{currentLang === 'ES' ? 'Servicios especializados' : 'Specialized Services'}
					</h2>
					<p class="text-[#4a6080] mb-6 text-sm">
						{currentLang === 'ES'
							? 'Explorá en detalle cada uno de los servicios que componen esta área.'
							: 'Explore in detail each of the services that make up this area.'}
					</p>
					<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
						{#each subServices as sub}
							{@const subTitle = currentLang === 'ES' ? sub.titleES : sub.titleEN}
							{@const subSummary = currentLang === 'ES' ? sub.summaryES : sub.summaryEN}
							<a href="{base}/services/{sub.id}" class="block group">
								<div class="bg-white border border-[#d0dce8] rounded-xl overflow-hidden hover:shadow-md hover:border-primary-celeste transition-all duration-200 h-full flex flex-col">
									<!-- Imagen del sub-servicio -->
									{#if sub.image}
										<div class="w-full h-40 overflow-hidden flex-shrink-0">
											<img
												src="{base}/images/{sub.image}"
												alt={subTitle}
												class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
											/>
										</div>
									{/if}
									<div class="p-5 flex flex-col flex-1">
										<div class="flex items-center gap-2 mb-3">
											<span class="material-icons" style="font-size: 1.25rem; color: #F6BD20;">{sub.icon}</span>
											<h3 class="font-bold text-sm text-secondary-azulprofundo leading-snug">{subTitle}</h3>
										</div>
										<p class="text-xs text-[#4a6080] leading-relaxed line-clamp-3 flex-1">{subSummary}</p>
										<div class="mt-3 flex items-center gap-1 text-primary-celeste text-xs font-semibold group-hover:gap-2 transition-all">
											{currentLang === 'ES' ? 'Ver detalle' : 'View details'}
											<span>→</span>
										</div>
									</div>
								</div>
							</a>
						{/each}
					</div>
				</div>
			{/if}

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
