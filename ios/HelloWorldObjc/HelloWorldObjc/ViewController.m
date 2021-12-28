
#import "ViewController.h"
#import <DynamsoftCameraEnhancer/DynamsoftCameraEnhancer.h>

@interface ViewController ()<DCEFrameListener>

@property(nonatomic, strong) DynamsoftCameraEnhancer *dce;
@property(nonatomic, strong) DCECameraView *dceView;

@end

@implementation ViewController{
    UIButton *photoButton;
    UIImageView* imageView;
    bool isview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurationDCE];
    [self configurationUI];
}

- (void)configurationDCE{
    _dceView = [DCECameraView cameraWithFrame:self.view.bounds];
    [self.view addSubview:_dceView];
    _dce = [[DynamsoftCameraEnhancer alloc] initWithView:_dceView];
    [_dce open];
    [_dce addListener:self];
    [_dce setFrameRate:30];
}

- (void)configurationUI{
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat SafeAreaBottomHeight = [[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 34 : 0;
    photoButton = [[UIButton alloc] initWithFrame:CGRectMake(w / 2 - 60, h - 170 - SafeAreaBottomHeight, 120, 120)];
    photoButton.adjustsImageWhenDisabled = NO;
    [photoButton setImage:[UIImage imageNamed:@"icon_capture"] forState:UIControlStateNormal];
    self->imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    [photoButton addTarget:self action:@selector(takePictures) forControlEvents:UIControlEventTouchUpInside];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:self->photoButton];
    });
}

- (void)takePictures{
    isview = true;
}

- (void)frameOutPutCallback:(nonnull DCEFrame *)frame timeStamp:(NSTimeInterval)timeStamp {
    if (isview) {
        isview = false;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->photoButton setEnabled:false];
            UIImage *image = [[UIImage alloc] initWithCGImage: frame.toUIImage.CGImage
                                               scale: 1.0
                                         orientation: UIImageOrientationRight];
            [self->imageView setImage:image];
            [self.view addSubview:self->imageView];
            [self addBack];
        });
    }
}

- (void)addBack{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(BackToHome)];
}

- (void)BackToHome{
    [imageView removeFromSuperview];
    self.navigationItem.leftBarButtonItem = nil;
    [photoButton setEnabled:true];
}

@end
