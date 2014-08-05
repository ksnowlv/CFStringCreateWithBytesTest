//
//  CFStringCreateWithBytesTestViewController.m
//  CFStringCreateWithBytesTest
//
//  Created by ksnowlv on 14-6-5.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import "CFStringCreateWithBytesTestViewController.h"

@interface CFStringCreateWithBytesTestViewController ()

@end


@implementation CFStringCreateWithBytesTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    for (NSInteger i = 0; i < 50; ++i) {
        [self test];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test
{
    NSString *string = @"你从这里来，要去哪呢？你说呢？33098832-eeeekdkd0099-=33ddaddddxxxxd\
    xxdfkakdldldlkladf3444kkfkdkdkdkklslsllsslsllslsllsllslslslslslkkdfjjfjfjfjfjfjjffjjfjffj\
    llskkdkdkkddlwiewie383849849848480248024048208240824082480420844800248042808440840400440\
    kdkepifijifdflkfdkfdk;fskkfskpkporfgkopefpkokoprgkpogkopgwrkpgrkpogrkpgwkpogrwkpgrwpkgkpogwr\
    ldl;;re94389403803480850853004300042808082408208082082480408402840820284402804280428042042\
    jdioeijoeriojiojeiojojjioojojohohohhouhouohuhouhouhououhouhouhhuohuohuoopjko[kkpokpkppkpkpkpk\
    jjojljjljljsdiioelowowjljelellelkjfjld";
    
    //NSLog(@"-------------before optimization");
    
    const NSInteger KLoopCount = 100;
    
    double curTime = CFAbsoluteTimeGetCurrent();
    //NSLog(@"time = %f",curTime);
    for (NSInteger i = 0; i < KLoopCount; ++i) {
        [(id)CFStringCreateWithBytes(NULL, (const UInt8 *)[string UTF8String], 0,kCFStringEncodingUTF8, NO) autorelease];
    }
    
    double lastTime = curTime;
    curTime = CFAbsoluteTimeGetCurrent();
    double lastDeltaTime = curTime - lastTime;
    
   // NSLog(@"before optimization delta time = %f",lastDeltaTime);
    //NSLog(@"-------------after optimization");
   
    const NSUInteger KFitMemoryBlockLength = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    curTime = CFAbsoluteTimeGetCurrent();
    
    
    //NSLog(@"time = %f",curTime);
    
    
    NSMutableString *pFitString = [[NSMutableString alloc] initWithCapacity:KFitMemoryBlockLength - 20];
    
    for (NSInteger i = 0; i < KLoopCount; ++i) {
        [pFitString setString:string];
    }
    [pFitString release];
    
    lastTime = curTime;
    curTime = CFAbsoluteTimeGetCurrent();
    double curDeltaTime = curTime - lastTime;
    
    //NSLog(@"after optimization delta time = %f",curDeltaTime);
    NSLog(@"two time offset = %f",curDeltaTime - lastDeltaTime);
}

@end
