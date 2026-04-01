<script>
	import { base } from '$app/paths';
	import { languageStore } from '$lib/stores/language.js';

	let { id = '', slug = '', title = '', summary = '', icon = '', image = '', isParent = false, isSubService = false, showImage = false } = $props();

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});
</script>

<a href="{base}/services/{slug}" class="block h-full">
	<div
		class="rounded-xl border transition-all duration-300 cursor-pointer h-full flex flex-col hover:shadow-md overflow-hidden"
		class:border-primary-celeste={isParent}
		class:bg-white={isParent}
		class:border-[#d0dce8]={!isParent}
		class:bg-[#f4f7fb]={!isParent}
	>
		<!-- Imagen de servicio (opcional) -->
		{#if showImage && image}
			<div class="w-full h-44 overflow-hidden flex-shrink-0">
				<img
					src="{base}/images/{image}"
					alt={title}
					class="w-full h-full object-cover"
				/>
			</div>
		{/if}

		<!-- Contenido de la card -->
		<div class="p-6 flex flex-col items-center text-center flex-1">
			<span class="material-icons mb-4" style="font-size: 2.5rem; color: #F6BD20;">{icon || 'settings'}</span>
			<h3 class="text-base font-bold text-secondary-azulprofundo mb-3 leading-snug">{title}</h3>
			<p class="text-sm text-[#4a6080] line-clamp-4 flex-1 leading-relaxed">
				{summary}
			</p>
		</div>
	</div>
</a>
