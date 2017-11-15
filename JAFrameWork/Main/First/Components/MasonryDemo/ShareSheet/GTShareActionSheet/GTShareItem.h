//
//  GTShareItem.h
//  UtopaClient
//
//  Created by Jacob on 2017/11/15.
//  Copyright © 2017年 GTLand_LeeMiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GTShareItemType) {
    GTShareItemTypeQQ = 1,
    GTShareItemTypeWeChatFriend,
    GTShareItemTypeWeChatCircle,
    GTShareItemTypeWeiBo,
    GTShareItemTypeRefresh,
    GTShareItemTypeCopyLink,
};

@interface GTShareItem : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *imgName;

@property (nonatomic,assign) GTShareItemType itemType;

@end
