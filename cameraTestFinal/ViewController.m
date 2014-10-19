//
//  ViewController.m
//  cameraTestFinal
//
//  Created by Akshay Ravikumar on 10/19/14.
//  Copyright (c) 2014 Akshay. All rights reserved.
//

#import "ViewController.h"
#import "tesseract.h"
#import <EventKit/EventKit.h>
@interface ViewController ()

@end

@implementation ViewController


- (IBAction)ChooseExisting{
    picker2=[[UIImagePickerController alloc] init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
    //[picker2 release];
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [ImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract setImage:image];
    [tesseract recognize];
    //NSLog(@"%@", [tesseract recognizedText]);
    NSString* printText=[tesseract recognizedText];
    NSLog(@"%@", printText);
    //NSLog(@"%@", [tesseract recognizedText]);
    myTextView.text=[self getDate:printText];
    [ImageView setImage:image];
}

- (NSString *) getDate: (NSString*)inputString
{
   // [self setiCalEvent:10 onDay:19 atYear:2014];
    NSError *error = nil;
    
    // String to search
    NSString *str = inputString;
    
    // Regular expression to parse email
    NSString *regexAsString = @"(Apnl|April)([^0-9]{0,3})([0-9]{1,2})([^0-9]{2,3})([0-9]{4})";
    
    // Create instance of NSRegularExpression
    // which is a compiled regular expression pattern
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexAsString options:0 error:&error];
    
    // If no errors
    if (!error)
    {
        // Array of matches of regex in string
        NSArray *results = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
        
        // View results to see range and length of matches
        NSLog(@"results: %@", results);
        
        int count = 1;
        // For each item found...
        for (NSTextCheckingResult *entry in results)
        {
            // Get email from the str using range
            NSString *text = [str substringWithRange:entry.range];
            
            NSLog(@"Result %d: - %@", count++, text);
            return text;
        }
    }
    else
        NSLog(@"Invalid epxression pattern: %@", error);
    return inputString;
}

-(void) setiCalEvent:(NSInteger)month onDay: (NSInteger)day atYear:(NSInteger)year{
    
    // Set the Date and Time for the Event
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    [comps setHour:9];
    [comps setMinute:0];
    [comps setTimeZone:[NSTimeZone systemTimeZone]];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *eventDateAndTime = [cal dateFromComponents:comps];
    
    // Set iCal Event
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    event.title = @"EVENT TITLE";
    
    event.startDate = eventDateAndTime;
    event.endDate = [[NSDate alloc] initWithTimeInterval:600 sinceDate:event.startDate];
    
    // Check if App has Permission to Post to the Calendar
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted){
            //---- code here when user allows your app to access their calendar.
            [event setCalendar:[eventStore defaultCalendarForNewEvents]];
            NSError *err;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        }else
        {
            //----- code here when user does NOT allow your app to access their calendar.
            [event setCalendar:[eventStore defaultCalendarForNewEvents]];
            NSError *err;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        }
    }];
}

- (IBAction)addToCal {
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract setImage:image];
    [tesseract recognize];
    //NSLog(@"%@", [tesseract recognizedText]);
    NSString* printText=[tesseract recognizedText];
    NSLog(@"%@", printText);
    //NSLog(@"%@", [tesseract recognizedText]);
    NSString *eventDate =[self getDate:printText];
    NSString *myString2 = @"Ap";
    NSString *month = [eventDate substringWithRange: NSMakeRange(0, 2)];
    NSLog(@"%@", month);
    NSInteger monthNum=0;
    if ([month isEqualToString:myString2]) {monthNum = 10;}
    NSLog(@"%zd", monthNum);
    NSString *event= [@"Event added on " stringByAppendingString:eventDate];
    NSString *eventMessage = [event stringByAppendingString:@" to Calendar."];
    [self setiCalEvent:monthNum onDay:19 atYear:2014];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Added Event"
                                                    message:eventMessage
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    //[alert release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
