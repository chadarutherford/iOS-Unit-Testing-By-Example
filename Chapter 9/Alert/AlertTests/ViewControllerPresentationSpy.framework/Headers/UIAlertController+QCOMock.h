//
//  UIAlertController+QCOMock.h
//  ViewControllerPresentationSpy
//
//  Created by Chad Rutherford on 9/25/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const QCOMockAlertControllerPresentedNotification;

@interface UIAlertController (QCOMock)
+ (void)qcoMock_swizzle;
@end

NS_ASSUME_NONNULL_END
