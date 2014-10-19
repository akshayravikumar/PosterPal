//
//  ViewController.h
//  cameraTestFinal
//
//  Created by Akshay Ravikumar on 10/19/14.
//  Copyright (c) 2014 Akshay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    //IBOutlet UIImageView *ImageView;
    IBOutlet UILabel *myTextView;
    IBOutlet UIImageView *ImageView;
    UIImage *image;
    //IBOutlet UIImageView *ImageView;
}


- (IBAction)ChooseExisting:(id)sender;

- (IBAction)TakePhoto:(id)sender;

- (IBAction)addToCal;

//@property (retain, nonatomic)
//- (IBAction)ChooseExisting:(id)sender;
/*<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
 UIImagePickerController *picker;
 UIImagePickerController *picker2;
 UIImage *image;
 IBOutlet UIImageView *imageView;}
 
 - (IBAction)TakePhoto;
 - (IBAction)ChooseExisting;*/

@end
