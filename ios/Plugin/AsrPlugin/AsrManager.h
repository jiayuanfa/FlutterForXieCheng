//
//  NSObject+AsrManager.h
//  Runner
//
//  Created by 贾元发 on 15.11.22.
//

#import <Foundation/Foundation.h>


@interface AsrManager: NSObject

typedef void(^AsrCallback)(NSString *message);

+ (instancetype)initWith:(AsrCallback)success failure:(AsrCallback)failure;
- (void)start;
- (void)stop;
- (void)cancel;

@end

