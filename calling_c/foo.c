// http://users.stat.umn.edu/~geyer/rc/
//   says this guide is obsolete, but has a link to github

void foo(int *nin, double *x)
{
    int n = nin[0];

    int i;

    for (i=0; i<n; i++)
        x[i] = x[i] * x[i];
}
