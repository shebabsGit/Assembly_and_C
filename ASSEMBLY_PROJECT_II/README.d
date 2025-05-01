Author: Shehab Ahmed 
Student ID: C00295178
Date: 01/05/2025
Description: Significant changes and considerations during conversion process

(Used GCC to help build a foundation for me to build around and work on)

Vulnerability Number 1:
    - Input validation can cause overflow
    - Fixed by setting a range of numbers user can Input (0-255, 1 Byte)
    - Does, however, limit the capacity and use of the program

Vulnerability Number 2:
    - After fixing vulnerability number 1, user can keep inputting incorrect inputs,
     possibly hindering and exploiting memory
    - This gives more chances to exploit other unknown vulnerabilities, like memory
    - Fixed by setting number of failed attempts per number input to 5. 
     After 5 attempts are reached, program is abruptly shut down with a message to let user know why.
    - This fixes memory access because the user is limited to inputs and interactions (quantity and range)

If alphabetic characters are inputted, it skips through the attempts and exits program immediately.
This "FEATURE" demonstrates NOT to fool around and to input a NUMBER within range.

Also made the code cleaner and as easy to read as possible (it is x64, it will hurt the eyes either way.. O>O).
