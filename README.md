# literate-disco

- can generate quote (author, and quote string)
- can generate photoURL
- can put both into screenshot (and package all of above, minus photoURL, into object)

- NEED:
- PROPERLY SETUP SEGUE FROM MAIN TO ADD DETAIL

- to pass back finished QUote BACK to mainview
- add that to an array (append)
- reload tableview once data passed back
- once click cell; open UIActivtiy/Share to save image, send via txt/etc.

"This is a table view, with a list of all the quote & image pairings we've made. Take a moment to sketch out a wireframe of what you want this screen to look like. It doesn't necessarily need to show images, but it should show the name of the person and at least part of their quote.

Tapping a cell will open up a UIActivityViewController, allowing the user to share an image to iMessage/Facebook/Twitter."

HOW -- to make it all work

ADD VIEW IS DELGATOR -- will call that method

MAIN VIEW IS DELEGATE will implement protocol method

will confirm to --> finishedQuoteDelegate (main view)


(create this in AddQUoteView)
protcol
func didFinishQuote (finished: quoteobject) {

}

mainView will IMPLEMENT this function

func didFinishQuote (finished: quoteobject) {
  objectarray.append(quoteobject)
  mainview.reloaddata  
}

addquote will CALL function when user clicks "Save"

func didFinishQuote (finished: quoteobject) {
 // make object to send back
 
}

// will then call self.delgate.didfinish(object)

