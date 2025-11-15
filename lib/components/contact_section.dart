// Archivo: lib/components/contact_section.dart (FINAL: TRADUCCIÓN REACTIVA)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:url_launcher/url_launcher.dart'; 

import '../app_shell.dart'; // Necesario para AppState
import '../translations.dart'; // Necesario para appTranslations

class ContactSection extends StatelessWidget {
  final bool showHeader;

  const ContactSection({
    super.key,
    this.showHeader = true, 
  });
  
  // FUNCIÓN AUXILIAR: Construye el título y subtítulo de la sección
  Widget _buildHeaderContent(Map<String, dynamic> translations, ColorScheme colorScheme) {
    final title = translations['contact_cards_title'] as String? ?? 'Medios de Contacto';
    final subtitle = translations['contact_cards_subtitle'] as String? ?? 'Elige el canal que mejor se adapte a tus necesidades.';

    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface, 
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: colorScheme.onSurface.withAlpha(179),
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    // ACCESO AL NOTIFICADOR DE IDIOMA
    final languageNotifier = AppState.of(context).languageNotifier; 
    final colorScheme = Theme.of(context).colorScheme;

    // ✅ Envolvemos el contenido en ValueListenableBuilder para la reactividad.
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, language, child) {
        
        // Obtenemos las traducciones basadas en el idioma actual
        final translations = appTranslations[language] as Map<String, dynamic>? ?? {}; 
        
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  if (showHeader)
                    _buildHeaderContent(translations, colorScheme),
                  
                  // === GRILLA DE CONTACTO RESPONSIVA ===
                  _ContactGrid(
                    colorScheme: colorScheme,
                    translations: translations, 
                  ),
                  
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ----------------------------------------------------------------------
// WIDGET PRIVADO: _ContactGrid
// ----------------------------------------------------------------------

class _ContactGrid extends StatelessWidget {
  final ColorScheme colorScheme;
  final Map<String, dynamic> translations; 

  const _ContactGrid({
    required this.colorScheme,
    required this.translations,
  });
  
  void _handleFormTap(BuildContext context) {
    context.go('/contact'); 
    debugPrint("Navegando a la página de Contacto (/contact)...");
  }

  Widget _buildFormButton(
    BuildContext context, 
    ColorScheme colorScheme,
    bool isDesktop,
  ) {
    // Usa la clave de traducción
    final buttonText = translations['contact_card_form_button'] as String? ?? 'Formulario';
    
    final button = ElevatedButton(
      onPressed: () => _handleFormTap(context), 
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.onSurface,
        foregroundColor: colorScheme.surface,
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 20 : 10, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: isDesktop ? 16 : 12, fontWeight: FontWeight.bold), 
      ),
    );

    if (!isDesktop) {
      return FractionallySizedBox(
        widthFactor: 0.85, 
        alignment: Alignment.centerLeft, 
        child: button,
      );
    }
    return button;
  }
  
  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 700;
    
    final List<Widget> contactItems = [
      // 1. CORREO ELECTRÓNICO
      _ContactCard(
        colorScheme: colorScheme,
        icon: Icons.email_outlined,
        title: translations['contact_card_email_title'] as String? ?? 'Correo Electrónico',
        isDesktop: isDesktop, 
        child: InkWell(
          onTap: () async {
            final Uri emailLaunchUri = Uri(scheme: 'mailto', path: 'contacto@igencore.cl');
            if (await canLaunchUrl(emailLaunchUri)) {
              await launchUrl(emailLaunchUri);
            }
          },
          child: Text(
            'contacto@igencore.cl',
            style: TextStyle(
              fontSize: isDesktop ? 16 : 12, 
              color: colorScheme.onSurface.withAlpha(204),
              decoration: TextDecoration.underline,
              decorationColor: colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ),
      ),
      
      // 2. WHATSAPP
      _ContactCard(
        colorScheme: colorScheme,
        icon: Icons.chat_bubble_outline,
        title: translations['contact_card_whatsapp_title'] as String? ?? 'WhatsApp',
        isDesktop: isDesktop, 
        child: InkWell(
          onTap: () async {
            const String number = '+56934684985';
            final Uri whatsappUri = Uri.parse('https://wa.me/$number');
            if (await canLaunchUrl(whatsappUri)) {
                await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
            }
          },
          child: Text(
            '+56 9 3468 4985',
            style: TextStyle(
              fontSize: isDesktop ? 16 : 14, 
              color: colorScheme.onSurface.withAlpha(204),
              decoration: TextDecoration.underline,
              decorationColor: colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ),
      ),
      
      // 3. LINKEDIN
      _ContactCard(
        colorScheme: colorScheme,
        icon: Icons.alternate_email,
        title: translations['contact_card_linkedin_title'] as String? ?? 'LinkedIn',
        isDesktop: isDesktop, 
        child: InkWell(
          onTap: () async {
            const String linkedinUrl = 'https://www.linkedin.com/company/igencore/';
            final Uri url = Uri.parse(linkedinUrl);
            if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          child: Text(
            'ln/igencore',
            style: TextStyle(
              fontSize: isDesktop ? 16 : 14, 
              color: colorScheme.onSurface.withAlpha(204),
              decoration: TextDecoration.underline,
              decorationColor: colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ),
      ),
      
      // 4. FORMULARIO DE MENSAJE
      _ContactCard(
        colorScheme: colorScheme,
        icon: Icons.mark_email_unread_outlined,
        title: translations['contact_card_form_title'] as String? ?? 'Mensaje Directo',
        isDesktop: isDesktop, 
        child: _buildFormButton(context, colorScheme, isDesktop),
      ),
    ];

    if (isDesktop) {
      // Versión de escritorio (Row)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contactItems.map((item) => Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
           child: item, 
        ))).toList(),
      );
    } else {
      // Versión móvil/tablet (GridView)
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8, 
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 12.0, 
        ),
        itemCount: contactItems.length,
        itemBuilder: (context, index) => contactItems[index],
      );
    }
  }
}

// ----------------------------------------------------------------------
// WIDGET PRIVADO: _ContactCard
// ----------------------------------------------------------------------

class _ContactCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final IconData icon;
  final String title;
  final Widget child;
  final bool isDesktop; 

  const _ContactCard({
    required this.colorScheme,
    required this.icon,
    required this.title,
    required this.child,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final double cardPadding = isDesktop ? 24.0 : 16.0; 
    
    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: colorScheme.surface, 
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.onSurface.withAlpha(26), 
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withAlpha(13),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 36,
                color: colorScheme.onSurface,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 16, 
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
          child,
        ],
      ),
    );
  }
} 