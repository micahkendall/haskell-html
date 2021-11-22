import Data.List
import Data.Maybe
import HEngine
-- need some infix operator which allows Html # <- [props] [children] (inserting <- [props] to other normal statements)

items = [("2021 Nov 30",
        "Why I swore off haskell web tech"),
        ("2021 Nov 25",
        "Are haskell html templates even a good idea?"
        ),
        ("2021 Nov 17",
        "Writing a HTML composition library for haskell")]

--blogItem = (\[a, b]->P # [String a, String "\n<br/>\n", String b, String "<hr/>"])
blogItem (a, b) = H6 # [
        String a,
        A # [
            H1 # [
                String b
            ]
        ]
    ]
blogItems = Unwrap $ map blogItem items

home = Html # [
        Body # [
            Div # [
                H1 # [String "Micah's Blog."],
                Hr # [],
                Unwrap $ map blogItem items
                --P # [String "Content of a paragraph"],
                --A # [String "https://williamsaffreys-testicles.to"]-- empty link object
            ]
        ]
    ]

main=putStrLn (render home)