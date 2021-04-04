#!/usr/local/bin/guile \
-e main -s
!#
; Checks if the word string is a palindrome.
(define (palindrome? word)
  ; Call the helper method, passing the whole string argument and the initial left and right pointers (0 and length - 1 respectively).
  (loop word 0 (- (string-length word) 1)))

; Uses recursion to check opposite characters in the word, as we move the left and right pointers in the opposite direction.
(define (loop word left right)
  (cond ((>= left right)  ; Check if we checked for equality for all opposites.
         #t) ; If we have by this point, then this word should be a palindrome.
        ((not (char=? (string-ref word left) (string-ref word right)))  ; Check if the opposites are equal.
         #f) ; If they're not equal, then it's not a palindrome.
        (else   ; We continue the recursion if none of the base cases have been met.
         (loop word (+ left 1) (- right 1))))) ; Move the pointers in the opposite directions.

; Calls the palindrome function and passes the command line arguments to the function.
; NOTE: WE only take one argument, and should be a string that is not empty.
(define (main args)
  (display (palindrome? (car (cdr args))))
  (newline))