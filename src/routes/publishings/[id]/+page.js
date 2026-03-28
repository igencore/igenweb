import { publishings } from '$lib/data/publishings.js';

export const entries = async () => {
	return publishings.map((pub) => ({
		id: pub.id
	}));
};

export const prerender = true;
