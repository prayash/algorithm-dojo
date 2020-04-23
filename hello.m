#import <Foundation/Foundation.h>

@interface SampleClass:NSObject
- (void)sampleMethod;
@end

@implementation SampleClass
- (void)sampleMethod {
    NSLog(@"Hello, World! \n");
}
@end

int main() {
    SampleClass *s = [[SampleClass alloc] init];
    [s sampleMethod];

    int  var1;
    char var2[10];

    NSLog(@"Address of var1 variable: %x\n", &var1);
    NSLog(@"Address of var2 variable: %x\n", &var2);

    return 0;
}
