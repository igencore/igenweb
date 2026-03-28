import { services } from '$lib/data/services.js';

export const entries = async () => {
	return services.map((service) => ({
		id: service.id
	}));
};

export const prerender = true;
