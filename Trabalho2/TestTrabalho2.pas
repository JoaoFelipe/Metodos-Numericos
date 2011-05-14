program TestTrabalho2;
uses TestUnit, TestUtilsUnit, TestLagrangeUnit, TestNewtonUnit;

begin
  StartTests;
  DoAllUtilsTests; 
  DoAllLagrangeTests;
  DoAllNewtonTests;
  DoAllNewtonGregoryTests;
  EndTests;
end.
