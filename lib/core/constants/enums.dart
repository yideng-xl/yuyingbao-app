/// 记录类型
enum RecordType {
  breastfeeding('母乳亲喂'),
  bottle('瓶喂'),
  formula('配方奶'),
  solid('辅食'),
  diaper('尿布'),
  growth('成长记录'),
  water('饮水'),
  nutrition('营养补充');

  final String label;
  const RecordType(this.label);
}

/// 亲喂侧
enum BreastfeedingSide {
  left('左侧'),
  right('右侧'),
  both('双侧');

  final String label;
  const BreastfeedingSide(this.label);
}

/// 辅食类型
enum SolidType {
  riceCereal('米粉'),
  vegetablePuree('蔬菜泥'),
  fruitPuree('水果泥'),
  meatPuree('肉泥'),
  eggYolk('蛋黄'),
  other('其他');

  final String label;
  const SolidType(this.label);
}

/// 大便质地
enum DiaperTexture {
  watery('稀水样'),
  soft('软便'),
  normal('正常'),
  hard('干硬');

  final String label;
  const DiaperTexture(this.label);
}

/// 大便颜色
enum DiaperColor {
  yellow('黄色'),
  green('绿色'),
  brown('褐色'),
  black('黑色');

  final String label;
  const DiaperColor(this.label);
}

/// 性别
enum Gender {
  male('男'),
  female('女');

  final String label;
  const Gender(this.label);
}
