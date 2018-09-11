//
//  TRDrop.h
//  TRDrop
//
//  Created by 姜政 on 2018/1/30.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TRDropState) {
    TRDropStateInfo,
    TRDropStateSuccess,
    TRDropStateWarning,
    TRDropStateError,
};
@interface TRDrop : UIView
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  UIVisualEffectView *effectV;
@property (strong, nonatomic)  UILabel *messageL;
@property (strong, nonatomic)  NSTimer *hideDelayTimer;
+ (instancetype)sharedInstace;

+(void)showMessage:(NSString *)message state:(TRDropState)state duration:(CGFloat)duration;
+(void)showError:(NSString *)errorMsg;
+(void)showSuccess:(NSString *)success;
@end
