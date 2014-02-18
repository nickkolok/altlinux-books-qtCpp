#include <iostream>
#include <math.h>
#include <complex>
using namespace std;
int main()
{
  complex <double> b(sqrt(3),-1),y;
  cout<<"b="<<b;
  y=pow(b,20);
  cout<<"y="<<y<<endl;
  cout<<real(y)/pow(2,19)<<"\t";
  cout<<imag(y)/pow(2,19)<<"\n";
  complex <double> a(1,sqrt(3)),c (1,-1),z;
  z=pow(a/c,40);
  cout<<"z="<<z<<endl;
  cout<<real(z)/pow(2,19)<<"\t";
  cout<<imag(z)/pow(2,19)<<"\n";
  return 0;
}
