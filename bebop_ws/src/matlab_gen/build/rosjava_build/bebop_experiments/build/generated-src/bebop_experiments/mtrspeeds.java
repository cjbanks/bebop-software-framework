package bebop_experiments;

public interface mtrspeeds extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "bebop_experiments/mtrspeeds";
  static final java.lang.String _DEFINITION = "float64 m_1\nfloat64 m_2\nfloat64 m_3\nfloat64 m_4\n\n";
  static final boolean _IS_SERVICE = false;
  static final boolean _IS_ACTION = false;
  double getM1();
  void setM1(double value);
  double getM2();
  void setM2(double value);
  double getM3();
  void setM3(double value);
  double getM4();
  void setM4(double value);
}
