//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTunesManager : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (iTunesManager*)sharedInstance;

- (NSArray *)buscarFilmes:(NSString *)termo;
- (NSArray *)buscarMusica:(NSString *)termo;
- (NSArray *)buscarPodcast:(NSString *)termo;
- (NSArray *)buscarLivro:(NSString *)termo;

@end
