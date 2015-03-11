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

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController
@synthesize texto, botao, lang;


- (void)viewDidLoad {
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
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
    
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    [self.tableview setDelegate:self];
    [self.tableview setDataSource:self];
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarFilmes:self.texto.text];

#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
//    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
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
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
//    NSDateFormatter *formata = [[NSDateFormatter alloc] init];
//    [formata setDateFormat:@"HH:mm:ss"];
//    
//    NSString *string = [formata stringFromDate:filme.duracao];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:@"Filme"];
//    [celula.tempo setText:string];
    [celula.genero setText:filme.genero];
    [celula.pais setText:filme.pais];
    
    return celula;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (IBAction)busca:(id)sender {
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarFilmes:self.texto.text];
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
@end
