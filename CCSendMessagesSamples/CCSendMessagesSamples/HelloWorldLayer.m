//
//  HelloWorldLayer.m
//  CCSendMessagesSamples
//
//  Created by 畑 圭輔 on 11/12/14.
//  Copyright keisuke.hata 2011年. All rights reserved.
//


// Import the interfaces
#import <AVFoundation/AVFoundation.h>
#import "HelloWorldLayer.h"
#import "CCSendMessages.h"

#define __USE_CCSENDMESSAGES 0

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

- (void) animationStart {

    CCLOG(@"アニメーション開始");
}

#if __USE_CCSENDMESSAGES == 0

- (void) changeSpriteAttribute:(void *)data {
    
    CCSprite *sprite = (CCSprite *)data;
    NSAssert( [sprite isKindOfClass:[CCSprite class]] == TRUE,@"This isn't CCSprite class" );
   
    sprite.scale   = 2.0;
    sprite.opacity = 128;
}

#endif

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) {

        CCSprite *iconImage = [CCSprite spriteWithFile:@"Icon.png"];
        iconImage.position = ccp( 100, 100 );
        [self addChild:iconImage];

        #if __USE_CCSENDMESSAGES == 1

            // アニメーション開始メソッドを呼び出す
            CCSendMessages *message1 = [CCSendMessages actionWithTarget:self];
            [[message1 addMessage] animationStart];

            // 2倍拡大＆不透明度を半分に
            CCSendMessages *message2 = [CCSendMessages actionWithTarget:iconImage];
            [(CCSprite *)[message2 addMessage] setOpacity:128];
            [(CCSprite *)[message2 addMessage] setScale:2.0];

            // シーケンスアニメーション生成
            // 1) animationStartメソッドを呼び出す
            // 2) 1秒待つ
            // 3) 2倍拡大＆不透明度を半分に
            CCSequence *seq = nil;[CCSequence actions:
                    message1,
                    [CCDelayTime actionWithDuration:1.0],
                    message2,
                    nil];

            [iconImage runAction:seq];
        #else

            // アニメーション開始メソッドを呼び出す
            CCCallFunc *callFunc1 = [CCCallFunc actionWithTarget:self
                                                        selector:@selector(animationStart)];
        
            // 2倍拡大＆不透明度を半分に
            CCCallFuncND *callFunc2 = [CCCallFuncND actionWithTarget:self
                                                           selector:@selector(changeSpriteAttribute:)
                                                               data:iconImage];

            // シーケンスアニメーション生成
            // 1) animationStartメソッドを呼び出す
            // 2) 1秒待つ
            // 3) 2倍拡大＆不透明度を半分に
            CCSequence *seq = [CCSequence actions:callFunc1,
                            [CCDelayTime actionWithDuration:1.0],
                            callFunc2,
                            nil];

            [iconImage runAction:seq];
        #endif
    }
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
