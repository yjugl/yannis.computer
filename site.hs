{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid ((<>))
import Hakyll

main :: IO ()
main = hakyll $ do
         match ("images/*.jpg" .||. "css/*.css" .||. "js/*.js" .||. "favicon.ico") $ do
                  route idRoute
                  compile copyFileCompiler

         match "templates/*.html" $ compile templateCompiler

         match "pages/*.md" $ compile pandocCompiler

         create ["index.html"] $ section "news" "News"

         create ["about.html"] $ section "about" "About"

section :: String -> String -> Rules ()
section section title = do
  route idRoute
  compile $ do
    articles <- loadAll $ fromGlob $ "pages/" ++ section ++ "-*.md"
    let sectionCtx = listField "articles" defaultContext (return articles) <> defaultContext
    let mainCtx = constField "title" title <> defaultContext
    makeItem "" >>=
            loadAndApplyTemplate "templates/section.html" sectionCtx >>=
            loadAndApplyTemplate "templates/main.html" mainCtx
