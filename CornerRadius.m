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
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFrame) name:UIDeviceOrientationDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillChangeStatusBarFrame:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFrame) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (id)initWithRadius:(NSInteger)radius color:(UIColor *)color
{
    if(self = [super initWithFrame:[self appFrame]])
	{
		self.cornersOn = YES;
		self.radius = radius;
		self.color = color;
		
		self.contentMode = UIViewContentModeRedraw;
		
		[self initStuff_CornerRadius];
	}
	
	return self;
}

- (void)applicationWillChangeStatusBarFrame:(NSNotification *)notif
{
	[UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
		[self updateFrame];
	} completion:^(BOOL finished) {
        [self updateFrame];
    }];
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

- (void)setCornersOn:(BOOL)cornersOn
{
	BOOL oldCornersOn = _cornersOn;
	_cornersOn = cornersOn;
	
	if(oldCornersOn != self.cornersOn)
	{
		[self setNeedsDisplay];
	}
}

- (CGRect)appFrame
{
	return [UIScreen mainScreen].applicationFrame;
}

- (void)updateFrame
{
	self.frame = [self appFrame];
}

- (void)drawRect:(CGRect)rect
{
    if(self.cornersOn)
	{
		CGContextRef context = UIGraphicsGetCurrentContext();
		
		[self.color set];
		
		// Bottom left corner
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
		CGContextAddArc(context, rect.origin.x + self.radius, rect.origin.y + rect.size.height - self.radius, self.radius, M_PI, M_PI / 2, 1);
		
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
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

@end
