//
//  CelulaViewController.m
//  iTunesSearch
//
//  Created by Andre Lucas Ota on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "CelulaViewController.h"

@interface CelulaViewController ()

@end

@implementation CelulaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.titulo setText:_txt];
    [self.tipo setText:_kind];
    [self.genero setText:_gen];
    [self.preco setText:_custo];
    
    NSURL *imageURL = [NSURL URLWithString:_img];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    [self.capa setImage:[UIImage imageWithData:imageData]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
