
#import <Foundation/Foundation.h>

@interface NetWorkResponseModel : NSObject
@property (copy, nonatomic, readwrite)id data;
@property (copy, nonatomic, readwrite)NSNumber *code;
@property (copy, nonatomic, readwrite)NSNumber *is_alert;
@property (copy, nonatomic, readwrite)NSNumber *error;
@property (copy, nonatomic, readwrite)NSNumber *failed;
@property (nonatomic, assign) NSInteger status;
@property (copy, nonatomic, readwrite)NSNumber *success;
@property (copy, nonatomic, readwrite)NSString *msg;

@property (copy, nonatomic, readwrite)NSArray *dataArray;
@property (copy, nonatomic, readwrite)NSDictionary *dataDict;
@end
