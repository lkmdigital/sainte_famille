class Api {
  static const _host = 'https://saintefamille.malia-pay.com/api/v1';

  static const checkAppVersion = '$_host/get_app_version.php';

  static const operatorStatus = 'http://malia-pay.com/operator_status.php';

  static const checkStatus = "$_host/check_subscription_status.php";

  static const pay =
      'https://saintefamille.malia-pay.com/OnlinePaymentService/add_payer';

  static const paySubscription =
      'https://saintefamille.malia-pay.com/OnlinePaymentService/add_tb_subscription';

  static const _hostArticles = '$_host/articles';
  static const _hostecoles = '$_host/ecoles';
  static const _hosteclasses = '$_host/classes';
  static const _hostUser = '$_host/user';
  static const _hostPaiements = '$_host/paiements';

  static const addArticles = '$_hostArticles/add.php';
  static const getAll = '$_hostecoles/get_all.php';
  static const getAll1 = '$_hosteclasses/get_all.php';
  static const getScolarite = '$_hosteclasses/get_scolarite.php';
  static const getCantine = '$_hosteclasses/get_cantine.php';
  static const getTransport = '$_hosteclasses/get_transport.php';
  static const getKitScolaire = '$_hosteclasses/get_kit.php';
  static const getTenueScolaire = '$_hosteclasses/get_tenues.php';
  static const getSortieScolaire = '$_hosteclasses/get_sortie.php';

  static const checkMatricule = '$_hosteclasses/check_matricule.php';
  static const checkFamilyCode = '$_hostUser/check_family_code.php';

  // getAll User Children by code_famille
  static const getChildren = '$_hostUser/get_children.php';

  static const getExamens = '$_hosteclasses/get_examens.php';
  static const getDevoirs = '$_hosteclasses/get_devoirs.php';
  static const getProfs = '$_hosteclasses/get_profs.php';

  // Articles
  // static const searchShoes = '$_hostShoes/search.php';
  static const getEnfant = '$_hostPaiements/get_enfants.php';
  static const getAllPayment = '$_hostPaiements/get_all.php';
  static const getLastPayment = '$_hostPaiements/last_payment.php';
  static const getMtnCiWebhookStatus = '$_hostPaiements/mtn_ci_webhook.php';

  // User
  static const checkEmail = '$_hostUser/check_email.php';
  static const login = '$_hostUser/login.php';
  static const register = '$_hostUser/register.php';
  static const google = '$_hostUser/google.php';
  static const wave = '$_hostUser/google.php';

  static const passwordRecovery = '$_hostUser/password_recovery.php';
  static const newPassword = '$_hostUser/new_password.php';
}
