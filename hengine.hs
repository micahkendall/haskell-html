module HEngine where
import Data.Char
import Data.List
import Kebab

-- represent different html elements (plan to automatically generate this enum set)
data RawElement = Html | Body | Div | P | B | H1 | H5 | Li | Span | H3 | A | Hr | H6
    deriving (Show)
type AssignedProperty = (String, String)
data Element = MkElem RawElement [AssignedProperty] [Element] | String String | Unwrap [Element]

-- automatically splits now, same as above but for css
data CssProperty = BackgroundColor | Color | FontSize | TextAlign | Width | MarginLeft | MarginTop | Height | Padding | BoxShadow | TextDecoration | TextTransform | FontFamily
    deriving (Show)

strFromProp :: CssProperty -> String
strFromProp = toKebab.show

toString :: RawElement -> String
toString = map toLower.show

extraTab = (foldr1 (++)).(map (\x->if (x=='\n') then "\n  "; else [x]))

insertProps [] = ""
insertProps ((a, b):xs) = " "++a++"=\""++b++"\""

render :: Element -> String
render (Unwrap x) = ((foldr1 (++)).(map render)) x
render (String x) = x++""
render (MkElem x y []) = "<"++(toString x)++(insertProps y)++">" ++ "</"++(toString x)++">"
render (MkElem x y z) = "\n<"++(toString x)++(insertProps y)++">" ++ extraTab ("\n"++((foldr1 (++)).(map render)) (z))++"\n" ++ "</"++(toString x)++">"

(#) :: RawElement -> [Element] -> Element
(#) x = MkElem x []
(#&) x y = (MkElem x y)

--(=->) :: ([Element] -> Element) -> ([Element] -> Element)
--(=->) (MkElem x y) z = MkElem x (y++z)

css [] = ""
css ((a,b):xs) = (strFromProp a) ++ ":" ++ b ++ ";" ++ (css xs)

-- ? 
a --> b = (a, b)