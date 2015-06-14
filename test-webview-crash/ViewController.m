//
//  ViewController.m
//  test-webview-crash
//
//  Created by Farhad Malekpour on 6/13/15.
//  Copyright (c) 2015 Dayana Networks Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.webView.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)testButtonClicked:(id)sender
{
	NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"test01.html"];
	[self.webView loadHTMLString:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL] baseURL:[NSURL URLWithString:@"https://googleads.g.doubleclick.net/"]];
	
	
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	NSLog(@"WebViewDidFinishLoad");
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@"WebViewDidStartLoad");
}

@end
