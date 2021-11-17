-- revise, this is garbage
-- (CamelCase) -> (kebab-case)
-- for css
module Kebab where
import Data.Char (toLower, isUpper)
toKebab = (map toLower).tail.uncamelHelper
    where
        uncamelHelper [] = ""
        uncamelHelper (x:xs) = (uncamelChar x)++uncamelHelper xs
        uncamelChar x = if x `elem` ['a'..'z'] then [x] else ['-', x]