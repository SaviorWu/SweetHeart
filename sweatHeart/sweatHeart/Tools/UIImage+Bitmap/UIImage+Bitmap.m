//
//  UIImage+Bitmap.m
//  HLBluetoothDemo
//
//  Created by Harvey on 16/5/3.
//  Copyright © 2016年 Halley. All rights reserved.
//

#import "UIImage+Bitmap.h"

#import <AVFoundation/AVFoundation.h>

@implementation UIImage (Bitmap)

//
- (NSData *)bitmapData
{
    CGImageRef imageRef = self.CGImage;
    // Create a bitmap context to draw the uiimage into
    CGContextRef context = [self bitmapRGBA8Context];
    
    if(!context) {
        return nil;
    }
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // Draw image into the context to get the raw image data
    CGContextDrawImage(context, rect, imageRef);
    
    // Get a pointer to the data
    uint32_t *bitmapData = (uint32_t *)CGBitmapContextGetData(context);
    
    
    if(bitmapData) {
        
        uint8_t *m_imageData = (uint8_t *) malloc(width * height/8 + 8*height/8);
        memset(m_imageData, 0, width * height/8 + 8*height/8);
        int result_index = 0;
        
        for(int y = 0; (y + 24) < height; ) {
            m_imageData[result_index++] = 27;
            m_imageData[result_index++] = 51;
            m_imageData[result_index++] = 0;
            
            m_imageData[result_index++] = 27;
            m_imageData[result_index++] = 42;
            m_imageData[result_index++] = 33;
            
            m_imageData[result_index++] = width%256;
            m_imageData[result_index++] = width/256;
            for(int x = 0; x < width; x++) {
                int value = 0;
                for (int temp_y = 0 ; temp_y < 8; ++temp_y)
                {
                    uint8_t *rgbaPixel = (uint8_t *) &bitmapData[(y+temp_y) * width + x];
                    uint32_t gray = 0.3 * rgbaPixel[BPRed] + 0.59 * rgbaPixel[BPGreen] + 0.11 * rgbaPixel[BPBlue];
                    
                    if (gray < 127)
                    {
                        value += 1<<(7-temp_y)&255;
                    }
                    
                }
                m_imageData[result_index++] = value;
                
                value = 0;
                for (int temp_y = 8 ; temp_y < 16; ++temp_y)
                {
                    uint8_t *rgbaPixel = (uint8_t *) &bitmapData[(y+temp_y) * width + x];
                    uint32_t gray = 0.3 * rgbaPixel[BPRed] + 0.59 * rgbaPixel[BPGreen] + 0.11 * rgbaPixel[BPBlue];
                    
                    if (gray < 127)
                    {
                        value += 1<<(7-temp_y%8)&255;
                    }
                    
                }
                m_imageData[result_index++] = value;
                
                value = 0;
                for (int temp_y = 16 ; temp_y < 24; ++temp_y)
                {
                    uint8_t *rgbaPixel = (uint8_t *) &bitmapData[(y+temp_y) * width + x];
                    uint32_t gray = 0.3 * rgbaPixel[BPRed] + 0.59 * rgbaPixel[BPGreen] + 0.11 * rgbaPixel[BPBlue];
                    
                    if (gray < 127)
                    {
                        value += 1<<(7-temp_y%8)&255;
                    }
                    
                }
                m_imageData[result_index++] = value;
            }
            m_imageData[result_index++] = 13;
            m_imageData[result_index++] = 10;
            y += 24;
        }
        
        NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
        [data appendBytes:m_imageData length:result_index];
        
        free(bitmapData);
        return data;
    }
    
    NSLog(@"Error getting bitmap pixel data\n");
    CGContextRelease(context);
    
    return nil ; 
}

- (CGContextRef)bitmapRGBA8Context
{
    CGImageRef imageRef = self.CGImage;
    if (!imageRef) {
        return NULL;
    }
    
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    uint32_t *bitmapData;
    
    size_t bitsPerPixel = 32;
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bytesPerRow = width * bytesPerPixel;
    size_t bufferLength = bytesPerRow * height;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if(!colorSpace) {
        NSLog(@"Error allocating color space RGB\n");
        return NULL;
    }
    
    // Allocate memory for image data
    bitmapData = (uint32_t *)malloc(bufferLength);
    
    if(!bitmapData) {
        NSLog(@"Error allocating memory for bitmap\n");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    //Create bitmap context
    
    context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);	// RGBA
    if(!context) {
        free(bitmapData);
        NSLog(@"Bitmap context not created");
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return context;	

}

- (UIImage *)imageWithscaleMaxWidth:(CGFloat)maxWidth
{
    CGFloat width = self.size.width;
    if (width > maxWidth)
    {
        CGFloat height = self.size.height;
        CGFloat maxHeight = maxWidth * height / width;
        
        CGSize size = CGSizeMake(maxWidth, maxHeight);
        UIGraphicsBeginImageContext(size);
        [self drawInRect:CGRectMake(0, 0, maxWidth, maxHeight)];
        UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resultImage;
    }
    
    return self;
}

- (UIImage *)blackAndWhiteImage
{
//    CGSize size = self.size;
    CIImage *beginImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"
                                  keysAndValues:kCIInputImageKey,beginImage,kCIInputColorKey,[CIColor colorWithCGColor:[UIColor blackColor].CGColor],nil];

    CIImage *outputImage = [filter outputImage];

//    UIImage *newImage = [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:size.width];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    return newImage;
}

@end

@implementation UIImage (QRCode)

+ (UIImage *)barCodeImageWithInfo:(NSString *)info
{
    // 创建条形码
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 将字符串转换成NSData
    NSData *data = [info dataUsingEncoding:NSUTF8StringEncoding];
    // 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    // 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    // 将CIImage转换成UIImage，并放大显示
    UIImage *image =[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:300];
    return image;
}

+ (UIImage *)qrCodeImageWithInfo:(NSString *)info centerImage:(UIImage *)centerImage  width:(CGFloat)width
{
    if (!info) {
        return nil;
    }
    
//    NSData *strData = [info dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
//    //创建二维码滤镜
//    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [qrFilter setValue:strData forKey:@"inputMessage"];
//    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
//    CIImage *qrImage = qrFilter.outputImage;
//
//    UIImage *codeImage = [UIImage createNonInterpolatedUIImageFormCIImage:qrImage withSize:width - 10];

    // 1.实例化二维码滤镜
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    
    [filter setDefaults];
    
    // 3.将字符串转换成NSdata
    
    NSData *data  = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5.生成二维码
    
    CIImage *outputImage = [filter outputImage];
    
    UIImage *codeImage = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:width];
    
    //二维码rect
    CGRect rect = CGRectMake(0, 0, codeImage.size.width, codeImage.size.height);
    UIGraphicsBeginImageContext(rect.size);
    [codeImage drawInRect:rect];
    //定制logo
    if (centerImage) {
        //icon尺寸,UIBezierPath
        CGSize logoSize = CGSizeMake(rect.size.width*0.2, rect.size.height*0.2);
        CGFloat x = CGRectGetMidX(rect) - logoSize.width*0.5;
        CGFloat y = CGRectGetMidY(rect) - logoSize.height*0.5;
        CGRect logoFrame = CGRectMake(x, y, logoSize.width, logoSize.height);
        [[UIBezierPath bezierPathWithRoundedRect:logoFrame cornerRadius:10] addClip];
        
        [centerImage drawInRect:logoFrame];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

+ (UIImage*)imageBgColorToTransparentWith:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

/**
 压图片质量
 
 @param image image
 @return Data
 */
+ (UIImage *)zipImageWithImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    NSData *compressedData = UIImagePNGRepresentation(image);
    // 质量大于20MB
    NSLog(@"compressedData = %lu",(unsigned long)[compressedData length]);
    NSLog(@"MAX_SIZE = %d",MAX_SIZE);
    if ([compressedData length] > MAX_SIZE)
    {
        NSLog(@"图片质量过大，请处理后在上传");
//        return nil;
    }
    int iLoop   = 1;
    while ([compressedData length] > PICTURE_MAXSIZE_HEIGHT_WIDTH)
    {
        NSLog(@"count = %d compressedData = %lu",iLoop,(unsigned long)[compressedData length]);
        iLoop++;
        if (iLoop > 3)
        {
            // 长宽适配都做完，大小依然大于规定
            NSData *imageData = UIImageJPEGRepresentation(image,0.5);
            NSLog(@"imageData = %lu",(unsigned long)[imageData length]);
            return [UIImage imageWithData:imageData];
        }
        
        // 图片大小大于规定大小
        if (image.size.width > PICTURE_MAX_WIDTH && image.size.height > PICTURE_MAX_HEIGHT)
        {
            // 图片大小大于300KB，且长宽都大于最大限制
            if (image.size.width > image.size.height)
            {
                // 宽度大于高度，根据宽度进行长边适配
                compressedData = UIImagePNGRepresentation([[self class] compressImage:image newWidth:PICTURE_MAX_WIDTH]);
            }
            else
            {
                // 宽度小于高度，根据高度度进行长边适配
                compressedData = UIImagePNGRepresentation([[self class] compressImage:image newWidth:image.size.width/(image.size.height/PICTURE_MAX_HEIGHT)]);
            }
            
        }
        else if(image.size.width > PICTURE_MAX_WIDTH && image.size.height < PICTURE_MAX_HEIGHT)
        {
            // 宽度大于高度，根据宽度长边适配
            compressedData = UIImagePNGRepresentation([[self class] compressImage:image newWidth:PICTURE_MAX_WIDTH]);
        }
        else if(image.size.width < PICTURE_MAX_WIDTH && image.size.height > PICTURE_MAX_HEIGHT)
        {
            // 宽度小于高度，根据高度度进行长边适配
            compressedData = UIImagePNGRepresentation([[self class] compressImage:image newWidth:image.size.width/(image.size.height/PICTURE_MAX_HEIGHT)]);
        }
        else
        {
            // 高宽都小于设定尺寸，则直接进行质量压缩
            compressedData  = UIImageJPEGRepresentation(image , 0.9);
        }
        image   = [UIImage imageWithData:compressedData];
    }
    
    return [UIImage imageWithData:compressedData];
}
/**
 *  等比缩放本图片大小
 *
 *  @param newImageWidth 缩放后图片宽度，像素为单位
 *
 *  @return self-->(image)
 */
+ (UIImage *)compressImage:(UIImage *)image newWidth:(CGFloat)newImageWidth
{
    if (!image) return nil;
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = newImageWidth;
    float height = image.size.height/(image.size.width/width);
    
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
@end
