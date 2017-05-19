//
//  AddDoctorViewController.h
//  ProjectDream
//
//  @author Qu Liang
//  
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@protocol DoctorProtocol <NSObject>
//this method will be called in the view controllers which conforms to this protocol
-(void)newDoctorAdded;

@end

@interface AddDoctorViewController : BaseViewController
//create a property for the delegate.it is always weak for protocol delegate to avoid retain cycles
@property (nonatomic, weak) id<DoctorProtocol> delegate;

@end
