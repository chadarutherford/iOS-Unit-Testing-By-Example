//
//  UIAlertAction+QCOMock.h
//  ViewControllerPresentationSpy
//
//  Created by Chad Rutherford on 9/25/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertAction (QCOMock)
+ (void)qcoMock_swizzle;
- (void (^ __nullable)(UIAlertAction *action))qcoMock_handler;
@end

NS_ASSUME_NONNULL_END
