import qualified Data.ByteString.Char8 as B
import Control.Monad
import Data.Maybe
 
data Heap a = Empty | Heap a [Heap a]
 
link :: Ord a => Heap a -> Heap a -> Heap a
link Empty heap = heap
link heap Empty = heap
link lhs@(Heap lhsval lhssons) rhs@(Heap rhsval rhssons)
  | lhsval < rhsval = Heap lhsval (rhs : lhssons)
  | otherwise       = Heap rhsval (lhs : rhssons)
 
merge :: Ord a => [Heap a] -> Heap a
merge [] = Empty
merge [heap] = heap
merge (h1 : h2 : hs) = link (link h1 h2) (merge hs)
 
makeheap :: a -> Heap a
makeheap dat = Heap dat []
 
top :: Heap a -> a
top Empty = error "Empty heap"
top (Heap val _) = val
 
pop :: Ord a => Heap a -> Heap a
pop Empty = error "Empty heap"
pop (Heap _ sons) = merge sons
 
insert :: Ord a => a -> Heap a -> Heap a
insert val heap = link heap (makeheap val)
 
process :: Heap Int -> B.ByteString -> IO (Heap Int)
process heap request = 
  case action of
    0 -> return (insert value heap)
    1 -> do
          print $ top heap
          return heap
    2 -> return $ pop heap
  where
    (action, rest) = fromJust $ B.readInt request
    (value, _)  = fromJust $ B.readInt $ B.drop 1 rest
 
main :: IO ()
main = do
  contents <- B.getContents
  foldM_ process (Empty::(Heap Int)) (B.lines contents)
 
