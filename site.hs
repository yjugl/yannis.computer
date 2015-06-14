{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid ((<>))
import Hakyll

main :: IO ()
main = hakyll $ do
         match ("images/*.jpg" .||. "css/*.css" .||. "js/*.js") $ do
                  route idRoute
                  compile copyFileCompiler

         match "templates/*.html" $ compile templateCompiler

         match "pages/index-*.md" $ compile pandocCompiler

         create ["index.html"] $ do
                  route idRoute
                  compile $ do
                    articles <- loadAll "pages/index-*.md"
                    let ctx = listField "articles" defaultContext (return articles) <> defaultContext
                    makeItem "" >>=
                      loadAndApplyTemplate "templates/section.html" ctx >>=
                      loadAndApplyTemplate "templates/main.html" defaultContext
                                                     
