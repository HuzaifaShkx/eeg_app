class EEGData {
  AF7? aF7;
  AF7? aF8;
  AF7? tP10;
  AF7? tP9;

  EEGData({this.aF7, this.aF8, this.tP10, this.tP9});

  EEGData.fromJson(Map<String, dynamic> json) {
    aF7 = json['AF7'] != null ? new AF7.fromJson(json['AF7']) : null;
    aF8 = json['AF8'] != null ? new AF7.fromJson(json['AF8']) : null;
    tP10 = json['TP10'] != null ? new AF7.fromJson(json['TP10']) : null;
    tP9 = json['TP9'] != null ? new AF7.fromJson(json['TP9']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aF7 != null) {
      data['AF7'] = this.aF7!.toJson();
    }
    if (this.aF8 != null) {
      data['AF8'] = this.aF8!.toJson();
    }
    if (this.tP10 != null) {
      data['TP10'] = this.tP10!.toJson();
    }
    if (this.tP9 != null) {
      data['TP9'] = this.tP9!.toJson();
    }
    return data;
  }
}

class AF7 {
  List<double>? alpha;
  List<double>? beta;
  List<double>? delta;
  List<double>? theta;

  AF7({this.alpha, this.beta, this.delta, this.theta});

  AF7.fromJson(Map<String, dynamic> json) {
    alpha = json['Alpha'].cast<double>();
    beta = json['Beta'].cast<double>();
    delta = json['Delta'].cast<double>();
    theta = json['Theta'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Alpha'] = this.alpha;
    data['Beta'] = this.beta;
    data['Delta'] = this.delta;
    data['Theta'] = this.theta;
    return data;
  }
}
