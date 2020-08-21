
#import "NetWorkResponseModel.h"

@implementation NetWorkResponseModel
-(NSDictionary *)dataDict{
    if ([self.data isKindOfClass:[NSDictionary class]]) {
        return self.data;
    }
    return @{};
}

-(NSArray *)dataArray{
    if ([self.data isKindOfClass:[NSArray class]]) {
        return self.data;
    }
    return @[];
}
@end
