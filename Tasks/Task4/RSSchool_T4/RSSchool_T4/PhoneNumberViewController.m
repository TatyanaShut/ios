//
//  PhoneNumberViewController.m
//  RSSchool_T4
//
//  Created by Tatyana Shut on 18.04.2019.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneNumberViewController.h"
#define NUMBERS_ONLY @"1234567890+"
#define CHARACTER_LIMIT_WITHOUT_IMAGE 12
#define arrayImageKod8 [NSArray arrayWithObjects: @"373", @"374", @"993", nil]
#define arrayImageKod9 [NSArray arrayWithObjects: @"375", @"380", @"992", @"994", @"996", @"998", nil]
#define arrayImageKod10 [NSArray arrayWithObjects: @"7", @"77", nil]
#define arrayImage8 [NSArray arrayWithObjects: @"flag_MD",@"flag_AM",@"flag_TM",nil]
#define arrayImage9 [NSArray arrayWithObjects: @"flag_BY",@"flag_UA",@"flag_TJ",@"flag_AZ",@"flag_KG",@"flag_UZ",nil]
#define arrayImage10 [NSArray arrayWithObjects: @"flag_RU", @"flag_KZ", nil]

@interface PhoneNumberViewController () <UITextFieldDelegate>
@property (nonatomic, retain) UITextField *mainTextField;
@property (nonatomic, retain) UIImageView *imgforLeft;

@end

@implementation PhoneNumberViewController

@synthesize mainTextField;
@synthesize imgforLeft;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/10, self.view.frame.size.width-65.f, 70.f)];
    self.mainTextField.textAlignment = NSTextAlignmentCenter;
    self.mainTextField.layer.cornerRadius = 20.f;
    self.mainTextField.layer.borderColor = [UIColor redColor].CGColor;
    self.mainTextField.layer.borderWidth = 1.4f;
    self.mainTextField.keyboardType = UIKeyboardTypePhonePad;
    self.mainTextField.textColor = [UIColor blackColor];
    self.mainTextField.font = [UIFont systemFontOfSize:20.f];
    self.mainTextField.delegate = self;
    [self.view addSubview:mainTextField];
    
    self.imgforLeft=[[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 25.f, 25.f)];
    [self.imgforLeft setContentMode:UIViewContentModeCenter];
    self.mainTextField.leftView=imgforLeft;
    self.mainTextField.leftViewMode=UITextFieldViewModeAlways;
    [self.view addSubview:imgforLeft];
    [self.mainTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.mainTextField.layer.sublayerTransform = CATransform3DMakeTranslation(30.f, 0.f, 0.f);
    
}
-(void)textFieldDidChange :(UITextField *) textField{
    
    if ([textField.text isEqualToString:@""]){
        self.imgforLeft.image = nil;
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    [cs retain];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    [cs release];
    NSString *stringFromArray = [NSString new];
    NSString *stringFromImage = [NSString new];
    NSString *phoneNumberFormatter = [self formatNumber:textField.text];
    [phoneNumberFormatter retain];
    NSInteger lengthOnlyPhoneNumber = (NSInteger)[self getLength:textField.text];
    NSString * phoneString = [textField.text substringToIndex:lengthOnlyPhoneNumber];
    
    if((phoneString.length == 0) && ![string isEqualToString:@"+"] && ![string hasPrefix:@"+"] && (string.length != 0) )
    {
        textField.text = @"+";
    }
    phoneString = [phoneString stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    for(NSUInteger i = 0;  i < arrayImageKod8.count; i++){
        stringFromArray = [arrayImageKod8 objectAtIndex:i];
        stringFromImage = [arrayImage8 objectAtIndex:i];
        NSUInteger lengthStringPhoneNumber = [[self formatNumber:[textField text]] length];
        
        if([phoneString isEqualToString:stringFromArray]){
            
            [imgforLeft setImage:[UIImage imageNamed:stringFromImage]];
        }
        if ([phoneString length] > 3){
            
            if( [arrayImageKod8 containsObject:[phoneString substringToIndex:3]] ){
                
                if(lengthStringPhoneNumber == 12 && range.length == 0){
                    return NO;
                }
                
                if(lengthStringPhoneNumber == 6){
                    textField.text = [NSString stringWithFormat:@"%@(%@) ",[phoneNumberFormatter substringToIndex:4],[phoneNumberFormatter substringWithRange:NSMakeRange(4, 2)]];
                    
                    if(range.length > 0)
                        textField.text = [NSString stringWithFormat:@"%@",phoneNumberFormatter];
                }
                else if(lengthStringPhoneNumber == 9){
                    textField.text = [NSString stringWithFormat:@"%@(%@) %@-",[phoneNumberFormatter  substringToIndex:4],[phoneNumberFormatter substringWithRange:NSMakeRange(4, 2)],[phoneNumberFormatter substringWithRange:NSMakeRange(6, 3)]];
                    
                    if(range.length > 0)
                        textField.text = [NSString stringWithFormat:@"%@",phoneNumberFormatter];
                }
            }
        }
    }
    
    for(NSUInteger i = 0;  i < arrayImageKod9.count; i++){
        stringFromArray = [arrayImageKod9 objectAtIndex:i];
        stringFromImage = [arrayImage9 objectAtIndex:i];
        
        if([phoneString isEqualToString:stringFromArray]){
            [imgforLeft setImage:[UIImage imageNamed:stringFromImage]];
        }
        if ([phoneString length] > 3){
            
            if( [arrayImageKod9 containsObject:[phoneString substringToIndex:3]] ){
                NSUInteger length = [[self formatNumber:[textField text]] length];
                
                if(length == 13 && range.length == 0){
                    return NO;
                }
                
                if(length == 6){
                    textField.text = [NSString stringWithFormat:@"%@(%@) ",[phoneNumberFormatter substringToIndex:4],[phoneNumberFormatter substringWithRange:NSMakeRange(4, 2)]];
                    
                    if(range.length > 0)
                        textField.text = [NSString stringWithFormat:@"%@",phoneNumberFormatter];
                }
                else if(length == 9){
                    textField.text = [NSString stringWithFormat:@"%@(%@) %@-",[phoneNumberFormatter  substringToIndex:4],[phoneNumberFormatter substringWithRange:NSMakeRange(4, 2)],[phoneNumberFormatter substringWithRange:NSMakeRange(6, 3)]];
                    
                    if(range.length > 0)
                        textField.text = [NSString stringWithFormat:@"%@",phoneNumberFormatter];
                }
                else if(length == 11){
                    textField.text = [NSString stringWithFormat:@"%@(%@) %@-%@-",[phoneNumberFormatter  substringToIndex:4],[phoneNumberFormatter substringWithRange:NSMakeRange(4, 2)],[phoneNumberFormatter substringWithRange:NSMakeRange(6, 3)],[phoneNumberFormatter substringWithRange:NSMakeRange(9, 2)]];
                    
                    if(range.length > 0)
                        textField.text = [NSString stringWithFormat:@"%@",phoneNumberFormatter];
                }
            }
            
        }
    }
    
    for(NSUInteger i = 0;  i < arrayImageKod10.count; i++){
        stringFromArray = [arrayImageKod10 objectAtIndex:i];
        stringFromImage = [arrayImage10 objectAtIndex:i];
        
        if([phoneString isEqualToString:stringFromArray]){
            [imgforLeft setImage:[UIImage imageNamed:stringFromImage]];
        }
        if ([phoneString length] >1){
            
            if( [arrayImageKod10 containsObject:[phoneString substringToIndex:1]] ){
                
                NSUInteger length = [[self formatNumber:[textField text]] length];
                
                if(length == 12 && range.length == 0){
                    return NO;
                }
                if (length == 5) {
                    textField.text = [NSString stringWithFormat:@"%@(%@) ",[phoneNumberFormatter substringToIndex:2],[phoneNumberFormatter substringWithRange:NSMakeRange(2, 3)]];
                    if (range.length > 0) {
                        [textField setText:[NSString stringWithFormat:@"%@",phoneNumberFormatter ]];
                    }
                }
                else if (length == 8) {
                    [textField setText:[NSString stringWithFormat:@"%@(%@)%@ ",[phoneNumberFormatter substringToIndex:2],[phoneNumberFormatter substringWithRange:NSMakeRange(2, 3)],[phoneNumberFormatter substringWithRange:NSMakeRange(5, 3)]]];
                    if (range.length > 0) {
                        [textField setText:[NSString stringWithFormat:@"%@",phoneNumberFormatter ]];
                        
                    }
                }
                else if (length == 10) {
                    
                    [textField setText:[NSString stringWithFormat:@"%@(%@) %@ %@ ",[phoneNumberFormatter substringToIndex:2],[phoneNumberFormatter substringWithRange:NSMakeRange(2, 3)],[phoneNumberFormatter substringWithRange:NSMakeRange(5, 3)],[phoneNumberFormatter substringWithRange:NSMakeRange(8, 2)]]];
                    if (range.length > 0) {
                        textField.text = [NSString stringWithFormat:@"%@",phoneNumberFormatter];
                        
                    }
                }
            }
        }
    }
    if(phoneString.length > 3){
        
        if(![arrayImageKod8 containsObject:[phoneString substringToIndex:3]] && ![arrayImageKod9 containsObject:[phoneString substringToIndex:3]] && ![arrayImageKod10 containsObject:[phoneString substringToIndex:1]]) {
            NSUInteger newLength = [phoneString length] + [string length] - range.length;
            
            //            CAKeyframeAnimation * anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            //                anim.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-10.0f, 0.0f, 0.0f)],
            //                                [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(10.0f, 0.0f, 0.0f)]];
            //                anim.autoreverses = YES;
            //                [textField.layer addAnimation:anim forKey:nil];
            //                textField.textColor = [UIColor redColor];
            
            return (newLength <= CHARACTER_LIMIT_WITHOUT_IMAGE);
        }
    }
    [phoneNumberFormatter release];
    [stringFromArray release];
    [stringFromImage release];
    
    return ([string isEqualToString:filtered]);
    return YES;
}

- (NSString *)formatNumber:(NSString *)mobileNumber{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return mobileNumber;
}

- (NSInteger)getLength:(NSString *)mobileNumber{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSInteger lendhtMain = (NSInteger)[mobileNumber length];
    return lendhtMain;
}

- (void)dealloc{
    [mainTextField release];
    [imgforLeft release];
    [super dealloc];
}
@end
