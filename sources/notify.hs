-- ghc -dynamic notify.hs

import DBus.Notify
main = do
  client <- connectSession
  let hello = blankNote { summary="Hello world!",
                          body=(Just $ Text "This is an example notification."),
                          appImage=(Just $ Icon "dialog-information") }
  notification <- notify client hello
  return 0
