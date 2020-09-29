//
//  UIViewController+QCOMock.h
//  ViewControllerPresentationSpy
//
//  Created by Chad Rutherford on 9/25/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const QCOMockViewControllerPresentingViewControllerKey;
extern NSString *const QCOMockViewControllerAnimatedKey;
extern NSString *const QCOMockViewControllerCompletionKey;
extern NSString *const QCOMockViewControllerPresentedNotification;
extern NSString *const QCOMockViewControllerDismissedNotification;

@interface UIViewController (QCOMock)
+ (void)qcoMock_swizzleCaptureAlert;
+ (void)qcoMock_swizzleCaptureViewController;
+ (void)qcoMock_swizzleCaptureDismiss;
@end

NS_ASSUME_NONNULL_END
