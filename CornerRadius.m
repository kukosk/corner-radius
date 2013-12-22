//
//  CornerRadius.m
//

#import "CornerRadius.h"

#define DEFAULT_RADIUS 3.0
#define DEFAULT_COLOR [UIColor blackColor]


@implementation CornerRadius

- (void)initStuff_CornerRadius
{
	self.backgroundColor = [UIColor clearColor];
	self.userInteractionEnabled = NO;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (id)initWithRadius:(NSInteger)radius color:(UIColor *)color
{
    if(self = [super initWithFrame:[self mainScreenFrame]])
	{
		self.radius = radius;
		self.color = color;
		
		[self initStuff_CornerRadius];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [self initWithRadius:DEFAULT_RADIUS color:DEFAULT_COLOR];
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [self initWithRadius:DEFAULT_RADIUS color:DEFAULT_COLOR];
	return self;
}

- (CGRect)mainScreenFrame
{
	return [UIScreen mainScreen].applicationFrame;
}

- (void)drawRect:(CGRect)rect
{
    self.frame = [self mainScreenFrame];
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	[self.color set];
    
    // Bottom left corner
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + self.radius, rect.origin.y + rect.size.height - self.radius, self.radius, M_PI, M_PI / 2, 1); //STS fixed
    
    // Bottom right corner
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - self.radius, rect.origin.y + rect.size.height - self.radius, self.radius, M_PI / 2, 0.0f, 1);
    
    // Top right corner
    CGContextMoveToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + rect.size.width - self.radius, rect.origin.y + self.radius, self.radius, 0.0f, -M_PI / 2, 1);
    
    // Top left corner
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + self.radius, rect.origin.y + self.radius, self.radius, -M_PI / 2, M_PI, 1);
    
    CGContextFillPath(context);
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end
