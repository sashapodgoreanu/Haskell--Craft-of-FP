>   module Chapter6Exercises where
>   import Hugs.Prelude
>   import Char
>   import Pictures hiding (printPicture)


>   cheese :: Picture    
>   cheese = ["############",
>             "#....##..#.#",
>             "#..##.....##",
>             "#.#.......##",
>             "#.#...#...##",
>             "#.#...###.##",
>             "##....#..###",
>             "#.#...#....#",
>             "#..#...#...#",
>             "#...#..#...#",
>             "#....#.#...#",
>             "############"]


Exercise 6.1

>   superimposeChar :: Char -> Char -> Char
>   superimposeChar '.' '.' = '.'
>   superimposeChar a b = '#'


Exercise 6.2

>   superimposeLine :: [Char] -> [Char] -> [Char]
>   superimposeLine linea lineb = [superimposeChar a b | (a,b) <- zip linea lineb]


Exercise 6.3

>   superimpose :: Picture -> Picture -> Picture
>   superimpose pica picb = [superimposeLine a b | (a,b) <- zip pica picb]


Exercise 6.4

>   printPicture :: Picture -> IO ()
>   printPicture pic = putStr (foldl (\x y -> x ++ y ++ "\n") "" pic)


Exercise 6.6

>   rotateLine90 :: Picture -> Int -> [Char]
>   rotateLine90 pic n = reverse [line!!n | line<-pic]

>   rotate90 :: Picture -> Picture
>   rotate90 pic = [rotateLine90 pic i | i<-[0 .. (length pic) - 1]]


Exercise 6.7

>   rotateAnti90 :: Picture -> Picture
>   rotateAnti90 pic = rotate90 (rotate90 (rotate90 pic))


Exercise 6.8

>   scaleX :: [Char] -> Int -> [Char]
>   scaleX line n = foldl (++) "" [replicate n c | c<-line]

>   scaleY :: Picture -> Int -> Picture
>   scaleY pic n = concat [replicate n line | line<-pic]

>   scale :: Picture -> Int -> Picture
>   scale pic n
>     | n <= 0     = []
>     | otherwise  = scaleY [scaleX line n | line<-pic] n


Exercise 6.9

>   type Position = (Int, Int)
>   type Image = (Picture, Position)

>   makeImage :: Picture -> Position -> Image
>   makeImage pic pos = (pic, pos)


Exercise 6.10

>   changePosition :: Image -> Position -> Image
>   changePosition img pos = (fst img, pos)


Exercise 6.11

>   posX :: Image -> Int
>   posX img = (fst . snd) img

>   posY :: Image -> Int
>   posY img = (snd . snd) img

>   moveImage :: Image -> Int -> Int -> Image
>   moveImage img x y = changePosition img (posX img + x, posY img + y)


Exercise 6.12

>   printImage :: Image -> IO ()
>   printImage img = printPicture (fst img)


Exercise 6.13

>   naiveTrans :: Image -> (Picture -> Picture) -> Image
>   naiveTrans img f = makeImage ((f . fst) img) (snd img)

>   flipImageNaiveH :: Image -> Image
>   flipImageNaiveH img = naiveTrans img flipH

>   flipImageNaiveV :: Image -> Image
>   flipImageNaiveV img = naiveTrans img flipV

>   rotateImageNaive :: Image -> Image
>   rotateImageNaive img = naiveTrans img rotate

>   rotateImageNaive90 :: Image -> Image
>   rotateImageNaive90 img = naiveTrans img rotate90


Exercise 6.14

>   imageHeight :: Image -> Int
>   imageHeight img = (length . fst) img

>   imageWidth :: Image -> Int
>   imageWidth img = length ((fst img)!!0)

>   flipImageGeoH :: Image -> Image
>   flipImageGeoH img = moveImage (flipImageNaiveH img) (imageWidth img) 0

>   flipImageGeoV :: Image -> Image
>   flipImageGeoV img = moveImage (flipImageNaiveV img) 0 (imageHeight img)

>   rotateImageGeo :: Image -> Image
>   rotateImageGeo img = moveImage (rotateImageNaive img) (- (imageWidth img)) (imageHeight img)

>   rotateImageGeo90 :: Image -> Image
>   rotateImageGeo90 img = moveImage (rotateImageNaive90 img) 0 (imageHeight img)


Erercise 6.18

>   maxThreeOccurs :: Int -> Int -> Int -> (Int, Int)
>   maxThreeOccurs a b c
>     = (maxOccurs, timesOccurs)
>       where
>       maxOccurs   = max a (max b c)
>       timesOccurs = length (filter (\x -> x == maxOccurs) [a, b, c])


Exercise 6.20

>   type Name     = String
>   type Price    = Int
>   type BarCode  = Int
>   type Database = [(BarCode, Name, Price)]

>   type TillType = [BarCode]
>   type BillType = [(Name, Price)]

>   codeIndex :: Database
>   codeIndex = [(4719, "Barries nuts", 345),
>                (3513, "Smolik deck", 5945),
>                (3883, "Badass Jacket", 595),
>                (4758, "Cheeseburger", 3943),
>                (1523, "Whale dildo", 1535),
>                (8583, "Muska Shoes", 7900)]

>   lineLength :: Int
>   lineLength = 30

>   produceBill :: TillBill -> String
>   produceBill = formatBill . makeBill

>   
