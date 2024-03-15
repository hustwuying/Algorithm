#include <iostream>
#include <complex>
#include <math.h>
#include <vector>
#include <ctime>

using namespace std;

struct complex_d
{
  double real = 1.0;
  double imag = 0.0;
};
complex_d operator+(complex_d d1, complex_d d2);
complex_d operator-(complex_d d1, complex_d d2);
complex_d operator*(complex_d d1, complex_d d2);
double abs(complex_d d1);

int log2(int N);                    // function to calculate the log2(.) of int numbers
void ordina(vector<complex_d> &f1); // using the reverse order in the array
int reverse(int N, int n);          // calculating revers number
vector<complex_d> fft_dit(vector<complex_d> &data_in, int N);
vector<complex_d> fft_dif(vector<complex_d> &data_in, int N);

int main()
{

  int N = 8;
  double f = 2.0;
  complex_d item;
  vector<complex_d> data_in;
  vector<complex_d> fft_out;
  for (int i = 0; i < N; i++)
  {
    item.real = cos(2 * M_PI * f * i / N);
    item.imag = sin(2 * M_PI * f * i / N);
    data_in.push_back(item);
  }

  clock_t start = clock();
  fft_out = fft_dif(data_in, N);
  clock_t end = clock();
  cout << "花费了" << (double)(end - start) / CLOCKS_PER_SEC * 1000 << "ms" << endl;

  for (int i = 0; i < N; i++)
  {
    cout << sqrt(fft_out[i].real * fft_out[i].real + fft_out[i].imag * fft_out[i].imag) / N << endl;
  }
  return 0;
}

complex_d operator+(complex_d d1, complex_d d2)
{
  complex_d sum;
  sum.real = d1.real + d2.real;
  sum.imag = d1.imag + d2.imag;
  return sum;
}
complex_d operator-(complex_d d1, complex_d d2)
{
  complex_d sum;
  sum.real = d1.real - d2.real;
  sum.imag = d1.imag - d2.imag;
  return sum;
}
complex_d operator*(complex_d d1, complex_d d2)
{
  complex_d mult;
  mult.real = d1.real * d2.real - d1.imag * d2.imag;
  mult.imag = d1.real * d2.imag + d1.imag * d2.real;
  return mult;
}
double abs(complex_d d1)
{
  return sqrt(d1.real * d1.real + d1.imag * d1.imag);
}

int log2(int N) /*function to calculate the log2(.) of int numbers*/
{
  int k = N, i = 0;
  while (k)
  {
    k >>= 1;
    i++;
  }
  return i - 1;
}

int reverse(int N, int n) // calculating revers number
{
  int j, p = 0;
  for (j = 1; j <= log2(N); j++)
  {
    if (n & (1 << (log2(N) - j)))
    {
      p |= 1 << (j - 1);
    }
  }
  return p;
}

void ordina(vector<complex_d> &f1) // using the reverse order in the array
{
  vector<complex_d> f2;
  int N = f1.size();
  for (int i = 0; i < N; i++)
  {
    f2.push_back(f1[reverse(N, i)]);
  }
  for (int i = 0; i < N; i++)
  {
    f1[i] = f2[i];
  }
}

vector<complex_d> fft_dif(vector<complex_d> &data_in, int N)
{
  vector<complex_d> fft_out = data_in;
  int m = log2(N);
  for (int i0 = m; i0 > 0; i0--)
  {
    int p = pow(2, m - i0);
    int q = pow(2, i0);
    for (int i1 = 0; i1 < p; i1++)
    {
      for (int i2 = 0; i2 < q / 2; i2++)
      {
        complex_d temp1;

        double phi = i2 * p * 2 * M_PI / N;
        complex_d r;
        r.real = cos(phi);
        r.imag = sin(phi);

        temp1 = fft_out[i1 * q + i2] - fft_out[i1 * q + i2 + q / 2];

        fft_out[i1 * q + i2] = fft_out[i1 * q + i2] + fft_out[i1 * q + i2 + q / 2];

        fft_out[i1 * q + i2 + q / 2] = r * temp1;
      }
    }
  }
  ordina(fft_out);
  return fft_out;
}

vector<complex_d> fft_dit(vector<complex_d> &data_in, int N)
{
  vector<complex_d> fft_out = data_in;
  ordina(fft_out);
  int m = log2(N);
  for (int i0 = 0; i0 < m; i0++)
  {
    int p = pow(2, m - i0 - 1);
    int q = pow(2, i0 + 1);
    for (int i1 = 0; i1 < p; i1++)
    {
      for (int i2 = 0; i2 < q / 2; i2++)
      {
        double phi = i2 * p * 2 * M_PI / N;
        complex_d r;
        r.real = cos(phi);
        r.imag = sin(phi);

        complex_d temp1 = r * fft_out[i1 * q + i2 + q / 2];
        complex_d temp2 = fft_out[i1 * q + i2];

        fft_out[i1 * q + i2] = temp2 + temp1;
        fft_out[i1 * q + i2 + q / 2] = temp2 - temp1;
        
      }
    }
  }

  return fft_out;
}
