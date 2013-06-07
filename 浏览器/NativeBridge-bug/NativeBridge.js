
var NativeBridge = {
  callbacksCount : 1,
  callbacks : {},
  
  // Automatically called by native layer when a result is available
  resultForCallback : function resultForCallback(callbackId, resultArray) {
    var callback = NativeBridge.callbacks[callbackId];
    if (!callback) return;
    callback.apply(null,resultArray);
  },
  
  // Use this in javascript to request native objective-c code
  // functionName : string (I think the name is explicit :p)
  // args : array of arguments
  // callback : function with n-arguments that is going to be called when the native code returned
  call : function call(functionName, args, callback) {
    
    var hasCallback = callback && typeof callback == "function";
    var callbackId = hasCallback ? NativeBridge.callbacksCount++ : 0;
    
    window.location = "js-frame:" + functionName + ":" + callbackId+ ":" + encodeURIComponent(JSON.stringify(args));
    
    if (hasCallback)
      NativeBridge.callbacks[callbackId] = callback;
    
  }

};


