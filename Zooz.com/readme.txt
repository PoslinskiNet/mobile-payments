ZooZ iOS SDK v1.4.3 (API-265)
============================

This iOS library allows you to integrate ZooZ Mobile in-app payments into your iOS application include iPhone, iPad and iPod touch.


********************************************************************************
Upgrading from previous versions - some resources changed
It is advised to remove the previous version of ZooZ from your project and re-add the zooz.embeddedframework to your project tree.
********************************************************************************



Getting Started
==============================
Getting started is quick and easy. just follow the steps as described in the integration document
Also you can look at the demo project inside this zip file


Registration
==============================
To use ZooZ SDK it is required to receive API credentials.
In order to receive these credentials please register your app in ZooZ portal.
http://www.zooz.com

Important note:
When registering your app in the web portal you need to supply "Unique ID" in the app registration form.
The Unique ID must match your iOS app Bundle Identification property
you can find it in your app_info.plist or by calling in your app to:
    NSLog(@"%@",[NSBundle mainBundle].bundleIdentifier);



Version changes
=============================


SDK version 1.4.3
------------------
1) Major change in payment type selection view, to better show paypal option.

2) Added kiosk mode - to allow receive payments with never remember user payment details

3) Enhanced images for retina display.

4) Added camera scan for credit card, instead of typing - powered by Jumio 

5) Verified on iOS 6.1

6) Small bug fixes.


SDK version 1.4.1.1
------------------
1) Critical bug fix - crash when entering invalid full card number and then trying to edit again the card number field and type more digits.


SDK version 1.4.1
------------------

1) Added new pre register cards - where developer can allow users to register cards without actual paying.

2) Improved UI.

3) Date picker in expiration date changed to text input instead of picker scrolls.



SDK version 1.4.0
------------------

1) New seals images in footer to improve payer trust.

2) Support for local cards 8-digits for some countries.

3) Dialog navigation bar can include customize image/app logo.

4) Support for pre-initialize so the popup dialog can appear immediately - you should call the pre-init before the user press the pay button (On app init or your checkout screen init)

5) More translation languages are now supported: de, en, es, fr, he, hu, it, pt, tr

6) Checked and verified for iOS6 (GM Seed version) and armv7s (iPhone 5) architecture.

7) Include PayPal's new SDK package for iOS6.

8) Fixed crash bug on iOS6 only, when user opens the dialog, closes it and then open it again and try to pay (iOS6 issue only)


SDK version 1.3.9
------------------

Upgrading from previous version please note the header and parameter name changes.

1) Added support for additional details text in invoice item (per item).

2) Added invoice Item additional details field.

3) Added support for both shipping and billing addresses.

4) Bug fixes


********************************************************************************
Upgrading from previous versions (1.3.8 and before)  - please note the ZooZ headers protocol changes
SOME PARAMETER NAMES IN ZOOZ OBJECTS AND RESPONSES WERE CHANGED
********************************************************************************


SDK version 1.3.8.1
------------------
1) Some fixes.

2) Added "Invoice additional Details field for custom description on the transaction.

3) PayPal will be hidden for apps that are set not to accept PayPal.


1.3.7.1 - Fixed some issue that fails to run on iOS devices with lower version then iOS 5


SDK version 1.3.7
------------------

1) UI colors customization support.

2) Email field validation.

3) Developer can choose not to require Zip code from end user.

4) Support landscape mode for iPad.

5) Some headers cleaning and improvements.

6) Added Spanish translation.



SDK version 1.3.5
------------------

1) Can customize tintColor of the dialog popup

2) paymentToken added to the payment response to be used in server APIs

3) Asking for zip code is now optional - default is not to ask for it.

4) As always minor bug fixes in UI.


SDK version 1.3.2
------------------
********************************************************************************
Upgrading from previous versions - please note the ZooZ headers protocol changes
********************************************************************************
1) Protocol headers modifications - Please note that minor protocol and header file declarations where changed to accommodate new features.

2) Success payment callback is now called after payment completed before the success page is displayed.
We added a close dialog on success callback.

3) Now the ZooZ API support adding invoice items, so you can track using ZooZ the items that were purchased.
These items are sent in our email, URL callbacks.

4) InvoiceRefNumber parameter on the ZooZ API is now returned by the email / URL transaction call back from our servers.

5) Added clearer waiting progress spinner, and not using the iPhone default.

6) As always minor bug fixes in UI.



SDK version 1.3
---------------

1) Major UI enhancements

2) UI flavor for iPad included.

3) Email added as mandatory field for User credit card details (Can be passed by API)

4) VeriSign Seal added - seal authorized by VeriSign - checkout https://app.zooz.com/portal

5) Added support for German language.

6) Bug fixes.


SDK version 1.2 
---------------
1‫(‬ Sandbox is now a separate environment, which allows you to have sandbox transactions along with production transactions, Also there is a better separation for device and cards information between sandbox and production.
Previous versions of the SDK cannot be used for sandbox and only production apps with previous version will continue to run.
This is a mandatory update of the SDK for working with sandbox.


2) Added localization framework support - 
add this property to your app-info.plist:  "Localized resources can be mixed"=YES 
We are working hard to add more locals, currently supporting "en, fr, he"
For supporting other languages please send us an email.

3) Added API for passing user (buyer) information. If your app holds any part of this information then passing it to ZooZ will help in: Reducing the need from the user to re-type, tracking and monitoring user activity, reduce risk and fraud, easier refund process if needed.
We strongly recommend you to pass our API this information.

4) Support for European postal code format (Not limited to 5 digits).

5) Minor bug fixes.


SDK Version 1.1:
-----------------
1) Added PayPal support
2) Support for iOS-SDK3.1
3) Support for armv6 architecture.
4) Minor bug fixes.


Upgrading from previous SDK version
==============================
If you already integrated the previous ZooZ SDK and you want to upgrade to this one please do the following:

Upgrading from any previous version:
1) Make sure all resources of the ZooZ SDK library files are added to your project (Its recommended to remove the old ZooZ SDK library reference and re add it to the project - this makes sure that all library new resources are added)
When you add ZooZ SDK do not copy the files, just reference it.
2) Make sure paths to the old library are removed (Check in your target "Search framework paths" attribute)
3) Optional if you want to show the new locals: add to your app-info.plist
CFBundleAllowMixedLocalizations = YES

Credits:
________
Some of our icons - YOOtheme, http://www.yootheme.com/icons
