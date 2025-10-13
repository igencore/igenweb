// Archivo: lib/pages/contact_page.dart (NUEVA PÁGINA DE CONTACTO - SIN DUPLICIDAD DE TÍTULOS)

import 'package:flutter/material.dart';
import '../app_shell.dart'; 
import '../components/footer_section.dart';
// Importamos el componente de contacto. Asumimos que puede recibir un parámetro 'showHeader'.
import '../components/contact_section.dart'; 
import '../translations.dart'; 

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final languageNotifier = AppState.of(context).languageNotifier;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final colorScheme = Theme.of(context).colorScheme;
    
    return SingleChildScrollView(
      child: Container(
        color: backgroundColor,
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        
        child: ValueListenableBuilder<String>(
          valueListenable: languageNotifier,
          builder: (context, language, child) {
            final translations = appTranslations[language] as Map<String, dynamic>? ?? {};

            return Column(
              children: [
                // 1. HEADER (TÍTULO PRINCIPAL - Introducción al Formulario)
                _buildHeader(context, translations, colorScheme),
                
                // 2. FORMULARIO DE CONTACTO
                _buildContactForm(context, translations, colorScheme),
                
                const SizedBox(height: 80),
                
                // 3. SECCIÓN DE CONTACTO (Tarjetas)
                // 🚨 CAMBIO CLAVE: Llamamos a ContactSection indicando que NO muestre su propio título.
                // NOTA: Esto requiere que ContactSection tenga un parámetro 'showHeader'.
                const ContactSection(showHeader: false), 
                
                const SizedBox(height: 80),
                
                // 4. FOOTER
                const FooterSection(),
              ],
            );
          },
        ),
      ),
    );
  }
  
  // ====================================================================
  // WIDGET AUXILIAR: Encabezado (Título y Subtítulo - Sin cambios)
  // ====================================================================

  Widget _buildHeader(BuildContext context, Map<String, dynamic> translations, ColorScheme colorScheme) {
    final title = translations['contact_title'] as String? ?? 'Conversemos Sobre Tu Proyecto';
    final subtitle = translations['contact_subtitle'] as String? ?? 'Estamos listos para conversar sobre tu próximo proyecto minero. Elige la vía que prefieras.';
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // WIDGET AUXILIAR: Formulario de Contacto Simple (Sin cambios)
  // ====================================================================

  Widget _buildContactForm(BuildContext context, Map<String, dynamic> translations, ColorScheme colorScheme) {
    // Claves de traducción para los campos
    final nameLabel = translations['form_name_label'] as String? ?? 'Your Name';
    final emailLabel = translations['form_email_label'] as String? ?? 'Your Email';
    final messageLabel = translations['form_message_label'] as String? ?? 'Your Message';
    final submitCta = translations['form_submit_cta'] as String? ?? 'Send Message';
    
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo Nombre
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: nameLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            
            // Campo Email
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: emailLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            
            // Campo Mensaje
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: messageLabel,
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            
            // Botón de Envío
            ElevatedButton(
              onPressed: () {
                // TODO: Implementar lógica de envío de formulario (API, email, etc.)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Formulario enviado (simulado)')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                submitCta,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}