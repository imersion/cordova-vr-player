#import <UIKit/UIKit.h>

#import "VideoPlayerViewController.h"
#import "GoogleVRPlayer.h"
#import "GVRVideoView.h"

@interface VideoPlayerViewController () <GVRVideoViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet GVRVideoView *videoView;
@end

@implementation VideoPlayerViewController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _videoView.delegate = self;
    _videoView.enableFullscreenButton = YES;
    _videoView.enableCardboardButton = YES;
    _videoView.enableTouchTracking = YES;
    _videoView.displayMode = kGVRWidgetDisplayModeFullscreen;
    
    self.fallbackVideoPlayed = NO;
    
    // get user defined path
    NSString *videoPath  =  [self valueForKey:@"videoUrl"];
    // get user defined video type
    NSString *videoType  =  [self valueForKey:@"videoType"];

    // set video type GVRVideoType using the NSString user provided
    GVRVideoType chosenType;
    if ([videoType isEqual:[NSNull null]]) {
        chosenType = kGVRVideoTypeStereoOverUnder;
    } else if ([videoType isEqualToString:@"Mono"]) {
        chosenType = kGVRVideoTypeMono;
    } else if ([videoType isEqualToString:@"StereoOverUnder"]) {
        chosenType = kGVRVideoTypeStereoOverUnder;
    } else if ([videoType isEqualToString:@"SphericalV2"]) {
        chosenType = kGVRVideoTypeSphericalV2;
    } else {
        chosenType = kGVRVideoTypeStereoOverUnder;
    }

    // remove starting forward slash if User put one in
    if ([videoPath hasPrefix:@"/"] && [videoPath length] > 1) {
        videoPath = [videoPath substringFromIndex:1];
    }
    
    // concat "www/" + videoPath
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"www/" , videoPath];
    
    // get the full resource location of the video file
    NSString *finalPath = [[[NSBundle mainBundle] resourcePath]
                          stringByAppendingPathComponent:fullPath];
    
    // create NSURL object with it
    NSURL *videoUrl  = [NSURL fileURLWithPath:finalPath];
    NSLog(@"videoUrl is: %@", videoUrl);
    
    // and away we go!
    // TODO: make ofType set by user as well
    [_videoView loadFromUrl:videoUrl
                     ofType:chosenType];

}

#pragma mark - GVRVideoViewDelegate

- (void)widgetView:(GVRWidgetView *)widgetView didLoadContent:(id)content {
    NSLog(@"Finished loading video");
}

- (void)widgetView:(GVRWidgetView *)widgetView
didChangeDisplayMode:(GVRWidgetDisplayMode)displayMode{
    if (displayMode != kGVRWidgetDisplayModeFullscreen && displayMode != kGVRWidgetDisplayModeFullscreenVR){
        // Full screen closed, closing the view
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)widgetView:(GVRWidgetView *)widgetView
didFailToLoadContent:(id)content
  withErrorMessage:(NSString *)errorMessage {
    
    NSLog(@"Failed to load video: %@", errorMessage);
    NSString *videoPath  =  [self valueForKey:@"fallbackVideoUrl"];
    
    if (!([videoPath isEqual:[NSNull null]]) && ([errorMessage isEqualToString:@"Cannot Decode"] || self.fallbackVideoPlayed == NO)){
        self.fallbackVideoPlayed = YES;
        
        NSURL *videoUrl  = [NSURL URLWithString:videoPath];
        [_videoView loadFromUrl:videoUrl
                         ofType:kGVRVideoTypeMono];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to load video"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)videoView:(GVRVideoView*)videoView didUpdatePosition:(NSTimeInterval)position {
    // Loop the video when it reaches the end.
    if (position == videoView.duration) {
        [_videoView seekTo:0];
        [_videoView play];
    }
}

@end
