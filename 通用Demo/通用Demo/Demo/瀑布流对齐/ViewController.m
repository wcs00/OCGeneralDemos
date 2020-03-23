//
//  ViewController.m
//  CollectionViewAlignmentFlowLayout
//
//  Created by Wcs on 2020/3/13.
//  Copyright © 2020 wcs. All rights reserved.
//

#import "ViewController.h"
#import "AlignmentCollectionViewFlowLayout.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupSubviews];
    [self test];
}
- (void)test{}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


- (void)setupSubviews {
//    AlignmentCollectionViewFlowLayout *flowLayout = [[AlignmentCollectionViewFlowLayout alloc] initWithAlignmentType:AlignmentTypeLeft verticalSpace:10];
    AlignmentCollectionViewFlowLayout *flowLayout = [[AlignmentCollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.verticalSpace = 20;
    flowLayout.type = NSTextAlignmentCenter;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 20;
    
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 30);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 20, 300, 400) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor blackColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:collectionView];
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
@end
