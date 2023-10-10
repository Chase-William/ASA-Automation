## Functions

### AutoClicker

Performs a left click every 50 milliseconds.

To change the auto click speed read <a href="#change_autoclick_interval">here</a>.

### Auto Metal Farm

Combines the auto clicker with automatic:

1. Take all of flint.
2. Drop all berries.
3. Drop all stone.

To change the auto click speed read <a href="#change_autoclick_interval">here</a>.

> Dropping of items is triggered by a click threshold, therefore, adjusting *autoClickInterval* can have a side effect on this function.

### Handle Metal Farm Junk

Pauses any existing functions *(i.g., auto clicker)* running to perform the following before resuming paused functions.

1. Take all of flint.
2. Drop all berries.
3. Drop all stone.

> Do not trigger when inside the dino's inventory or yours.

### Auto Self Meat Farm

Produce meat by suiciding over campfires constantly.

> Ensure Meat Farm Beds poisition is set to your beds to respawn at. I tried using image search and other options for automatically finding the beds after a query, but because of the large amount of iterations of this function; a fool proof approach was needed.

### Auto Fertilizer

Produce slot caps of fertilizer by using a irrigated toilet and this function. Your character must be ready to defecate and be seated on a irrigated toilet not within any inventory to begin.

> Will automatically stop at 250 fert.

### Auto Fish

...

### Auto Take All

...

### Auto Brew

...

### Auto Eat

...

### Auto Drink

...

### Auto Equip Scuba

...


<a name="change_autoclick_interval"></a>
#### Change AutoClicker Interval

To change the auto click interval follow these steps:

1. Open `config.ini`.
2. Find *autoClickInterval* under the *[delay]* section.
3. Replace the default *50* with your interval in milliseconds.


## Developer Notes

A function ending in `Safe` means it has built in mechanics to ensure the desired state is reached before returning.

### Interrupt Logic
To make functions easier to use, they should be interruptable, resumeable, and replaceable to allow long running processes and quick process to work together. Therefore, below is a map of rules all functions adhere to.

#### Interruptible & Resumable Functions
Functions that can be momentarily paused while another functions executes and later resumed afterwards automatically.

1. Auto Clicker
2. Metal Farm
3. Auto Brew
4. Auto Eat
5. Auto Drink

#### Interruptable & Replaceable Functions
Functions that can be interrupted *(execution terminates)* and be replaced by another.

1. Drop Metal Farm Junk

#### Uninterruptable Functions
Functions that cannot be interrupted by other functions and therefore, can only be enabled/disabled directly.

1. Bot
2. Paste Farm
3. Suicide Farm
4. Fert Farm
5. Take All
6. Give All
7. Self Drop All
8. Other Drop All
   
#### Catalyst Functions
Functions that can interrupt other functions or fail to execute if an uninterruptable function is currently active.

1. Take All
2. Give All
3. Self Drop All
4. Other Drop All
5. Drop Metal Farm Junk

#### Process Stuff

```
----- Health Had

43-CA-ED - white wall
red, green diff = 87 (hex) -> (decimal) 135
green, blue diff = 23 -> 35
red, blue diff = AA -> 170

00-83-A6 - metal structure

red, green diff = 83 -> 131
green, blue diff = 23 -> 35
red, blue diff = A6 -> 166

00-7F-9F - fridge pale

red, green diff = 7F -> 127
green, blue diff = 20 -> 32
red, blue diff = 9F -> 159

average red,green diff = 131
average green, blue diff = 34
average red, blue diff = 165

Health Had Image Mask: 131, 34, 165

------ Health Lost

CDE3EA - white wall
red, green diff = 16 -> 22
green, blue diff = 7 -> 7
red, blue diff = 1D -> 29

33-50-56 - metal structure
red, green diff = 1D -> 29
green, blue diff = 6 -> 6
red, blue diff = 23 -> 35

21-3B-39 - fridge pale
red, green diff = 1A -> 26
green, blue diff = 2 -> 2
red, blue diff = 18 -> 24

Health Lost Image Mask: 25, 5, 29

Results:

Health Had Image Mask: 131, 34, 165 == More opaque

Health Lost Image Mask: 25, 5, 29 == More transparent
```