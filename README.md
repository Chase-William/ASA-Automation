## Function Index

- <a href="#autoClicker">Auto Clicker</a>
- <a href="#autoMetalFarm">Auto Metal Farm</a>
- <a href="#handleMetalFarmJunk">Handle Metal Farm Junk</a>
- <a href="#autoTransfer">Auto Transfer All</a> *(give & take)*
- <a href="#autoDrop">Auto Drop All</a> *(self & other)*
- <a href="#autoConsume">Auto Consume</a> *(healing, food, water)*
- <a href="#autoFertilizer">Auto Fertilizer</a>
- <a href="#autoFish">Auto Fish</a>

## Supported Resolutions 🖥️
- 2560x1440, Fullscreen or Windowed Fullscreen
- 1920x1080, Fullscreen or Windowed Fullscreen

## Functions 📜
Listed below are all the functions or scripts supported in this application.

<a name="autoClicker"></a>
### Auto Clicker 🖱️

By default performs a left click at a specified interval, but can be configured to send keystrokes instead. To send keystrokes, set a keystroke in the *keystroke* hotkey box labeled *Keystroke*. To return to default left click functionality, clear *Keystroke* input and set.

#### Example use cases:

1. Use default to level tank dino health
2. Use keystroke `A` to afk spam craft
3. Use kstroke `E` to afk spam heal carnivore by feeding raw meat

| Interruptable & Resumable By |
| --- |
| Handle Metal Farm Junk |
| Give All |
| Take All |
| Self Drop All |
| Other Drop All |

To read about function interrupt, go <a href="#functionInterrupt">here</a>.

<a name="autoMetalFarm"></a>
### Auto Metal Farm

Auto left clicks with periodic handling of resources gathered. Listed below describes the *handling* process:

1. Take all of flint.
2. Drop all berries.
3. Drop all stone.

| Interruptable & Replaceable By |
| --- |
| Auto Clicker |

To read about function interrupt, go <a href="#functionInterrupt">here</a>.

| Start State | End State |
| --- | --- |
| Not In Inventory, On Dino | Not In Inventory, On Dino |

<a name="handleMetalFarmJunk"></a>
### Handle Metal Farm Junk 🗑️

Invokes the following to immediately run once:

1. Take all of flint.
2. Drop all berries.
3. Drop all stone.

| Start State | End State |
| --- | --- |
| Not In Inventory | Not In Inventory |

<a name="autoTransfer"></a>
### Auto Transfer
Transfers all from a source inventory to a target inventory witha an optional use of a filter.

- ⬅️ **Take All**, gives all items to other inventory
- ➡️ **Give All**, takes all from other inventory

| Start State | End State |
| --- | --- |
| Not In Inventory | Not In Inventory |

<a name="autoDrop"></a>
### Auto Drop All ⬇️

- **Self Drop All**, drops all of your items
- **Other Drop All**, drops all of other's inventory items

| Start State | End State |
| --- | --- |
| Not In Inventory | Not In Inventory |

<a name="autoConsume"></a>
## Auto Consumption
Allows the automatic consumption of consumables once a threshold is reached.

- 🩹 **AutoBrew**, consume med brews
- 🥞 **AutoEat**, consume hunger based consumable
- 🍹 **AutoDrink**, consume water base consumable

| Interruptable & Resumable By |
| --- |
| Handle Metal Farm Junk |
| Give All |
| Take All |
| Self Drop All |
| Other Drop All |

> **Note:** Ensure your in-game hotbar keybinds for healing, eating, and drinking are set under the *In-Game Keybinds* tab.

To read about function interrupt, go <a href="#functionInterrupt">here</a>.

Goto <a href="#autoConsumptionMeta">here</a> to read how auto consumption works.

<a name="autoFertilizer"></a>
### Auto Fertilizer 💩

Produce slot caps of fertilizer by using a irrigated toilet. Character must be ready to defecate and be seated on an irrigated toilet.

| Start State | End State |
| --- | --- |
| Not In Inventory | Not In Inventory |

> **Note:** Will automatically stop at 250 fert and cannot be paused; you had Taco Bell.

<a name="autoFish"></a>
### Auto Fish 🎣

Automatically detects fishing prompts and fulfills them.

Goto <a href="#autoFishMeta">here</a> to read about how Auto Fishing works.

# Options & Supporting Functionalities

<a name="change_autoclick_interval"></a>
### AutoClicker Interval

To change the auto click interval follow these steps:

1. Open `config.ini`.
2. Find *autoClickInterval* under the *[delay]* section.
3. Replace the default *50* with your interval in milliseconds.

<a name="functionInterrupt"></a>
### Function Interrupt ⏯️
To make functions easier to use, they should be pauseable, resumeable, and replaceable to allow:

1. Prevent unwanted function execution overlap
2. Prevent user request being placed in a queue delaying execution
3. Allow long running and quick task to work together
  
Therefore, the interrupt logic table has been defined below.

#### Interruptible & Resumable Functions
Functions that can be momentarily paused while another functions executes and later resumed afterwards automatically.

1. Auto Clicker
2. Metal Farm
3. Auto Brew
4. Auto Eat
5. Auto Drink

#### Interruptable & Replaceable Functions
Functions that can be interrupted *(execution terminates)* and be replaced by another.

1. Handle Metal Farm Junk, *(only effected by Auto Clicker)*

#### Uninterruptable Functions
Functions that cannot be interrupted by other functions and therefore, can only be enabled/disabled directly.

1. Bot *(omitted from default application)*
2. Paste Farm *(omitted from default application)*
3. Suicide Farm *(omitted from default application)*
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
5. Handle Metal Farm Junk

<a name="autoConsumptionMeta"></a>
### Auto Consumption *(How it works)*

<a name="autoFishMeta"></a>
### Auto Fish *(How it works)*

## Developer Notes

A function ending in `Safe` means it has built in mechanics to ensure the desired state is reached before returning.

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



## OMITTED FROM GENERAL RELEASE

### Auto Self Meat Farm

Produce meat by suiciding over campfires constantly.

> Ensure Meat Farm Beds poisition is set to your beds to respawn at. I tried using image search and other options for automatically finding the beds after a query, but because of the large amount of iterations of this function; a fool proof approach was needed.