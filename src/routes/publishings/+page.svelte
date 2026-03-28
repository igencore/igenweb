<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { publishings } from '$lib/data/publishings.js';
	import { base } from '$app/paths';

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});
</script>

<svelte:head>
	<title>{currentLang === 'ES' ? 'Publicaciones Científicas en Minería | iGenCore Chile' : 'Scientific Publications in Mining | iGenCore Chile'}</title>
	<meta name="description" content={currentLang === 'ES'
		? 'Publicaciones científicas e insights del sector minero por iGenCore. Investigación en materiales, optimización de procesos y algoritmos de IA para minería sostenible.'
		: 'Scientific publications and mining sector insights by iGenCore. Research in materials, process optimization and AI algorithms for sustainable mining.'} />
	<meta name="keywords" content={currentLang === 'ES'
		? 'publicaciones minería Chile, investigación minera, Minería 4.0, IA minería, innovación minera iGenCore'
		: 'mining publications Chile, mining research, Mining 4.0, AI mining, iGenCore mining innovation'} />
	<link rel="canonical" href="https://igencore.github.io/igenweb/publishings" />
	<meta property="og:title" content={currentLang === 'ES' ? 'Publicaciones Científicas en Minería | iGenCore' : 'Scientific Publications in Mining | iGenCore'} />
	<meta property="og:description" content={currentLang === 'ES'
		? 'Investigación y publicaciones científicas sobre minería sostenible y Minería 4.0.'
		: 'Research and scientific publications on sustainable mining and Mining 4.0.'} />
	<meta property="og:url" content="https://igencore.github.io/igenweb/publishings" />
	<meta name="twitter:title" content={currentLang === 'ES' ? 'Publicaciones Mineras | iGenCore' : 'Mining Publications | iGenCore'} />
	<meta name="twitter:description" content={currentLang === 'ES'
		? 'Investigación científica en minería sostenible y tecnología industrial.'
		: 'Scientific research in sustainable mining and industrial technology.'} />
</svelte:head>

<!-- Hero con imagen full-bleed y título superpuesto -->
<section class="relative">
	<img
		src="{base}/images/publishings_img_1.jpg"
		alt="Publicaciones"
		class="w-full h-72 md:h-96 object-cover"
	/>
	<div class="absolute inset-0 bg-black/45 flex items-end px-4 pb-12">
		<div class="max-w-5xl mx-auto w-full">
			<h1 class="text-3xl md:text-5xl font-bold text-white">
				{t(currentLang, 'publishings_intro.main_title')}
			</h1>
		</div>
	</div>
</section>

<!-- Subtítulo + grid de publicaciones -->
<section class="py-20 bg-[#f4f7fb]">
	<div class="max-w-5xl mx-auto px-4 sm:px-6">
		<p class="text-lg text-[#4a6080] leading-relaxed mb-12 max-w-3xl">
			{t(currentLang, 'publishings_intro.main_subtitle')}
		</p>

		<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
			{#each publishings as pub}
				<a href="{base}/publishings/{pub.id}" class="block">
					<div class="bg-white border border-[#d0dce8] rounded-xl p-6 flex gap-4 hover:border-primary-celeste hover:shadow-md transition-all h-full">
						<span class="material-icons flex-shrink-0 mt-1" style="font-size: 1.75rem; color: #1671d8;">
							{pub.icon || 'article'}
						</span>
						<div>
							<h3 class="font-bold text-secondary-azulprofundo text-base mb-2 leading-snug">
								{currentLang === 'ES' ? pub.titleES : pub.titleEN}
							</h3>
							<p class="text-[#4a6080] text-sm leading-relaxed">
								{currentLang === 'ES' ? pub.summaryES : pub.summaryEN}
							</p>
						</div>
					</div>
				</a>
			{/each}
		</div>
	</div>
</section>
