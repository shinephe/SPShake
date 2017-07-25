//
//  SPTools.m
//  SPShake
//
//  Created by shinephe on 2017/7/21.
//  Copyright © 2017年 shinephe. All rights reserved.
//

#import "SPTools.h"
#import <AVFoundation/AVFoundation.h>

@interface SPTools ()

@end


@implementation SPTools

+ (void)playMusic:(NSString *)fileName {
    
    if (!fileName) {
        
        return;
    }
    
    AVAudioPlayer *musicPlayer = nil;
    
    if ([self getMusicDictionary][fileName]) {
        
        musicPlayer = [self getMusicDictionary][fileName];

    }
    else {
    
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        
        if (!fileURL) {
            
            return;
        }
        
        musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        
        [self getMusicDictionary][fileName] = musicPlayer;
    }
   
    if (!musicPlayer.isPlaying) {
       
        [musicPlayer play];
    }
}

static NSMutableDictionary *_musicDictionary;
+ (NSMutableDictionary *)getMusicDictionary {

    if (!_musicDictionary) {
        
        _musicDictionary = [[NSMutableDictionary alloc]init];
    }
    return _musicDictionary;
}

@end
