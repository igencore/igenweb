// Archivo: lib/translations.dart (EXPANDIDO CON CLAVES DE SECCIÓN DE TARJETAS, RESEARCH SECTION Y FOOTER)

final Map<String, dynamic> appTranslations = {
  'EN': {
    // ==========================================================
    // CLAVES DE NAVEGACIÓN Y TÍTULOS
    // ==========================================================
    'home': 'Home',
    'about_us': 'About Us',
    'our_mission': 'Our Mission',
    'our_team': 'Our Team',
    'our_trajectory': 'Our Trajectory', 
    'services': 'Services',
    'research': 'Research',
    'contact': 'Contact',
    
    // SERVICES INTRO SECTION
    'services_intro_title': 'Our Comprehensive Solutions', 
    'services_intro_subtitle': 'Advanced engineering and industrial technology to maximize mining efficiency.', 
    'contact_us_cta': 'View Services', 
    
    // HERO SECTION (Añadidas claves por si faltaban)
    'hero_title': 'Mining Operational Excellence',
    'hero_subtitle': 'Driving efficiency and sustainability in every process.',
    'hero_button_text': 'Discover Our Work',

    // CONTACT SECTION
    'contact_title': 'Let\'s Discuss Your Project',
    'contact_subtitle': 'We are ready to talk about your next mining project. Choose your preferred channel.',
    'contact_cards_title': 'Contact Channels',
    'contact_cards_subtitle': 'Choose the channel that best suits your needs.',
    'contact_card_email_title': 'Corporate Email',
    'contact_card_whatsapp_title': 'WhatsApp Contact',
    'contact_card_linkedin_title': 'LinkedIn Network',
    'contact_card_form_title': 'Direct Message Form',
    'contact_card_form_button': 'Send Message',
    
    // NUEVAS CLAVES DE FORMULARIO DE CONTACTO
    'form_name_label': 'Your Name',
    'form_email_label': 'Your Email',
    'form_message_label': 'Your Message',
    'form_submit_cta': 'Send Request',
    
    // ==========================================================
    // FOOTER SECTION 🚨 CLAVES AÑADIDAS
    // ==========================================================
    'footer_copyright': 'All rights reserved',
    'footer_legal_notice': 'Legal Notice',

    // ==========================================================
    // ESTRUCTURA DE INVESTIGACIÓN (RESEARCH SECTION HOME)
    // ==========================================================
    'research_main_title': 'Research for the Mining of Tomorrow',
    'research_main_subtitle': 'Learn about our participation in the technological development of the future.',
    'research_content_title': 'Leading Innovation in Mining 4.0',
    'research_content_body': 'Our team focuses on the research of new materials, process optimization, and development of AI algorithms to improve the safety and productivity of large-scale mining, with an emphasis on sustainability and environmental impact.',
    'research_content_button': 'View Projects',

    // ==========================================================
    // ESTRUCTURA DE SERVICIOS (9 Tarjetas de Valor Comercial)
    // ==========================================================
    'services_data': [
      // 1. Geometallurgy (Principal)
      {
        'title': 'Strategic Geometallurgy and Process Optimization',
        'route': '/services/geometalurgia', 
        'icon': 'precision_manufacturing',
        'summary': 'Comprehensive research and evaluation to maximize mineral and water recovery while drastically reducing operational risks and costs.',
      },
      // 1a. Sub: Flotation Research
      {
        'title': 'Advanced Flotation Optimization',
        'route': '/services/geometalurgia/flotacion',
        'icon': 'insights', // Icono: Insights/Analytics
        'summary': 'We install specialized sensors for simultaneous measurement of gas flow and froth height, creating precise operational baselines for maximum metallurgical efficiency.',
      },
      // 1b. Sub: Clay Modeling
      {
        'title': 'Clay Modeling and Viscosity Control',
        'route': '/services/geometalurgia/arcillas',
        'icon': 'texture', // Icono: Texture/Surface
        'summary': 'High-precision mineralogical examination to determine clay types, offering solutions that significantly reduce acid consumption, viscosity, and operational costs.',
      },
      // 1c. Sub: Reagents
      {
        'title': 'Reagent Analysis and Supply Chain Optimization',
        'route': '/services/geometalurgia/reactivos',
        'icon': 'science', // Icono: Science/Test Tube
        'summary': 'Detailed studies on flocculants and foaming agents to fine-tune thickening, flotation, and ensure optimal recovery of water resources.',
      },
      
      // 2. FLUID TRANSPORTATION (Principal)
      {
        'title': 'High-Efficiency Pumping Systems and Fluid Transport',
        'route': '/services/transporte_fluidos', 
        'icon': 'waves_outlined',
        'summary': 'Supply, commissioning, and continuous monitoring of a wide range of high-quality pumping equipment, complete with a strategic spare parts stock for assured continuity.',
      },
      
      // 3. METAL-MECHANIC (Principal)
      {
        'title': 'Precision Metal-Mechanics and Critical Part Manufacturing',
        'route': '/services/metalmecanica', 
        'icon': 'handyman_outlined',
        'summary': 'Digital scanning and manufacturing of any critical metal part. We optimize alloys and ensure the highest quality casting to guarantee superior durability and operational continuity.',
      },

      // 4. PROCESS AUTOMATION (Principal)
      {
        'title': 'Advanced Industrial Automation and Efficiency',
        'route': '/services/automatizacion', 
        'icon': 'memory_outlined',
        'summary': 'Implement technology to replace hazardous manual tasks, optimizing overall plant efficiency, minimizing errors, and achieving significant time and cost savings.',
      },
      
      // 4a. Sub: Automatic Lubrication
      {
        'title': 'Automatic Lubrication Systems (German Technology)',
        'route': '/services/automatizacion/lubricacion',
        'icon': 'settings_suggest', // Icono: Settings/Suggest
        'summary': 'Devices for hard-to-reach or hazardous points, extending equipment life, reducing downtime due to wear, and optimizing safety and lubricant consumption.',
      },
      
      // 4b. Sub: Remote Monitoring (Wear Prediction) and Pigging
      {
        'title': 'Patented Remote Wear Prediction and Pigging',
        'route': '/services/automatizacion/monitoreo',
        'icon': 'leak_add', // Icono: Leak/Pipeline
        'summary': 'Real-time wear data management for mill/chute liners (no cables/external power). Includes Pigging Stations for safe, high-pressure pipeline inspection and maintenance.',
      },
      
    ],

    // ==========================================================
    // ESTRUCTURA DE INVESTIGACIÓN (RESEARCH PAGE)
    // ==========================================================
    'research_intro_title': 'Scientific Research and Mining Insights',
    'research_intro_subtitle': 'We deepen the challenges of the mining sector and share our data-driven conclusions.',
    'research_read_more_cta': 'Read Full Article',
    
    // Claves para el menú (MANTENIDAS)
    'research_1': 'Sustainable Mining',
    'research_2': 'AI in Flotation',
    'research_3': 'Tailings Management',

    'research_data': [
      {
        'title': 'Sustainable Mining Practices for Arid Regions',
        'summary': 'A comparative study on water recirculation techniques in the Atacama Desert, focusing on maximizing efficiency with minimal environmental impact.',
        'route': '/research/sustainable-mining',
        'icon': 'insights',
      },
      {
        'title': 'The Role of Artificial Intelligence in Flotation Efficiency',
        'summary': 'Research detailing the application of neural networks to predict and adjust flotation parameters in real-time, significantly reducing reagent usage.',
        'route': '/research/ai-flotation',
        'icon': 'psychology',
      },
      {
        'title': 'Innovative Techniques for Dry Tailings Management',
        'summary': 'Analysis of new technologies for the stable and safe confinement of mining waste, emphasizing geotechnical stability and water recovery.',
        'route': '/research/tailings-management',
        'icon': 'science',
      },
      {
        'title': 'Optimizing Energy Consumption in Crushing Plants',
        'summary': 'Evaluation of energy efficiency in primary crushing circuits using advanced dynamic simulation models.',
        'route': '/research/energy-crushing',
        'icon': 'memory_outlined',
      },
    ],
  },
  'ES': {
    // ==========================================================
    // CLAVES DE NAVEGACIÓN Y TÍTULOS
    // ==========================================================
    'home': 'Inicio',
    'about_us': 'Nosotros',
    'our_mission': 'Nuestra Misión',
    'our_team': 'Nuestro Equipo',
    'our_trajectory': 'Trayectoria y Logros', 
    'services': 'Servicios',
    'research': 'Investigación',
    'contact': 'Contacto',
    
    // SERVICES INTRO SECTION
    'services_intro_title': 'Nuestras Soluciones Integrales', 
    'services_intro_subtitle': 'Ingeniería avanzada y tecnología industrial para maximizar la eficiencia en minería.', 
    'contact_us_cta': 'Ver Servicios', 

    // HERO SECTION
    'hero_title': 'Excelencia Operacional en Minería',
    'hero_subtitle': 'Impulsamos la eficiencia y la sostenibilidad en cada proceso.',
    'hero_button_text': 'Descubre Nuestro Trabajo',

    // CONTACT SECTION
    'contact_title': 'Conversemos Sobre Tu Proyecto',
    'contact_subtitle': 'Estamos listos para conversar sobre tu próximo proyecto minero. Elige la vía que prefieras.',
    'contact_cards_title': 'Medios de Contacto',
    'contact_cards_subtitle': 'Elige el canal que mejor se adapte a tus necesidades.',
    'contact_card_email_title': 'Correo Corporativo',
    'contact_card_whatsapp_title': 'Contacto WhatsApp',
    'contact_card_linkedin_title': 'Red LinkedIn',
    'contact_card_form_title': 'Formulario de Mensaje',
    'contact_card_form_button': 'Enviar Mensaje',

    // NUEVAS CLAVES DE FORMULARIO DE CONTACTO
    'form_name_label': 'Tu Nombre',
    'form_email_label': 'Tu Correo Electrónico',
    'form_message_label': 'Tu Mensaje o Consulta',
    'form_submit_cta': 'Enviar Solicitud',
    
    // ==========================================================
    // FOOTER SECTION 🚨 CLAVES AÑADIDAS
    // ==========================================================
    'footer_copyright': 'Todos los derechos reservados',
    'footer_legal_notice': 'Aviso Legal',

    // ==========================================================
    // ESTRUCTURA DE INVESTIGACIÓN (RESEARCH SECTION HOME)
    // ==========================================================
    'research_main_title': 'Investigación para la minería del mañana',
    'research_main_subtitle': 'Conoce nuestra participación en el desarrollo tecnológico del futuro.',
    'research_content_title': 'Liderando la innovación en Minería 4.0',
    'research_content_body': 'Nuestro equipo se enfoca en la investigación de nuevos materiales, optimización de procesos y desarrollo de algoritmos de IA para mejorar la seguridad y la productividad de la minería a gran escala, con un enfoque en la sostenibilidad y el impacto ambiental.',
    'research_content_button': 'Ver Proyectos',

    // ==========================================================
    // ESTRUCTURA DE SERVICIOS (9 Tarjetas de Valor Comercial)
    // ==========================================================
    'services_data': [
      // 1. Geometalurgia (Principal)
      {
        'title': 'Geometalurgia Estratégica y Optimización de Procesos',
        'route': '/services/geometalurgia', 
        'icon': 'precision_manufacturing',
        'summary': 'Investigación y evaluación integral para maximizar la recuperación de mineral y agua, mientras reducimos drásticamente los riesgos y costos operacionales.',
      },
      // 1a. Sub: Flotation Research
      {
        'title': 'Optimización Avanzada de Flotación',
        'route': '/services/geometalurgia/flotacion',
        'icon': 'insights', 
        'summary': 'Instalamos sensores especializados para medición simultánea de flujo de gas y espuma, creando líneas de base operacionales precisas para su máxima eficiencia metalúrgica.',
      },
      // 1b. Sub: Clay Modeling
      {
        'title': 'Modelamiento y Control de Viscosidad por Arcillas',
        'route': '/services/geometalurgia/arcillas',
        'icon': 'texture', 
        'summary': 'Determinación del tipo de arcillas mediante examinación mineralógica de alta precisión, ofreciendo soluciones que reducen significativamente el consumo de ácido, la viscosidad y los costos operativos.',
      },
      // 1c. Sub: Reagents
      {
        'title': 'Análisis y Optimización de Reactivos Químicos',
        'route': '/services/geometalurgia/reactivos',
        'icon': 'science', 
        'summary': 'Estudios detallados de floculantes y espumantes para ajustar con precisión los procesos de espesamiento, flotación y asegurar la recuperación óptima del recurso hídrico.',
      },
      
      // 2. TRANSPORTE DE FLUIDOS (Principal)
      {
        'title': 'Sistemas de Bombeo y Transporte de Fluidos de Alto Rendimiento',
        'route': '/services/transporte_fluidos', 
        'icon': 'waves_outlined',
        'summary': 'Suministro, puesta en marcha y monitoreo continuo de una amplia gama de equipos de bombeo de alta calidad, con stock de repuestos estratégico para asegurar la continuidad operacional.',
      },
      
      // 3. METALMECÁNICA (Principal)
      {
        'title': 'Metalmecánica de Precisión y Fabricación de Piezas Críticas',
        'route': '/services/metalmecanica', // Corregida la ruta faltante de '/'
        'icon': 'handyman_outlined',
        'summary': 'Escaneo digital y fabricación de cualquier pieza metálica crítica. Optimizamos aleaciones y garantizamos fundición de la más alta calidad para una durabilidad superior y continuidad operacional.',
      },

      // 4. AUTOMATIZACIÓN DE PROCESOS (Principal)
      {
        'title': 'Automatización Industrial Avanzada y Eficiencia',
        'route': '/services/automatizacion', 
        'icon': 'memory_outlined',
        'summary': 'Implementamos tecnología para reemplazar tareas manuales de riesgo, optimizando la eficiencia de planta, minimizando errores y logrando ahorros significativos de tiempo y costos.',
      },
      
      // 4a. Sub: Automatic Lubrication
      {
        'title': 'Sistemas de Lubricación Automática (Tecnología Alemana)',
        'route': '/services/automatizacion/lubricacion',
        'icon': 'settings_suggest', 
        'summary': 'Dispositivos para puntos de difícil acceso o peligrosos que extienden la vida útil del equipo, reducen el tiempo de inactividad por desgaste y optimizan la seguridad y consumo de lubricante.',
      },
      
      // 4b. Sub: Remote Monitoring (Wear Prediction) and Pigging
      {
        'title': 'Monitoreo Remoto Patentado y Pigging',
        'route': '/services/automatizacion/monitoreo',
        'icon': 'leak_add', 
        'summary': 'Gestión de datos de desgaste de revestimientos de molinos/chutes en tiempo real (sin cables/alimentación externa). Incluye Pigging Stations para inspección y mantenimiento seguro de tuberías.',
      },
    ],

    // ==========================================================
    // ESTRUCTURA DE INVESTIGACIÓN (RESEARCH PAGE)
    // ==========================================================
    'research_intro_title': 'Investigación Científica e Insights Mineros',
    'research_intro_subtitle': 'Profundizamos en los desafíos del sector minero y compartimos nuestras conclusiones basadas en datos.',
    'research_read_more_cta': 'Leer Artículo Completo',
    
    // Claves para el menú (MANTENIDAS)
    'research_1': 'Minería Sostenible',
    'research_2': 'IA en Flotación',
    'research_3': 'Gestión de Relaves',

    'research_data': [
      {
        'title': 'Prácticas de Minería Sostenible para Regiones Áridas',
        'summary': 'Estudio comparativo sobre técnicas de recirculación de agua en el Desierto de Atacama, enfocándose en maximizar la eficiencia con mínimo impacto ambiental.',
        'route': '/research/mineria-sostenible',
        'icon': 'insights',
      },
      {
        'title': 'El Rol de la Inteligencia Artificial en la Eficiencia de Flotación',
        'summary': 'Investigación que detalla la aplicación de redes neuronales para predecir y ajustar parámetros de flotación en tiempo real, reduciendo significativamente el uso de reactivos.',
        'route': '/research/ia-flotacion',
        'icon': 'psychology',
      },
      {
        'title': 'Técnicas Innovadoras para la Gestión de Relaves Secos',
        'summary': 'Análisis de nuevas tecnologías para la contención estable y segura de residuos mineros, enfatizando la estabilidad geotécnica y la recuperación hídrica.',
        'route': '/research/gestion-relaves',
        'icon': 'science',
      },
      {
        'title': 'Optimización del Consumo Energético en Plantas de Chancado',
        'summary': 'Evaluación de la eficiencia energética en circuitos de chancado primario mediante modelos avanzados de simulación dinámica.',
        'route': '/research/energia-chancado',
        'icon': 'memory_outlined',
      },
    ],
  },
};