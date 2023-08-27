const baseUrl = 'http://upkeepplus.tech/api/';

const endPointCities = "getAllCountry";

const endPointProposeNewService = "ProposeNewService";
const endPointGetAllMyPropose = "getAllMyPropose";

class EndPointAuth {
  static const signup = 'register';
  static const verifyPinSignup = 'email/verify';
  static const resendPin = 'resend/email/token';
  static const loginCustomer = 'login';
  static const loginProvider = 'loginFoundation';

  static const changePassword = 'changePassword';
  static const logout = 'logout';

  static const forgotPassword = 'forgot-password';
  static const verifyPinForgetPassword = 'verify/pin';
}

class EndPointFoundations {
  static const filterFoundations = 'filterWithService';
  static const getAllFoundationsForOwner = 'getAllFoundationForOwner';
  static const foundationFilter = 'FoundationFilter';
}

class EndPointServices {
  static const getAllServiceForFoundation = 'getAllServiceForFoundation';
  static const reservationService = 'ReservationService';
  static const stopService = 'stopService';
  static const editService = 'editService';
  static const addServiceToFoundation = 'addServiceToFoundation';
  static const getAvailableTime = 'getAvailableTime';
}

class EndPointAdsJobs {
  static const getAdsSliders = 'getAdsSliders';
  static const getJobsSliders = 'getJobSliders';

  static const showAllAdsForFoundation = 'showAllAdsForFoundation';

  static const addJob = 'addJob';
  static const deleteJob = 'deleteJob';
  static const editJob = 'editJob';
  static const showAllJobForFoundation = 'showAllJobForFoundation';
}

class EndPointCategories {
  static const getAllServiceInSystem = 'getAllServiceInSystem';
  static const getAllSubServiceInSystem = 'getAllSubServiceInSystem';
}

class EndPointOrders {
  static const getAllOrder = 'getAllOrder';
  static const cancelOrder = 'cancelOrder';
  static const setAssessment = 'setAssessment';

  static const blockUserService = 'blockUserService';
  static const blockUserFoundation = 'blockUserFoundation';
  static const acceptOrder = 'acceptOrder ';
  static const rejectedOrder = 'rejectedOrder ';
  static const getAllOrderForService = 'getAllOrderForService';
  static const getAllOrderForAllService = 'getAllOrderForAllService';
}
