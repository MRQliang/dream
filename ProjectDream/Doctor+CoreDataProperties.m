//
//  Doctor+CoreDataProperties.m
//  
//
//  @author Qu Liang
//
//  This file was automatically generated and should not be edited.
//

#import "Doctor+CoreDataProperties.h"

@implementation Doctor (CoreDataProperties)

+ (NSFetchRequest<Doctor *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Doctor"];
}

@dynamic name;
@dynamic specialization;
@dynamic city;

@end
