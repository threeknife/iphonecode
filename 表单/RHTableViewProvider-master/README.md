RHTableViewProvider
===================

UITableViews wired up in three lines of code? Yes sir.

## Updates

* Now optionally draw custom views or use the default iOS cells/headers/footers with the __shouldDrawCustomViews__ property
* RHTableViewProviderEditable .. a work in progress to separate out logic for working with editable tables
* Improved custom view drawing
* More examples
* Submitted to Cocoapods

## What Does It Do?

This is a set of classes to strip the UITableView boilerplate code from your view controllers, wire them up quickly, easily create complex, custom tableview setups with interchangeable cell and section styles/content.

* Wires a UITableView up in your view controller with three lines of code
* Easily provide custom objects to each cell
* Interchange custom UITableViewCell classes
* Custom drawing of cells (drawRect) if needed
* Pull to Refresh with your custom view
* Handles display of your custom 'empty state' view
* Core Data compatability setting table content with an NSFetchRequest and NSManagedObjectContext
* Interchange custom section header/footer views, populate with dynamic data
* Plays nicely with editing tables, deleting rows etc

Beyond the above, UITableView obviously offers more functionality via further delegate methods etc which I've not really found the need to package for re-use as yet. If you need to get more control and hook into the further parts of UITableView just subclass an instance of RHTableViewProvider and drop in your own delegates and notifications there as you require.


## Sample Usage

    @interface ViewController ()

    @property (strong, nonatomic) RHTableViewProvider *provider;
    @property (strong, nonatomic) UITableView *tableView;

    @end

    @implementation ViewController

    - (void)viewDidLoad
    {
      [super viewDidLoad];
      
      // Create a table view and add it to your view (Conveinience)
      self.tableView = [RHTableViewProvider tableViewWithFrame:self.view.bounds style:UITableViewStylePlain forSuperView:self.view];
      
      // Setup your table view provider
      self.provider = [[RHTableViewProvider alloc] initWithTableView:_tableView delegate:self customise:NO];
      
      // Update your content
      [_provider setContent:@[@"One", @"Two", @"Three"] withSections:NO];
    }

    #pragma mark - RHTableViewProviderDelegate

    - (void)RHTableViewProvider:(RHTableViewProvider *)provider didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
      id object = [provider objectAtIndexPath:indexPath];
      NSLog(@"Hello Object: %@", object);
    }

    @end

## Custom Cells

All of your cells will need to be a subclass of __RHTableViewProviderCell__ which includes lots of useful properties when working with more intricate tables, custom drawing code and template methods. A simple example of how to start working with a custom cell is below, setting the height for this type of cell, custom drawing if required and the __populateWithObject:(id)object__ implemenation which is how all our cells get their content, which can of course be passing or storing a reference to any object you like. 

    @implementation MYCustomCell

    + (CGFloat)height
    {
      return 44.0f;
    }

    // Add all your custom views here once the cell has been initialized with the correct frame and subviews
    - (void)setupView
    {
      [super setupView];
      self.nameLabel = [UILabel alloc] initWithFrame:_customView.frame];
      [_customView addSubview:_nameLabel];
    }

    - (void)populateWithObject:(id)anObject
    {
      Person *person = (Person *)anObject;
      _nameLabel = person.name;
    }

    - (void)drawContentView:(CGRect)rect
    {
      [super drawContentView:rect];
      CGContextRef context = UIGraphicsGetCurrentContext();
      CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
      CGContextFillRect(context, rect);
    }

    @end

## TODOs

* This is currently best for more static tableViews and menus, I'll be re-implementing a version of 'cellForRowAtIndexPath' to lazy load in cells/sections without the boilerplate. (Adding a 'cell datasource' for the lazy loading, set default datasource as the provider not the view controller)
* Improve editing table custom view drawing

## Contact

Any questions or issues feel free to get in touch

[hello@robhayward.co.uk] (hello@robhayward.co.uk)

[@robhayward] (http://www.twitter.com/robhayward)
