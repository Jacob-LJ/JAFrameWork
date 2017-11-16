//
//  PopMenuController.m
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/16.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#import "PopMenuController.h"
#import "CommonMenuView.h"

@interface PopMenuController ()

@property (nonatomic,assign) BOOL flag;
@property (nonatomic,assign) int itemCount;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation PopMenuController {
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    /**
     *  rightBarButton的点击标记，每次点击更改flag值。
     *  如果您用普通的button就不需要设置flag，通过按钮的seleted属性来控制即可
     */
    self.flag = YES;
    
    /**
     *  这些数据是菜单显示的图片名称和菜单文字，请各位大牛指教，如果有更好的方法：
     *  QQ :  827023449  (好友验证的问题随便写，最好有针对性)
     *  e-mail : KongPro@163.com，喜欢请在github上点颗星星，不胜感激！ 🙏
     *  GitHub : https://github.com/KongPro/PopMenuTableView
     */
    MenuModel *model1 = [[MenuModel alloc] init];
    model1.imageName = @"icon_button_affirm";
    model1.itemName = @"撤回";

    MenuModel *model2 = [[MenuModel alloc] init];
    model2.imageName = @"icon_button_recall";
    model2.itemName = @"确认";
    
    MenuModel *model3 = [[MenuModel alloc] init];
    model3.imageName = @"icon_button_record";
    model3.itemName = @"记录";
    
    NSArray *dataArray = @[model1,model2,model3];
    _dataArray = dataArray;
    
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建普通的MenuView，frame可以传递空值，宽度默认120，高度自适应
     */
    [CommonMenuView createMenuWithFrame:CGRectZero dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag]; // do something
    } backViewTap:^{
        weakSelf.flag = YES; // 这里的目的是，让rightButton点击，可再次pop出menu
    }];
}

- (void)setUpNav {
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(popMenuAdd:)];
    UIBarButtonItem *composeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(popMenuCompose:)];
    
    UIBarButtonItem *actionItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(popMenuAction:)];
    UIBarButtonItem *organizeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(popMenuOrganize:)];
    
    self.navigationItem.leftBarButtonItems = @[addItem, actionItem];
    self.navigationItem.rightBarButtonItems = @[organizeItem, composeItem];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    [CommonMenuView showMenuAtPoint:point];
}

#pragma mark - Nav上的四个button
- (void)popMenuAdd:(id)sender {
    CGFloat topMargin = isiPhoneX?30:0;
    [self popMenu:CGPointMake(30, 50 + topMargin)];
}
                                
- (void)popMenuOrganize:(id)sender {
    CGFloat topMargin = isiPhoneX?30:0;
    [self popMenu:CGPointMake(self.navigationController.view.width - 30, 50 + + topMargin)];
}
                                
- (void)popMenuCompose:(id)sender {
    CGFloat topMargin = isiPhoneX?30:0;
    [self popMenu:CGPointMake(self.navigationController.view.width - 80, 50 + topMargin)];
}
                                
- (void)popMenuAction:(id)sender {
    CGFloat topMargin = isiPhoneX?30:0;
    [self popMenu:CGPointMake(75, 50 + topMargin)];
}



- (void)popMenu:(CGPoint)point{
    if (self.flag) {
        [CommonMenuView showMenuAtPoint:point];
        self.flag = NO;
    }else{
        [CommonMenuView hideMenu];
        self.flag = YES;
    }
}

#pragma mark  -- 增加一个菜单项
- (IBAction)addMenuItem:(id)sender {
    
    MenuModel *addModel = [[MenuModel alloc] init];
    addModel.imageName = @"icon_button_recall";
    addModel.itemName = [NSString stringWithFormat:@"新增项%d",self.itemCount + 1];
    
    NSArray *newItemArray = @[addModel];
    /**
     *  追加菜单项
     */
    [CommonMenuView appendMenuItemsWith:newItemArray];
    
    self.itemCount ++;
    self.numberLabel.text = [NSString stringWithFormat:@"累计增加  %d  项", self.itemCount];
}

#pragma mark -- 恢复菜单项
- (IBAction)removeMenuItem:(id)sender {
    /**
     *  更新菜单
     */
    [CommonMenuView updateMenuItemsWith:_dataArray];
    
    self.itemCount = 0;
    self.numberLabel.text = [NSString stringWithFormat:@"累计增加 %d 项", self.itemCount];
}

#pragma mark - 回调事件(自定义)
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:str message:[NSString stringWithFormat:@"点击了第%ld个菜单项",tag] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
    [CommonMenuView hideMenu];
    self.flag = YES;
}

#pragma mark - dealloc
- (void)dealloc{
    [CommonMenuView clearMenu];   // 移除菜单
}

@end
