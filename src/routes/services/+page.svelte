<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { services } from '$lib/data/services.js';
	import ServiceCard from '$lib/components/ServiceCard.svelte';
	import PointCloudAnimation from '$lib/components/PointCloudAnimation.svelte';
	import { base } from '$app/paths';

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	let mainServices = $derived(services.filter((s) => s.parent === null));

	function getSubservices(id) {
		return services.filter((s) => s.parent === id);
	}

	function getDisplayTitle(service) {
		const title = currentLang === 'ES' ? service.titleES : service.titleEN;
		return `${service.id}. ${title}`;
	}
</script>

<svelte:head>
	<title>iGenCore - {t(currentLang, 'nav.services')}</title>
	<meta name="description" content={t(currentLang, 'services_intro.subtitle')} />
</svelte:head>

<!-- Bloque continuo: título + animación + cards sin corte -->
<section class="relative bg-[#eef2f8]">
	<!-- Título -->
	<div class="relative z-10 pt-20 pb-2">
		<div class="max-w-6xl mx-auto px-4 sm:px-6 text-center">
			<h1 class="text-4xl md:text-5xl font-bold mb-3 text-secondary-azulprofundo">
				{t(currentLang, 'services_intro.title')}
			</h1>
			<p class="text-xl text-[#4a6080] max-w-2xl mx-auto">
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

	<!-- Grid de servicios emergiendo desde la animación -->
	<div class="relative z-10 -mt-52 pb-20">
		<div class="max-w-6xl mx-auto px-4 sm:px-6">
			<div class="space-y-8">
				{#each mainServices as service}
					{@const subs = getSubservices(service.id)}
					{@const totalCards = 1 + subs.length}
					<div class="grid gap-5"
						style="grid-template-columns: repeat({totalCards >= 4 ? 2 : Math.min(totalCards, 3)}, minmax(0, 1fr));"
					>
						<ServiceCard
							id={service.id}
							title={getDisplayTitle(service)}
							summary={currentLang === 'ES' ? service.summaryES : service.summaryEN}
							icon={service.icon}
							image={service.image}
							isParent={true}
							showImage={true}
						/>
						{#each subs as subservice}
							<ServiceCard
								id={subservice.id}
								title={getDisplayTitle(subservice)}
								summary={currentLang === 'ES' ? subservice.summaryES : subservice.summaryEN}
								icon={subservice.icon}
								image={subservice.image}
								isParent={false}
								isSubService={true}
								showImage={true}
							/>
						{/each}
					</div>
				{/each}
			</div>
		</div>
	</div>
</section>
