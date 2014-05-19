#include <iostream>
#include <fstream>
#include <iomanip>
using namespace std;
int main()
{
  int i, n; double a;
  ofstream f; //`Описывает поток для записи данных в файл.`
  f.open("abc1.txt"); //`Открываем файл в режиме записи,`
      //`режим \Sys{ios::out} устанавливается по умолчанию.`
  cout<<"n=";cin>>n; //`Ввод количества вещественных чисел.`
  for(i=0;i<n;i++)
  {
    cout<<"a="; cin>>a; //`Ввод очередного числа.`
    if (i<n-1) //`Если число не последнее,`
      f<<a<<"\t"; //`записать в файл это число и символ табуляции, иначе`
    else f<<a; //`записать только число.`
  }
  f.close(); //`Закрытие потока.`
return 0;
}

