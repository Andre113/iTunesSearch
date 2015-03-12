//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/Livro.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

- (NSArray *)pesquisa:(NSString *) termoUsado :(NSString *)tipo{
    
//    if (!termoUsado) {
//        termoUsado = @"";
//    }
    
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=%@", termoUsado, tipo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    return resultados;
}

- (NSArray *)buscarFilmes:(NSString *)termo {
    
    NSArray *resultados = [self pesquisa:termo: @"movie"];
    
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Filme *filme = [[Filme alloc] init];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setPais:[item objectForKey:@"country"]];
        [filme setIdent:[item objectForKey:@"kind"]];
        [filme setImg:[item objectForKey:@"artworkUrl100"]];
        [filmes addObject:filme];
    }
    
    return filmes;
}

- (NSArray *)buscarMusica:(NSString *)termo {
    
    NSArray *resultados = [self pesquisa:termo :@"music"];
    
    NSMutableArray *musicas = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Musica *musica = [[Musica alloc] init];
        [musica setNome:[item objectForKey:@"trackName"]];
        [musica setGenero:[item objectForKey:@"primaryGenreName"]];
        [musica setPais:[item objectForKey:@"country"]];
        [musica setIdent:[item objectForKey:@"kind"]];
        [musica setImg:[item objectForKey:@"artworkUrl100"]];
        [musicas addObject:musica];
    }
    
    return musicas;
}

- (NSArray *)buscarPodcast:(NSString *)termo{
    NSArray *resultados = [self pesquisa:termo :@"podcast"];
    
    NSMutableArray *podcasts = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Podcast *podcast = [[Podcast alloc] init];
        [podcast setNome:[item objectForKey:@"trackName"]];
        [podcast setGenero:[item objectForKey:@"primaryGenreName"]];
        [podcast setPais:[item objectForKey:@"country"]];
        [podcast setIdent:[item objectForKey:@"kind"]];
        [podcast setImg:[item objectForKey:@"artworkUrl100"]];
        [podcasts addObject:podcast];
    }
    
    return podcasts;
}

- (NSArray *)buscarLivro:(NSString *)termo{
    NSArray *resultados = [self pesquisa:termo :@"ebook"];
    
    NSMutableArray *livros = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Livro *livro = [[Livro alloc] init];
        [livro setNome:[item objectForKey:@"trackName"]];
        [livro setGenero:[item objectForKey:@"primaryGenreName"]];
        [livro setPais:[item objectForKey:@"country"]];
        [livro setIdent:[item objectForKey:@"kind"]];
        [livro setImg:[item objectForKey:@"artworkUrl100"]];
        [livros addObject:livro];
    }
    
    return livros;
}


#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
