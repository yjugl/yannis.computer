{-# LANGUAGE OverloadedStrings #-}
import Hakyll

directFiles :: Pattern
directFiles = "images/*" .||. "css/*" .||. "js/*"

main :: IO ()
main = hakyll $ do
         match directFiles $ do
                  route idRoute
                  compile copyFileCompiler

         match "index.html" $ do
                  route idRoute
                  compile copyFileCompiler
