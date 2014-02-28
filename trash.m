#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import <libgen.h>

int main (int argc, const char * argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
	NSString *pathPrefix=@"./";
    
	NSWorkspace *ws=[NSWorkspace sharedWorkspace];
	int i=0;
	for (i=1; i<argc; i++) {
		NSInteger theTag=0;
		char *p=(char*)argv[i];
		NSString *theDir=[[NSString alloc] initWithCString: dirname(p)
                                                  encoding: NSUTF8StringEncoding];
		NSString *theFileB=[[NSString alloc] initWithCString: basename(p)
                                                    encoding: NSUTF8StringEncoding];
		NSString *theFile=[pathPrefix stringByAppendingString: theFileB];
		NSArray *files=[[NSArray alloc] initWithObjects: theFile, nil];
        
		// Perform the delete
		BOOL result=[ws performFileOperation: NSWorkspaceRecycleOperation
                                      source: theDir
                                 destination: @""
                                       files: files
                                         tag: &theTag];
        
		if(result == NO) {
			perror(p);
		}
        
		[theDir release];
		[theFileB release];
		[files release];
	}
    
	[pool release];
	return 0;
}
