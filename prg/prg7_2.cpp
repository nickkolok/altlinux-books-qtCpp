#include <iostream>
#include <fstream>
using namespace std;
int main()
{
  ifstream f; //`Поток для чтения.`
  float a; int n=0;
  f.open("abc1.txt"); //`Открываем файл в режиме чтения.`
  if (f) //`Если открытие файла прошло корректно, то`
  {
    while (!f.eof()) //`Организован цикл, выполнение цикла`
    //`прервется, когда ,будет достигнут конца файла.`
    {
      f>>a;	    
//      if(f.rdstate()!=ios::eofbit)
      if (!f.eof())      
      {
      //  f>>a; //`Чтение очередного значения из потока \Sys{f} в переменную \Sys{a}.`
        cout<<a<<"\t"; //`Вывод значения переменной \Sys{a}` 
        n++;  //`Увеличение количества считанных чисел.`
      }
    }
    cout<<endl;
    f.close(); //`Закрытие потока.`
    cout<<"n="<<n<<endl; //`Вывод на экран количества чисел.`
  }
  else cout<<"File not found"<<endl; //`Если открытие файла прошло некорректно, то`
  //`вывод сообщение, об отсутствии такого файла.`
  return 0;
}

