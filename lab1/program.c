#include <stdio.h>
#define M 5
#define N 3

void process(int n,int m,int matrix[M][N],int *result)
{
    int rowSum=0;
    int minValue=0;
    for (int i=0;i<M;++i){
        for (int j=0;i<N;++j){
            rowSum+=matrix[i][j];
        }
        if(i==0||rowSum<minValue)
        {
            minValue=rowSum;
            result=i;
        }
        rowSum=0;
    }
}

void main(int argc, char** argv)
{
    int matrix[M][N];
    int result=0;

    for (int i=0;i<M;++i){
        for (int j=0;j<N;++j){
            scanf("%d",&matrix[i][j]);
        }
    }

    process(N,M,matrix,result);

    for (int i=0;i<M;++i){
        printf("%d", result);
    }

    return 0;
}