/*
 Copyright (c) 2013 Rhys Powell and Josh Johnson
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "HKURLTestProtocol.h"
#import "HKDefines.h"
#import "HKCannedDataSource.h"

NSString * const kHKURLTestProtocolHTTPVersion = @"HTTP/1.1";

@implementation HKURLTestProtocol

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static HKURLTestProtocol *hk_sharedProtocol = nil;
    dispatch_once(&onceToken, ^{
        hk_sharedProtocol = [[HKURLTestProtocol alloc] init];
    });
    return hk_sharedProtocol;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (NSCachedURLResponse *)cachedResponse
{
    return nil;
}

- (void)startLoading
{
    HKCannedDataSource *datasource = [[HKURLTestProtocol sharedInstance] dataSource];
    
    if ([datasource error]) {
        [self loadCannedError];
    } else if ([datasource responseDictionary]) {
        [self loadCannedResponse];
    }
}

- (void)stopLoading
{
    // required overload
}

#pragma mark - Loading

- (void)loadCannedResponse
{
    NSURLRequest *request = [self request];
    id<NSURLProtocolClient> client = [self client];
    HKCannedDataSource *datasource = [[HKURLTestProtocol sharedInstance] dataSource];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:datasource.responseDictionary options:0 error:nil];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:request.URL
                                                              statusCode:datasource.statusCode
                                                             HTTPVersion:kHKURLTestProtocolHTTPVersion
                                                            headerFields:@{ @"Content-Type": @"application/json" }];
    [client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [client URLProtocol:self didLoadData:data];
    [client URLProtocolDidFinishLoading:self];
}

- (void)loadCannedError
{
    HKCannedDataSource *datasource = [[HKURLTestProtocol sharedInstance] dataSource];
    id<NSURLProtocolClient> client = [self client];
    [client URLProtocol:self didFailWithError:datasource.error];
}

@end
