#include <iostream>
#include <math.h>
using namespace std;
const double ANGLE[16] = {
    45.0000,    26.5650,    14.0362,    7.1250, 
    3.5763,     1.7889,     0.8952,     0.4476,
    0.2238,     0.1119,     0.05595,    0.02797, 
    0.01399,    0.006989,   0.003494,   0.001755
};

int main()
{
    double angle  = 37.0;
    int N = 16;
    double z = 0.0;
    double cosz = 1.0;
    double sinz = 0.0;
    double s = 1;
    
    
    clock_t start = clock();

    

    for (int i = 0; i < N; i++)
    {
        if (angle >= z)
        {
            s = 1;
        }
        else
        {
            s = -1;
        }
        double sinz_ = sinz;
        sinz = sinz - (s / pow(2,i)) * cosz;
        cosz = cosz + (s / pow(2,i)) * sinz_;
        z = z + s * ANGLE[i];
    }
    cosz = cosz / 1.64676;
    clock_t end = clock();
    cout << "花费了" << (double)(end - start) / CLOCKS_PER_SEC * 1000 << "ms" << endl;
    cout << cosz << endl;
    return 0;
}
