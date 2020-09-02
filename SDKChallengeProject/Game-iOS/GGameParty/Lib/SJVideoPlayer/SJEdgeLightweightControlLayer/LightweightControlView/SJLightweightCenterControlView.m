//
//  SJLightweightCenterControlView.m
//  SJVideoPlayerProject
//
//  Created by BlueDancer on 2018/3/21.
//  Copyright © 2018年 SanJiang. All rights reserved.
//

#import "SJLightweightCenterControlView.h"
//#import <Masonry/Masonry.h>
//#import <SJAttributesFactory/SJAttributeWorker.h>
//#import <SJUIFactory/SJUIFactory.h>
#import "UIView+SJVideoPlayerSetting.h"

@interface SJLightweightCenterControlView ()

@property (nonatomic, strong, readonly) UIButton *failedBtn;
@property (nonatomic, strong, readonly) UIButton *replayBtn;

@end

@implementation SJLightweightCenterControlView
@synthesize failedBtn = _failedBtn;
@synthesize replayBtn = _replayBtn;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( !self ) return nil;
    [self _centerSetupView];
    [self _centerSettings];
    return self;
}

- (CGSize)intrinsicContentSize {
    CGFloat w = ceil(SJScreen_Min() * 0.382);
    return CGSizeMake(w, w);
}

- (void)clickedBtn:(UIButton *)btn {
    if ( ![_delegate respondsToSelector:@selector(centerControlView:clickedBtnTag:)] ) return;
    [_delegate centerControlView:self clickedBtnTag:btn.tag];
}

- (void)failedState {
    self.replayBtn.hidden = YES;
    self.failedBtn.hidden = NO;
}

- (void)replayState {
    self.replayBtn.hidden = NO;
    self.failedBtn.hidden = YES;
}

- (void)_centerSetupView {
    [self addSubview:self.failedBtn];
    [self addSubview:self.replayBtn];
    [_failedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    
    [_replayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}

- (UIButton *)failedBtn {
    if ( _failedBtn ) return _failedBtn;
    _failedBtn = [SJUIButtonFactory buttonWithImageName:@"" target:self sel:@selector(clickedBtn:) tag:SJLightweightCenterControlViewTag_Failed];
    return _failedBtn;
}
- (UIButton *)replayBtn {
    if ( _replayBtn ) return _replayBtn;
    _replayBtn = [SJUIButtonFactory buttonWithImageName:@"" target:self sel:@selector(clickedBtn:) tag:SJLightweightCenterControlViewTag_Replay];
    _replayBtn.titleLabel.numberOfLines = 0;
    return _replayBtn;
}

- (void)_centerSettings {
    __weak typeof(self) _self = self;
    self.settingRecroder = [[SJVideoPlayerControlSettingRecorder alloc] initWithSettings:^(SJEdgeControlLayerSettings * _Nonnull setting) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        
        [self.replayBtn setAttributedTitle:sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
            if ( setting.replayBtnImage ) {
                make.insert(setting.replayBtnImage, 0, CGPointZero, setting.replayBtnImage.size);
            }
            if ( setting.replayBtnImage && 0 != setting.replayBtnTitle.length ) {
                make.insertText(@"\n", -1);
            }
            
            if ( 0 != setting.replayBtnTitle.length ) {
                make.insert([NSString stringWithFormat:@"%@", setting.replayBtnTitle], -1);
                make.lastInserted(^(SJAttributesRangeOperator * _Nonnull lastOperator) {
                    lastOperator
                    .font(setting.replayBtnFont)
                    .textColor(setting.replayBtnTitleColor);
                });
            }
            make.alignment(NSTextAlignmentCenter).lineSpacing(6);
        }) forState:UIControlStateNormal];
        
        
        [self.failedBtn setAttributedTitle:sj_makeAttributesString(^(SJAttributeWorker * _Nonnull make) {
            if ( setting.playFailedBtnImage ) {
                make.insert(setting.playFailedBtnImage, 0, CGPointZero, setting.playFailedBtnImage.size);
            }
            if ( setting.playFailedBtnImage && 0 != setting.playFailedBtnTitle.length ) {
                make.insertText(@"\n", -1);
            }
            
            if ( 0 != setting.playFailedBtnTitle.length ) {
                make.insert([NSString stringWithFormat:@"%@", setting.playFailedBtnTitle], -1);
                make.lastInserted(^(SJAttributesRangeOperator * _Nonnull lastOperator) {
                    lastOperator
                    .font(setting.playFailedBtnFont)
                    .textColor(setting.playFailedBtnTitleColor);
                });
            }
            make.alignment(NSTextAlignmentCenter).lineSpacing(6);
        }) forState:UIControlStateNormal];
        
    }];
}

@end

