//
//  ViewController.m
//  HelloWorld
//
//  Created by Dynamsoft on 2023/7/25.
//

#import "ViewController.h"
#import <DynamsoftCore/DynamsoftCore.h>
#import <DynamsoftCameraEnhancer/DynamsoftCameraEnhancer.h>

@interface ViewController () <DSVideoFrameListener>

@property (nonatomic, strong) DSCameraView *cameraView;
@property (nonatomic, strong) DSCameraEnhancer *dce;
@property (nonatomic, assign) BOOL isClicked;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpCamera];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.dce open];
}

- (void)setUpCamera {
    self.cameraView = [[DSCameraView alloc] initWithFrame:self.view.bounds];
    self.cameraView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:self.cameraView atIndex:0];
    self.dce = [[DSCameraEnhancer alloc] init];
    self.dce.cameraView = self.cameraView;
    [self.dce addListener:self];
}

- (void)onFrameOutPut:(nonnull DSImageData *)frame {
    if (self.isClicked) {
        self.isClicked = false;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.button.enabled = false;
            self.imageView.image = [frame toUIImage:nil];
            self.imageView.hidden = false;
            [self addBack];
        });
    }
}

- (void)addBack{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(touchBarItem)];
}

- (void)touchBarItem{
    self.imageView.hidden = true;
    self.button.enabled = true;
    self.navigationItem.leftBarButtonItem = nil;
}

- (IBAction)touchEvent:(id)sender {
    self.isClicked = true;
}

@end
