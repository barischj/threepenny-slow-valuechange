module Main where

import qualified Graphics.UI.Threepenny      as UI
import           Graphics.UI.Threepenny.Core
import           Reactive.Threepenny

main :: IO ()
main = do
  startGUI defaultConfig setup

setup :: Window -> UI ()
setup window = do
  (event, handler) <- liftIO $ newEvent
  behavior         <- stepper "No file selected." event
  text             <- UI.div # sink UI.text behavior
  input            <- UI.input # set UI.type_ "file"
  getBody window #+ map element [text, input]
  on UI.valueChange input $ const $ do
    liftIO $ handler "File selected."

