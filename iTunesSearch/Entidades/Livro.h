//
//  Livro.h
//  iTunesSearch
//
//  Created by Andre Lucas Ota on 11/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Livro : NSObject

@property (nonatomic, strong) NSString *nome;
//@property (nonatomic, strong) NSString *trackId;
//@property (nonatomic, strong) NSString *artista;
//@property (nonatomic, strong) NSDate *duracao;
@property (nonatomic, strong) NSString *autor;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *ident;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *preco;

@end
