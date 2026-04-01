export const services = [
	{
		id: '1',
		slug: 'geometallurgy',
		titleES: 'Geometalurgia',
		titleEN: 'Geometallurgy',
		summaryES:
			'Servicios de investigación y evaluación de los distintos procedimientos y componentes involucrados en el procesamiento de minerales que permiten optimizar las operaciones, maximizando así la recuperación tanto del mineral valioso como del recurso agua y a su vez disminuyendo los riesgos operacionales.',
		summaryEN:
			'Research and evaluation services for the various procedures and components involved in mineral processing that allow the optimization of operations, thereby maximizing the recovery of both valuable minerals and water resources, while reducing operational risks.',
		icon: 'precision_manufacturing',
		image: 'service_geometalurgia.jpg',
		parent: null
	},
	{
		id: '1a',
		slug: 'flotationresearch',
		titleES: 'Servicio de investigación de flotación',
		titleEN: 'Flotation Research Service',
		summaryES:
			'La optimización del rendimiento metalúrgico de celdas de flotación requiere de la búsqueda de perfiles de flujo de aire y alturas de espuma a lo largo del banco que sean compatibles con las condiciones necesarias para la circulación del flujo volumétrico de alimentación. La dispersión de aire es el proceso más relevante que ocurre en máquinas de flotación. Por ende, diseñamos y fabricamos sensores especialmente desarrollados para medir de forma simultánea y continua el flujo de gas, densidad aparente de la pulpa, altura de espuma y tamaño de burbuja sin entorpecer la operación de las celdas. Los resultados obtenidos nos permiten crear líneas de base operacional en bancos de celdas del circuito de flotación, que a su vez permiten mantener a la celda en su máximo punto operacional.',
		summaryEN:
			'Optimizing the metallurgical performance of flotation cells requires identifying airflow profiles and froth heights along the cell bank that are compatible with the necessary conditions for the feed flow rate. Air dispersion is the most critical process occurring in flotation machines. Therefore, we designed and manufactured sensors that are specially developed to measure simultaneously and continuously gas flow, pulp density, froth height, and bubble size without disrupting the cell operation. The obtained results allow us to establish operational baselines for cell banks within the flotation circuit, which in turn enable us to maintain the cell at its optimal operating point.',
		icon: 'insights',
		image: 'service_flotacion.jpg',
		parent: '1'
	},
	{
		id: '1b',
		slug: 'clayanalysis',
		titleES: 'Modelamiento y análisis de arcillas',
		titleEN: 'Clay minerals modeling and analysis',
		summaryES:
			'La presencia de arcillas puede generar efectos negativos a la hora de concentrar minerales de cobre. En la conminución, disminuye la eficiencia de chancado y molienda debido al incremento de viscosidad. En flotación, se reduce la recuperación y ley de concentrado. En la lixiviación, provocan la formación de aglomerados y aumentan la viscosidad de la pulpa. Mediante la examinación mineralógica de alta precisión, podemos determinar que tipo de arcillas se encuentran presentes y recomendar soluciones que permitan reducir los costos operativos. Además, realizamos modelamiento de control de arcillas para evitar tragedias operacionales.',
		summaryEN:
			'The presence of clays can have negative effects when concentrating copper ores. In comminution, their presence decreases crushing and grinding efficiency due to increased viscosity. In flotation, the recovery and concentrate grade are reduced. In leaching, they cause agglomerate formation and increased pulp viscosity. Through high-precision mineralogical examination, we determine the types of clays present and recommend solutions to reduce operating costs. We also perform clay control modeling to prevent operational disasters.',
		icon: 'texture',
		image: 'service_arcillas.jpg',
		parent: '1'
	},
	{
		id: '1c',
		slug: 'reagentanalysis',
		titleES: 'Análisis de reactivos',
		titleEN: 'Reagent Analysis',
		summaryES:
			'En el área de reactivos, realizamos pruebas y estudios de floculantes y espumantes para así optimizar los procesos operacionales de espesamiento, flotación y recuperación de agua.',
		summaryEN:
			'In the reagent area, we conduct tests and studies on flocculants and foaming agents to optimize the operation processes of thickening, flotation, and water recovery.',
		icon: 'science',
		image: 'service_reactivos.jpg',
		parent: '1'
	},
	{
		id: '3',
		slug: 'metalparts',
		titleES: 'Metalmecánica',
		titleEN: 'Metal Parts Scanning',
		summaryES:
			'Realizamos el levantamiento de cualquier pieza metálica crítica para su posterior fabricación sin la necesidad de ninguna modificación, dando así continuidad operacional. En caso de requerir, optimizamos las aleaciones para así mejorar la durabilidad de la pieza. Nos aseguramos de que el proceso de fundición y mecanizado cumplan con los más altos estándares de calidad.',
		summaryEN:
			"We scan any critical metal part for subsequent manufacturing without the need for any modifications, thus ensuring operational continuity. If necessary, we optimize metal alloys to improve the part's durability. We ensure that the casting and machining process meet the highest quality standards.",
		icon: 'handyman',
		image: 'service_metalmecanica.jpg',
		parent: null
	},
	{
		id: '4',
		slug: 'processautomation',
		titleES: 'Automatización de procesos',
		titleEN: 'Process Automation',
		summaryES:
			'Ofrecemos tecnología para realizar tareas que antes se hacían manualmente, con el objetivo de optimizar la eficiencia, reducir errores, ahorrar tiempo y costos operacionales.',
		summaryEN:
			'We offer technology to perform tasks that were previously performed manually, with the goal of optimizing efficiency, reducing errors, and saving time and operational costs.',
		icon: 'memory',
		image: 'service_automatizacion.jpg',
		parent: null
	},
	{
		id: '4a',
		slug: 'automaticlubrication',
		titleES: 'Lubricación automática',
		titleEN: 'Automatic Lubrication',
		summaryES:
			'En la minería, muchos puntos de lubricación son difíciles de alcanzar o se encuentran en entornos peligrosos. Para ello, ofrecemos dispositivos de lubricación automática para una serie de diferentes aplicaciones. Desde dispositivos electromecánicos, electroquímicos hasta dispositivos con varias líneas de lubricación. Lubricadores automáticos de tecnología alemana que permiten un mayor ahorro de tiempo, menos tiempo de inactividad de las máquinas, menor consumo de lubricante, mayor vida útil y menor riesgo de contaminación e impurezas.',
		summaryEN:
			'In mining, many lubrication points are difficult to reach or located in hazardous environments. Therefore, we offer automatic lubricators for a range of different applications. From electromechanical and electrochemical devices to devices with multiple lubrication lines. Automatic lubricators with German technology enable greater time savings, less machine downtime due to wear, lower lubricant consumption, longer service life, and a lower risk of contamination and impurities.',
		icon: 'settings_suggest',
		image: 'service_lubricacion.jpg',
		parent: '4'
	},
	{
		id: '4b',
		slug: 'monitoringtechnology',
		titleES: 'Tecnología de monitoreo',
		titleEN: 'Monitoring Technology',
		summaryES:
			'Predicción de desgaste de revestimiento de molinos y chute de forma remota. Tecnología que recopila y gestiona datos de desgaste en tiempo real para optimizar y reducir el desgaste de revestimientos en futuras líneas de procesamiento, ahorrando costos operacionales. Esta tecnología patentada monitorea mientras el activo está en funcionamiento sin la necesidad de alimentación externa ni cables. Las "Pigging stations" realizan inspección, limpieza y mantenimiento de tuberías, facilitando el flujo simultáneo de múltiples productos y reduciendo los riesgos operacionales.',
		summaryEN:
			'Remote mill and chute liner wear prediction. This technology collects and manages real-time wear data to optimize and reduce liner wear in future processing lines, saving operational costs. This patented technology monitors the asset while it is operating without the need for external power or cables. Pigging stations inspect, clean, and maintain pipelines, facilitating the simultaneous flow of multiple products and reducing operational risks.',
		icon: 'leak_add',
		image: 'service_monitoreo.jpg',
		parent: '4'
	},
	{
		id: '4c',
		slug: 'fluidcircuitdesign',
		titleES: 'Diseño y fabricación de circuito de fluidos',
		titleEN: 'Fluid Circuit Design and Manufacturing',
		summaryES:
			'Ante la necesidad de facilitar la operación de limpieza en planta concentradora, diseñamos y elaboramos circuitos automatizados de plantas de floculante para relaves de emergencia y planta de molibdeno.',
		summaryEN:
			'Given the need to facilitate cleaning operations at the concentration plant, we design and build automated circuits for flocculant plants for emergency tailings and molybdenum plants.',
		icon: 'water',
		image: 'service_circuito_fluidos.jpg',
		parent: '4'
	},
	{
		id: '2',
		slug: 'fluidtransportation',
		titleES: 'Transporte de fluidos',
		titleEN: 'Fluid Transportation',
		summaryES:
			'Manejo de fluidos mediante bombeo y control de flujo: contamos con altos estándares de manufacturación, ofreciendo una vasta gama de equipos de bombeo y válvulas, en cualquier materialidad y para cualquier tipo de aplicación que el cliente necesite. Nos caracterizamos por priorizar e impulsar la fabricación nacional, fomentando así la economía chilena al generar empleo, reducir la dependencia del mercado externo, y a la vez mejorar la tecnología local. Una vez entregado el activo, nos aseguramos de que este funcione en perfectas condiciones, asesorando su puesta en marcha, manteniendo un servicio de supervisión con tecnología de monitoreo de condiciones y manteniendo un stock de repuesto al alcance del cliente.',
		summaryEN:
			'Fluid handling through pumping and flow control: We maintain high manufacturing standards, offering a wide range of pumping equipment and valves, in any material and for any application the customer may need. We are characterized by prioritizing and promoting national manufacturing, thus fostering the Chilean economy by generating employment, reducing dependence on the foreign market, and simultaneously improving local technology. Once the asset is delivered, we ensure that it functions perfectly, advising on its commissioning, maintaining a monitoring service with condition monitoring technology, and keeping a spare parts inventory readily available to the customer.',
		icon: 'waves',
		image: 'service_transporte_fluidos.jpg',
		parent: null
	}
];
