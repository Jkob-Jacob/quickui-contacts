###
The main app page, which shows a toolbar and a list of contacts.

This is the app's top-level View, although it doesn't do much; it simply hands
the contact collection Model to an instance of ContactListBox, which does the
real work of showing the contacts. The important thing is that the Presenter
doesn't need to know anything about what's going on inside the View; it can
just interact with the top page here. We could completely redesign this page
and the Presenter logic could remain the same.
###

class window.ContactsPage extends Page
  
  inherited:
    title: "Contacts — QuickUI Sample Application"
    fill: true
    content:
      ###
      Divide the available real estate into a top panel and a content region.
      Importantly, we *don't* have to know the pixel height of the Toolbar in
      the top panel; the VerticalPanels control will take care of ensuring the
      remaining space goes to the main content region. On a modern browser that
      supports CSS flexbox layout, VerticalPanels will use that.
      ###
      control: "VerticalPanels"
      constrainHeight: true
      top:
        control: "Toolbar"
      content:
        control: "ContactListBox", ref: "contactListBox"

  # The page exposes various list box properties as its own properties. This
  # way, we can let the Presenter manipulate the set of contacts and the
  # selection without giving it direct access to the list box.
  contacts: Control.chain "$contactListBox", "items"
  insertItemBefore: ( args... ) ->
    @$contactListBox().insertItemBefore args...
  removeItemAt: ( args... ) ->
    @$contactListBox().removeItemAt args...
  selectedContact: Control.chain "$contactListBox", "selectedControl"
  selectedIndex: Control.chain "$contactListBox", "selectedIndex"
