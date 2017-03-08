//
//  PaymentManager.m
//  NativeView
//
//  Created by Giancarlo Bautista on 3/7/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentManager.h"
#import <React/RCTBridgeModule.h>

@implementation PaymentManager

+ (instancetype)sharedInstance {
  static PaymentManager *_sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[PaymentManager alloc] init];
  });
  return _sharedInstance;
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(showPaymentViewController:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{

  dispatch_async(dispatch_get_main_queue(), ^{
    self.resolve = resolve;
    self.reject = reject;
    
    UIViewController *viewController = [[UIViewController alloc] init];
    UIView *paymentView = [[UIView alloc] init];
    [paymentView setBackgroundColor:[UIColor whiteColor]];
    [viewController setTitle:@"Payment Manager"];
    [viewController setView:paymentView];
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(userDidCancelPayment)];
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(userDidFinishPayment)];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

    self.reactRoot = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [self.reactRoot presentViewController:navigationController animated:YES completion:nil];
  });
}

- (void)userDidCancelPayment {
  [self.reactRoot dismissViewControllerAnimated:YES completion:nil];
  
  /*
  NSError *error = [NSError errorWithDomain:@"payment_manager"
                                     code:-52
                                 userInfo:@{
                                            NSLocalizedDescriptionKey:@"User cancelled payment"
                                            }];
   self.reject(@"cancelled_payment", @"User cancelled payment", error);
  */
  
  NSDictionary *res = @{
                        @"success": @false,
                        @"message": @"User cancelled payment"
                        };
  self.resolve(res);
}

- (void)userDidFinishPayment {
  [self.reactRoot dismissViewControllerAnimated:YES completion:nil];
  
  NSDictionary *res = @{
                        @"success": @true,
                        @"nonce": @"asdf1234",
                        @"message": @"User finished payment"
                        };
  self.resolve(res);
}

@end
