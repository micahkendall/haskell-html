module HEngine where
import Data.Char
import Data.List
import Kebab

-- represent different html elements (plan to automatically generate this enum set)
data RawElement = Html | Body | Div | P | B | H1 | H5 | Li | Span | H3 | A | Hr
    deriving (Show)

-- automatically splits now, same as above but for css
data CssProperty = BackgroundColor | Color | FontSize | TextAlign | Width | MarginLeft | MarginTop | Height | Padding | BoxShadow | TextDecoration | TextTransform | FontFamily
    deriving (Show)

-- for future type annotations
type AssignedProperty = (String, String)
type Element = (RawElement, [AssignedProperty])

-- takes a css property, gives corresponding string (using kebab lib I made)
strFromProp :: CssProperty -> String
strFromProp = toKebab.show

-- similar to above but for html. Easier to do.
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

-- expanding css list options into a string
css [] = ""
css ((a,b):xs) = (strFromProp a) ++ ":" ++ b ++ ";" ++ (css xs)