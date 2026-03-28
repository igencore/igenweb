<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { base } from '$app/paths';

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});
</script>

<svelte:head>
	<title>iGenCore - {t(currentLang, 'about.title')}</title>
	<meta name="description" content={t(currentLang, 'about.subtitle')} />
</svelte:head>

<!-- Hero con imagen full — título superpuesto, al estilo banner -->
<section class="relative w-full h-[400px] md:h-[480px] overflow-hidden bg-[#0f2c65]">
	<img
		src="{base}/images/about_mision_vision.jpg"
		alt="Sobre iGenCore"
		class="w-full h-full object-cover"
	/>
	<div class="absolute inset-0 bg-gradient-to-r from-[#0f2c65]/80 via-[#0f2c65]/50 to-transparent"></div>
	<div class="absolute inset-0 flex items-center">
		<div class="max-w-7xl mx-auto px-6 sm:px-10 w-full">
			<p class="text-accent-amarillo text-sm font-semibold uppercase tracking-widest mb-3">iGenCore</p>
			<h1 class="text-4xl md:text-5xl lg:text-6xl font-black text-white leading-tight mb-4">
				{t(currentLang, 'about.title')}
			</h1>
			<p class="text-white/80 text-lg max-w-xl">
				{t(currentLang, 'about.subtitle')}
			</p>
		</div>
	</div>
</section>

<!-- Quiénes somos — texto introductorio -->
<section class="py-20 bg-[#f4f7fb]">
	<div class="max-w-4xl mx-auto px-4 sm:px-6">
		<p class="text-lg text-[#1a2a4a] leading-relaxed">
			{t(currentLang, 'about.intro_text')}
		</p>
	</div>
</section>

<!-- Propósito, Misión y Visión -->
<section class="py-20 bg-[#eef2f8]">
	<div class="max-w-4xl mx-auto px-4 sm:px-6 space-y-16">

		<!-- Propósito -->
		<div id="proposito" class="scroll-mt-20">
			<div class="flex items-center gap-4 mb-5">
				<div class="w-12 h-12 bg-primary-celeste rounded-lg flex items-center justify-center flex-shrink-0">
					<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z" />
					</svg>
				</div>
				<h2 class="text-2xl md:text-3xl font-bold text-primary-celeste">
					{t(currentLang, 'about.proposito_title')}
				</h2>
			</div>
			<p class="text-base text-[#1a2a4a] leading-relaxed">
				{t(currentLang, 'about.proposito_text')}
			</p>
		</div>

		<!-- Misión -->
		<div id="mision" class="scroll-mt-20">
			<div class="flex items-center gap-4 mb-5">
				<div class="w-12 h-12 bg-primary-celeste rounded-lg flex items-center justify-center flex-shrink-0">
					<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
					</svg>
				</div>
				<h2 class="text-2xl md:text-3xl font-bold text-primary-celeste">
					{t(currentLang, 'about.mision_title')}
				</h2>
			</div>
			<p class="text-base text-[#1a2a4a] leading-relaxed">
				{t(currentLang, 'about.mision_text')}
			</p>
		</div>

		<!-- Visión -->
		<div id="vision" class="scroll-mt-20">
			<div class="flex items-center gap-4 mb-5">
				<div class="w-12 h-12 bg-primary-celeste rounded-lg flex items-center justify-center flex-shrink-0">
					<svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
					</svg>
				</div>
				<h2 class="text-2xl md:text-3xl font-bold text-primary-celeste">
					{t(currentLang, 'about.vision_title')}
				</h2>
			</div>
			<p class="text-base text-[#1a2a4a] leading-relaxed">
				{t(currentLang, 'about.vision_text')}
			</p>
		</div>

	</div>
</section>
