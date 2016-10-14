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

#import "RMXBooleanVariable.h"

#import "RMXRemixer.h"

@implementation RMXBooleanVariable

+ (instancetype)booleanVariableWithKey:(NSString *)key
                          defaultValue:(BOOL)defaultValue
                           updateBlock:(RMXBooleanUpdateBlock)updateBlock {
  RMXBooleanVariable *variable =
      [[self alloc] initWithKey:key defaultValue:defaultValue updateBlock:updateBlock];
  return [RMXRemixer addVariable:variable];
}

+ (instancetype)booleanVariableWithKey:(NSString *)key
                           updateBlock:(RMXBooleanUpdateBlock)updateBlock {
  RMXBooleanVariable *variable =
      [[self alloc] initWithKey:key defaultValue:NO updateBlock:updateBlock];
  return [RMXRemixer addVariable:variable];
}

+ (instancetype)variableFromDictionary:(NSDictionary *)dictionary {
  NSString *key = [dictionary objectForKey:RMXDictionaryKeyKey];
  BOOL selectedValue = [[dictionary objectForKey:RMXDictionaryKeySelectedValue] boolValue];
  return [[self alloc] initWithKey:key defaultValue:selectedValue updateBlock:nil];
}

- (NSDictionary *)toJSON {
  NSMutableDictionary *json = [super toJSON];
  json[RMXDictionaryKeySelectedValue] = @([self selectedBooleanValue]);
  return json;
}

#pragma mark - Private

- (instancetype)initWithKey:(NSString *)key
               defaultValue:(BOOL)defaultValue
                updateBlock:(RMXBooleanUpdateBlock)updateBlock {
  self = [super initWithKey:key
             typeIdentifier:RMXTypeBoolean
               defaultValue:@(defaultValue)
                updateBlock:^(RMXVariable *_Nonnull variable, id _Nonnull selectedValue) {
                  updateBlock(variable, [selectedValue boolValue]);
                }];
  self.controlType = RMXControlTypeSwitch;
  return self;
}

- (BOOL)selectedBooleanValue {
  return [self.selectedValue boolValue];
}

- (void)setSelectedBooleanValue:(BOOL)selectedBooleanValue {
  self.selectedValue = @(selectedBooleanValue);
}

@end
