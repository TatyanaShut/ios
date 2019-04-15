#import "DateMachine.h"
// знаю, что слишком большой код и не оптимизирован, но тут открыла новые штуки для себя, хоть тесты некоторые не прошли, но что-то в этом есть)
@interface DateMachine () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property(strong,nonatomic) NSMutableArray* array;
@property (nonatomic, retain)UITextField  *dateUnitTextField;
@property (nonatomic, retain) UILabel  *currentDateLabel;
@property (nonatomic, retain) UITextField *stepTextField;
@property (nonatomic, retain) UITextField * dateStartTextField;

@end

@implementation DateMachine
@synthesize array;
@synthesize dateUnitTextField;
@synthesize currentDateLabel;
@synthesize stepTextField;
@synthesize dateStartTextField;


- (void)viewDidLoad {
    [super viewDidLoad];
    
#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 100
    array = [[NSMutableArray alloc]initWithObjects:@"year",@"month",@"day",@"week",@"hour",@"minute", nil];
    
    currentDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 300, 50)];
    currentDateLabel.textAlignment = NSTextAlignmentCenter;
    currentDateLabel.textColor = [UIColor redColor];
    currentDateLabel.layer.borderColor = [UIColor blackColor].CGColor;
    currentDateLabel.layer.borderWidth = 1.4f;
    currentDateLabel.layer.cornerRadius = 20;
    currentDateLabel.tag = 11;
    currentDateLabel.numberOfLines = 1;
    [self.view addSubview:currentDateLabel];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
    currentDateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    UIButton *subButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 100, 100)];
    [subButton setTitle:@"Sub" forState:(UIControlStateNormal)];
    subButton.layer.borderColor = [UIColor blackColor].CGColor;
    subButton.layer.borderWidth = 1.4f;
    subButton.layer.cornerRadius = 40;
    [subButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [subButton addTarget:self action:@selector(subButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subButton];
    [subButton release];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(120, 200, 100, 100)];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    addButton.layer.borderColor = [UIColor blackColor].CGColor;
    addButton.layer.borderWidth = 1.4f;
    addButton.layer.cornerRadius = 40;
    [addButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    [addButton release];
    
    stepTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 320, 300, 50)];
    stepTextField.placeholder = @"Step";
    stepTextField.textAlignment = NSTextAlignmentCenter;
    stepTextField.layer.cornerRadius = 20;
    stepTextField.layer.borderWidth = 1.4f;
    stepTextField.layer.borderColor = [UIColor blackColor].CGColor;
    stepTextField.delegate = self;
    stepTextField.tag = 1;
    
    [stepTextField setTextColor:[UIColor redColor]];
    [self.view addSubview:stepTextField];
    
    dateUnitTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 390, 300, 50)];
    dateUnitTextField.placeholder = @"Date unit";
    dateUnitTextField.textAlignment = NSTextAlignmentCenter;
    dateUnitTextField.layer.cornerRadius = 20;
    dateUnitTextField.layer.borderColor = [UIColor blackColor].CGColor;
    dateUnitTextField.layer.borderWidth = 1.4f;
    dateUnitTextField.tag = 3;
    dateUnitTextField.delegate = self;
    [dateUnitTextField setTextColor:[UIColor redColor]];
    [self.view addSubview:dateUnitTextField];
    
    
    
    UIPickerView * picker = [UIPickerView new];
    picker.delegate = self;
    picker.dataSource = self;
    [dateUnitTextField setInputView:picker];
    [picker release];
    
    
    
    
    dateStartTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 460, 300, 50)];
    dateStartTextField.placeholder = @"Start date";
    dateStartTextField.textAlignment = NSTextAlignmentCenter;
    dateStartTextField.layer.cornerRadius = 20;
    dateStartTextField.layer.borderColor = [UIColor blackColor].CGColor;
    dateStartTextField.layer.borderWidth = 1.4f;
    dateStartTextField.tag = 2;
    dateStartTextField.delegate = self;
    [dateStartTextField setTextColor:[UIColor redColor]];
    [self.view addSubview:dateStartTextField];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [dateStartTextField setInputView:datePicker];
    [datePicker release];
    
    
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    [dateUnitTextField setText:[array objectAtIndex:row]];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [array count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return [array objectAtIndex:row];
}



-(void)subButtonclick:(id)sender {
    
    if(dateStartTextField.text.length == 0) {
        
        if([dateUnitTextField.text isEqual: @"year"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *minusYears = [NSDateComponents new];
            minusYears.year = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusYears toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusYears release];
            
        }
        
        if([dateUnitTextField.text isEqual: @"month"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *minusMonth = [NSDateComponents new];
            minusMonth.month = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusMonth toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusMonth release];
        }
        
        if([dateUnitTextField.text isEqual: @"day"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *minusDay = [NSDateComponents new];
            minusDay.day = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusDay toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusDay release];
        }
        
        if([dateUnitTextField.text isEqual: @"week"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *minusWeek = [NSDateComponents new];
            minusWeek.weekOfMonth = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusWeek toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusWeek release];
        }
        if([dateUnitTextField.text isEqual: @"hour"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *minusHour = [NSDateComponents new];
            minusHour.hour = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusHour toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusHour release];
        }
        if([dateUnitTextField.text isEqual: @"minute"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *minusMinute = [NSDateComponents new];
            minusMinute.minute = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusMinute toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusMinute release];
        }
        
        
        
    }else{
        if([dateUnitTextField.text isEqual: @"year"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *minusYears = [NSDateComponents new];
            minusYears.year = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusYears toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusYears release];
        }
        if([dateUnitTextField.text isEqual: @"month"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *minusMonth = [NSDateComponents new];
            minusMonth.month = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusMonth toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusMonth release];
            
        }
        
        if([dateUnitTextField.text isEqual: @"day"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *minusDay = [NSDateComponents new];
            minusDay.day = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusDay toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusDay release];
        }
        
        if([dateUnitTextField.text isEqual: @"week"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *minusWeek = [NSDateComponents new];
            minusWeek.weekOfMonth = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusWeek toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusWeek release];
        }
        if([dateUnitTextField.text isEqual: @"hour"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *minusHour = [NSDateComponents new];
            minusHour.hour = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusHour toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusHour release];
        }
        if([dateUnitTextField.text isEqual: @"minute"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *minusMinute = [NSDateComponents new];
            minusMinute.minute = -stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:minusMinute toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [minusMinute release];
            
        }
    }
    
    
}
-(void)addButtonClick:(id) sender{
    
    if(dateStartTextField.text.length == 0) {
        
        if([dateUnitTextField.text isEqual: @"year"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *plusYears = [NSDateComponents new];
            plusYears.year = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusYears toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusYears release];
        }
        if([dateUnitTextField.text isEqual: @"month"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *plusMonth = [NSDateComponents new];
            plusMonth.month = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusMonth toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusMonth release];
        }
        
        if([dateUnitTextField.text isEqual: @"day"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *plusDay = [NSDateComponents new];
            plusDay.day = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusDay toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusDay release];
        }
        
        if([dateUnitTextField.text isEqual: @"week"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *plusWeek = [NSDateComponents new];
            plusWeek.weekOfMonth = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusWeek toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusWeek release];
        }
        if([dateUnitTextField.text isEqual: @"hour"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *plusHour = [NSDateComponents new];
            plusHour.hour = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusHour toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusHour release];
        }
        if([dateUnitTextField.text isEqual: @"minute"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:currentDateLabel.text];
            NSDateComponents *plusMinute = [NSDateComponents new];
            plusMinute.minute = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusMinute toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusMinute release];
        }
        
        
        
    }else{
        
        
        if([dateUnitTextField.text isEqual: @"year"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *plusYears = [NSDateComponents new];
            plusYears.year = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusYears toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusYears release];
        }
        if([dateUnitTextField.text isEqual: @"month"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *plusMonth = [NSDateComponents new];
            plusMonth.month = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusMonth toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusMonth release];
        }
        
        if([dateUnitTextField.text isEqual: @"day"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *plusDay = [NSDateComponents new];
            plusDay.day = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusDay toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusDay release];
        }
        
        if([dateUnitTextField.text isEqual: @"week"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *plusWeek = [NSDateComponents new];
            plusWeek.weekOfMonth = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusWeek toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusWeek release];
        }
        if([dateUnitTextField.text isEqual: @"hour"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *plusHour = [NSDateComponents new];
            plusHour.hour = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusHour toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusHour release];
        }
        if([dateUnitTextField.text isEqual: @"minute"]){
            NSString *step  = stepTextField.text;
            [step retain];
            NSInteger stepInt = [step integerValue];
            [step release];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
            [dateFormatter setDateFormat:@"dd/MM/yy HH:mm"];
            NSDate *dateFromString = [dateFormatter dateFromString:dateStartTextField.text];
            NSDateComponents *plusMinute = [NSDateComponents new];
            plusMinute.minute = +stepInt;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:plusMinute toDate:dateFromString options:0];
            currentDateLabel.text = [dateFormatter stringFromDate:newDate];
            [dateFormatter release];
            [plusMinute release];
            
        }
    }
    
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
    }
    if(textField.tag == 2) {
        
        UIDatePicker *picker = (UIDatePicker*)textField.inputView;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSDate *eventDate = picker.date;
        [dateFormat setDateFormat:@"dd/MM/yyyy HH:ss"];
        NSString *dateString = [dateFormat stringFromDate:eventDate];
        textField.text = [NSString stringWithFormat:@"%@",dateString];
        
    }
    
    
    return NO;
}
-(void)dealloc {
    [array release];
    [stepTextField release];
    [dateUnitTextField release];
    [currentDateLabel release];
    [stepTextField release];
    [dateStartTextField release];
    [super dealloc];
}

@end
