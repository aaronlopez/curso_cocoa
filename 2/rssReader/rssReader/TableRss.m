//
//  TableRss.m
//  rssReader
//
//  Created by aaron on 08/05/13.
//  Copyright (c) 2013 Educacion. All rights reserved.
//

#import "TableRss.h"
#import "News.h"
@interface TableRss ()


@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) News *current;
@property (strong, nonatomic) NSMutableString	*currentNodeContent;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *items;
@end

@implementation TableRss
@synthesize items=_items;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.items =[[NSMutableArray alloc] initWithCapacity:0];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    News *new=[self.items objectAtIndex:indexPath.row];
    cell.textLabel.text=new.title;
    cell.detailTextLabel.text=new.pubdate;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark getData

- (IBAction)refreshDataAsync:(id)sender {
    [self query1];
    
	
}

-(void) query1{
    NSXMLParser *parser			= [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/david.miprueba/reuters.rss.xml"]];
      
    parser.delegate = self;
	[parser parse];
}


- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
    [self.data setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error description]);
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *result = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
    
    NSXMLParser *parser			= [[NSXMLParser alloc] initWithData:self.data];
	parser.delegate = self;
	[parser parse];
	
    
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if ([elementname isEqualToString:@"title"])
	{
		self.current = [News alloc];
	}
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if ([elementname isEqualToString:@"title"])
	{
		self.current.title = self.currentNodeContent;
	}
	if ([elementname isEqualToString:@"description"])
	{
		self.current.description = self.currentNodeContent; 
	}
	if ([elementname isEqualToString:@"pubDate"])
	{
        self.current.pubdate = self.currentNodeContent;
        
		[self.items addObject:self.current ];
		self.current = nil;
		self.currentNodeContent = nil;
        [self.tableView reloadData];
	}
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	self.currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}




-(void) query2{
    
    
    NSString *urlString = @"https://s3-eu-west-1.amazonaws.com/david.miprueba/reuters.rss.xml";
    
    [NSURLConnection connectionWithRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:urlString]]
                                  delegate:self];
}


-(void) post{
    NSString *post = @"key1=val1&key2=val2";
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding  allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:@"http://server"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
}


@end
