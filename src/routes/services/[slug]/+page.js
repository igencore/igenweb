import { services } from '$lib/data/services.js';

export const prerender = true;

export function entries() {
	return services.map((s) => ({ slug: s.slug }));
}
