<script>
	import { languageStore } from '$lib/stores/language.js';
	import { t } from '$lib/data/translations.js';
	import { base } from '$app/paths';

	let currentLang = $state('ES');
	let formData = $state({ name: '', email: '', phone: '', message: '' });
	let isSubmitting = $state(false);
	let submitStatus = $state(null);

	languageStore.subscribe((value) => {
		currentLang = value;
	});

	const handleSubmit = async (e) => {
		e.preventDefault();
		isSubmitting = true;
		submitStatus = null;

		const pocketbaseUrl = import.meta.env.VITE_POCKETBASE_URL;

		if (!pocketbaseUrl) {
			submitStatus = {
				type: 'warning',
				message: currentLang === 'ES'
					? 'El servidor de correo no está configurado aún.'
					: 'Email server is not configured yet.'
			};
			isSubmitting = false;
			return;
		}

		try {
			const response = await fetch(`${pocketbaseUrl}/api/collections/igencore_contacts/records`, {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ name: formData.name, email: formData.email, phone: formData.phone, message: formData.message })
			});

			if (response.ok) {
				submitStatus = {
					type: 'success',
					message: currentLang === 'ES'
						? 'Mensaje enviado exitosamente. Nos pondremos en contacto pronto.'
						: 'Message sent successfully. We will contact you soon.'
				};
				formData = { name: '', email: '', phone: '', message: '' };
			} else {
				throw new Error('Network response was not ok');
			}
		} catch (error) {
			submitStatus = {
				type: 'error',
				message: currentLang === 'ES'
					? 'Error al enviar el mensaje. Por favor intenta de nuevo.'
					: 'Error sending message. Please try again.'
			};
		} finally {
			isSubmitting = false;
		}
	};
</script>

<section class="py-20 bg-[#eef2f8]">
	<div class="max-w-4xl mx-auto px-4 sm:px-6">
		<h2 class="text-3xl md:text-4xl font-bold text-center mb-3 text-secondary-azulprofundo">
			{t(currentLang, 'contact.title')}
		</h2>
		<p class="text-center text-[#4a6080] mb-12 max-w-2xl mx-auto">
			{t(currentLang, 'contact.subtitle')}
		</p>

		<!-- Contact Form -->
		<div class="max-w-2xl mx-auto mb-12">
			<form onsubmit={handleSubmit}>
				<div class="mb-5">
					<input
						type="text"
						id="name"
						bind:value={formData.name}
						required
						placeholder={t(currentLang, 'contact.form_name_label')}
						class="w-full px-4 py-3 border border-[#c0cfe0] rounded-lg bg-white text-[#1a2a4a] placeholder-[#8a9ab0] focus:ring-2 focus:ring-primary-celeste focus:border-transparent outline-none"
					/>
				</div>

				<div class="mb-5">
					<input
						type="email"
						id="email"
						bind:value={formData.email}
						required
						placeholder={t(currentLang, 'contact.form_email_label')}
						class="w-full px-4 py-3 border border-[#c0cfe0] rounded-lg bg-white text-[#1a2a4a] placeholder-[#8a9ab0] focus:ring-2 focus:ring-primary-celeste focus:border-transparent outline-none"
					/>
				</div>

				<div class="mb-5">
					<input
						type="tel"
						id="phone"
						bind:value={formData.phone}
						placeholder={t(currentLang, 'contact.form_phone_label')}
						class="w-full px-4 py-3 border border-[#c0cfe0] rounded-lg bg-white text-[#1a2a4a] placeholder-[#8a9ab0] focus:ring-2 focus:ring-primary-celeste focus:border-transparent outline-none"
					/>
				</div>

				<div class="mb-5">
					<textarea
						id="message"
						bind:value={formData.message}
						required
						rows="5"
						placeholder={t(currentLang, 'contact.form_message_label')}
						class="w-full px-4 py-3 border border-[#c0cfe0] rounded-lg bg-white text-[#1a2a4a] placeholder-[#8a9ab0] focus:ring-2 focus:ring-primary-celeste focus:border-transparent outline-none resize-none"
					></textarea>
				</div>

				{#if submitStatus}
					<div
						class="mb-5 p-4 rounded"
						class:bg-green-100={submitStatus.type === 'success'}
						class:text-green-800={submitStatus.type === 'success'}
						class:bg-red-100={submitStatus.type === 'error'}
						class:text-red-800={submitStatus.type === 'error'}
						class:bg-yellow-100={submitStatus.type === 'warning'}
						class:text-yellow-800={submitStatus.type === 'warning'}
					>
						{submitStatus.message}
					</div>
				{/if}

				<button
					type="submit"
					disabled={isSubmitting}
					class="w-full px-6 py-3 bg-accent-amarillo text-black font-bold rounded-lg hover:brightness-110 disabled:opacity-50 transition"
				>
					{isSubmitting
						? (currentLang === 'ES' ? 'Enviando...' : 'Sending...')
						: t(currentLang, 'contact.form_submit_cta')}
				</button>
			</form>
		</div>

		<!-- Contact Cards — 3 cards con datos reales -->
		<div class="grid grid-cols-1 md:grid-cols-3 gap-4">
			<!-- Email -->
			<div class="bg-white border border-[#d0dce8] p-5 rounded-xl text-center hover:border-primary-celeste transition">
				<div class="mb-3">
					<svg class="w-6 h-6 mx-auto text-primary-celeste" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
					</svg>
				</div>
				<h3 class="font-bold mb-2 text-[#1a2a4a] text-sm">{t(currentLang, 'contact.card_email_title')}</h3>
				<a href="mailto:info@igencore.cl" class="text-primary-celeste hover:underline text-sm">
					info@igencore.cl
				</a>
			</div>

			<!-- Teléfonos / WhatsApp -->
			<div class="bg-white border border-[#d0dce8] p-5 rounded-xl text-center hover:border-primary-celeste transition">
				<div class="mb-3">
					<svg class="w-6 h-6 mx-auto text-primary-celeste" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
					</svg>
				</div>
				<h3 class="font-bold mb-2 text-[#1a2a4a] text-sm">{t(currentLang, 'contact.card_whatsapp_title')}</h3>
				<div class="space-y-1">
					<a href="https://wa.me/56974591433" target="_blank" rel="noopener" class="block text-primary-celeste hover:underline text-sm">
						+56 9 7459 1433
					</a>
					<a href="https://wa.me/56934684985" target="_blank" rel="noopener" class="block text-primary-celeste hover:underline text-sm">
						+56 9 3468 4985
					</a>
				</div>
			</div>

			<!-- LinkedIn -->
			<div class="bg-white border border-[#d0dce8] p-5 rounded-xl text-center hover:border-primary-celeste transition">
				<div class="mb-3">
					<svg class="w-6 h-6 mx-auto text-primary-celeste" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1" />
					</svg>
				</div>
				<h3 class="font-bold mb-2 text-[#1a2a4a] text-sm">{t(currentLang, 'contact.card_linkedin_title')}</h3>
				<a href="https://linkedin.com/company/igencore" target="_blank" rel="noopener" class="text-primary-celeste hover:underline text-sm">
					iGenCore
				</a>
			</div>
		</div>

		<!-- Texto asesor -->
		<p class="text-center text-[#4a6080] text-sm mt-8">
			{currentLang === 'ES' ? 'Contacta a uno de nuestros asesores para más información.' : 'Contact one of our advisors for more information.'}
		</p>
	</div>
</section>
