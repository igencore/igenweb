<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { base } from '$app/paths';

	let currentLang = $state('ES');

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	let year = $derived(new Date().getFullYear());
	let navItems = $derived([
		{ href: '/', label: t(currentLang, 'nav.home') },
		{ href: '/about', label: t(currentLang, 'nav.about_us') },
		{ href: '/services', label: t(currentLang, 'nav.services') },
		{ href: '/publishings', label: t(currentLang, 'nav.publishings') },
		{ href: '/contact', label: t(currentLang, 'nav.contact') }
	]);
</script>

<footer class="bg-[#eef2f8] text-[#1a2a4a] border-t border-[#d0dce8]">
	<div class="max-w-6xl mx-auto px-6 py-12 md:py-16">

		<!-- Desktop: grid 3 columnas | Mobile: logo centrado arriba, luego 2 cols, contacto abajo -->
		<div class="hidden md:grid md:grid-cols-3 gap-8 mb-10">
			<!-- Brand -->
			<div>
				<img src={base + '/images/logoigenblack.png'} alt="iGenCore" class="h-8 mb-4" style="filter: brightness(0) invert(41%) sepia(25%) hue-rotate(178deg) saturate(377%) brightness(75%);" />
				<p class="text-[#4a6080] text-sm leading-relaxed">
					{currentLang === 'ES' ? 'Excelencia operacional en minería.' : 'Operational excellence in mining.'}
				</p>
			</div>

			<!-- Navigation -->
			<div>
				<h4 class="font-semibold mb-4 text-secondary-azulprofundo text-sm uppercase tracking-wide">
					{currentLang === 'ES' ? 'Navegación' : 'Navigation'}
				</h4>
				<nav class="space-y-2">
					{#each navItems as item}
						<a
							href={base + item.href}
							class="text-[#4a6080] hover:text-primary-celeste transition text-sm block"
						>
							{item.label}
						</a>
					{/each}
				</nav>
			</div>

			<!-- Contact -->
			<div>
				<h4 class="font-semibold mb-4 text-secondary-azulprofundo text-sm uppercase tracking-wide">
					{currentLang === 'ES' ? 'Contacto' : 'Contact'}
				</h4>
				<div class="space-y-2 text-sm text-[#4a6080]">
					<p>📧 info@igencore.cl</p>
					<p>📱 +56 9 7459 1433</p>
					<p>📱 +56 9 3468 4985</p>
					<p>🔗 LinkedIn: iGenCore</p>
				</div>
			</div>
		</div>

		<!-- Mobile layout -->
		<div class="md:hidden">
			<!-- Logo centrado -->
			<div class="flex flex-col items-center text-center mb-8">
				<img src={base + '/images/logoigenblack.png'} alt="iGenCore" class="h-9 mb-3" style="filter: brightness(0) invert(41%) sepia(25%) hue-rotate(178deg) saturate(377%) brightness(75%);" />
				<p class="text-[#4a6080] text-sm">
					{currentLang === 'ES' ? 'Excelencia operacional en minería.' : 'Operational excellence in mining.'}
				</p>
			</div>

			<!-- 2 columnas: navegación + contacto -->
			<div class="grid grid-cols-2 gap-6 mb-8">
				<div>
					<h4 class="font-semibold mb-3 text-secondary-azulprofundo text-xs uppercase tracking-wide">
						{currentLang === 'ES' ? 'Navegación' : 'Navigation'}
					</h4>
					<nav class="space-y-2">
						{#each navItems as item}
							<a
								href={base + item.href}
								class="text-[#4a6080] hover:text-primary-celeste transition text-sm block"
							>
								{item.label}
							</a>
						{/each}
					</nav>
				</div>

				<div>
					<h4 class="font-semibold mb-3 text-secondary-azulprofundo text-xs uppercase tracking-wide">
						{currentLang === 'ES' ? 'Contacto' : 'Contact'}
					</h4>
					<div class="space-y-2 text-sm text-[#4a6080]">
						<p>📧 info@igencore.cl</p>
						<p>📱 +56 9 7459 1433</p>
						<p>📱 +56 9 3468 4985</p>
						<p>🔗 iGenCore</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Copyright — compartido desktop y mobile -->
		<div class="border-t border-[#d0dce8] pt-6">
			<div class="flex flex-col md:flex-row justify-between items-center gap-2 text-sm text-[#4a6080]">
				<p>© {year} iGenCore. {t(currentLang, 'footer.copyright')}.</p>
				<p>
					Web dev by <a
						href="https://exosfera.org"
						target="_blank"
						rel="noopener noreferrer"
						class="text-primary-celeste hover:underline"
					>exosfera</a>
				</p>
			</div>
		</div>
	</div>
</footer>
