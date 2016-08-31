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

#import "RMXSwitch.h"

@implementation RMXSwitch

@synthesize title;
@synthesize defaultValue;
@synthesize delaysCommit;

- (instancetype)initWithTitle:(NSString *)title {
  self = [super init];
  if (self) {
    self.title = title;
    self.delaysCommit = NO;
  }
  return self;
}

+ (instancetype)controlWithTitle:(NSString *)title {
  return [[[self class] alloc] initWithTitle:title];
}

- (RMXModelType)modelType {
  return kRMXModelTypeSwitch;
}

- (NSDictionary *)toJSON {
  NSMutableDictionary *json = [NSMutableDictionary dictionary];
  json[@"controlType"] = @"__RemixControlTypeSwitch__";
  json[@"title"] = self.title;
  json[@"defaultValue"] = self.defaultValue;
  return json;
}

@end