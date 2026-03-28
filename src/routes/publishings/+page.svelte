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
	<title>iGenCore - {t(currentLang, 'nav.publishings')}</title>
	<meta name="description" content={t(currentLang, 'publishings_intro.main_subtitle')} />
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
