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

#import "RMXCellTextInput.h"

@interface RMXCellTextInput () <UITextFieldDelegate>
@end

@implementation RMXCellTextInput {
  UITextField *_textField;
}

@dynamic variable;

+ (CGFloat)cellHeight {
  return RMXCellHeightLarge;
}

- (void)setVariable:(RMXStringVariable *)variable {
  [super setVariable:variable];
  if (!variable) {
    return;
  }

  _textField = [[UITextField alloc] initWithFrame:CGRectZero];
  _textField.text = self.variable.selectedValue;
  _textField.returnKeyType = UIReturnKeyDone;
  _textField.delegate = self;
  [self.controlViewWrapper addSubview:_textField];

  self.detailTextLabel.text = variable.title;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _textField.frame = self.controlViewWrapper.bounds;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  _textField = nil;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  [self.delegate cellRequestedFullScreenOverlay:self];
  return YES;
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *currentValue =
      [textField.text stringByReplacingCharactersInRange:range withString:string];
  [self.variable setSelectedValue:currentValue];
  [self.variable save];
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [_textField resignFirstResponder];
  return YES;
}

@end
