#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KGModalStyle){
    KGModalStyleGradient,
    KGModalStyleSolid
};
typedef void(^clickShadow) (void);
@interface KGModal : NSObject
@property (nonatomic, assign) BOOL bNeedShadow;
// Determines if the modal should dismiss if the user taps outside of the modal view
// Defaults to YES
@property (nonatomic) BOOL tapOutsideToDismiss;

@property (strong, nonatomic) UIWindow *window;

// Determins if the close button or tapping outside the modal should animate the dismissal
// Defaults to YES
@property (nonatomic) BOOL animateWhenDismissed;

// Determins if the close button is shown
// Defaults to YES
@property (nonatomic) BOOL showCloseButton;
@property (nonatomic, strong) clickShadow shadowBlock;
// The background display style, can be a transparent radial gradient or a transparent black
// Defaults to gradient, this looks better but takes a bit more time to display on the retina iPad
@property (nonatomic) enum KGModalStyle backgroundDisplayStyle;

// The shared instance of the modal
+ (id)sharedInstance;

// Set the content view to display in the modal and display with animations
- (void)showWithContentView:(UIView *)contentView;

// Set the content view to display in the modal and whether the modal should animate in
- (void)showWithContentView:(UIView *)contentView andAnimated:(BOOL)animated;

// Hide the modal with animations
- (void)hide;

// Hide the modal and whether the modal should animate away
- (void)hideAnimated:(BOOL)animated;

- (void)getIn:(int) t;

@end
