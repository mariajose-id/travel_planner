import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';


class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Planificador de Viajes';

  @override
  String get appTitle => 'Planificador de Viajes';

  @override
  String get auth_signIn => 'Iniciar Sesión';

  @override
  String get auth_signUp => 'Registrarse';

  @override
  String get auth_email => 'Correo Electrónico';

  @override
  String get auth_password => 'Contraseña';

  @override
  String get auth_confirmPassword => 'Confirmar Contraseña';

  @override
  String get auth_forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get auth_noAccount => '¿No tienes una cuenta? ';

  @override
  String get auth_haveAccount => '¿Ya tienes una cuenta? ';

  @override
  String get auth_signInErrorTitle => 'Error al Iniciar Sesión';

  @override
  String get auth_signUpErrorTitle => 'Error al Registrarse';

  @override
  String get home_welcome => 'Bienvenido';

  @override
  String get home_upcomingTrips => 'Próximos Viajes';

  @override
  String get home_recentlyViewed => 'Vistos Recientemente';

  @override
  String get errors_invalidEmail =>
      'Por favor ingresa un correo electrónico válido';

  @override
  String get errors_shortPassword =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get errors_passwordsDontMatch => 'Las contraseñas no coinciden';

  @override
  String get errors_requiredField => 'Este campo es requerido';

  @override
  String get errors_genericError =>
      'Ocurrió un error. Por favor inténtalo de nuevo.';

  @override
  String get signInSubtitle => 'Inicia sesión para continuar';

  @override
  String get welcomeBack => 'Bienvenido de Nuevo';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get or => 'O';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta? Iniciar Sesión';

  @override
  String get fullName => 'Nombre Completo';

  @override
  String get enterFullName => 'Ingresa tu nombre completo';

  @override
  String get enterEmail => 'Ingresa tu correo electrónico';

  @override
  String get enterPassword => 'Ingresa tu contraseña';

  @override
  String get confirmPassword => 'Confirmar Contraseña';

  @override
  String get enterConfirmPassword => 'Confirma tu contraseña';

  @override
  String get createAccountButton => 'Crear Cuenta';

  @override
  String get signInButton => 'Iniciar Sesión';

  @override
  String get joinUsToStartPlanning =>
      'Únete a nosotros para comenzar a planificar';

  @override
  String get fillInDetails => 'Completa tus datos para comenzar';

  @override
  String get journeyStartsHere => 'Tu viaje comienza aquí';

  @override
  String get travelPlannerWelcome => '¡Bienvenido a Planificador de Viajes!';

  @override
  String get signOut => 'Cerrar Sesión';

  @override
  String get failedToSignOut => 'Error al cerrar sesión';

  @override
  String get settings => 'Configuración';

  @override
  String get appSettings => 'App Settings';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get footerAddress =>
      '1234 Adventure Way\nSeattle, WA 98101\nUnited States';

  @override
  String get footerPhoneNumber => '+1 (555) 123-4567';

  @override
  String get footerCompany => 'Wanderly Inc.';

  @override
  String get footerCommunity => 'Wanderly Community';

  @override
  String get footerOwnerCreator => 'Wanderly Team';

  @override
  String get save => 'Save';

  @override
  String get allRightsReserved => 'All rights reserved';

  @override
  String get createdBy => 'Created by';

  @override
  String get profile => 'Perfil';

  @override
  String get manageYourProfile => 'Gestiona tu perfil y preferencias';

  @override
  String get preferences => 'Preferencias';

  @override
  String get theme => 'Tema';

  @override
  String get chooseTheme => 'Elige tu tema preferido';

  @override
  String get language => 'Idioma';

  @override
  String get chooseLanguage => 'Elige tu idioma preferido';

  @override
  String get account => 'Cuenta';

  @override
  String get signOutConfirmation =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get explore => 'Explorar';

  @override
  String get favorites => 'Favoritos';

  @override
  String get yourTrips => 'Tus Viajes';

  @override
  String get errorLoadingTrips => 'Error al cargar los viajes';

  @override
  String get noTripsYet => 'Aún no hay viajes';

  @override
  String get startPlanningNextAdventure =>
      'Empieza a planear tu próxima aventura';

  @override
  String get addTrip => 'Agregar Viaje';

  @override
  String get totalTrips => 'Viajes Totales';

  @override
  String get totalBudget => 'Presupuesto Total';

  @override
  String get planned => 'Planeado';

  @override
  String get ongoing => 'En Curso';

  @override
  String get completed => 'Completado';

  @override
  String get tripDetails => 'Detalles del Viaje';

  @override
  String get searchTrips => 'Buscar Viajes';

  @override
  String get enterTripTitle => 'Ingrese el título del viaje...';

  @override
  String get close => 'Cerrar';

  @override
  String get filterTrips => 'Filtrar Viajes';

  @override
  String get filterByStatus => 'Filtrar por estado';

  @override
  String get clearFilters => 'Limpiar Filtros';

  @override
  String get tripNotFound => 'Viaje no encontrado';

  @override
  String get destination => 'Destino';

  @override
  String get budget => 'Presupuesto';

  @override
  String get status => 'Estado';

  @override
  String get startDate => 'Fecha de Inicio';

  @override
  String get endDate => 'Fecha de Finalización';

  @override
  String get tags => 'Etiquetas';

  @override
  String get tripStatusPlanned => 'Planeado';

  @override
  String get tripStatusOngoing => 'En curso';

  @override
  String get tripStatusCompleted => 'Completado';

  @override
  String get tripStatusCancelled => 'Cancelado';

  @override
  String get addNewTrip => 'Agregar Nuevo Viaje';

  @override
  String get editTrip => 'Editar Viaje';

  @override
  String get delete => 'Eliminar';

  @override
  String get loading => 'Cargando...';

  @override
  String get authenticating => 'Autenticando...';

  @override
  String get connecting => 'Conectando...';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get pageNotFound => 'Página no encontrada';

  @override
  String get thePageYoureLookingForDoesntExist =>
      'La página que buscas no existe.';

  @override
  String get networkError => 'Error de Red';

  @override
  String get pleaseCheckYourInternetConnection =>
      'Por favor verifica tu conexión a internet e intenta de nuevo.';

  @override
  String get serverError => 'Error del Servidor';

  @override
  String get ourServersAreExperiencingIssues =>
      'Nuestros servidores están experimentando problemas. Por favor intenta más tarde.';

  @override
  String get retry => 'Reintentar';

  @override
  String get goHome => 'Ir al Inicio';

  @override
  String get deleteTrip => 'Eliminar Viaje';

  @override
  String deleteTripConfirmation(Object tripTitle) {
    return '¿Estás seguro de que quieres eliminar \"$tripTitle\"?';
  }

  @override
  String get tripTitle => 'Título del Viaje';

  @override
  String get updateTrip => 'Actualizar Viaje';

  @override
  String get description => 'Descripción';

  @override
  String get enterTripDescription => 'Ingrese la descripción del viaje';

  @override
  String get enterDestination => 'Ingrese el destino';

  @override
  String get selectStartDate => 'Seleccionar fecha de inicio';

  @override
  String get selectEndDate => 'Seleccionar fecha de finalización';

  @override
  String get enterBudget => 'Ingrese el presupuesto';

  @override
  String get pleaseEnterTripTitle => 'Por favor ingrese un título de viaje';

  @override
  String get pleaseEnterDescription => 'Por favor ingrese una descripción';

  @override
  String get pleaseEnterDestination => 'Por favor ingrese un destino';

  @override
  String get pleaseSelectStartDate =>
      'Por favor seleccione una fecha de inicio';

  @override
  String get pleaseSelectEndDate =>
      'Por favor seleccione una fecha de finalización';

  @override
  String get pleaseEnterBudget => 'Por favor ingrese un presupuesto';

  @override
  String get pleaseEnterValidNumber => 'Por favor ingrese un número válido';

  @override
  String get toast_welcomeBack => '¡Bienvenido de nuevo!';

  @override
  String get toast_invalidCredentials => 'Correo o contraseña inválidos';

  @override
  String get toast_accountCreated => '¡Cuenta creada exitosamente!';

  @override
  String get toast_signUpFailed => 'Error al crear cuenta';

  @override
  String get toast_selectBothDates =>
      'Por favor selecciona fecha de inicio y fin';

  @override
  String get toast_endDateAfterStart =>
      'La fecha de fin debe ser después de la fecha de inicio';

  @override
  String get toast_tripCreated => '¡Viaje creado exitosamente!';

  @override
  String toast_tripError(Object error) {
    return 'Error: $error';
  }

  @override
  String get toast_unexpectedError => 'Ocurrió un error inesperado';

  @override
  String get nav_home => 'Inicio';

  @override
  String get nav_explore => 'Explorar';

  @override
  String get nav_trips => 'Viajes';

  @override
  String get nav_saved => 'Guardados';

  @override
  String get quickActions => 'Acciones Rápidas';

  @override
  String get viewYourTrips => 'Ver tus viajes';

  @override
  String get recentPlaces => 'Lugares recientes';

  @override
  String get discover => 'Descubrir';

  @override
  String get savedPlaces => 'Lugares guardados';

  @override
  String get recentActivity => 'Actividad Reciente';

  @override
  String get noRecentTrips => 'Sin viajes recientes';

  @override
  String get startPlanning => 'Empieza a planear tu próxima aventura';

  @override
  String get noTrips => 'No trips yet';

  @override
  String get discoverNewPlaces => 'Descubre nuevos lugares';

  @override
  String get favoriteDestinations => 'Tus destinos favoritos';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get tab_profile => 'Perfil';

  @override
  String get tab_preferences => 'Preferencias';

  @override
  String get tab_account => 'Cuenta';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get privacy => 'Privacidad';

  @override
  String get notificationsSettings => 'Configuración de Notificaciones';

  @override
  String get manageNotifications =>
      'Gestiona tus preferencias de notificaciones';

  @override
  String get emailNotifications => 'Notificaciones por Email';

  @override
  String get pushNotifications => 'Notificaciones Push';

  @override
  String get privacySettings => 'Configuración de Privacidad';

  @override
  String get managePrivacy => 'Gestiona tu privacidad y configuración de datos';

  @override
  String get dataUsage => 'Uso de Datos';

  @override
  String get deleteAccount => 'Eliminar Cuenta';

  @override
  String get deleteAccountWarning => 'Esta acción no se puede deshacer';

  @override
  String get deleteAccountConfirmation =>
      '¿Estás seguro de que quieres eliminar tu cuenta? Todos tus datos se eliminarán permanentemente.';

  @override
  String get failedToDeleteAccount => 'Error al eliminar la cuenta';

  @override
  String get signInWithGoogle => 'Continuar con Google';
}
