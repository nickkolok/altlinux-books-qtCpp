#include <iostream>
#include <fstream>
#include <math.h>
#include <complex>
using namespace std;
int main()
{
int i,j,p,N,M,K;
complex <float> **A,**B,**C;
ifstream f;
ofstream g;
f.open("abc.txt");
f>>N>>M>>K;
cout<<"N="<<N<<"\tM="<<M<<"\tK="<<K<<endl;
A=new complex <float> *[N];
for(i=0;i<N;A[i]=new complex <float> [M],i++);
B=new complex <float> *[M];
for(i=0;i<M;B[i]=new complex <float> [K],i++);
C=new complex <float> *[N];
for(i=0;i<N;C[i]=new complex <float> [K],i++);
for(i=0;i<N;i++)
  for(j=0;j<M;f>>A[i][j],j++);
cout<<"Матрица A\n";
for(i=0;i<N;cout<<endl,i++)
  for(j=0;j<M;cout<<A[i][j]<<"\t",j++);
for(i=0;i<M;i++)
  for(j=0;j<K;f>>B[i][j],j++);
cout<<"Матрица B\n";
for(i=0;i<M;cout<<endl,i++)
  for(j=0;j<K;cout<<B[i][j]<<"\t",j++);
for(i=0;i<N;i++)
  for(j=0;j<K;j++)
    for(C[i][j]=p=0;p<M;p++)
      C[i][j]+=A[i][p]*B[p][j];
f.close();
cout<<"Матрица C\n";
for(i=0;i<N;cout<<endl,i++)
  for(j=0;j<K;cout<<C[i][j]<<"\t",j++);
g.open("result.txt");
g<<"Матрица C=A*B\n";
for(i=0;i<N;g<<endl,i++)
  for(j=0;j<K;g<<C[i][j]<<"\t",j++);
g.close();
return 0;
}
