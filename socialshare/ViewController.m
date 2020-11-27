//
//  ViewController.m
//  socialshare
//
//  Created by Firas CHOUACHI on 2/27/20.
//  Copyright © 2020 Firas CHOUACHI. All rights reserved.
//

#import "ViewController.h"
#import "Social/social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *TweetTextView;

-(void) configureTweetTextView;
-(void) showAlertMessage :( NSString *) myMessage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTweetTextView];
}

-(void) showAlertMessage :( NSString *) myMessage{
    
    UIAlertController *alertController ;
    alertController = [UIAlertController alertControllerWithTitle :@"TwitterShare" message:myMessage preferredStyle: UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (IBAction)showShareAction:(id)sender {
    if ([self.TweetTextView isFirstResponder]){ [self.TweetTextView resignFirstResponder];
        
    }
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"" message:@"Tweet your note" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *TweetlAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
            
            
            
            SLComposeViewController *TwitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            
            if ( [self.TweetTextView.text length] < 140){
                [TwitterVC setInitialText:self.TweetTextView.text];
            }
            else {
                
                NSString *shortTexT = [self.TweetTextView.text substringFromIndex:140];
                [TwitterVC setInitialText:shortTexT];
                
                
                
                
            }
            
            [self presentViewController:TwitterVC animated:YES completion:nil];
            
        }
        else { [self showAlertMessage:@"you are not signed io to Twitter"];
            
        }
    }];
    
    [actionController addAction:TweetlAction];
    
    
    [actionController addAction:cancelAction];

    
    [self presentViewController:actionController animated:YES completion:nil];
}


-(void) configureTweetTextView{
    self.TweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor ;
    
    self.TweetTextView.layer.cornerRadius= 10.0;
    self.TweetTextView.layer.borderColor =[UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.TweetTextView.layer.borderWidth =2.0;
    
}

@end
