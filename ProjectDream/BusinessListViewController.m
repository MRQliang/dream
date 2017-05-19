//
//  BusinessListViewController.m
//  ProjectDream
//
//  @author Qu Liang
//  
//

#import "BusinessListViewController.h"
#import "Constants.h"
#import "BusinessDetailViewController.h"

@interface BusinessListViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *listArray;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation BusinessListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    // Do any additional setup after loading the view.
    //create the array of dictionaries
    listArray  = [[NSArray alloc]initWithObjects:
                  @{@"Economy":@"An economy (From Greek οίκος – household and νęμoμαι – manage) is an area of the production, distribution, or trade, and consumption of goods and services by different agents in a given geographical location.Understood in its broadest sense, 'The economy is defined as a social domain that emphasizes the practices, discourses, and material expressions associated with the production, use, and management of resources'.Economic agents can be individuals, businesses, organizations, or governments.Economic transactions occur when two parties agree to the value or price of the transacted good or service, commonly expressed in a certain currency.Monetary transactions only account for a small part of the economic domain."},
                  @{@"Commerce":@"Commerce is the activity of buying and selling of goods and services, especially on a large scale.The system includes legal, economic, political, social, cultural and technological systems that are in operation in any country or internationally."},
                  @{@"Accounting":@"Accounting or accountancy is the measurement, processing and communication of financial information about economic entities such as businesses and corporations.The modern field was established by the Italian mathematician Luca Pacioli in 1494. Accounting, which has been called the language of business,measures the results of an organization's economic activities and conveys this information to a variety of users, including investors, creditors, management, and regulators.Practitioners of accounting are known as accountants. The terms 'accounting' and 'financial reporting' are often used as synonyms."},
                  @{@"Marketing":@"Marketing is the study and management of exchange relationships.The American Marketing Association has defined marketing as 'the activity, set of institutions, and processes for creating, communicating, delivering, and exchanging offerings that have value for customers, clients, partners, and society at large.'"},
                  @{@"Financial":@"Financial management refers to the efficient and effective management of money (funds) in such a manner as to accomplish the objectives of the organization.It is the specialized function directly associated with the top management.The significance of this function is not seen in the 'Line' but also in the capacity of 'Staff' in overall of a company.It has been defined differently by different experts in the field."},
                  @{@"Statistics":@"Statistics is a branch of mathematics dealing with the collection, analysis, interpretation, presentation, and organization of data.In applying statistics to, e.g., a scientific, industrial, or social problem, it is conventional to begin with a statistical population or a statistical model process to be studied.Populations can be diverse topics such as 'all people living in a country' or 'every atom composing a crystal'.Statistics deals with all aspects of data including the planning of data collection in terms of the design of surveys and experiments."},
                  @{@"Tourism":@"Tourism is travel for pleasure or business; also the theory and practice of touring, the business of attracting, accommodating, and entertaining tourists, and the business of operating tours.Tourism may be international, or within the traveler’s country.The World Tourism Organization defines tourism more generally, in terms which go 'beyond the common perception of tourism as being limited to holiday activity only', as people traveling to and staying in places outside their usual environment for not more than one consecutive year for leisure, business and other purposes."
},nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //number of sections in table view
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //number of rows in each section
    return listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //create and configure the cell
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    NSDictionary *dict = [listArray objectAtIndex: indexPath.row];
    NSString *key = [[dict allKeys]lastObject];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row + 1,key];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //checl which row is selected and go to the appropriate detailed page
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:kShowBusinessDetailSegue sender:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Go to detail view controller.and show the details of the selected item.
    BusinessDetailViewController *detailViewController = (BusinessDetailViewController *)segue.destinationViewController;
    NSIndexPath *selectedIndex  = (NSIndexPath *)sender;
    NSDictionary *dict = [listArray objectAtIndex: selectedIndex.row];
    detailViewController.detailString = [dict.allValues lastObject];
    
}

@end
