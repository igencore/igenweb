<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { base } from '$app/paths';
	import { page } from '$app/stores';

	let currentLang = $state('ES');
	let mobileMenuOpen = $state(false);

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	const toggleLanguage = () => {
		languageStore.toggle();
	};

	const toggleMobileMenu = () => {
		mobileMenuOpen = !mobileMenuOpen;
	};

	const closeMobileMenu = () => {
		mobileMenuOpen = false;
	};

	// Nav items without Contacto (it gets a special button treatment)
	let navItems = $derived([
		{ href: '/', label: t(currentLang, 'nav.home') },
		{ href: '/about', label: t(currentLang, 'nav.about_us') },
		{ href: '/services', label: t(currentLang, 'nav.services') },
		{ href: '/publishings', label: t(currentLang, 'nav.publishings') },
	]);
</script>

<!-- Header with white background for light mode -->
<header class="sticky top-0 z-50 bg-white shadow-md">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 py-3 flex justify-between items-center">

		<!-- Izquierda: logo -->
		<div class="flex items-center space-x-3">
			<a href="{base}/" class="flex items-center">
				<img
					src={base + '/images/logoigenblack.png'}
					alt="iGenCore"
					class="h-9 w-auto"
					style="filter: brightness(0) invert(41%) sepia(25%) hue-rotate(178deg) saturate(377%) brightness(75%);"
				/>
			</a>
		</div>

		<!-- Centro: navegación desktop -->
		<nav class="hidden md:flex items-center space-x-8">
			{#each navItems as item}
				<a
					href={base + item.href}
					class="text-[#1a2a4a] text-sm font-medium hover:text-primary-celeste transition flex items-center gap-1"
					class:text-primary-celeste={$page.url.pathname === item.href || $page.url.pathname.startsWith(item.href + '/')}
					class:font-bold={$page.url.pathname === item.href || $page.url.pathname.startsWith(item.href + '/')}
				>
					{item.label}
				</a>
			{/each}

			<!-- Botón Contacto amarillo -->
			<a
				href="{base}/contact"
				class="px-5 py-2 bg-accent-amarillo text-black font-bold text-sm rounded hover:brightness-110 transition"
			>
				{t(currentLang, 'nav.contact')}
			</a>
		</nav>

		<!-- Derecha: selector de idioma -->
		<div class="hidden md:flex items-center">
			<button
				onclick={toggleLanguage}
				class="text-[#1a2a4a] text-sm font-semibold flex items-center gap-1 hover:text-accent-amarillo transition"
			>
				{currentLang}
				<svg class="w-3 h-3 opacity-70" fill="none" stroke="currentColor" viewBox="0 0 24 24">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7" />
				</svg>
			</button>
		</div>

		<!-- Mobile menu button -->
		<button
			onclick={toggleMobileMenu}
			class="md:hidden p-2 text-[#1a2a4a] hover:text-accent-amarillo transition"
			aria-label="Toggle mobile menu"
		>
			<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
			</svg>
		</button>
	</div>

	<!-- Mobile Navigation -->
	{#if mobileMenuOpen}
		<nav class="md:hidden bg-white border-t border-[#d0dce8] px-5 pt-4 pb-5">
			<!-- Links de navegación -->
			<div class="space-y-1 mb-5">
				{#each navItems as item}
					<a
						href={base + item.href}
						onclick={closeMobileMenu}
						class="flex items-center py-2.5 text-sm font-medium text-[#1a2a4a] hover:text-primary-celeste transition border-b border-[#f0f4f8] last:border-0"
						class:text-primary-celeste={$page.url.pathname === item.href}
						class:font-bold={$page.url.pathname === item.href}
					>
						{item.label}
					</a>
				{/each}
			</div>

			<!-- Fila inferior: botón Contacto + toggle idioma -->
			<div class="flex items-center justify-between gap-3 pt-1">
				<a
					href="{base}/contact"
					onclick={closeMobileMenu}
					class="flex-1 text-center px-4 py-2.5 bg-accent-amarillo text-black font-bold text-sm rounded hover:brightness-110 transition"
				>
					{t(currentLang, 'nav.contact')}
				</a>
				<button
					onclick={toggleLanguage}
					class="flex items-center gap-1.5 px-4 py-2.5 border border-[#d0dce8] rounded text-[#1a2a4a] text-sm font-semibold hover:border-primary-celeste hover:text-primary-celeste transition"
				>
					<svg class="w-3.5 h-3.5 opacity-60" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5h12M9 3v2m1.048 9.5A18.022 18.022 0 016.412 9m6.088 9h7M11 21l5-10 5 10M12.751 5C11.783 10.77 8.07 15.61 3 18.129" />
					</svg>
					{currentLang === 'ES' ? 'EN' : 'ES'}
				</button>
			</div>
		</nav>
	{/if}
</header>
