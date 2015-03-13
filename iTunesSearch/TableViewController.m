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
#import "CelulaViewController.h"
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
    
//    Delegates
    [self.tableview setDelegate:self];
    [self.tableview setDataSource:self];
    [self.texto setDelegate:self];
    
//    Troca linguagem e executa busca
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    [self changeLang:language];
    [self search];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
//    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

//Trocar a linguagem dependendo do sistema
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

//Realiza a busca de todos os tipos de mídia
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

//Monta a table dependendo da aba selecionada
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
            [celula.genero setText:livro.autor];
            
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
                
                NSURL *imageURL = [NSURL URLWithString:filme.img];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                [celula.img setImage:[UIImage imageWithData:imageData]];
            }
            
            if (indexPath.section == 1){
                Musica *musica = [arrayMusicas objectAtIndex:indexPath.row];
                [celula.nome setText:musica.nome];
                [celula.tipo setText:@"Música"];
                [celula.genero setText:musica.genero];
                [celula.pais setText:musica.pais];
                
                NSURL *imageURL = [NSURL URLWithString:musica.img];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                [celula.img setImage:[UIImage imageWithData:imageData]];
            }
            
            if (indexPath.section == 2){
                Podcast *podcast = [arrayPodcast objectAtIndex:indexPath.row];
                [celula.nome setText:podcast.nome];
                [celula.tipo setText:@"Podcast"];
                [celula.genero setText:podcast.genero];
                [celula.pais setText:podcast.pais];
                
                NSURL *imageURL = [NSURL URLWithString:podcast.img];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                [celula.img setImage:[UIImage imageWithData:imageData]];
            }
            
            if (indexPath.section == 3){
                Livro *livro = [arrayEBook objectAtIndex:indexPath.row];
                [celula.nome setText:livro.nome];
                [celula.tipo setText:@"Livro"];
                [celula.genero setText:livro.autor];
                
                NSURL *imageURL = [NSURL URLWithString:livro.img];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                [celula.img setImage:[UIImage imageWithData:imageData]];
            }
        }
    }
    return celula;

}

//Define o número de linhas nas sections
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

//Seleciona o tamanho da célula
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

//Seleciona o título das sections
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSInteger i = self.tipoMidia.selectedSegmentIndex;
    if (section == 0){
        if(i==0 || i==4){
            return @"Filme";
        }
        else{
            if(i==1){
                return @"Música";
            }
            else{
                if(i==2){
                    return @"Podcast";
                }
                else{
                    return @"eBook";
                }
            }
        }
    }
    
    if (section == 1)
        return @"Musica";
    if(section == 2)
        return @"Podcast";
    if (section == 3)
        return @"eBook";
    return @"undefined";
}

////Para outra view
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger i = self.tipoMidia.selectedSegmentIndex;
//    CelulaViewController *cel = [[CelulaViewController alloc]init];
//    
////    Filme *filme = [arrayFilmes objectAtIndex:indexPath.row];
////    [cel.titulo setText:filme.nome];
//    
//    if(i==4){
//        switch(indexPath.section){
//            case 0:{
//                Filme *filme = [arrayFilmes objectAtIndex:indexPath.row];
//                [cel.titulo setText:@"teste"];
//                [cel.tipo setText:@"Filme"];
//                [cel.genero setText:filme.genero];
//                [cel.preco setText:filme.preco];
//                break;
//            }
//        }
//        switch(indexPath.section){
//            case 1:{
//                Musica *musica = [arrayMusicas objectAtIndex:indexPath.row];
//                [cel.titulo setText:musica.nome];
//                [cel.tipo setText:@"Musica"];
//                [cel.genero setText:musica.genero];
//                [cel.preco setText:musica.preco];
//                break;
//            }
//        }
//        switch(indexPath.section){
//            case 2:{
//                Podcast *podcast = [arrayPodcast objectAtIndex:indexPath.row];
//                [cel.titulo setText:podcast.nome];
//                [cel.tipo setText:@"Podcast"];
//                [cel.genero setText:podcast.genero];
//                [cel.preco setText:podcast.preco];
//                break;
//            }
//        }
//        switch(indexPath.section){
//            case 3:{
//                Livro *livro = [arrayEBook objectAtIndex:indexPath.row];
//                [cel.titulo setText:livro.nome];
//                [cel.tipo setText:@"Livro"];
//                [cel.genero setText:livro.autor];
//                [cel.preco setText:livro.preco];
//                break;
//            }
//        }
//    }
//    else{
//        if(i == 0){
//            Filme *filme = [arrayFilmes objectAtIndex:indexPath.row];
//            [cel.titulo setText:filme.nome];
//            [cel.tipo setText:@"Filme"];
//            [cel.genero setText:filme.genero];
//            [cel.preco setText:filme.preco];
//        }
//        else{
//            if(i == 1){
//                Musica *musica = [arrayMusicas objectAtIndex:indexPath.row];
//                [cel.titulo setText:musica.nome];
//                [cel.tipo setText:@"Musica"];
//                [cel.genero setText:musica.genero];
//                [cel.preco setText:musica.preco];
//            }
//            else{
//                if(i == 2){
//                    Podcast *podcast = [arrayPodcast objectAtIndex:indexPath.row];
//                    [cel.titulo setText:podcast.nome];
//                    [cel.tipo setText:@"Podcast"];
//                    [cel.genero setText:podcast.genero];
//                    [cel.preco setText:podcast.preco];
//                }
//                else{
//                    Livro *livro = [arrayEBook objectAtIndex:indexPath.row];
//                    [cel.titulo setText:livro.nome];
//                    [cel.tipo setText:@"Livro"];
//                    [cel.genero setText:livro.autor];
//                    [cel.preco setText:livro.preco];
//                }
//            }
//        }
//    }
//    [self.navigationController pushViewController:cel animated:YES];
//}

// Para colocar imagens na section
//- (UIView *)tableView : (UITableView *)tableView viewForHeaderInSection : (NSInteger) section {
//    UIImageView *img;
//    if (section == 4){
//        
//    }
//    else{
//        if (section == 0){
//            img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
//        }
//        if (section == 1){
//            
//        }
//            
//        if (section == 2){
//            
//        }
//        
//        if (section == 3){
//            
//        }
//    }
//        
//    return img;
//}

//Apertar o botão busca
- (IBAction)busca:(id)sender {
    [self search];
    [self.tableview reloadData];
}

//Trocar a linguagem ao selecionar
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

//Teclado some ao clicar na tela
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

//Teclado desaparece ao apertar return. Realiza busca ao clicar em return
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self busca:self];
    return YES;
}

//Ao trocar de aba
- (IBAction)trocaMidia:(id)sender {
    [self busca:self];
}
@end
