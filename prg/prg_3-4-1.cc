#include <stdio.h>
#include <math.h>
#define PI 3.14159
using namespace std;
int main()
{
	float x, y;	//Описание переменных
	x=0;			//Присваивание параметру цикла
					//стартового значения
					//Цикл с предусловием
	while (x<=PI)	//Пока параметр цикла 
					//не превышает конечное значение
	{				//выполнять тело цикла
		y=exp(sin(x))*cos(x);	//Вычислить значение y
							//Вывод на экран пары х и y.
		printf("\t x=%5.2f \t y=%5.4f \n",x,y);
		x+=0.1;	//Изменение параметра цикла 
					//(переход к следующему значению x)
	}	//Конец цикла
return 0;
}