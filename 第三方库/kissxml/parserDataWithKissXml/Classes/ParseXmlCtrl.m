//
//  ParseXmlCtrl.m
//  parserDataWithKissXml
//
//  Created by angel li on 11-1-17.
//  Copyright Lixf 2011. All rights reserved.
//

#import "ParseXmlCtrl.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "xmlData.h"

@implementation ParseXmlCtrl
@synthesize parsedDataArray;

//解析XML
static NSString *kXML =				@"//XML";
static NSString *KUSER =			@"USER";
static NSString *KTITLE =			@"TITLE";
static NSString *KCONTENT =	@"CONTENT";


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSMutableArray *array = [[NSMutableArray alloc] init];
	self.parsedDataArray = array;
	[array release];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"xmlData" ofType:@"xml"];
	NSData *data = [[NSData alloc] initWithContentsOfFile:path];
	[self parsedDataFromData:data];
	[data release];
}



-(void)parsedDataFromData:(NSData *)data{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
	
	/////解析
	NSArray *items = [doc nodesForXPath:kXML error:nil];
	
	for (DDXMLElement *obj in items) {
		xmlData *data = [[xmlData alloc] init];
		
		DDXMLElement *aUser = [obj elementForName:KUSER];
		if(aUser)
			data.user = aUser.stringValue;
		DDXMLElement *aTitle = [obj elementForName:KTITLE];
		if(aTitle)
			data.title = aTitle.stringValue;
		DDXMLElement *content = [obj elementForName:KCONTENT];
		if(content)
			data.content = content.stringValue;
		NSDictionary *XmlDictionary;
		XmlDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
						 data.user,@"kUsers",
						 data.title,@"kTitles",
						 data.content,@"kContents",
						 nil];
		[self performSelectorInBackground:@selector(parsedXml:) withObject:XmlDictionary];
		[data release];
	}
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[doc release];
}


- (void)parsedXml:(NSDictionary *)dic{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [self.parsedDataArray addObject:dic];
	[pool release];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[parsedDataArray release];
    [super dealloc];
}

@end
