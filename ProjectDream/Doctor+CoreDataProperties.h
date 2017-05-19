//
//  Doctor+CoreDataProperties.h
//  
//
//  @author Qu Liang
//
//  This file was automatically generated and should not be edited.
//

#import "Doctor+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Doctor (CoreDataProperties)

//this class is automatically created by xcode with the properties and relationships used in coredata

+ (NSFetchRequest<Doctor *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *specialization;
@property (nullable, nonatomic, copy) NSString *city;

@end

NS_ASSUME_NONNULL_END
