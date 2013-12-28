//
//  CornerRadius.h
//

#import <UIKit/UIKit.h>

@interface CornerRadius : UIView

@property (assign, nonatomic) NSInteger radius;
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) BOOL cornersOn;

- (id)initWithRadius:(NSInteger)radius color:(UIColor *)color;

@end
