//
//  PaymentManager.h
//  NativeView
//
//  Created by Giancarlo Bautista on 3/7/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#ifndef PaymentManager_h
#define PaymentManager_h

#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>

@interface PaymentManager : UIViewController <RCTBridgeModule>

@property (nonatomic, strong) UIViewController *reactRoot;
@property (nonatomic, strong) RCTPromiseResolveBlock resolve;
@property (nonatomic, strong) RCTPromiseRejectBlock reject;

+ (instancetype)sharedInstance;

@end

#endif /* PaymentManager_h */
