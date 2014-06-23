//
//  mainViewController.m
//  Facebook Paper
//
//  Created by Jason Demetillo on 6/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()


@property (strong, nonatomic) IBOutlet UIView *headlinesView;
@property (strong, nonatomic) IBOutlet UIScrollView *slideScroll;

@property (nonatomic) CGPoint originalTrayLocation;

- (IBAction)onDrag:(UIPanGestureRecognizer *)sender;

@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.slideScroll.contentSize = CGSizeMake(1490,255);
    self.slideScroll.frame = CGRectMake(0,314,320,255);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onDrag:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    int theWidth = self.view.frame.size.width;
    int theHeight = self.view.frame.size.height;
    int collapseHeight = 44;
    int topY = theHeight / 2;
    int bottomY = (theHeight * 1.5) - collapseHeight;
    CGPoint theCenter = self.headlinesView.center;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
    	
    	self.originalTrayLocation = theCenter;
    	
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
		// user is dragging the headline area around
		if (theCenter.y < topY) {
		// user dragged too high - add resistance
			theCenter.y = topY + (translation.y * 0.3);
		} else if (theCenter.y > bottomY) {
		// user dragged too low - add resistance, but more fuzzy
			theCenter.y = bottomY + (translation.y * 0.5);
		} else {
		// user drags as normal
			theCenter.y = self.originalTrayLocation.y + translation.y;
            
		}
		self.headlinesView.center = theCenter;
		
	} else if (sender.state == UIGestureRecognizerStateEnded) {
		
		if (velocity.y > 0) {
			
		// user dragged down, collapse the main screen
			[UIView animateWithDuration:0.3 animations:^{
				self.headlinesView.center = CGPointMake(theWidth / 2, bottomY);
			}];
			
		} else {
			
		// user dragged up, show the main screen
			[UIView animateWithDuration:0.3 animations:^{
				self.headlinesView.center = CGPointMake(theWidth / 2, topY);
			}];
			
		}
		
	}
}
@end
