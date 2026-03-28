<script>
	import { onMount, onDestroy } from 'svelte';

	let canvas;
	let animationId;
	let containerEl;

	onMount(() => {
		const ctx = canvas.getContext('2d');
		let t = 0;

		const COLS = 38;
		const ROWS = 26;

		function resize() {
			if (!containerEl) return;
			canvas.width = containerEl.offsetWidth || 1400;
			canvas.height = containerEl.offsetHeight || 220;
		}

		function draw() {
			resize();
			const W = canvas.width;
			const H = canvas.height;
			ctx.clearRect(0, 0, W, H);

			const originX = W * 0.5;
			const originY = H * 0.58;

			const isoX = 18;
			const isoY = 9;

			for (let row = 0; row < ROWS; row++) {
				for (let col = 0; col < COLS; col++) {
					const gc = col - COLS / 2 + 0.5;
					const gr = row - ROWS / 2 + 0.5;

					const sx = originX + (gc - gr) * isoX;
					const baseY = originY + (gc + gr) * isoY;

					if (sx < -10 || sx > W + 10) continue;

					const dist = Math.sqrt(gc * gc + gr * gr);
					const waveZ = Math.sin(dist * 0.32 - t) * 26;
					const sy = baseY - waveZ;

					// Profundidad: puntos cercanos más opacos y grandes
					const nearness = (row + col) / (ROWS + COLS - 2);
					const alpha = 0.05 + nearness * 0.7;
					const size = 0.3 + nearness * 3.4;

					ctx.beginPath();
					ctx.arc(sx, sy, size, 0, Math.PI * 2);
					// Azul celeste de la marca sobre fondo claro
					ctx.fillStyle = `rgba(22, 113, 216, ${alpha})`;
					ctx.fill();
				}
			}

			t += 0.018;
			animationId = requestAnimationFrame(draw);
		}

		draw();
	});

	onDestroy(() => {
		if (animationId) cancelAnimationFrame(animationId);
	});
</script>

<div bind:this={containerEl} class="w-full h-full overflow-hidden">
	<canvas
		bind:this={canvas}
		class="w-full h-full"
		style="display: block;"
	/>
</div>
