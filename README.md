## Why I Made This

I have played Ark Survival Evolved for a long time and I have been on the receiving end of almost every cheat at some point in time short of being *wizarded - cheater force joins tribe and claims all as owner*. I have been dev wiped twice as collateral when playing in mega-tribe and lost two different Shadow Caves bases via meshing; once after successfully defending against a large tribe for several days only to be meshed before the next attack. If Ark players can't beat you legitimately, they will resort to cheating; a time proven tale.

Cheating aside, I enjoy the game and it provides a medium for my friends and I to play together. I recall back to 2016 living on 10/10, an iceberg base, wishing I had an alt account to ride my ankylo so that I may individually farm metal with my quetzal. That was 7 years ago, and I still play Ark, but now, now I have the ability to do what I wished then.

This program aims to provide myself and others the ability to do the things I wish I could have back in my younger days, to improve the quality of life in a game that often needs it. To address those who call this cheating, play the game longer, Youtube *chanceware ark* and you'll see the horrors Gaijin has most likely forced Studio Wildcard to permit. Youtube the tribe *TEA on ark*, see how tribes of players get unjustifiably banned, Youtube videos about Mek and capped Tek Suit duping in Ark. In a game that takes ridiculous effort and time where all can be lost overnight as you sleep to cheats, this quality of life application is not the problem.

# How To Run
To run this program, double click the `run.ahk` file.

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

### Other Requirements

- UI Slot Scale must be 100%.
- Gamma must be default value; type: `gamma` in ARK's cmd prompt to set as default.

## Functions 📜
Listed below are all the functions or scripts supported in this application.

<a name="autoClicker"></a>
### Auto Clicker 🖱️

By default performs a left click at a specified interval, but can be configured to send keystrokes instead. To send keystrokes, set a keystroke in the *keystroke* hotkey box labeled *Keystroke*. To return to default left click functionality, clear *Keystroke* input and set.

#### Example use cases:

1. Use default to level tank dino health
2. Use keystroke `A` to afk spam craft
3. Use keystroke `E` to afk spam heal carnivore by feeding raw meat
4. Use keystroke `T` to afk feed a baby dinosaur

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

#### Example Use Cases:
1. Drop all junk when farming metal while using normal auto clicker near the end of the farming run

| Start State | End State |
| --- | --- |
| Not In Inventory | Not In Inventory |

<a name="autoTransfer"></a>
### Auto Transfer
Transfers all from a source inventory to a target inventory with optional filter usage.

#### Example Use Cases:
1. Take opponent's inventory after their defeat
2. Give raw meat to baby dinos quickly
3. Take all hide when farming meat
4. Take all paste from your snails

- ⬅️ **Take All**, takes items from other inventory
![auto-take-all-filtered](https://github.com/Chase-William/ASA-Helping-Tools/assets/46757278/2a8c30d8-9135-47ab-bf15-6ddbfd4c931c)
- ➡️ **Give All**, gives items to other inventory
![auto-give-all-filtered](https://github.com/Chase-William/ASA-Helping-Tools/assets/46757278/d0705ac9-582c-4e3e-af2d-eb7f61b87c55)

| Start State | End State |
| --- | --- |
| Not In Inventory | Not In Inventory |

<a name="autoDrop"></a>
### Auto Drop All ⬇️
Drop all from an inventory with optional filter usage.

#### Example Use Cases:
1. Drop all thatch when farming wood
2. Drop your baby dino on their head and get a mutation

- **Self Drop All**, drops your items
![auto-self-drop-all](https://github.com/Chase-William/ASA-Helping-Tools/assets/46757278/ccfc2a47-aad0-42f1-b1b1-38170be5ae4b)
- **Other Drop All**, drops other's inventory items
![auto-other-drop-all](https://github.com/Chase-William/ASA-Helping-Tools/assets/46757278/3182c72e-1a46-41ce-9e41-59b738a1472d)

| Start State | End State |
| --- | --- |
| Not In Inventory | Not In Inventory |

<a name="autoConsume"></a>
## Auto Consumption
Allows the automatic consumption of consumables once a threshold is reached.

- 🩹 **AutoBrew**, consume med brews
![auto-brew](https://github.com/Chase-William/ASA-Helping-Tools/assets/46757278/ba685641-dd93-4a57-a9dd-b6d703e0f429)
- 🥞 **AutoEat**, consume hunger based consumable
![auto-eat](https://github.com/Chase-William/ASA-Helping-Tools/assets/46757278/72dc97bf-6c8d-493e-9168-de668e82611d)
- 🍹 **AutoDrink**, consume water base consumable
![auto-drink](https://github.com/Chase-William/ASA-Helping-Tools/assets/46757278/28a5b31f-f732-4190-b63c-cb4d0048b609)

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
![auto-fert](https://github.com/Chase-William/ASA-Helping-Tools/assets/46757278/61228977-4555-4e5b-9859-3c24221f2ee5)

Produce slot caps of fertilizer by using a irrigated toilet. Character must be ready to defecate and be seated on an irrigated toilet.

| Start State | End State |
| --- | --- |
| Not In Inventory | Not In Inventory |

> **Note:** Will automatically stop at 250 fert and cannot be paused; you ate Taco Bell 🙏🏻.

<a name="autoFish"></a>
### Auto Fish 🎣
![auto-fish](https://github.com/Chase-William/ASA-Automation/assets/46757278/dc28bb5b-bbe2-4488-8919-666a84bd14f1)
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
In short, auto consumption functions based on the presence of the low health, food, and water mask. Below are samples of low health with different backgrounds that can be used to calculate ARK's mask low stat mask.

![health3](https://github.com/Chase-William/ASA-Automation/assets/46757278/02ffec8d-c8a3-46bd-9cd2-0393b765b6f5)
![health2](https://github.com/Chase-William/ASA-Automation/assets/46757278/3fb51732-d3f4-4251-bead-69fea13b43c0)
![health](https://github.com/Chase-William/ASA-Automation/assets/46757278/6e8a3878-5153-4a22-8847-f70a3ce960c3)

We cannot simply sample the color of a pixel to know if we have low health without calculating/checking the mask because of transparency. Therefore, think of the mask as a pattern between the RGB *(red, green, blue)* channels that make up every pixel. The pixel can be any color, but a certain pattern will always exist between those channels, and if it doesn't, the characters health, food, or water stat is not low.

To calculate the mask, first acquire the color of a pixel with the mask. In my calculations, I found the white background low health to have the color of `0x43CAED`. Taking the hex representation and breaking it down into it's individual RGB components yields:

```
Red Hex: 43
Green Hex: CA
Red Hex: ED
```

To start finding the mask, calculate the difference in color value between each color component like so:

```
*Math is all in Hex*
CA - 43 = 16, difference between green and red
ED - CA = 7, difference between blue and green
ED - 43 = 1D, difference between blue and red
```

A more visual illustration of what we just did:

![Frame 14](https://github.com/Chase-William/ASA-Automation/assets/46757278/cfa7e582-87cd-4d28-b58a-3ee0213fff15)

Moreover, combining the channels reveals our calculated mask value isn't far off.

![Frame 15](https://github.com/Chase-William/ASA-Automation/assets/46757278/cfc2ffac-e8e6-4d15-b9d3-c9b4573afcaf)

All that is left is to calculate the mask a few more times sampling different backgrounds before averaging them. Once that is done, compare the mask value found at runtime with the pre-determined including a level of permitted variance and you're done.

<a name="autoFishMeta"></a>
### Auto Fish *(How it works)*
Two separate approaches were used in developing the auto fishing solution. The first, was using the `ImageSearch &OutputVarX, &OutputVarY, X1, Y1, X2, Y2, ImageFile` function to search for letters within a generalized screen space. Below are a few of the images that were to be matched with:

![2560_1440_W_EDIT](https://github.com/Chase-William/ASA-Automation/assets/46757278/d4fc50c5-aba2-417d-bab3-1947a06532e0)
![2560_1440_A_EDIT](https://github.com/Chase-William/ASA-Automation/assets/46757278/95d12d13-7a7b-425a-a006-e9b234fd87e8)
![2560_1440_E_EDIT](https://github.com/Chase-William/ASA-Automation/assets/46757278/93d2d4f5-129d-4f04-84b5-7c611b112d01)
![2560_1440_X_EDIT](https://github.com/Chase-William/ASA-Automation/assets/46757278/cb21bdaf-747e-4ad4-8369-340e599e4edc)

They were emaciated as to reduce the extra white space needed to match against because ARK's prompt text is near pure white in the center of it's letters and lesser so closer to the edges. Therefore, matches were to be made with the near pure white center of prompt text. This approach led to heavy CPU usage and made my PC stutter. In short, my computer was looking for several needles in a hay stack every second. Even more so, it didn't work, but fret not, I had another card up my sleeve.

Approach #2, the basis of this idea for text recognition came from my days working on the [Tribe Logger](https://github.com/Chase-William#tribe-logger) bot. In that application I used [Tesseract](https://github.com/tesseract-ocr/tesseract), an open source Optical Character Recognition *(OCR)* library for pulling text from images. It is then, I had the thought of how one *should* be able to discriminate between characters as shown below:

![Letter Sequence](https://github.com/Chase-William/ASA-Automation/assets/46757278/f8cec99a-fe0e-4ec1-957d-5d22f7c7a28a)

This diagram describes the sequence characters are check in, and the locations that are checked in each iteration. Each red dot is a point checked during that iteration through the entire set of characters. In order for a given letter to be determined preset, each point check must return true *(AND gates all the way)*. After a character is found, a virtual key is sent to simulate user input and the entire process starts again at the specified `SetTimer` interval.
