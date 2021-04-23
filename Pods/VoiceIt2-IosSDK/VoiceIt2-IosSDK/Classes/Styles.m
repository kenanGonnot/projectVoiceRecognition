//
//  Styles.m
//  VoiceIt2-IosSDK
//
//  Created by VoiceIt Technologies, LLC
//  Copyright (c) 2020 VoiceIt Technologies, LLC. All rights reserved.
//

#import "Styles.h"

@implementation Styles
static NSMutableDictionary *styles;

+(NSMutableDictionary *)get{
    return styles;
}

+(void)set:(NSMutableDictionary*)styleSettings{
    styles = styleSettings;
}

+(NSString *)getMainColor{
    NSString * mainColor = [styles objectForKey:@"kThemeColor"];
    if (mainColor == nil) {
        mainColor = @"#FBC132";
    }
    return mainColor;
}

+(NSString *)getIconColor{
    NSString * iconColor = [styles objectForKey:@"kIconStyle"];
    if (iconColor == nil) {
        iconColor = @"#FBC132";
    }
   else  if([iconColor isEqualToString:@"default"]){
        iconColor = @"#FBC132";
    }
    else if([iconColor isEqualToString:@"monochrome"]){
        iconColor = @"#FFFFFF";
    }
    return iconColor;
}

+(UIColor *)getMainUIColor{
    return [Utilities uiColorFromHexString:[Styles getMainColor]];
}

+(UIColor *)getIconUIColor{
    return [Utilities uiColorFromHexString:[Styles getIconColor]];
}

+(CGColorRef)getMainCGColor{
    return [Utilities cgColorFromHexString:[Styles getMainColor]];
}
@end
