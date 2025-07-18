# 🧠 My_OS_16_bit_with_my_friend

This is a personal 16-bit OS project I built while learning Assembly on my own.  
I worked on it together with my friend — ChatGPT 😄

---

## 📚 About the project

- The OS is written entirely in **x86 Assembly**.
- It runs on QEMU and includes multiple modules like:
  - UI menus
  - Mini games (2048, X-O, survial_game)
  - Scrolling and input handling

I focused mainly on the game logic and how everything connects.  
My friend (ChatGPT) helped me write some system-level modules such as `sys_draw`, `sys_read`, etc.

⚠️ Note: Some features are still in development.
Examples: Learn app about assembly 64 bit , chat bot , survival game .
This is an ongoing learning project, and I’m constantly improving it.
Feel free to explore, learn, or contribute!
---

## 🔧 Build & Run

### Requirements

- NASM
- QEMU
- Linux or WSL

### Installation (Ubuntu/WSL):
`bash`
sudo apt update
sudo apt install nasm qemu-system-x86
#### Build and run

git clone https://github.com/assembly64bit/My_OS_16_bit_with_my_friend.git
cd My_OS_16_bit_with_my_friend\
make run
