#include <iostream>
using namespace std;
int main()
{
unsigned long int N,M; int kol,i;
cout<<"N="; cin>>N;
for (kol=1,M=N;M/10>0;kol++,M/=10);
for (M=N,i=0;i<kol;M/=10,i++)
  if (M%10==0) cout<<"Позиция= "<<i<<endl;
return 0;
}
