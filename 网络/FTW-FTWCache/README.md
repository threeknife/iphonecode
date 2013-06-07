# FTWCache

FTWCache is a dead simple caching class I wrote for the FTW iOS App. It has two class methods for setting and retrieving data,

	+ (void) setObject:(NSData*)data forKey:(NSString*)key;

and

	+ (id) objectForKey:(NSString*)key;

and you can reset the cache with

	+ (void) resetCache;

It stores the files in your Caches folder in its own folder. The default expiration time is 7 days, but you can modify that if you need. I wrote a good blog post that I'll be posting about on Monday about how to use this in conjunction with Grand Central Dispatch to download and show asynchronous images in a UITableView.

It takes NSData objects, so anything you can format in that way (audio files, images, simple text) can be store in the cache. Note also that the system will also periodically flush the Caches folders of apps if it finds it needs more space.