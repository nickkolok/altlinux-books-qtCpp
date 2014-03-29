#include <iostream>
#include <fstream>
#include <iomanip>
#include <stdlib.h>
using namespace std;
int main()
{
int n=0;
float a;
fstream F;
//открываем файл в режиме чтения
F.open("abc1.txt");
//если открытие файла прошло корректно, то
if (F)
{
//цикл для чтения значений из файла; выполнение цикла прервется,
//когда достигнем конца файла, в этом случае F.eof() вернет истину.
while (!F.eof())
{
//чтение очередного значения из потока F в переменную a
F>>a;
//вывод значения переменной a на экран
cout<<a<<"\t";
//увеличение количества считанных чисел
n++;
}
//закрытие потока
F.close();
//вовод на экран количества считанных чисел
cout<<"n="<<n<<endl;
}
//если открытие файла прошло некорректно, то вывод
//сообщения об отсутствии такого файла
else cout<<" Файл не существует"<<endl;
return 0;
}
