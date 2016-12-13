# Image-Carousel

Add an array of images to a view and scroll them.
Able to add page control indicator.

HOW TO USE (Xcode):

- Add the ImageCarouselView.swift file to your project.
- Add a view to a storyboard or xib in the Interface Builder. Change the class of the view to ImageCarouselView in the Identity Inspector.
	* From the Interface Builder, with the view selected, go to the attributes inspector. Here you can set the Carousel's Page Control on or off, change its colors, and set a maximum number of items after which the Page Control will be replaced by a label.
- Add an outlet for the view in the view controller.
- In the controller's viewDidLoad method, create an array of UIImage objects and assign it to the ImageCarouselView's 'images' property.


--

Roberto Rumbaut - 2016