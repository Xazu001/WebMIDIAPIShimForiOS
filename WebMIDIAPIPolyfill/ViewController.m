/*
 
 Copyright 2014 Takashi Mizuhiki
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 */

#import "ViewController.h"
#import "WebViewDelegate.h"
#import "MIDIDriver.h"

@interface ViewController ()
@property (nonatomic, strong) MIDIDriver *midiDriver;
@end

@implementation ViewController


- (void)loadURL:(NSURL *)url
{
    // Load URL
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark -
#pragma mark View action handlers

- (void)onEditingDidEnd:(UITextField *)field
{
    [self loadURL:[NSURL URLWithString:field.text]];
}


#pragma mark -
#pragma mark View initializers

- (void)viewDidLoad {
    [super viewDidLoad];

    _midiDriver = [[MIDIDriver alloc] init];
    WKWebViewConfiguration *configuration = [MIDIWebView createConfigurationWithMIDIDriver:_midiDriver sysexConfirmation:^(NSString *url) { return YES; }];

    // Utwórz WKWebView z konfiguracją
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    [self.view addSubview:_webView];

    // Open a specific URL
    NSURL *specificURL = [NSURL URLWithString:@"https://crosspad.app"];
    NSURLRequest *request = [NSURLRequest requestWithURL:specificURL];

    // Załaduj żądanie
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
