#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

typedef struct {
   int N;
   int *A;
   int c;
} coupons;
coupons initempty ( int ) ;
void destroycoupons ( coupons * ) ;
coupons addcoupon ( coupons, int ) ;
int allcoupons ( coupons ) ;

coupons initempty ( int N )
{
   coupons S;
   int i;
   S.c=0;
   S.N = N;
   S.A = (int *)malloc(N * sizeof(int));
   for (i=0; i<N; ++i) S.A[i] = 0;
   return S;
}

coupons addcoupon ( coupons S, int c )
{
    if(S.A[c]==0)
    {
   S.A[c] = 1;
   S.c++;
    }
   return S;
}

int allcoupons ( coupons S )
{
    if(S.c==S.N)
   return 1;
   else
   return 0;
}

void destroycoupons ( coupons *S )
{
   free(S -> A);
}

#include "choco.c"
