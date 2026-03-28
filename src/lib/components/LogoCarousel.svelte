<script>
	import { base } from '$app/paths';
	import { onMount, onDestroy } from 'svelte';

	const logos = [
		base + '/images/logos/logo1.png',
		base + '/images/logos/logo2.png',
		base + '/images/logos/logo3.png',
		base + '/images/logos/logo4.png',
		base + '/images/logos/logo5.png'
	];

	// Triple para asegurar un loop suave sin saltos visibles
	const allLogos = [...logos, ...logos, ...logos];

	let trackEl;
	let offset = 0;
	let rafId;
	let isPaused = false;
	let singleWidth = 0;

	onMount(() => {
		// Calculamos el ancho de un set de logos (1/3 del total)
		// Esperamos un frame para que el DOM esté listo
		requestAnimationFrame(() => {
			if (trackEl) {
				singleWidth = trackEl.scrollWidth / 3;
			}
			animate();
		});
	});

	onDestroy(() => {
		if (rafId) cancelAnimationFrame(rafId);
	});

	function animate() {
		if (!isPaused && trackEl) {
			offset += 0.5; // velocidad en px/frame
			// Reset suave: cuando hemos avanzado un set completo, volvemos al inicio
			if (offset >= singleWidth) {
				offset -= singleWidth;
			}
			trackEl.style.transform = `translateX(-${offset}px)`;
		}
		rafId = requestAnimationFrame(animate);
	}
</script>

<div
	class="bg-[#eef2f8] py-14 overflow-hidden"
	onmouseenter={() => (isPaused = true)}
	onmouseleave={() => (isPaused = false)}
	role="region"
	aria-label="Clientes"
>
	<div
		bind:this={trackEl}
		class="flex will-change-transform"
		style="width: max-content;"
	>
		{#each allLogos as logo, i}
			<div class="flex items-center justify-center px-10 h-16 flex-shrink-0">
				<img
					src={logo}
					alt="Cliente logo"
					class="h-full max-w-[140px] object-contain"
					style="filter: brightness(0) opacity(0.45);"
				/>
			</div>
		{/each}
	</div>
</div>
