//
//  ViewController.m
//  player
//
//  Created by Md Ibrahim Hassan on 17/05/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

#import "ViewController.h"
#import "HCYoutubeParser.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *videos = [HCYoutubeParser h264videosWithYoutubeURL:[NSURL URLWithString:@"<span class="VideoWrap:"><span class="Video: YouTube" data-youtube="youtube-8To-6VIJZRE?autoplay=1"><span class="VideoPreview"><a href="\/youtube.com/watch?v=8To-6VIJZRE"><img src="//img.youtube.com/vi/8To-6VIJZRE/0.jpg" width="640" height="385" border="0"></a></span><span class="VideoPlayer"></span></span></span>"]];
      
      // Presents a MoviePlayerController with the youtube quality medium
      MPMoviePlayerViewController *mp = [[[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:[videos objectForKey:@"medium"]]] autorelease];
      [self presentModalViewController:mp animated:YES];
      
      // To get a thumbnail for an image there is now a async method for that
//      [HCYoutubeParser thumbnailForYoutubeURL:url
//                                thumbnailSize:YouTubeThumbnailDefaultHighQuality
//                                completeBlock:^(UIImage *image, NSError *error) {
//                                    if (!error) {
//                                        self.thumbailImageView.image = image;
//                                    }
//                                    else {
//                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//                                        [alert show];
//                                    }
//                }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
