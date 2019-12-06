# Rhissl
A R port of [pnnl's chissl](https://github.com/pnnl/chissl)
Paper about [Chissl](https://dl.acm.org/citation.cfm?id=3302280)
YouTube video about [Chissl](https://youtu.be/VAsFlZGjL5I)

# Lookbook
Here is a description of what we need to do for this project

1st) Load the results of an Mnist Training

2nd) Display these initial results as a header to the shiny app as seen in the image below.
Lets just provide this via a quick k-means clustering. (we could even have this pre-computed)

![mnist header](Lookbook/First.PNG)

3rd) Provide the ability to click on one of these labels to invoke the editing of that group. In the image above the user is clicking on the number "8". The image below shows the first group editor menu.

![group editor](Lookbook/Second.PNG)

4rd) As seen in the image above when the user clicks on one of the images, it creates a second group to label. The column labels of the group editor can be seen better in the below image

![group editor closeup](Lookbook/Third.PNG)
