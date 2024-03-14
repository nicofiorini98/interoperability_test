#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    while (scanf("%d", &n) != EOF) {
		
        unsigned long long sum = 0;
		for (int i=1;i<=n;i++){
			sum += i;
		}
        printf("%llu\n", sum);
        fflush(stdout);
    }
    return 0;
}