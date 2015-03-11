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
    [self midiaSelect:midias];
    
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

- (void)midiaSelect: (NSArray *) midia{
    iTunesManager *itunes = [iTunesManager sharedInstance];
    NSInteger i = self.tipoMidia.selectedSegmentIndex;
    
    arrayFilmes = [itunes buscarFilmes:self.texto.text];
    arrayMusicas = [itunes buscarMusica:self.texto.text];
    arrayPodcast = [itunes buscarPodcast:self.texto.text];
    arrayEBook = [itunes buscarLivro:self.texto.text];
    
    if(i == 0){
        midia = arrayFilmes;
    }
    else{
        if(i == 1){
            midia = arrayMusicas;
        }
        else{
            if(i == 2){
                midia = arrayPodcast;
            }
            else{
                if(i == 3){
                    midia = arrayEBook;
                }
                else{
                    NSArray *aux = [[[arrayFilmes arrayByAddingObjectsFromArray:arrayMusicas]arrayByAddingObjectsFromArray:arrayPodcast]arrayByAddingObjectsFromArray:arrayEBook];
                    midia = aux;
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    NSInteger i = self.tipoMidia.selectedSegmentIndex;
    
    if(i == 0){
        Filme *filme = [midias objectAtIndex:indexPath.row];
        
        [celula.nome setText:filme.nome];
        [celula.tipo setText:@"Filme"];
        [celula.genero setText:filme.genero];
        [celula.pais setText:filme.pais];
        
        return celula;
    }
    else{
        if(i == 1){
            Musica *musica = [midias objectAtIndex:indexPath.row];
            [celula.nome setText:musica.nome];
            [celula.tipo setText:@"Música"];
            [celula.genero setText:musica.genero];
            [celula.pais setText:musica.pais];
            
            return celula;
        }
        else{
            if(i == 2){
                Podcast *podcast = [midias objectAtIndex:indexPath.row];
                [celula.nome setText:podcast.nome];
                [celula.tipo setText:@"Podcast"];
                [celula.genero setText:podcast.genero];
                [celula.pais setText:podcast.pais];
                
                return celula;
            }
            else{
                Livro *livro = [midias objectAtIndex:indexPath.row];
                [celula.nome setText:livro.nome];
                [celula.tipo setText:@"Livro"];
                
                return celula;
            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (IBAction)busca:(id)sender {
    [self midiaSelect:midias];
//    midias = [itunes buscarFilmes:self.texto.text];
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
