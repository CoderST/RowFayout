//
//  ViewController.m
//  STRowFlowLayout
//
//  Created by xiudou on 2016/11/19.
//  Copyright © 2016年 STCode. All rights reserved.
//

#import "ViewController.h"
#import "STRowLayout.h"
#import "TestModel.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,STRowLayoutDelegate>
/** 总数据 */
@property (nonatomic,strong) NSMutableArray *dataArray;
/** <#name#> */
@property (nonatomic,weak) UICollectionView *collectionView;
@end

@implementation ViewController
static  NSString *cellIdentifier = @"cellIdentifier";
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 创建collectionView
    [self setupCollectionView];
    
    // 2 添加一个按钮
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(self.view.bounds.size.width - 100, 30, 80, 40);
    button.backgroundColor = [UIColor purpleColor];
    [button setTitle:@"添加一条数据" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    button.layer.cornerRadius = button.frame.size.height * 0.5;
    button.clipsToBounds = YES;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    }

- (void)buttonClick{
    TestModel *model = [[TestModel alloc] init];
    // 2 创建数据
    model.width = arc4random() % 50 + 50;
    [self.dataArray addObject:model];
    [self.collectionView reloadData];
}

- (void)setupCollectionView{
    STRowLayout *layout = [[STRowLayout alloc] init];
    
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height - 80) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了第%zd个item",indexPath.item);
}

#pragma mark - STRowLayoutDelegate
- (CGFloat)stLayout:(STRowLayout *)stLayout widthtForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestModel *model = self.dataArray[indexPath.item];
    
    return model.width;
}

- (CGFloat)heightForRowAtIndexPath:(STRowLayout *)stLayout{
    
    return 40;
}

- (CGFloat)layoutcolumnSpacingStLayout:(STRowLayout *)stLayout{
    
    return 20;
}


@end
