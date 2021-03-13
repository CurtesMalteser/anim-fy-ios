# AnimFy for iOS

**AnimFy** is an app fpr iOS that displays the top rated list of anime and manga on Kitsu API.

## How to build

After clone the project to your MacOS machine open your Xcode IDE.

Go file > open (or press CMD + O) and open the project.

You might need to "Set the active shceme" to be "AnimFy".  
In ca of doubts go Helpe menu and type "Switch schemes and destinations". Follow the instructions.

I should build without problems and should be ready run on a simulator.

## How to use

The app initial screen displays a tab bar controller that presents the top anime or top manga depending on the selected
tab.  
The app must be online to download this data.

Click in one of the collection items to see the details about the selected anime/manga.

On that section is possible to add the selected item to the favorites or watch/read later list.  
This selection is preserved on local storage and is available even if the app is offline.

To navigate to favorites or watch/read later section, press the menu button in the top right corner menu of the initial
screen.  
Is possible to close this menu by tapping on close button or outside the selection buttons area.

After make your selection the stored items will be display on a similar collection view and select one of these items  
like previously explained.

The displayed details are only the poster, synopsis and option to add/remove from favorites or watch/read later list.

When the details view is dismissed the previous favorites or watch/read later list will be updated if there are any
changes.

If the favorites or watch/read later list is empty, an informative message is displayed to inform the user that there
are  
no items for that selection.

Close the favorites or watch/read later list the app will display the initial screen.
