//
//  AddDoctorViewController.m
//  ProjectDream
//
//  @author Qu Liang
//  
//

#import "AddDoctorViewController.h"
#import "AppDelegate.h"
#import "Doctor+CoreDataClass.h"

@interface AddDoctorViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *specializationField;
@property (nonatomic, weak) IBOutlet UITextField *cityField;



@end

@implementation AddDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //when clicked anywhere on the screen the keyboard dismisses from the screen
    [self.view endEditing:true];
}

- (IBAction)save{
    //saving the new entry to core data
    //get the context from appdelegate
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
  //create an entity description.Entity is where we create the properties
    Doctor *doctor = [NSEntityDescription insertNewObjectForEntityForName:@"Doctor" inManagedObjectContext:context];
    //save the data
    doctor.name = _nameField.text;
    doctor.specialization = _specializationField.text;
    doctor.city = _cityField.text;
    NSError *error = nil;
    if ([context save:&error] == NO) {
        //show alert if there is an error
        [self showAlertWithtitle:@"Error" andMessage:error.localizedDescription];
    }else{
        //dismiss the current view controller and call the delegate method on successful saving of the new entry to core data database
        [self dismissViewControllerAnimated:true completion:nil];
       // [self dismissViewControllerAnimated:true completion:^{
            [self.delegate newDoctorAdded];
       // }];
    }
    
    
}

- (IBAction)cancel{
    //just dismiss the current view controller
    [self dismissViewControllerAnimated:true completion:nil];
}





@end
