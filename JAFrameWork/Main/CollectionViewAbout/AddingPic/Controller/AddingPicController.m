//
//  AddingPicController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/10/25.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "AddingPicController.h"
#import "APImageCCell.h"

static const CGFloat kDefaultMargin = 12;
static const CGFloat kColumn = 3.0;
static const NSInteger kMaxImageCount = 6;

static NSString * const GTAPImageCCellID = @"GTAPImageCCell";

@interface AddingPicController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) CGFloat itemWH;
@property (nonatomic, strong) UICollectionView *colletionV;
@property (nonatomic, strong) NSMutableArray *imageModelArrM;

@end

@implementation AddingPicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
}

- (void)setUpCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    CGFloat itemWH = (JAScreenW - (kColumn + 1) * flowLayout.minimumInteritemSpacing - 2 * kDefaultMargin) / kColumn;
    self.itemWH = itemWH;
    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
    [collectionView registerClass:[APImageCCell class] forCellWithReuseIdentifier:GTAPImageCCellID];
    [self.view addSubview:collectionView];
    self.colletionV = collectionView;
    
    [self.colletionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(32);
        make.left.equalTo(self.view).offset(kDefaultMargin);
        make.right.equalTo(self.view).offset(-kDefaultMargin);
        make.height.mas_equalTo(itemWH);
    }];
    
}


#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.imageModelArrM.count == kMaxImageCount) {
        return self.imageModelArrM.count;
    } else {
        return self.imageModelArrM.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    APImageCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GTAPImageCCellID forIndexPath:indexPath];
    JAWeakSelf;
    cell.deleteImageBlock = ^(NSInteger index) {
        [weakSelf deleteCCellImageWihtIndex:index];
    };
    cell.index = row;
    if (self.imageModelArrM.count) {
        if (row == self.imageModelArrM.count) { //最后一个
            if (row == self.imageModelArrM.count - 1) { //最大图片数最后一个
                cell.type = APImageCCellType_image;
//                cell.image = self.imageModelArrM[row].img;
            } else {
                cell.type = APImageCCellType_add;
            }
        } else {
            cell.type = APImageCCellType_image;
//            cell.image = self.imageModelArrM[row].img;
        }
    } else {
        cell.type = APImageCCellType_add;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击-- %@",indexPath);
    APImageCCell *ccell = (APImageCCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (ccell.type == APImageCCellType_add) {
        //添加图片
//        TZImagePickerController *imagePick = [[TZImagePickerController alloc] initWithMaxImagesCount:(kMaxImageCount - self.imageModelArrM.count) delegate:self];
//        [self presentViewController:imagePick animated:YES completion:NULL];
    }
}

//#pragma mark - TZImagePickerControllerDelegate
//- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
//
//    if (isSelectOriginalPhoto) {
//        self.assets = [NSArray arrayWithArray:assets];
//        self.photos = [NSArray arrayWithArray:photos];
//        self.flag = 0;
//        self.originImageArrM = [NSMutableArray arrayWithCapacity:1];
//        //递归获取原图
//        [self getOriginImages];
//
//    } else {
//
//        [self boxImageWithUploadPicDataModel:photos];
//        [self caculateCollectionVH];
//        [self.colletionV reloadData];
//    }
//
//}

#pragma mark - private aciton
- (void)deleteCCellImageWihtIndex:(NSInteger)index {
    [self.imageModelArrM removeObjectAtIndex:index];
    [self caculateCollectionVH];
    [self.colletionV reloadData];
}

- (void)caculateCollectionVH {
    
    NSInteger count = 1;
    if (self.imageModelArrM.count == kMaxImageCount) {
        count = kMaxImageCount;
    } else {
        count = self.imageModelArrM.count + 1;
    }
    
    NSInteger maxRow = (count + kColumn - 1) / kColumn;
    [self.colletionV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(maxRow * self.itemWH);
    }];
    [self.view layoutIfNeeded];
}

//- (void)boxImageWithUploadPicDataModel:(NSArray *)photos {
//
//    NSMutableArray *uploadImageArray = [NSMutableArray arrayWithCapacity:1];
//    for (int i = 0; i < photos.count; i++) {
//        UIImage *image = photos[i];
//        GTUpLoadPictureDataModel *model = [[GTUpLoadPictureDataModel alloc] init];
//        model.img = image;
//        [uploadImageArray addObject:model];
//    }
//    [self.imageModelArrM addObjectsFromArray:uploadImageArray];
//}

@end
