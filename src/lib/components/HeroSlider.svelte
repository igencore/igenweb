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
	let textVisible = $state(true);

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	// Texto actualmente mostrado (se actualiza solo cuando el texto está invisible)
	// Usamos $derived para que capture cambios reactivos de currentLang
	let displayedSlogan = $state(slides[0].sloganES);

	// Duración del fade de texto en ms
	const TEXT_FADE_MS = 400;

	async function goToSlide(index) {
		if (index === currentSlide) return;

		// 1. Fade out del texto
		textVisible = false;

		// 2. Esperar a que termine el fade out, luego cambiar imagen y texto
		await new Promise(r => setTimeout(r, TEXT_FADE_MS));
		currentSlide = index;
		displayedSlogan = currentLang === 'ES' ? slides[index].sloganES : slides[index].sloganEN;

		// 3. Fade in del texto
		textVisible = true;
	}

	// Sincronizar displayedSlogan cuando cambia el idioma
	$effect(() => {
		displayedSlogan = currentLang === 'ES'
			? slides[currentSlide].sloganES
			: slides[currentSlide].sloganEN;
	});

	// Avance automático
	onMount(() => {
		const interval = setInterval(() => {
			goToSlide((currentSlide + 1) % slides.length);
		}, 6000);
		return () => clearInterval(interval);
	});

	// Swipe touch support
	let touchStartX = 0;
	let touchStartY = 0;

	function onTouchStart(e) {
		touchStartX = e.touches[0].clientX;
		touchStartY = e.touches[0].clientY;
	}

	function onTouchEnd(e) {
		const dx = e.changedTouches[0].clientX - touchStartX;
		const dy = e.changedTouches[0].clientY - touchStartY;

		if (Math.abs(dx) > 50 && Math.abs(dx) > Math.abs(dy)) {
			if (dx < 0) {
				goToSlide((currentSlide + 1) % slides.length);
			} else {
				goToSlide((currentSlide - 1 + slides.length) % slides.length);
			}
		}
	}
</script>

<!-- Hero — imagen full width con slogan overlay -->
<section
	class="relative w-full h-[520px] md:h-[620px] overflow-hidden bg-[#0f2c65]"
	aria-label="Hero slider"
	ontouchstart={onTouchStart}
	ontouchend={onTouchEnd}
>

	<!-- Slides (imágenes con fade) -->
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
			<div class="absolute inset-0 bg-gradient-to-r from-[#0f2c65]/80 via-[#0f2c65]/40 to-transparent"></div>
		</div>
	{/each}

	<!-- Contenido sobre la imagen -->
	<div class="relative z-10 h-full flex items-center">
		<div class="max-w-7xl mx-auto px-6 sm:px-10 w-full">
			<div class="max-w-2xl">
				<p class="text-accent-amarillo text-sm font-semibold uppercase tracking-widest mb-4">iGenCore</p>

				<!-- Slogan con fade in/out suave — una sola h1, sin saltos de posición -->
				<h1
					class="text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-black text-white leading-tight mb-6"
					style="transition: opacity {TEXT_FADE_MS}ms ease-in-out; opacity: {textVisible ? 1 : 0};"
				>
					{displayedSlogan}
				</h1>

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
			></button>
		{/each}
	</div>

</section>
