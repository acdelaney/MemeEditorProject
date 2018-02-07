# MemeMeProject

The purpose of the Meme Me App is to be a fun portfolio app where the user can make meme's using photos from his or her camera or the photo library.

## Installation

```
git clone https://github.com/acdelaney/MemeEditorProject.git
```

## Usage

On launch the app opens up to a table view controller that displays recently created memes.  There is a tab controller at the bottom and users are able to toggle between a table view and a collection view.  Selecting a meme within the table or collection view navigates to the Meme Detail view controller, which displays the meme.  Pressing the + button in the upper right navigates to the Meme Creator view controller.

On the Meme Creator view controller, the textfields Top and Bottom appear over a black background.  Using the buttons on the tool bar, the user can select a photo from the photo library or take a picture using the camera.  Once the photo is selected, it appears with the textfields superimposed.  Selecting either textfield clears the placeholder words, and the user can type new words.  Once the meme is done, selecting the button in the upper left allows the user to save the photo or share it through an Activity View Controller.  Once the meme is saved, the Sent Meme view controller is displayed with the newly created meme in the table and collection view.
