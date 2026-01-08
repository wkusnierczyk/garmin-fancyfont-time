# Garmin Fancyfonts Time

A minimalist, elegant, nerdy, typography-focused Garmin Connect IQ watch face that displays the current time using a variety of beautiful fonts..

![Fancyfonts Time](resources/graphics/FancyfontsTimeHero-small.png)

Available from [Garmin Connect IQ Developer portal](https://apps.garmin.com/apps/{blank:app-id}) or through the Connect IQ mobile app.

> **Note**  
> Fancyfonts Time is part of a [collection of unconventional Garmin watch faces](https://github.com/wkusnierczyk/garmin-watch-faces). It has been developed for fun, as a proof of concept, and as a learning experience.
> It is shared _as is_ as an open source project, with no commitment to long term maintenance and further feature development.
>
> Please use [issues](https://github.com/wkusnierczyk/garmin-fancyfonts-time/issues) to provide bug reports or feature requests.  
> Please use [discussions](https://github.com/wkusnierczyk/garmin-fancyfonts-time/discussions) for any other comments.
>
> All feedback is wholeheartedly welcome.

## Contents

* [Fancyfonts time](#fancyfonts-time)
* [Features](#features)
* [Fonts](#fonts)
* [Build, test, deploy](#build-test-deploy)

## Fancyfonts time

{blank:description}

## Features

The Fancyfonts Time watch face supports the following features:

|Screenshot|Description|
|-|:-|
{blank:features}

## Fonts

The Fancyfonts Time watch face uses custom fonts:

| Font                           | Size on 454x454 pixel screen |
| :----------------------------- | ---------------------------: |
| Acme regular                   |                           56 |
| Amaranth regular               |                           56 |
| AmaticSC regular               |                           74 |
| Asimovian regular              |                           49 |
| BerkshireSwash regular         |                           56 |
| CaveatBrush regular            |                           62 |
| Changa regular                 |                           56 |
| CormorantUnicase bold          |                           56 |
| CroissantOne regular           |                           49 |
| UbuntuCondensed regular        |                           25 |
| Delius regular                 |                           56 |
| DynaPuff_SemiCondensed regular |                           56 |
| EpundaSlab medium              |                           56 |
| Fondamento regular             |                           56 |
| GloriaHallelujah regular       |                           49 |
| GrenzeGotisch medium           |                           62 |
| Handlee regular                |                           56 |
| Italiana regular               |                           62 |
| Jura regular                   |                           49 |
| Limelight regular              |                           49 |
| LobsterTwo regular             |                           56 |
| LoveYaLikeASister regular      |                           56 |
| Macondo regular                |                           56 |
| Megrim regular                 |                           49 |
| Merienda regular               |                           49 |
| Philosopher bold               |                           49 |
| PoetsenOne regular             |                           49 |
| Quintessential regular         |                           62 |
| RammettoOne regular            |                           37 |
| Sniglet regular                |                           49 |
| SpecialElite regular           |                           49 |
| StackSansNotch regular         |                           49 |
| SUSE regular                   |                           56 |
| TenorSans regular              |                           49 |
| TurretRoad regular             |                           49 |
| UnicaOne regular               |                           56 |
| UnifrakturMaguntia regular     |                           62 |
| YuseiMagic regular             |                           49 |

## Build, test, deploy

To modify and build the sources, you need to have installed:

* [Visual Studio Code](https://code.visualstudio.com/) with [Monkey C extension](https://developer.garmin.com/connect-iq/reference-guides/visual-studio-code-extension/).
* [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/).

Consult [Monkey C Visual Studio Code Extension](https://developer.garmin.com/connect-iq/reference-guides/visual-studio-code-extension/) for how to execute commands such as `build` and `test` to the Monkey C runtime.

You can use the included `Makefile` to conveniently trigger some of the actions from the command line.

```bash
# build binaries from sources
make build

# run unit tests -- note: requires the simulator to be running
make test

# run the simulation
make run

# clean up the project directory
make clean
```

To sideload your application to your Garmin watch, see [developer.garmin.com/connect-iq/connect-iq-basics/your-first-app](https://developer.garmin.com/connect-iq/connect-iq-basics/your-first-app/).
