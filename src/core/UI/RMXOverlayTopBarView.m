/*
 Copyright 2016-present Google Inc. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "RMXOverlayTopBarView.h"

#import "RMXOverlayResources.h"

@interface RMXOverlayTopBarView ()


@end

@implementation RMXOverlayTopBarView

static CGFloat kButtonHeight = 40.0f;
NSString *const kTitleRemixer = @"Remixer";
NSString *const kButtonTitleNearby = @"NEARBY";

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.25;

    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setFrame:CGRectMake(8, 0, kButtonHeight, kButtonHeight)];
    [_closeButton setImage:RMXResources(RMXIconClose) forState:UIControlStateNormal];
    [_closeButton setTintColor:[UIColor blackColor]];
    [self addSubview:_closeButton];

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.text = kTitleRemixer;
    [_titleLabel setTextColor:[UIColor blackColor]];
    [self addSubview:_titleLabel];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
  _closeButton.center = CGPointMake(_closeButton.center.x, self.center.y);
  [_titleLabel sizeToFit];
  _titleLabel.center =
      CGPointMake(CGRectGetMaxX(_closeButton.frame) + 8 + CGRectGetMidX(_titleLabel.bounds),
                  self.center.y);
}

@end
