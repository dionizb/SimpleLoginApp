//
//  Biometrics.h
//  SimpleLoginAppUITests
//
//  Created by Dioniz Bardhaj on 8.10.21.
//

#import <Foundation/Foundation.h>

@interface Biometrics: NSObject

+ (void)enrolled;
+ (void)unenrolled;
+ (void)successfulAuthentication;
+ (void)unsuccessfulAuthentication;

@end
