#include <iostream>
#include <math.h>
#include <complex>
using namespace std;
int main()
{
  complex <double> x (4, -6);
  complex <double> y (-7, 2);
  cout<<"x*y="<<x*y<<endl;
  cout<<"sin(x)*cos(y)="<<sin(x)*cos(y)<<endl;
  cout<<"conj(x)*ln(y)="<<conj(x)*log(y)<<endl;
  cout<<"sh(y)="<<sinh(y)<<endl;
  return 0;
}
