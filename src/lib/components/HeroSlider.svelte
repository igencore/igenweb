<script>
	import { onMount } from 'svelte';
	import { base } from '$app/paths';
	import { languageStore } from '$lib/stores/language.js';

	const slides = [
		{
			img: '/images/banner1.jpg',
			sloganES: 'Soluciones integrales para la excelencia operacional de la industria minera.',
			sloganEN: 'Comprehensive solutions for operational excellence in the mining industry.'
		},
		{
			img: '/images/banner2.jpg',
			sloganES: 'Soluciones innovadoras para optimizar el procesamiento de minerales.',
			sloganEN: 'Innovative solutions to optimize mineral processing.'
		}
	];

	let currentSlide = $state(0);
	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	onMount(() => {
		const interval = setInterval(() => {
			currentSlide = (currentSlide + 1) % slides.length;
		}, 6000);
		return () => clearInterval(interval);
	});

	const goToSlide = (index) => { currentSlide = index; };
</script>

<!-- Hero — imagen full width con slogan overlay, estilo BHP -->
<section class="relative w-full h-[520px] md:h-[620px] overflow-hidden bg-[#0f2c65]">

	<!-- Slides -->
	{#each slides as slide, index}
		<div
			class="absolute inset-0 transition-opacity duration-1000 ease-in-out"
			class:opacity-100={currentSlide === index}
			class:opacity-0={currentSlide !== index}
		>
			<img
				src="{base}{slide.img}"
				alt="Banner {index + 1}"
				class="w-full h-full object-cover"
			/>
			<!-- Gradiente oscuro sobre la imagen para legibilidad del texto -->
			<div class="absolute inset-0 bg-gradient-to-r from-[#0f2c65]/80 via-[#0f2c65]/40 to-transparent"></div>
		</div>
	{/each}

	<!-- Contenido sobre la imagen -->
	<div class="relative z-10 h-full flex items-center">
		<div class="max-w-7xl mx-auto px-6 sm:px-10 w-full">
			<div class="max-w-2xl">
				<!-- Logo o marca opcional -->
				<p class="text-accent-amarillo text-sm font-semibold uppercase tracking-widest mb-4">iGenCore</p>

				<!-- Slogan dinámico por slide -->
				{#each slides as slide, index}
					<h1
						class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-black text-white leading-tight mb-6 transition-opacity duration-700"
						class:opacity-100={currentSlide === index}
						class:opacity-0={currentSlide !== index}
						style="position: {currentSlide === index ? 'relative' : 'absolute'}; top: 0;"
					>
						{currentLang === 'ES' ? slide.sloganES : slide.sloganEN}
					</h1>
				{/each}

				<a
					href="{base}/services"
					class="inline-block mt-2 px-7 py-3 bg-accent-amarillo text-black font-bold text-sm rounded hover:brightness-110 transition"
				>
					{currentLang === 'ES' ? 'Descubre Nuestros Servicios' : 'Discover Our Services'}
				</a>
			</div>
		</div>
	</div>

	<!-- Indicadores de slide -->
	<div class="absolute bottom-6 left-1/2 -translate-x-1/2 flex space-x-3 z-10">
		{#each slides as _, index}
			<button
				onclick={() => goToSlide(index)}
				class="w-3 h-3 rounded-full transition-all {currentSlide === index ? 'bg-accent-amarillo scale-110' : 'bg-white/50 hover:bg-white/80'}"
				aria-label="Ir a slide {index + 1}"
			/>
		{/each}
	</div>

</section>
