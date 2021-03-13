class GeneralModel {
  bool onBoarded;
  String currentLocale;

  GeneralModel({this.onBoarded, this.currentLocale});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    this.onBoarded = json['onBoarded'];
    this.currentLocale = json['currentLocale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentLocale'] = this.currentLocale;
    data['onBoarded'] = this.onBoarded;
    return data;
  }
}
