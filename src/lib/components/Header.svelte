<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { services } from '$lib/data/services.js';
	import { base } from '$app/paths';
	import { page } from '$app/stores';

	let currentLang = $state('ES');
	let mobileMenuOpen = $state(false);
	let servicesMegaOpen = $state(false);
	let megaMenuTimeout = $state(null);

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

	const openMegaMenu = () => {
		if (megaMenuTimeout) clearTimeout(megaMenuTimeout);
		servicesMegaOpen = true;
	};

	const closeMegaMenuDelayed = () => {
		megaMenuTimeout = setTimeout(() => {
			servicesMegaOpen = false;
		}, 150);
	};

	const cancelClose = () => {
		if (megaMenuTimeout) clearTimeout(megaMenuTimeout);
	};

	// Servicios padre con sus hijos agrupados
	let serviceGroups = $derived(
		services
			.filter((s) => s.parent === null)
			.map((parent) => ({
				...parent,
				children: services.filter((s) => s.parent === parent.id)
			}))
	);

	// Título limpio sin número de ID
	function cleanTitle(service) {
		return currentLang === 'ES' ? service.titleES : service.titleEN;
	}

	// Nav items sin Servicios (se maneja por separado con megamenú)
	let navItems = $derived([
		{ href: '/', label: t(currentLang, 'nav.home') },
		{ href: '/about', label: t(currentLang, 'nav.about_us') },
		{ href: '/publishings', label: t(currentLang, 'nav.publishings') },
	]);

	// Imagen decorativa para el megamenú (columna con menos sub-elementos)
	// Geometalurgia tiene 3 hijos, Automatización tiene 3 hijos → usamos la columna de Metalmecánica o Transporte (sin hijos)
	// Ponemos imagen decorativa al lado de "Transporte de Fluidos" (sin sub-items, columna más vacía)
	const megaMenuImage = 'service_flotacion.jpg';
</script>

<!-- Header with white background for light mode -->
<header class="sticky top-0 z-50 bg-white shadow-md">
	<div class="max-w-7xl mx-auto px-4 sm:px-6 py-3 flex justify-between items-center">

		<!-- Izquierda: logo -->
		<div class="flex items-center space-x-3">
			<a href="{base}/" class="flex items-center">
				<img
					src={base + '/images/logoigenblack_hd.png'}
					alt="iGenCore"
					class="h-9 w-auto"
					style="filter: brightness(0) invert(41%) sepia(25%) hue-rotate(178deg) saturate(377%) brightness(75%);"
				/>
			</a>
		</div>

		<!-- Centro: navegación desktop -->
		<nav class="hidden md:flex items-center space-x-8">
			<!-- Inicio -->
			<a
				href="{base}/"
				class="text-[#1a2a4a] text-sm font-medium hover:text-primary-celeste transition flex items-center gap-1"
				class:text-primary-celeste={$page.url.pathname === '/'}
				class:font-bold={$page.url.pathname === '/'}
			>
				{t(currentLang, 'nav.home')}
			</a>

			<!-- Nosotros -->
			<a
				href="{base}/about"
				class="text-[#1a2a4a] text-sm font-medium hover:text-primary-celeste transition flex items-center gap-1"
				class:text-primary-celeste={$page.url.pathname === '/about' || $page.url.pathname.startsWith('/about/')}
				class:font-bold={$page.url.pathname === '/about' || $page.url.pathname.startsWith('/about/')}
			>
				{t(currentLang, 'nav.about_us')}
			</a>

			<!-- Servicios con megamenú -->
			<div
				class="relative"
				onmouseenter={openMegaMenu}
				onmouseleave={closeMegaMenuDelayed}
				role="navigation"
			>
				<button
					class="text-[#1a2a4a] text-sm font-medium hover:text-primary-celeste transition flex items-center gap-1"
					class:text-primary-celeste={$page.url.pathname.startsWith('/services')}
					class:font-bold={$page.url.pathname.startsWith('/services')}
					onclick={() => servicesMegaOpen = !servicesMegaOpen}
					aria-haspopup="true"
					aria-expanded={servicesMegaOpen}
				>
					{t(currentLang, 'nav.services')}
					<svg
						class="w-3 h-3 opacity-70 transition-transform duration-200"
						class:rotate-180={servicesMegaOpen}
						fill="none" stroke="currentColor" viewBox="0 0 24 24"
					>
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7" />
					</svg>
				</button>

				<!-- Megamenú desplegable -->
				{#if servicesMegaOpen}
					<div
						class="absolute left-1/2 -translate-x-1/2 top-full mt-3 bg-white rounded-2xl shadow-2xl border border-[#e0e8f0] overflow-hidden z-50"
						style="width: 780px;"
						onmouseenter={cancelClose}
						onmouseleave={closeMegaMenuDelayed}
						role="menu"
					>
						<!-- Punta decorativa -->
						<div class="absolute -top-2 left-1/2 -translate-x-1/2 w-4 h-4 bg-white border-t border-l border-[#e0e8f0] rotate-45"></div>

						<div class="flex">
							<!-- Columnas de servicios -->
							<div class="flex-1 p-6 grid grid-cols-2 gap-x-6 gap-y-1">
								{#each serviceGroups as group}
									<div class="mb-4">
										<!-- Servicio padre -->
										<a
											href="{base}/services/{group.id}"
											onclick={() => servicesMegaOpen = false}
											class="flex items-center gap-2 px-3 py-2 rounded-lg font-semibold text-sm text-secondary-azulprofundo hover:bg-[#eef2f8] hover:text-primary-celeste transition group"
											role="menuitem"
										>
											<span class="material-icons text-accent-amarillo" style="font-size: 1.1rem;">{group.icon}</span>
											{cleanTitle(group)}
										</a>

										<!-- Sub-servicios -->
										{#if group.children.length > 0}
											<div class="ml-4 mt-0.5 space-y-0.5 border-l-2 border-[#e0e8f0] pl-3">
												{#each group.children as child}
													<a
														href="{base}/services/{child.id}"
														onclick={() => servicesMegaOpen = false}
														class="flex items-center gap-1.5 px-2 py-1.5 rounded-md text-xs text-[#4a6080] hover:text-primary-celeste hover:bg-[#f0f5fb] transition"
														role="menuitem"
													>
														<span class="material-icons opacity-60" style="font-size: 0.85rem;">{child.icon}</span>
														{cleanTitle(child)}
													</a>
												{/each}
											</div>
										{/if}
									</div>
								{/each}
							</div>

							<!-- Imagen decorativa lateral -->
							<div class="w-52 flex-shrink-0 relative overflow-hidden">
								<img
									src="{base}/images/{megaMenuImage}"
									alt="iGenCore servicios"
									class="w-full h-full object-cover"
								/>
								<div class="absolute inset-0 bg-gradient-to-t from-[#0f2c65]/80 via-[#0f2c65]/30 to-transparent"></div>
								<div class="absolute bottom-0 left-0 right-0 p-4">
									<p class="text-white text-xs font-semibold leading-tight opacity-90">
										{currentLang === 'ES' ? 'Soluciones integrales para la minería' : 'Comprehensive mining solutions'}
									</p>
								</div>
							</div>
						</div>
					</div>
				{/if}
			</div>

			<!-- Publicaciones -->
			<a
				href="{base}/publishings"
				class="text-[#1a2a4a] text-sm font-medium hover:text-primary-celeste transition flex items-center gap-1"
				class:text-primary-celeste={$page.url.pathname === '/publishings' || $page.url.pathname.startsWith('/publishings/')}
				class:font-bold={$page.url.pathname === '/publishings' || $page.url.pathname.startsWith('/publishings/')}
			>
				{t(currentLang, 'nav.publishings')}
			</a>

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
			<!-- Inicio y Nosotros -->
			<div class="space-y-1 mb-3">
				<a
					href="{base}/"
					onclick={closeMobileMenu}
					class="flex items-center py-2.5 text-sm font-medium text-[#1a2a4a] hover:text-primary-celeste transition border-b border-[#f0f4f8]"
					class:text-primary-celeste={$page.url.pathname === '/'}
				>
					{t(currentLang, 'nav.home')}
				</a>
				<a
					href="{base}/about"
					onclick={closeMobileMenu}
					class="flex items-center py-2.5 text-sm font-medium text-[#1a2a4a] hover:text-primary-celeste transition border-b border-[#f0f4f8]"
					class:text-primary-celeste={$page.url.pathname === '/about'}
				>
					{t(currentLang, 'nav.about_us')}
				</a>
			</div>

			<!-- Servicios expandibles en mobile -->
			<div class="mb-3">
				<p class="text-xs font-bold text-[#4a6080] uppercase tracking-wider mb-2 px-0">
					{t(currentLang, 'nav.services')}
				</p>
				<div class="space-y-0.5">
					{#each serviceGroups as group}
						<a
							href="{base}/services/{group.id}"
							onclick={closeMobileMenu}
							class="flex items-center gap-2 py-2 px-2 text-sm font-semibold text-secondary-azulprofundo hover:text-primary-celeste rounded-lg hover:bg-[#f0f5fb] transition border-b border-[#f0f4f8]"
						>
							<span class="material-icons text-accent-amarillo" style="font-size: 1rem;">{group.icon}</span>
							{cleanTitle(group)}
						</a>
						{#each group.children as child}
							<a
								href="{base}/services/{child.id}"
								onclick={closeMobileMenu}
								class="flex items-center gap-2 py-1.5 pl-7 text-xs text-[#4a6080] hover:text-primary-celeste rounded hover:bg-[#f0f5fb] transition"
							>
								<span class="material-icons opacity-50" style="font-size: 0.8rem;">{child.icon}</span>
								{cleanTitle(child)}
							</a>
						{/each}
					{/each}
				</div>
			</div>

			<!-- Publicaciones -->
			<div class="space-y-1 mb-5">
				<a
					href="{base}/publishings"
					onclick={closeMobileMenu}
					class="flex items-center py-2.5 text-sm font-medium text-[#1a2a4a] hover:text-primary-celeste transition border-b border-[#f0f4f8]"
					class:text-primary-celeste={$page.url.pathname === '/publishings'}
				>
					{t(currentLang, 'nav.publishings')}
				</a>
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
