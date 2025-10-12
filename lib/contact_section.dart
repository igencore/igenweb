// Archivo: lib/contact_section.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Asegúrate de haber resuelto el pubspec.yaml

import 'translations.dart'; 

class ContactSection extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;
  final VoidCallback onFormTap;

  const ContactSection({
    super.key, 
    required this.languageNotifier,
    required this.onFormTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: languageNotifier,
      builder: (context, language, _) {
        final contactText = appTranslations[language]!;
        final colorScheme = Theme.of(context).colorScheme;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  // === TÍTULO PRINCIPAL ===
                  Text(
                    contactText['contact_title'] ?? 'Contáctanos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface, 
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // === BAJADA DE TEXTO (SUBTÍTULO) ===
                  Text(
                    contactText['contact_subtitle'] ?? 'Estamos listos para conversar sobre tu próximo proyecto minero. Elige la vía que prefieras.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      // CORRECCIÓN DEPRECATED (Línea 51): withOpacity(0.7) -> withAlpha(179)
                      color: colorScheme.onSurface.withAlpha(179),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // === GRILLA DE CONTACTO RESPONSIVA ===
                  _ContactGrid(
                    colorScheme: colorScheme,
                    onFormTap: onFormTap,
                    language: language,
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

class _ContactGrid extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback onFormTap;
  final String language;

  const _ContactGrid({
    required this.colorScheme,
    required this.onFormTap,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 700;
    final contactText = appTranslations[language]!;
    
    final List<Widget> contactItems = [
      // 1. CORREO ELECTRÓNICO
      _ContactCard(
        colorScheme: colorScheme,
        icon: Icons.email_outlined,
        title: contactText['contact_card_email_title'] ?? 'Correo Electrónico',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'info@igencore.cl',
                );
                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                }
              },
              child: Text(
                'contacto@igencore.cl',
                style: TextStyle(
                  fontSize: 16,
                  // CORRECCIÓN DEPRECATED (Línea 115): withOpacity(0.8) -> withAlpha(204)
                  color: colorScheme.onSurface.withAlpha(204),
                  decoration: TextDecoration.underline,
                  // CORRECCIÓN DEPRECATED (Línea 117): withOpacity(0.5) -> withAlpha(128)
                  decorationColor: colorScheme.onSurface.withAlpha(128),
                ),
              ),
            ),
          ],
        ),
      ),
      
      // 2. WHATSAPP
      _ContactCard(
        colorScheme: colorScheme,
        icon: Icons.chat_bubble_outline,
        title: contactText['contact_card_whatsapp_title'] ?? 'WhatsApp',
        child: InkWell(
          onTap: () async {
            const String number = '+56934684985';
            final Uri whatsappUri = Uri.parse('https://wa.me/$number');
            if (await canLaunchUrl(whatsappUri)) {
                await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
            }
          },
          child: Text(
            '+56 9 7373 9696',
            style: TextStyle(
              fontSize: 16,
              // CORRECCIÓN DEPRECATED (Línea 143): withOpacity(0.8) -> withAlpha(204)
              color: colorScheme.onSurface.withAlpha(204),
              decoration: TextDecoration.underline,
              // CORRECCIÓN DEPRECATED (Línea 145): withOpacity(0.5) -> withAlpha(128)
              decorationColor: colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ),
      ),
      
      // 3. LINKEDIN
      _ContactCard(
        colorScheme: colorScheme,
        icon: Icons.alternate_email,
        title: contactText['contact_card_linkedin_title'] ?? 'LinkedIn',
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
              fontSize: 16,
              // CORRECCIÓN DEPRECATED (Línea 169): withOpacity(0.8) -> withAlpha(204)
              color: colorScheme.onSurface.withAlpha(204),
              decoration: TextDecoration.underline,
              // CORRECCIÓN DEPRECATED (Línea 171): withOpacity(0.5) -> withAlpha(128)
              decorationColor: colorScheme.onSurface.withAlpha(128),
            ),
          ),
        ),
      ),
      
      // 4. FORMULARIO DE MENSAJE
      _ContactCard(
        colorScheme: colorScheme,
        icon: Icons.mark_email_unread_outlined,
        title: contactText['contact_card_form_title'] ?? 'Mensaje Directo',
        child: ElevatedButton(
          onPressed: onFormTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.onSurface,
            foregroundColor: colorScheme.surface,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            contactText['contact_card_form_button'] ?? 'Formulario',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contactItems.map((item) => Expanded(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
           child: ConstrainedBox( // AÑADIR CONSTRAINEDBOX para aumentar la altura
            constraints: const BoxConstraints(minHeight: 250), 
            child: item,
          ),
        ))).toList(),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: contactItems.length,
        itemBuilder: (context, index) => contactItems[index],
      );
    }
  }
}

class _ContactCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final IconData icon;
  final String title;
  final Widget child;

  const _ContactCard({
    required this.colorScheme,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: colorScheme.surface, 
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // CORRECCIÓN DEPRECATED (Línea 249): withOpacity(0.1) -> withAlpha(26)
          color: colorScheme.onSurface.withAlpha(26), 
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            // CORRECCIÓN DEPRECATED (Línea 254): withOpacity(0.05) -> withAlpha(13)
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
          // Ícono y Título
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
          
          // Contenido Dinámico
          child,
        ],
      ),
    );
  }
}