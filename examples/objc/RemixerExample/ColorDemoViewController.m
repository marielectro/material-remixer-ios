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

#import "ColorDemoViewController.h"

#import "Remixer.h"

@interface ColorDemoView : UIView
@property(nonatomic, assign) CGFloat leftPadding;
@end

@implementation ColorDemoView {
  UIView *_box;
  CGFloat _topPadding;
  CGFloat _boxSideLength;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    
    _box = [[UIView alloc] initWithFrame:CGRectZero];
    _box.alpha = [_box alphaRemixForKey:@"alpha" updateProperty:@"alpha"];
    _box.backgroundColor = [_box colorRemixForKey:@"colorPicker" updateProperty:@"backgroundColor"];
    _box.hidden = [_box booleanRemixForKey:@"hidden" updateProperty:@"hidden"];
    [self addSubview:_box];
    
    _leftPadding = [self layoutRemixForKey:@"leftPadding" updateProperty:@"leftPadding"];
    _topPadding = [self layoutRemixForKey:@"topPadding" updateProperty:@"topPadding"];
    _boxSideLength = [self layoutRemixForKey:@"boxSideLength" updateProperty:@"boxSideLength"];
    
    // Add segment control.
    NSArray *themesOptions = @[ @"Light", @"Dark" ];
    [RMXItemListRemix addItemListRemixWithKey:@"theme"
                                 defaultValue:themesOptions[0]
                                     itemList:themesOptions
                                  updateBlock:^(RMXRemix *_Nonnull remix, id selectedValue) {
                                    self.backgroundColor =
                                        ([selectedValue isEqualToString:@"Light"])
                                            ? [UIColor whiteColor]
                                            : [UIColor darkGrayColor];
                                  }];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  _box.frame = CGRectMake(_leftPadding, _topPadding, _boxSideLength, _boxSideLength);
}

@end

@interface ColorDemoViewController ()
@property(nonatomic, strong) ColorDemoView *view;
@end

@implementation ColorDemoViewController

@dynamic view;

- (void)loadView {
  self.view = [[ColorDemoView alloc] initWithFrame:CGRectZero];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [RMXRemixer removeAllRemixes];
}

@end
