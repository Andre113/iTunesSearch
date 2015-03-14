//
//  CelulaViewController.h
//  iTunesSearch
//
//  Created by Andre Lucas Ota on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CelulaViewController : UIViewController

@property (weak, nonatomic) NSString* txt;
@property (weak, nonatomic) NSString* img;
@property (weak, nonatomic) NSString* kind;
@property (weak, nonatomic) NSString* gen;
@property (weak, nonatomic) NSString* custo;

@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UIImageView *capa;
@property (weak, nonatomic) IBOutlet UILabel *tipo;
@property (weak, nonatomic) IBOutlet UILabel *genero;
@property (weak, nonatomic) IBOutlet UILabel *preco;

@end
