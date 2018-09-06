//
//  TRDrop.m
//  TRDrop
//
//  Created by 姜政 on 2018/1/30.
//

#import "TRDrop.h"


@implementation TRDrop

static TRDrop * _instace = nil;
+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (_instace == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instace = [super allocWithZone:zone];
        });
    }
    return _instace;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super init];
        [_instace addSubview:self.imageV];
        [_instace addSubview:self.messageL];

    });
    return _instace;
}

+ (instancetype)sharedInstace
{
    TRDrop *drop = [[self alloc] init];
    drop.backgroundColor = [UIColor whiteColor];
    return drop;
}
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return _instace;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return _instace;
}


-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}

-(UILabel *)messageL{
    if (!_messageL) {
        _messageL = [[UILabel alloc] init];
        _messageL.numberOfLines = 0;
        _messageL.font =   [UIFont systemFontOfSize:16*[UIScreen mainScreen].bounds.size.width/375.0f];
    }
    return _messageL;
}
+(void)showMessage:(NSString *)message state:(TRDropState)state duration:(CGFloat)duration{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSBundle *FrameWorkBundle = [NSBundle bundleForClass:[self class]];
        NSBundle *dorpBundle  = [NSBundle bundleWithPath:[FrameWorkBundle pathForResource:@"Drop" ofType:@"bundle"]];
        NSAssert(dorpBundle != nil, @"Bundle named '%@' not found!", @"Drop");
        if (!dorpBundle) return;
        
        
        TRDrop *drop =   [TRDrop sharedInstace];
        if (drop) {
            // 禁止将 AutoresizingMask 转换为 Constraints
            drop.imageV.translatesAutoresizingMaskIntoConstraints = NO;
            drop.messageL.translatesAutoresizingMaskIntoConstraints = NO;
            // 添加 width 约束
            NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:drop.imageV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:25];
            [drop.imageV addConstraint:widthConstraint];
            // 添加 height 约束
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:drop.imageV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:25];
            [drop.imageV addConstraint:heightConstraint];
            // 添加 left 约束
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:drop.imageV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:drop attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
            [drop addConstraint:leftConstraint];
            // 添加 centerX 约束
            NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:drop.imageV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:drop attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.5*[UIApplication sharedApplication].statusBarFrame.size.height];
            [drop addConstraint:centerXConstraint];
            
            // 添加 height 约束
            NSLayoutConstraint *heightConstraint1 = [NSLayoutConstraint constraintWithItem:drop.messageL attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:50];
            [drop.messageL addConstraint:heightConstraint1];
            // 添加 left 约束
            NSLayoutConstraint *leftConstraint1 = [NSLayoutConstraint constraintWithItem:drop.messageL attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:drop attribute:NSLayoutAttributeLeading multiplier:1.0 constant:55];
            [drop addConstraint:leftConstraint1];
            
            // 添加 right 约束
            NSLayoutConstraint *rightConstraint1 = [NSLayoutConstraint constraintWithItem:drop.messageL attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:drop attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:20];
            [drop addConstraint:rightConstraint1];
            
            // 添加 centerX 约束
            NSLayoutConstraint *centerXConstraint1 = [NSLayoutConstraint constraintWithItem:drop.messageL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:drop attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.5*[UIApplication sharedApplication].statusBarFrame.size.height];
            [drop addConstraint:centerXConstraint1];
        }
        CGFloat height = 64+[UIApplication sharedApplication].statusBarFrame.size.height-20;
        drop.frame = CGRectMake(0,-height, [UIScreen mainScreen].bounds.size.width, height);
        drop.messageL.text = message;
        switch (state) {
                
            case TRDropStateInfo:
            {
                NSString *bundleImageName = [NSString stringWithFormat: @"%@", @"info_tip.png"];
                drop.imageV.image = [[UIImage alloc] initWithContentsOfFile:[dorpBundle  pathForResource:bundleImageName ofType:nil]];
                drop.backgroundColor = [UIColor whiteColor];
                break;
            }
            case TRDropStateSuccess:
            {
                NSString *bundleImageName = [NSString stringWithFormat: @"%@", @"success_tip.png"];
                drop.imageV.image = [[UIImage alloc] initWithContentsOfFile:[dorpBundle  pathForResource:bundleImageName ofType:nil]];
                drop.backgroundColor = [UIColor whiteColor];
                break;
            }
                
            case TRDropStateWarning:
            {
                NSString *bundleImageName = [NSString stringWithFormat: @"%@", @"info_tip.png"];
                drop.imageV.image = [[UIImage alloc] initWithContentsOfFile:[dorpBundle  pathForResource:bundleImageName ofType:nil]];
                drop.backgroundColor = [UIColor whiteColor];
                break;
            }
            case TRDropStateError:
            {
                NSString *bundleImageName = [NSString stringWithFormat: @"%@", @"error_tip.png"];
                drop.imageV.image = [[UIImage alloc] initWithContentsOfFile:[dorpBundle  pathForResource:bundleImageName ofType:nil]];
                drop.backgroundColor = [UIColor whiteColor];
                break;
            }
                
            default:
                break;
        }
        [[UIApplication sharedApplication].delegate.window addSubview:drop];
        [[UIApplication  sharedApplication].delegate.window bringSubviewToFront:drop];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGRect rect = drop.frame;
            rect.origin.y = 0;
            drop.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [drop removeFromSuperview];
        });
    });
  
}
+(void)showError:(NSString *)errorMsg{
    [TRDrop showMessage:errorMsg state:TRDropStateError duration:0.25];
}
+(void)showSuccess:(NSString *)success{
   [TRDrop showMessage:success state:TRDropStateSuccess duration:0.25];
}
@end
