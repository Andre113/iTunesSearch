//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Musica.h"
#import "Entidades/Podcast.h"
#import "Entidades/Livro.h"

@interface TableViewController () {
    NSArray *midias;
    NSArray *arrayFilmes;
    NSArray *arrayMusicas;
    NSArray *arrayPodcast;
    NSArray *arrayEBook;
}

@end

@implementation TableViewController
@synthesize texto, botao, lang, tipoMidia;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    [self.tableview setDelegate:self];
    [self.tableview setDataSource:self];
    
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    [self changeLang:language];
    [self search];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
//    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

- (void)changeLang: (NSString *)language{
    if([language isEqualToString:@"pt"]){
        [botao setTitle:@"Buscar" forState:UIControlStateNormal];
        [self.lang setSelectedSegmentIndex:0];
    }
    else{
        if([language isEqualToString:@"fr"]){
            [botao setTitle:@"Recherche" forState:UIControlStateNormal];
            [self.lang setSelectedSegmentIndex:2];
        }
        else{
            [botao setTitle:@"Search" forState:UIControlStateNormal];
            [self.lang setSelectedSegmentIndex:1];
        }
    }
}

- (void)search{
    iTunesManager *itunes = [iTunesManager sharedInstance];
    NSString *termo = self.texto.text;
    arrayFilmes = [itunes buscarFilmes:termo];
    arrayMusicas = [itunes buscarMusica:termo];
    arrayPodcast = [itunes buscarPodcast:termo];
    arrayEBook = [itunes buscarLivro:termo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger i = self.tipoMidia.selectedSegmentIndex;
    
    if(i != 4){
        return 1;
    }
    else{
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    NSInteger i = self.tipoMidia.selectedSegmentIndex;
    
    switch (i){
        case 0:{
            Filme *filme = [arrayFilmes objectAtIndex:indexPath.row];
            
            [celula.nome setText:filme.nome];
            [celula.tipo setText:@"Filme"];
            [celula.genero setText:filme.genero];
            [celula.pais setText:filme.pais];
            
            NSURL *imageURL = [NSURL URLWithString:filme.img];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            [celula.img setImage:[UIImage imageWithData:imageData]];
            
            break;
        }
        
        case 1:{
            Musica *musica = [arrayMusicas objectAtIndex:indexPath.row];
            [celula.nome setText:musica.nome];
            [celula.tipo setText:@"Música"];
            [celula.genero setText:musica.genero];
            [celula.pais setText:musica.pais];
            
            NSURL *imageURL = [NSURL URLWithString:musica.img];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            [celula.img setImage:[UIImage imageWithData:imageData]];
            
            break;
        }
        
        case 2:{
            Podcast *podcast = [arrayPodcast objectAtIndex:indexPath.row];
            [celula.nome setText:podcast.nome];
            [celula.tipo setText:@"Podcast"];
            [celula.genero setText:podcast.genero];
            [celula.pais setText:podcast.pais];
            
            NSURL *imageURL = [NSURL URLWithString:podcast.img];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            [celula.img setImage:[UIImage imageWithData:imageData]];
            
            break;
        }
        
        case 3:{
            Livro *livro = [arrayEBook objectAtIndex:indexPath.row];
            [celula.nome setText:livro.nome];
            [celula.tipo setText:@"Livro"];
            
            NSURL *imageURL = [NSURL URLWithString:livro.img];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            [celula.img setImage:[UIImage imageWithData:imageData]];
            
            break;
        }
        
        case 4:{
            if (indexPath.section == 0){
                Filme *filme = [arrayFilmes objectAtIndex:indexPath.row];
                [celula.nome setText:filme.nome];
                [celula.tipo setText:@"Filme"];
                [celula.genero setText:filme.genero];
                [celula.pais setText:filme.pais];
                [celula.img setImage:[UIImage imageNamed:filme.img]];
            }
            
            if (indexPath.section == 1){
                Musica *musica = [arrayMusicas objectAtIndex:indexPath.row];
                [celula.nome setText:musica.nome];
                [celula.tipo setText:@"Música"];
                [celula.genero setText:musica.genero];
                [celula.pais setText:musica.pais];
                [celula.img setImage:[UIImage imageNamed:musica.img]];
            }
            
            if (indexPath.section == 2){
                Podcast *podcast = [arrayPodcast objectAtIndex:indexPath.row];
                [celula.nome setText:podcast.nome];
                [celula.tipo setText:@"Podcast"];
                [celula.genero setText:podcast.genero];
                [celula.pais setText:podcast.pais];
                [celula.img setImage:[UIImage imageNamed:podcast.img]];
            }
            
            if (indexPath.section == 3){
                Livro *livro = [arrayEBook objectAtIndex:indexPath.row];
                [celula.nome setText:livro.nome];
                [celula.tipo setText:@"Livro"];
                [celula.img setImage:[UIImage imageNamed:livro.img]];
                break;
            }
        }
    }
    return celula;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger i = self.tipoMidia.selectedSegmentIndex;
    
    if(i==4){
        if (section == 0)
            return arrayFilmes.count;
        
        if (section == 1)
            return arrayMusicas.count;
        
        if (section == 2)
            return arrayPodcast.count;
        
        if (section == 3)
            return arrayEBook.count;
    }
    else{
        if (i==0){
            return arrayFilmes.count;
        }
        else{
            if(i==1){
                return arrayMusicas.count;
            }
            else{
                if(i==2){
                    return arrayPodcast.count;
                }
                else{
                    return arrayEBook.count;
                }
            }
        }
    }
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Filmes";
    if (section == 1)
        return @"Musica";
    if(section == 2)
        return @"Podcast";
    if (section == 3)
        return @"eBook";
    return @"undefined";
}

- (IBAction)busca:(id)sender {
    [self search];
    [self.tableview reloadData];
}

- (IBAction)trocaLang:(id)sender {
    botao.enabled = false;
    
    NSInteger i = self.lang.selectedSegmentIndex;
    
    if (i==0){
        [botao setTitle:@"Buscar" forState:UIControlStateNormal];
    }
    else{
        if(i==1){
            [botao setTitle:@"Search" forState:UIControlStateNormal];
        }
        else{
            [botao setTitle:@"Recherche" forState:UIControlStateNormal];
        }
    }
    botao.enabled = true;
}

- (IBAction)trocaMidia:(id)sender {
    [self busca:self];
}
@end
