**In flutter there is not a direct way to add inner shadow to a widget**
I came out with this way just to simulate this inner sahdow 
This is a demo video for the UI : [https://www.youtube.com/watch?v=5eRAQjn0PAM]
### General Explanation
- The TextFormField will be used just for taking the Input
- The height of the CustomTextField will be fieldHeight
- The Decoration of the CustomTextField will be the BoxDecorationof the Container
- We will use the _focusNode to listen the focus of the TextField
- We will use showBorder to control the border of the CustomTextField
- For the outer shadow I used the normal BoxShdow
### Custom Shadow Explanation
- We will use the `gradient` property to implement the inner shadow
- The `fillRatio` property will used to determine how many times the `fillColor` will repeat
- And the `isCustomShadow` used to enter a customizable `List<Color>` shadow
- You can use control the end and the begin of the shadow using the default value named parameters `shadowEnd` and `shadowBegin`

### This approch could be used with any widget, I provided a `TextField` for example
