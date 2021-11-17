import HEngine
import Data.List

items = [("2021 Nov 30":
        "Why I swore off haskell web tech":
        []),
        ("2021 Nov 25":
        "Are haskell html templates even a good idea?":
        []),
        ("2021 Nov 17":
        "Writing a HTML composition library for haskell":
        [])]

blogItemFromList [a,b] = (H5 -< [
        "style" --> css[
            Color --> "grey"
        ]
    ] $ a)
    ++ (A -< [
        "href" --> "https://example.com",
        "style" --> css[
            Color --> "#337ab7",
            TextDecoration --> "none"
        ]
    ]$ H1 -< [
        
    ] $ b)
blogItems = intercalate "\n" (map blogItemFromList (items))

lineSplit = Hr -< [] $ ""

home = Html -< []
      $ Body -< []
        $ Div -< [
            "style" --> css[
                    Width --> "calc(60% - 80px)",
                    MarginLeft --> "calc(20% - 40px)",
                    MarginTop --> "50px",
                    BackgroundColor --> "#eee",
                    Padding --> "80px",
                    BoxShadow --> "0px 0px 15px -4px rgba(0,0,0,0.77)"
                ]
            ]
            $ (H1 -< [
                "style" --> css[
                        Color --> "black",
                        FontSize --> "2em",
                        TextAlign --> "center",
                        FontFamily --> "-apple-system, BlinkMacSystemFont, 'Segoe UI'"
                    ]
                ]
                $ "Micah's Blog.")
            ++ (lineSplit)
            ++ blogItems

main = putStrLn home