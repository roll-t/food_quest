import 'package:food_quest/core/config/const/app_icons.dart';
import 'package:food_quest/main/nav/model/item_menu_feature_model.dart';
import 'package:get/get.dart';

class ManageController extends GetxController {
  final List<ItemMenuFeatureModel> listShowroomFeature = [
    ItemMenuFeatureModel(
      title: "Thống kê\nshowroom",
      iconUrl: AppIcons.icStatisticsVehicle,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý lợi nhuận",
      iconUrl: AppIcons.icProfit,
    ),
    ItemMenuFeatureModel(
      title: "Thêm xe mới",
      iconUrl: AppIcons.icAddCar,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý xe",
      iconUrl: AppIcons.icAllCar,
    ),
  ];

  final List<ItemMenuFeatureModel> listEmployeeFeature = [
    ItemMenuFeatureModel(
      title: "Theo dõi lương",
      iconUrl: AppIcons.icSalary,
    ),
    ItemMenuFeatureModel(
      title: "Hoa hồng",
      iconUrl: AppIcons.icRose,
    ),
    ItemMenuFeatureModel(
      title: "Chấm công",
      iconUrl: AppIcons.icAttendance,
    ),
  ];

  final List<ItemMenuFeatureModel> listDiamondFeature = [
    ItemMenuFeatureModel(
      title: "Nhập - Xuất\n Vàng",
      iconUrl: AppIcons.icExportGold,
    ),
    ItemMenuFeatureModel(
      title: "Vàng tồn kho",
      iconUrl: AppIcons.icGoldInventory,
    ),
    ItemMenuFeatureModel(
      title: "Giao dịch bán lẻ",
      iconUrl: AppIcons.icRetail,
    ),
    ItemMenuFeatureModel(
      title: "Dòng tiền theo ngày",
      iconUrl: AppIcons.icFlowMoney,
    ),
  ];

  final List<ItemMenuFeatureModel> listMoneyFeature = [
    ItemMenuFeatureModel(
      title: "Thống kê thu chi từng mảng",
      iconUrl: AppIcons.icIncomeExpenseByCategory,
    ),
    ItemMenuFeatureModel(
      title: "Báo cáo theo\nTuần - Tháng",
      iconUrl: AppIcons.icReportWeeklyMonthly,
    ),
  ];

  final List<ItemMenuFeatureModel> listCreditFeature = [
    ItemMenuFeatureModel(
      title: "Thống kê chung",
      iconUrl: AppIcons.ic20Loan,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý nguồn vốn",
      iconUrl: AppIcons.icMonthlyPrincipalInterest,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý thu chi",
      iconUrl: AppIcons.icReportDebt,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý cửa hàng",
      iconUrl: AppIcons.icReportDebt,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý khách hàng",
      iconUrl: AppIcons.icReportDebt,
    ),
    ItemMenuFeatureModel(
      title: "Cầm đồ",
      iconUrl: AppIcons.icReportDebt,
    ),
    ItemMenuFeatureModel(
      title: "Tín chấp",
      iconUrl: AppIcons.icReportDebt,
    ),
  ];
}
