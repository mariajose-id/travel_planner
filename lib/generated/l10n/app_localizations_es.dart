// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_title => 'Planificador de Viajes';

  @override
  String get toast_account_created => '¡Cuenta creada exitosamente!';

  @override
  String get label_email => 'Correo Electrónico';

  @override
  String get label_password => 'Contraseña';

  @override
  String get label_confirm_password => 'Confirmar Contraseña';

  @override
  String get label_welcome => 'Bienvenido';

  @override
  String get heading_upcoming_trips => 'Mis Viajes';

  @override
  String get heading_recently_viewed => 'Vistos Recientemente';

  @override
  String get error_invalid_email =>
      'Por favor ingresa un correo electrónico válido';

  @override
  String get error_short_password =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get error_passwords_dont_match => 'Las contraseñas no coinciden';

  @override
  String get error_required_field => 'Este campo es requerido';

  @override
  String get error_generic => 'Ocurrió un error. Por favor inténtalo de nuevo.';

  @override
  String get error_email_exists => 'An account with this email already exists';

  @override
  String get error_user_not_found => 'User not found';

  @override
  String get heading_sign_in_subtitle => 'Inicia sesión para continuar';

  @override
  String get heading_welcome_back => 'Bienvenido de Nuevo';

  @override
  String get heading_create_account => 'Crear Cuenta';

  @override
  String get label_or => 'O';

  @override
  String get label_already_have_account => '¿Ya tienes cuenta? Iniciar Sesión';

  @override
  String get label_full_name => 'Nombre Completo';

  @override
  String get hint_enter_full_name => 'Ingresa tu nombre completo';

  @override
  String get hint_enter_email => 'Ingresa tu correo electrónico';

  @override
  String get hint_enter_password => 'Ingresa tu contraseña';

  @override
  String get hint_confirm_password => 'Confirma tu contraseña';

  @override
  String get action_create_account => 'Crear Cuenta';

  @override
  String get action_sign_in => 'Iniciar Sesión';

  @override
  String get heading_fill_details => 'Completa tus datos para comenzar';

  @override
  String get heading_journey_starts => 'Tu viaje comienza aquí';

  @override
  String get action_sign_out => 'Cerrar Sesión';

  @override
  String get heading_settings => 'Configuración';

  @override
  String get heading_app_settings => 'Ajustes de la Aplicación';

  @override
  String get label_terms_of_service => 'Términos de Servicio';

  @override
  String get label_privacy_policy => 'Política de Privacidad';

  @override
  String get label_contact_us => 'Contáctenos';

  @override
  String get action_cancel => 'Cancelar';

  @override
  String get action_select_date => 'Seleccionar una fecha';

  @override
  String get tab_explore => 'Explorar';

  @override
  String get tab_favorites => 'Favoritos';

  @override
  String get tab_your_trips => 'Tus Viajes';

  @override
  String get error_loading_trips => 'Error al cargar los viajes';

  @override
  String get label_no_recent_trips => 'Sin viajes recientes';

  @override
  String get label_start_planning => 'Empieza a planear tu próxima aventura';

  @override
  String get action_add_trip => 'Añadir Viaje';

  @override
  String get label_total_trips => 'Viajes Totales';

  @override
  String get label_total_budget => 'Presupuesto Total';

  @override
  String get label_status_planned => 'Planeado';

  @override
  String get label_status_ongoing => 'En Curso';

  @override
  String get label_status_completed => 'Completado';

  @override
  String get heading_trip_details => 'Detalles del Viaje';

  @override
  String get action_close => 'Cerrar';

  @override
  String get label_description => 'Descripción';

  @override
  String get hint_enter_trip_description => 'Ingrese la descripción del viaje';

  @override
  String get label_destination => 'Destino';

  @override
  String get hint_enter_destination => 'Ingrese el destino';

  @override
  String get label_start_date => 'Fecha de Inicio';

  @override
  String get label_end_date => 'Fecha de Finalización';

  @override
  String get label_budget => 'Presupuesto';

  @override
  String get label_status => 'Estado';

  @override
  String get action_add_new_trip => 'Agregar Nuevo Viaje';

  @override
  String get heading_edit_trip => 'Editar Viaje';

  @override
  String get action_edit => 'Editar';

  @override
  String get action_delete => 'Eliminar';

  @override
  String get action_retry => 'Reintentar';

  @override
  String get label_trip_title => 'Título del Viaje';

  @override
  String get action_update_trip => 'Actualizar Viaje';

  @override
  String get hint_enter_trip_title => 'Ingrese el título del viaje';

  @override
  String get error_invalid_number => 'Por favor ingrese un número válido';

  @override
  String get toast_welcome_back => '¡Bienvenido de nuevo!';

  @override
  String get error_invalid_credentials => 'Correo o contraseña inválidos';

  @override
  String get toast_trip_created => '¡Viaje creado exitosamente!';

  @override
  String error_trip_generic(String error) {
    return 'Error: $error';
  }

  @override
  String get error_end_date_after_start =>
      'La fecha de fin debe ser después de la fecha de inicio';

  @override
  String get error_select_both_dates =>
      'Por favor selecciona fecha de inicio y fin';

  @override
  String get nav_home => 'Inicio';

  @override
  String get nav_explore => 'Explorar';

  @override
  String get nav_trips => 'Viajes';

  @override
  String get nav_saved => 'Guardados';

  @override
  String get heading_quick_actions => 'Acciones Rápidas';

  @override
  String get label_view_your_trips => 'Ver tus viajes';

  @override
  String get heading_recent_places => 'Lugares recientes';

  @override
  String get heading_saved_places => 'Lugares guardados';

  @override
  String get heading_recent_activity => 'Actividad Reciente';

  @override
  String get heading_profile => 'Perfil';

  @override
  String label_coming_soon(String feature) {
    return '$feature - Próximamente';
  }

  @override
  String get label_status_planned_tag => 'Planeado';

  @override
  String get label_status_ongoing_tag => 'En Curso';

  @override
  String get label_status_completed_tag => 'Completado';

  @override
  String get label_status_cancelled_tag => 'Cancelado';

  @override
  String get action_sign_in_google => 'Continuar con Google';

  @override
  String get tab_profile => 'Perfil';

  @override
  String get tab_preferences => 'Preferencias';

  @override
  String get tab_account => 'Cuenta';

  @override
  String get label_manage_profile => 'Gestiona tu perfil y preferencias';

  @override
  String get label_theme => 'Tema';

  @override
  String get label_choose_theme => 'Elige tu tema preferido';

  @override
  String get label_notifications => 'Notificaciones';

  @override
  String get label_manage_notifications =>
      'Gestiona tus preferencias de notificaciones';

  @override
  String get label_privacy => 'Privacidad';

  @override
  String get label_manage_privacy =>
      'Gestiona tu privacidad y configuración de datos';

  @override
  String get label_language => 'Idioma';

  @override
  String get dialog_sign_out_title =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get action_delete_account => 'Eliminar Cuenta';

  @override
  String get label_delete_account_warning => 'Esta acción no se puede deshacer';

  @override
  String get error_failed_sign_out => 'Error al cerrar sesión';

  @override
  String get dialog_delete_account_confirm =>
      '¿Estás seguro de que quieres eliminar tu cuenta? Todos tus datos se eliminarán permanentemente.';

  @override
  String get error_failed_delete_account => 'Error al eliminar la cuenta';

  @override
  String get action_delete_trip => 'Eliminar Viaje';

  @override
  String dialog_delete_trip_confirm(String tripTitle) {
    return '¿Estás seguro de que quieres eliminar \"$tripTitle\"?';
  }

  @override
  String get label_no_trips => 'No hay viajes aún';

  @override
  String get error_something_went_wrong => 'Algo salió mal';

  @override
  String get action_go_home => 'Ir al Inicio';

  @override
  String get heading_page_not_found => 'Página no encontrada';

  @override
  String get label_page_not_found_desc => 'La página que buscas no existe.';

  @override
  String get label_theme_light => 'Claro';

  @override
  String get label_theme_dark => 'Oscuro';

  @override
  String get label_theme_system => 'Sistema';

  @override
  String get error_network => 'Error de Red';

  @override
  String get error_network_desc =>
      'Por favor verifica tu conexión a internet e intenta de nuevo.';

  @override
  String get error_server => 'Error del Servidor';

  @override
  String get error_server_desc =>
      'Nuestros servidores están experimentando problemas. Por favor intenta más tarde.';

  @override
  String get error_unknown => 'Ocurrió un error desconocido';

  @override
  String get error_timeout => 'La solicitud agotó el tiempo';

  @override
  String get toast_success_generic => 'Operación completada exitosamente';

  @override
  String get heading_personal_info => 'Información Personal';

  @override
  String get label_email_simple => 'Correo';

  @override
  String get label_name => 'Nombre';

  @override
  String get hint_enter_name => 'Ingresa tu nombre';

  @override
  String get heading_edit_profile => 'Editar Perfil';

  @override
  String get action_save => 'Guardar';

  @override
  String get toast_welcome_to_wanderly => '¡Bienvenido a Wanderly!';

  @override
  String get heading_sign_up_subtitle =>
      'Únete a nuestra comunidad de viajeros';

  @override
  String get heading_create_trip => 'Crear Viaje';

  @override
  String get hint_enter_description => 'Ingresa la descripción del viaje';

  @override
  String get hint_enter_budget => 'Ingresa tu presupuesto';

  @override
  String get action_create => 'Crear';

  @override
  String get action_sign_up => 'Registrarse';

  @override
  String get label_confirm_password_simple => 'Confirmar Contraseña';

  @override
  String get hint_confirm_password_simple => 'Confirma tu contraseña';

  @override
  String get error_invalid_name => 'Por favor ingresa un nombre válido';

  @override
  String get label_all => 'Todos';

  @override
  String get heading_welcome => 'Bienvenido';

  @override
  String get label_profile_updated => 'Perfil actualizado exitosamente';

  @override
  String get label_no_changes => 'Sin cambios para guardar';

  @override
  String get error_update_profile => 'Error al actualizar perfil';

  @override
  String get nav_lists => 'Mis Listas';

  @override
  String get label_currency_converter => 'Conversor';

  @override
  String get heading_trip_lists => 'Listas de Viaje';

  @override
  String get label_no_lists => 'No hay listas aún';

  @override
  String get label_add_note => 'Añadir Nota';

  @override
  String get label_add_checklist => 'Añadir Lista de Verificación';

  @override
  String get hint_note_title => 'Título';

  @override
  String get hint_note_content => 'Escribe algo...';

  @override
  String get hint_checklist_item => 'Nuevo elemento';

  @override
  String get label_notes => 'Notas';

  @override
  String get label_checklists => 'Listas de Verificación';

  @override
  String get action_delete_note => 'Eliminar Nota';

  @override
  String get dialog_delete_note_confirm =>
      '¿Estás seguro de que quieres eliminar esta nota?';

  @override
  String label_hello(String name) {
    return 'Hola, $name';
  }

  @override
  String get heading_account_actions => 'Acciones de Cuenta';

  @override
  String get heading_developer_tools => 'Herramientas de Desarrollador';

  @override
  String get label_wanderly_console => 'Consola Wanderly';

  @override
  String get label_wanderly_console_desc =>
      'Inspeccionar registros del sistema y diagnósticos';

  @override
  String get toast_account_deleted => 'Cuenta eliminada exitosamente';

  @override
  String error_failed_delete_account_full(String error) {
    return 'Error al eliminar la cuenta: $error';
  }

  @override
  String get label_manage_data => 'Gestionar permisos del dispositivo';

  @override
  String get label_verified => 'Verificado';
}
