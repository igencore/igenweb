// Archivo: lib/translations.dart (ORGANIZADO POR SECCIÓN Y ACTUALIZADO A PUBLICACIONES)

final Map<String, dynamic> appTranslations = {
  'EN': {
    // ==========================================================
    // 1. CLAVES DE NAVEGACIÓN Y MENÚ (HEADER)
    // ==========================================================
    'home': 'Home',
    'about_us': 'About Us',
    'our_mission': 'Our Mission',
    'our_team': 'Our Team',
    'our_trajectory': 'Our Trajectory', 
    'services': 'Services',
    'publications': 'Publications', 
    'contact': 'Contact',
    
    // ==========================================================
    // 2. HERO SECTION (HOME PAGE)
    // ==========================================================
    'hero_title': 'Mining Operational Excellence',
    'hero_subtitle': 'Driving efficiency and sustainability in every process.',
    'hero_button_text': 'Discover Our Work',

    // ==========================================================
    // 3. SERVICES INTRO SECTION (HOME PAGE)
    // ==========================================================
    'services_intro_title': 'Our Comprehensive Solutions', 
    'services_intro_subtitle': 'Advanced engineering and industrial technology to maximize mining efficiency.', 
    'contact_us_cta': 'View Services', 

    // ==========================================================
    // 4. PUBLISHINGS INTRO SECTION (HOME PAGE) - Usa PublishingsSection
    // ==========================================================
    'publishings_main_title': 'Publications for the Mining of Tomorrow', // Texto ajustado para inglés
    'publishings_main_subtitle': 'Learn about our participation in the technological development of the future.',
    'publishings_content_title': 'Leading Innovation in Mining 4.0',
    'publishings_content_body': 'Our team focuses on the research of new materials, process optimization, and development of AI algorithms to improve the safety and productivity of large-scale mining, with an emphasis on sustainability and environmental impact.',
    'publishings_content_button': 'View Publications', // 🚨 Corregido el texto del botón para la sección principal

    // ==========================================================
    // 5. FOOTER SECTION
    // ==========================================================
    'footer_copyright': 'All rights reserved',
    'footer_legal_notice': 'Legal Notice',

    // ==========================================================
    // 6. CONTACT SECTION
    // ==========================================================
    'contact_title': 'Let\'s Discuss Your Project',
    'contact_subtitle': 'We are ready to talk about your next mining project. Choose your preferred channel.',
    'contact_cards_title': 'Contact Channels',
    'contact_cards_subtitle': 'Choose the channel that best suits your needs.',
    'contact_card_email_title': 'Corporate Email',
    'contact_card_whatsapp_title': 'WhatsApp Contact',
    'contact_card_linkedin_title': 'LinkedIn Network',
    'contact_card_form_title': 'Direct Message Form',
    'contact_card_form_button': 'Send Message',
    
    // Claves de Formulario
    'form_name_label': 'Your Name',
    'form_email_label': 'Your Email',
    'form_message_label': 'Your Message',
    'form_submit_cta': 'Send Request',
    
    // ==========================================================
    // 7. ESTRUCTURA DE SERVICIOS (FLAT - CON ID y TEXTOS COMPLETOS)
    // 🚨 MODIFICADO: Estructura plana con textos completos y ID de subcategoría
    // ==========================================================
    'services_data': [
      // 1. Geometallurgy (Principal)
      {
        'id': '1',
        'title': 'Geometallurgy',
        'route': '/services/geometalurgia', 
        'icon': 'precision_manufacturing',
        'summary': 'Research and evaluation services for the various procedures and components involved in mineral processing that allow the optimization of operations, thereby maximizing the recovery of both valuable minerals and water resources, while reducing operational risks.',
      },
      // 1a. Sub: Flotation Research
      {
        'id': '1a',
        'title': 'Flotation Research Service',
        'route': '/services/geometalurgia/flotacion',
        'icon': 'insights', 
        'summary': 'Optimizing the metallurgical performance of flotation cells requires finding air flow profiles and froth heights within the bank that are compatible with the necessary conditions for the circulation of the feed volumetric flow. Air dispersion is the most important process occurring in flotation machines. Therefore, we perform simultaneous and continuous measurement of gas flow, apparent density of pulp, and froth height, in addition to frequent spot measurements of pulp density, gas content, and bubble size in all cells within a bank. These measurements are carried out using sensors specifically developed for characterizing the operation of cells that process mineral slurries. The results obtained allow us to create operational baselines for cell banks in the flotation circuit, which in turn allow the cell to perform at its highest operating point.',
      },
      // 1b. Sub: Clay Modeling
      {
        'id': '1b',
        'title': 'Clay minerals modeling and analysis',
        'route': '/services/geometalurgia/arcillas',
        'icon': 'texture', 
        'summary': 'The presence of clays can have negative effects when concentrating copper ores. Therefore, in comminution, their presence decreases crushing and grinding efficiency due to increased viscosity. In flotation, the recovery and concentrate grade are reduced due to the reduced floatability of the copper ores. Moreover, in leaching, they cause the formation of agglomerates and increase pulp viscosity, which negatively impacts copper recovery and generates greater sulfuric acid consumption. Through high-precision mineralogical examination, we can determine the types of mineral clays present and, based on this, analyze and recommend solutions that primarily reduce operating costs. We also perform clay control modeling to prevent operational disasters.',
      },
      // 1c. Sub: Reagents
      {
        'id': '1c',
        'title': 'Reagent Analysis',
        'route': '/services/geometalurgia/reactivos',
        'icon': 'science', 
        'summary': 'In the reagent area, we conduct tests and studies on flocculants and foaming agents to optimize the operation processes of thickening, flotation, and water recovery.',
      },
      
      // 2. FLUID TRANSPORTATION (Principal)
      {
        'id': '2',
        'title': 'Fluid Transportation',
        'route': '/services/transporte_fluidos', 
        'icon': 'waves_outlined',
        'summary': 'Fluid handling through different kinds of pumps: we maintain high manufacturing standards, offering a wide range of pumping equipment, in any material and for any type of application that clients may require. Once the asset is delivered, we ensure it operates in perfect condition, advising on its commissioning, maintaining a supervision service with condition monitoring technology, and keeping a stock of spare parts available if necessary. For more information about our catalog, contact us.',
      },
      
      // 3. METAL-MECHANIC (Principal)
      {
        'id': '3',
        'title': 'Metal parts scanning',
        'route': '/services/metalmecanica', 
        'icon': 'handyman_outlined',
        'summary': 'We scan any critical metal part for subsequent manufacturing without the need for any modifications, thus ensuring operational continuity. If necessary, we optimize metal alloys to improve the part\'s durability. We ensure that the casting and machining process meet the highest quality standards.',
      },

      // 4. PROCESS AUTOMATION (Principal)
      {
        'id': '4',
        'title': 'Process Automation',
        'route': '/services/automatizacion', 
        'icon': 'memory_outlined',
        'summary': 'We offer technology to perform tasks that were previously performed manually, with the goal of optimizing efficiency, reducing errors, and saving time and operational costs.',
      },
      
      // 4a. Sub: Automatic Lubrication
      {
        'id': '4a',
        'title': 'Automatic Lubrication',
        'route': '/services/automatizacion/lubricacion',
        'icon': 'settings_suggest', 
        'summary': 'In mining, many lubrication points are difficult to reach or located in hazardous environments. Therefore, we offer automatic lubricators for a range of different applications. From electromechanical and electrochemical devices to devices with multiple lubrication lines. Automatic lubricators with German technology enable greater time savings, less machine downtime due to wear, lower lubricant consumption, longer service life, lubricant discharge based on operational needs, and a lower risk of contamination and impurities. This optimizes work safety and facilitates control and monitoring. For more information about our catalog, contact us.',
      },
      
      // 4b. Sub: Remote Monitoring (Wear Prediction) and Pigging
      {
        'id': '4b',
        'title': 'Monitoring Technology',
        'route': '/services/automatizacion/monitoreo',
        'icon': 'leak_add', 
        'summary': 'Remote mill and chute liner wear prediction. This technology collects and manages real-time wear data to optimize and reduce liner wear in future processing lines, thereby saving operational costs. This patented technology monitors the asset while it is operating without the need for external power or cables. Pigging stations inspect, clean, and maintain pipelines, and facilitate the simultaneous flow of multiple products. They reduce operational risks and facilitate maintenance while becoming a reliable and safe option for pipeline managing. For more information about our technologies, contact us.',
      },

      // 4c. Sub: Fluid Circuit Design
      {
        'id': '4c',
        'title': 'Fluid Circuit Design and Manufacturing',
        'route': '/services/automatizacion/diseno-fluidos',
        'icon': 'waves_outlined', 
        'summary': 'Given the need to facilitate cleaning operations at the concentration plant, we design and build automated circuits for flocculant plants for emergency tailings and molybdenum plants.',
      },
    ],

    // ==========================================================
    // 8. ESTRUCTURA DE PUBLICACIONES (PUBLISHINGS PAGE)
    // ==========================================================
    'publishings_intro_title': 'Scientific Publications and Mining Insights',
    'publishings_intro_subtitle': 'We deepen the challenges of the mining sector and share our data-driven conclusions.',
    'publishings_read_more_cta': 'Read Full Article',
    
    // 🚨 CLAVES DE MENÚ ANTIGUAS ELIMINADAS (research_1, research_2, research_3)

    'publishings_data': [
      {
        'title': 'Sustainable Mining Practices for Arid Regions',
        'summary': 'A comparative study on water recirculation techniques in the Atacama Desert, focusing on maximizing efficiency with minimal environmental impact.',
        'route': '/publishings/sustainable-mining', 
        'icon': 'insights',
      },
      {
        'title': 'The Role of Artificial Intelligence in Flotation Efficiency',
        'summary': 'Research detailing the application of neural networks to predict and adjust flotation parameters in real-time, significantly reducing reagent usage.',
        'route': '/publishings/ai-flotation', 
        'icon': 'psychology',
      },
      {
        'title': 'Innovative Techniques for Dry Tailings Management',
        'summary': 'Analysis of new technologies for the stable and safe confinement of mining waste, emphasizing geotechnical stability and water recovery.',
        'route': '/publishings/tailings-management', 
        'icon': 'science',
      },
      {
        'title': 'Optimizing Energy Consumption in Crushing Plants',
        'summary': 'Evaluation of energy efficiency in primary crushing circuits using advanced dynamic simulation models.',
        'route': '/publishings/energy-crushing', 
        'icon': 'memory_outlined',
      },
    ],
  },
  'ES': {
    // ==========================================================
    // 1. CLAVES DE NAVEGACIÓN Y MENÚ (HEADER)
    // ==========================================================
    'home': 'Inicio',
    'about_us': 'Nosotros',
    'our_mission': 'Nuestra Misión',
    'our_team': 'Nuestro Equipo',
    'our_trajectory': 'Trayectoria y Logros', 
    'services': 'Servicios',
    'publishings': 'Publicaciones',
    'contact': 'Contacto',
    
    // ==========================================================
    // 2. HERO SECTION (HOME PAGE)
    // ==========================================================
    'hero_title': 'Excelencia Operacional en Minería',
    'hero_subtitle': 'Impulsamos la eficiencia y la sostenibilidad en cada proceso.',
    'hero_button_text': 'Descubre Nuestro Trabajo',

    // ==========================================================
    // 3. SERVICES INTRO SECTION (HOME PAGE)
    // ==========================================================
    'services_intro_title': 'Nuestras Soluciones Integrales', 
    'services_intro_subtitle': 'Ingeniería avanzada y tecnología industrial para maximizar la eficiencia en minería.', 
    'contact_us_cta': 'Ver Servicios', 

    // ==========================================================
    // 4. PUBLISHINGS INTRO SECTION (HOME PAGE) - Usa PublishingsSection
    // ==========================================================
    'publishings_main_title': 'Publicaciones para la minería del mañana',
    'publishings_main_subtitle': 'Conoce nuestras publicaciones sobre el desarrollo tecnológico y futuro de la industria.',
    'publishings_content_title': 'Liderando la innovación en Minería 4.0',
    'publishings_content_body': 'Nuestro equipo se enfoca en la investigación de nuevos materiales, optimización de procesos y desarrollo de algoritmos de IA para mejorar la seguridad y la productividad de la minería a gran escala, con un enfoque en la sostenibilidad y el impacto ambiental.',
    'publishings_content_button': 'Ver Publicaciones',

    // ==========================================================
    // 5. FOOTER SECTION
    // ==========================================================
    'footer_copyright': 'Todos los derechos reservados',
    'footer_legal_notice': 'Aviso Legal',

    // ==========================================================
    // 6. CONTACT SECTION
    // ==========================================================
    'contact_title': 'Conversemos Sobre Tu Proyecto',
    'contact_subtitle': 'Estamos listos para conversar sobre tu próximo proyecto minero. Elige la vía que prefieras.',
    'contact_cards_title': 'Medios de Contacto',
    'contact_cards_subtitle': 'Elige el canal que mejor se adapte a tus necesidades.',
    'contact_card_email_title': 'Correo Corporativo',
    'contact_card_whatsapp_title': 'Contacto WhatsApp',
    'contact_card_linkedin_title': 'Red LinkedIn',
    'contact_card_form_title': 'Formulario de Mensaje',
    'contact_card_form_button': 'Enviar Mensaje',

    // Claves de Formulario
    'form_name_label': 'Tu Nombre',
    'form_email_label': 'Tu Correo Electrónico',
    'form_message_label': 'Tu Mensaje o Consulta',
    'form_submit_cta': 'Enviar Solicitud',
    
    // ==========================================================
    // 7. ESTRUCTURA DE SERVICIOS (FLAT - CON ID y TEXTOS COMPLETOS)
    // 🚨 MODIFICADO: Estructura plana con textos completos y ID de subcategoría
    // ==========================================================
    'services_data': [
      // 1. Geometalurgia (Principal)
      {
        'id': '1',
        'title': 'Geometalurgia',
        'route': '/services/geometalurgia', 
        'icon': 'precision_manufacturing',
        'summary': 'Servicios de investigación y evaluación de los distintos procedimientos y componentes involucrados en el procesamiento de minerales que permiten optimizar las operaciones, maximizando así la recuperación tanto del mineral valioso como del recurso agua y a su vez disminuyendo los riesgos operacionales.',
      },
      // 1a. Sub: Flotation Research
      {
        'id': '1a',
        'title': 'Servicio de investigación de flotación',
        'route': '/services/geometalurgia/flotacion',
        'icon': 'insights', 
        'summary': 'La optimización del rendimiento metalúrgico de celdas de flotación requiere de la búsqueda de perfiles de flujo de aire y alturas de espuma a lo largo del banco que sean compatibles con las condiciones necesarias para la circulación del flujo volumétrico de alimentación. La dispersión de aire es el proceso más relevante que ocurre en máquinas de flotación. Por ende, realizamos la medición simultánea y continua del flujo de gas, densidad aparente de la pulpa, y altura de espuma, además de mediciones puntuales frecuentes de densidad de pulpa, contenido de gas, y tamaño de burbuja en todas las celdas de un banco. Estas mediciones se llevan a cabo mediante la implementación de sensores que han sido especialmente desarrollados para la caracterización de la operación de celdas que procesan pulpas minerales. Los resultados obtenidos nos permiten crear líneas de base operacional en bancos de celdas del circuito de flotación, que a su vez permiten mantener a la celda en su máximo punto operacional.',
      },
      // 1b. Sub: Clay Modeling
      {
        'id': '1b',
        'title': 'Modelamiento y análisis de arcillas',
        'route': '/services/geometalurgia/arcillas',
        'icon': 'texture', 
        'summary': 'La presencia de arcillas puede generar efectos negativos a la hora de concentrar minerales de cobre. Por ende, en la conminución, la presencia de estas disminuye la eficiencia de chancado y molienda debido al incremento de viscosidad. En flotación, se reduce la recuperación y ley de concentrado debido a la reducción de flotabilidad de los minerales de cobre, por otra parte, en la lixiviación, provocan la formación de aglomerados y aumentan la viscosidad de la pulpa, lo que impacta negativamente la recuperación del cobre, generando mayor consumo de ácido sulfúrico. Mediante la examinación mineralógica de alta precisión, podemos determinar que tipo de arcillas se encuentran presentes y en base a esto, analizar y recomendar soluciones que permitan principalmente reducir los costos operativos. Además, realizamos modelamiento de control de arcillas para así evitar las tragedias operacionales.',
      },
      // 1c. Sub: Reagents
      {
        'id': '1c',
        'title': 'Análisis de reactivos',
        'route': '/services/geometalurgia/reactivos',
        'icon': 'science', 
        'summary': 'En el área de reactivos, realizamos pruebas y estudios de floculantes y espumantes para así optimizar los procesos operacionales de espesamiento, flotación y recuperación de agua.',
      },
      
      // 2. TRANSPORTE DE FLUIDOS (Principal)
      {
        'id': '2',
        'title': 'Transporte de fluidos',
        'route': '/services/transporte_fluidos', 
        'icon': 'waves_outlined',
        'summary': 'Manejo de fluidos mediante bombeo: contamos con altos estándares de manufacturación, ofreciendo una basta gama de equipos de bombeo, en cualquier materialidad y para cualquier tipo de aplicación que el cliente necesite. Una vez entregado el activo, nos aseguramos de que este funcione en perfectas condiciones, asesorando su puesta en marcha, manteniendo un servicio de supervisión con tecnología de monitoreo de condiciones y manteniendo un stock de repuesto al alcance del cliente en caso de que de que lo necesite. Para más información de nuestro catálogo, contáctanos.',
      },
      
      // 3. METALMECÁNICA (Principal)
      {
        'id': '3',
        'title': 'Metalmecánica',
        'route': '/services/metalmecanica', 
        'icon': 'handyman_outlined',
        'summary': 'Realizamos el levantamiento de cualquier pieza metálica crítica para su posterior fabricación sin la necesidad de ninguna modificación, dando así continuidad operacional. En caso de requerir, optimizamos las aleaciones para así mejorar la durabilidad de la pieza. Nos aseguramos de que el proceso de fundición y mecanizado cumplan con los más altos estándares de calidad.',
      },

      // 4. AUTOMATIZACIÓN DE PROCESOS (Principal)
      {
        'id': '4',
        'title': 'Automatización de procesos',
        'route': '/services/automatizacion', 
        'icon': 'memory_outlined',
        'summary': 'Ofrecemos tecnología para realizar tareas que antes se hacían manualmente, con el objetivo de optimizar la eficiencia, reducir errores, ahorrar tiempo y costos operacionales.',
      },
      
      // 4a. Sub: Automatic Lubrication
      {
        'id': '4a',
        'title': 'Lubricación automática',
        'route': '/services/automatizacion/lubricacion',
        'icon': 'settings_suggest', 
        'summary': 'En la minería, muchos puntos de lubricación son difíciles de alcanzar o se encuentran en entornos peligrosos, para ello, ofrecemos dispositivos de lubricación automática para una serie de diferentes aplicaciones. Desde dispositivos electromecánicos, eletroquímicos hasta dispositivos con varias líneas de lubricación. Lubricadores automáticos de tecnología alemana que permiten un mayor ahorro de tiempo, menos tiempo de inactividad de las máquinas debido a desgaste, menor consumo de lubricante, mayor vida útil, descarga de lubricante en función de las necesidades operacionales, menor riesgo de contaminación e impurezas. Por lo que se optimiza la seguridad en el trabajo y facilita el control y supervisión. Para más información de nuestro catálogo, contáctanos.',
      },
      
      // 4b. Sub: Remote Monitoring (Wear Prediction) and Pigging
      {
        'id': '4b',
        'title': 'Tecnología de monitoreo',
        'route': '/services/automatizacion/monitoreo',
        'icon': 'leak_add', 
        'summary': 'Predicción de desgaste de revestimiento de molinos y chute de forma remota. Tecnología que recopila y gestiona datos de desgaste en tiempo real para optimizar y reducir el desgaste de revestimientos en futuras líneas de procesamientos y así ahorrar costos operacionales. Esta tecnología patentada monitorea mientras el activo está en funcionamiento sin la necesidad de alimentación externa ni cables. Las “Pigging stations” (balas a alta presión) realizan inspección, limpieza y mantenimiento de tuberías, y facilitan el flujo simultáneo de múltiples productos. Disminuyen los riesgos operaciones y facilitan el mantenimiento al ser una opción confiable y segura. Para más información de nuestras tecnologías, contáctanos.',
      },

      // 4c. Sub: Fluid Circuit Design
      {
        'id': '4c',
        'title': 'Diseño y fabricación de circuito de fluidos',
        'route': '/services/automatizacion/diseno-fluidos',
        'icon': 'waves_outlined', 
        'summary': 'Ante la necesidad de facilitar la operación de limpieza en planta concentradora, diseñamos y elaboramos circuitos automatizados de plantas de floculante para relaves de emergencia y planta de molibdeno.',
      },
    ],

    // ==========================================================
    // 8. ESTRUCTURA DE PUBLICACIONES (PUBLISHINGS PAGE)
    // ==========================================================
    'publishings_intro_title': 'Publicaciones Científicas e Insights Mineros',
    'publishings_intro_subtitle': 'Profundizamos en los desafíos del sector minero y compartimos nuestras conclusiones basadas en datos.',
    'publishings_read_more_cta': 'Leer Artículo Completo',
    
    // 🚨 CLAVES DE MENÚ ANTIGUAS ELIMINADAS

    'publishings_data': [
      {
        'title': 'Prácticas de Minería Sostenible para Regiones Áridas',
        'summary': 'Estudio comparativo sobre técnicas de recirculación de agua en el Desierto de Atacama, enfocándose en maximizar la eficiencia con mínimo impacto ambiental.',
        'route': '/publishings/mineria-sostenible', 
        'icon': 'insights',
      },
      {
        'title': 'El Rol de la Inteligencia Artificial en la Eficiencia de Flotación',
        'summary': 'Investigación que detalla la aplicación de redes neuronales para predecir y ajustar parámetros de flotación en tiempo real, reduciendo significativamente el uso de reactivos.',
        'route': '/publishings/ia-flotacion', 
        'icon': 'psychology',
      },
      {
        'title': 'Técnicas Innovadoras para la Gestión de Relaves Secos',
        'summary': 'Análisis de nuevas tecnologías para la contención estable y segura de residuos mineros, enfatizando la estabilidad geotécnica y la recuperación hídrica.',
        'route': '/publishings/gestion-relaves', 
        'icon': 'science',
      },
      {
        'title': 'Optimización del Consumo Energético en Plantas de Chancado',
        'summary': 'Evaluación de la eficiencia energética en circuitos de chancado primario mediante modelos avanzados de simulación dinámica.',
        'route': '/publishings/energia-chancado', 
        'icon': 'memory_outlined',
      },
    ],
  },
};