//
//  GTBaseVCMethods.h
//  JAFrameWork
//
//  Created by Jacob_Liang on 2017/11/26.
//  Copyright © 2017年 Jacob. All rights reserved.
//

#ifndef GTBaseVCMethods_h
#define GTBaseVCMethods_h

@interface UIScrollView (LeeMJRefresh)
#pragma mark - normal
-(void)Lee_normalHeaderRefreshWithBlock:(void (^)(void))block;

-(void)Lee_endNormalHeaderRefresh;

-(void)Lee_beginNormalHeaderRefresh;



-(void)Lee_normalFooterRefreshWithBlock:(void (^)(void))block;

-(void)Lee_endNormalFooterRefresh;

-(void)Lee_endNormalFooterRefreshWithNoMoreData;
//

@end


#endif /* GTBaseVCMethods_h */
