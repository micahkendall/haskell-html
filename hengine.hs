module HEngine where
import Data.Char
import Data.List
import Kebab

-- represent different html elements
data RawElement = Html | Body | Div | P | B | H1 | H5 | Li | Span | H3 | A | Hr
    deriving (Show)

-- possibly automatically split at case change?
data CssProperty = BackgroundColor | Color | FontSize | TextAlign | Width | MarginLeft | MarginTop | Height | Padding | BoxShadow | TextDecoration | TextTransform | FontFamily
    deriving (Show)

type AssignedProperty = (String, String)

type Element = (RawElement, [AssignedProperty])

strFromProp :: CssProperty -> String
strFromProp = toKebab.show

unprops [] = ""
unprops ((a,b):xs) = a ++ "=\"" ++ b ++ "\" " ++ (unprops xs)

-- "open, close" can be under the "where" of the (#) function since they're only helpers anyway. (same for unprops.)
open a c = "<" ++ (map toLower (show a)) ++ " " ++ (unprops c) ++ ">"
close a = "</" ++ (map toLower (show a)) ++ ">"

--(#) :: Show a => (a, b) -> String -> String
(a, c) # b = (open a c) ++ b ++ (close a)

-- syntactic sugar for AssignedProperty
--(-->), (-<) // maybe add an operator for objects with no contents? (breaks, hrs.)
a --> b = (a, b)
a -< b = ((a, b)#)

css [] = ""
css ((a,b):xs) = (strFromProp a) ++ ":" ++ b ++ ";" ++ (css xs)

lineSplit = Hr -< [] $ ""