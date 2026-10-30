# `xyric.sh`

## What is Xyric?
[Xyric](https://scratch.mit.edu/projects/894909530) is a streaming platform\* in [Scratch](https://en.wikipedia.org/wiki/Scratch_(programming_language)) developed by [@DeafyLeaf](https://scratch.mit.edu/users/DeafyLeaf/)/[@DevSpring](https://scratch.mit.edu/users/DevSpring/). Xyric was designed to look like [Netflix](https://en.wikipedia.org/wiki/Netflix) (at least, to my knowledge). Xyric doesn't actually play movies, though...

## What is `xyric.sh`?
`xyric.sh` is a port of Xyric to [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)), a shell that provides a [CLI](https://en.wikipedia.org/wiki/Command-line_interface). `xyric.sh` is a [shell script](https://en.wikipedia.org/wiki/Shell_script) that, like most other shell scripts, uses the keyboard and **only** the keyboard for navigation.

## What inspired this project?
This project was inspired by [@cat_Eatacat](https://scratch.mit.edu/users/cat_Eatacat/)'s studio, the [Xyric app gallery](https://scratch.mit.edu/studios/35530438/), which has almost 60 unofficial ports of Xyric at the time of writing this.
*in reality, it was a discord message sent by [@31parkjulian](https://scratch.mit.edu/users/31parkjulian/)...*

## Why bash?
I like the command-line, and I like its limitations. I'm not the *best* coder, but I can code pretty good in bash. I've also learned a lot in bash programming from the Youtube channel, [You Suck At Programming](https://www.youtube.com/@yousuckatprogramming).

## How do I run this?
To run this, start by downloading the latest version (or any version) of `xyric.sh` from the [releases page](https://github.com/pid-j/xyric.sh/releases). Then, follow the steps according to your operating system.

### Windows
If you have [`wsl`](https://learn.microsoft.com/en-us/windows/wsl/install) installed, launch `wsl` and proceed to the steps for Linux. Otherwise, install it with this command:
```shell
wsl.exe --install
```

Then, launch `wsl` and proceed to the steps for Linux.

### macOS
To my knowledge the steps for Linux are the same for macOS; although, I don't know because I don't use a Mac.

### Linux
To run the script, add the executable flag and run it. The [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) will cause it to run with bash.
```shell
chmod +x /path/to/xyric.sh
/path/to/xyric.sh
```

Alternatively, to run the script with the `bash` executable instead:
```shell
bash /path/to/xyric.sh
```
