"use strict";

console.log("Content-Type: text/html");

var page = require("webpage").create(),
    system = require("system"),
    error = function (msg) {
        console.log("Status: 400 Bad Request\n");
        // console.log();
        console.log(msg);

        phantom.exit(1);
    },
    success = function (msg) {
        console.log("Status: 200 OK\n");
        // console.log();
        console.log(msg);
        phantom.exit(0);
    },
    executionStartTime = Date.now(),
    debug = false;

if (system.args.length <= 1) {
    error("Usage: behmeh.js requestJson")
    phantom.exit(1);
}

page.settings.resourceTimeout = 10000;

var address = system.args[1];
var cssSelector = system.args[2];

if (debug) console.log("Loading " + address);

//TODO: support for Authentication
//page.customHeaders = {};

//Redirect
page.onNavigationRequested = function (url) {
    if (debug) console.log("onNavigationRequested called for: " + url);
};

page.onLoadFinished = function (status) {
    if (status !== "success") {
        error("Load failed, got status " + status);
    } else {
        if (debug) console.log("onLoadFinished status " + status);
            page.includeJs("https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js", function () {

            var html = page.evaluateJavaScript("function(){return $('"+cssSelector+"').html();}");
            success(html);
            
        });

        
    }

};

page.open(address, function (status) {
    //TODO:
});

