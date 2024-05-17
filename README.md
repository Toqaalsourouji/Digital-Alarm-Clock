# 🎯 **Digital Alarm Clock** ⏰

This project implements a digital alarm clock using Verilog. The design is targeted for the BASYS3 FPGA board and includes several modules for handling different functionalities.

## 🧑‍🤝‍🧑 **Group Members**

- **Adham Gohar**
- **Toqa Hassanein**
- **Khadeejah Iraky**

## 📁 **Project Structure**

- **Diagrams**: Contains design diagrams.
  - `ASM_Design.png`: ASM design diagram.
  - `Block_Diagram.png`: Block diagram of the project.
  - `FSM_Design.png`: FSM design diagram.
- **Logisim_Evolution_Design**: Placeholder for Logisim Evolution design files.
- **src**: Contains the Verilog source files for different modules.
  - `ClockDiv.v`: Clock divider module.
  - `Debouncer.v`: Debouncer module.
  - `DigitalAlarmClock.v`: Main digital alarm clock module.
  - `DigitalAlarmClock_C.v`: Configuration for the digital alarm clock.
  - `HourMinCounter.v`: Hour and minute counter module.
  - `MultiplexedOutput.v`: Multiplexed output for the 7-segment display.
  - `NBitCounter.v`: N-bit counter module.
  - `PushButtonDet.v`: Push button detection module.
  - `risingEdgeDet.v`: Rising edge detection module.
  - `SevenSegment.v`: Seven-segment display module.
  - `Synchronizer.v`: Synchronizer module.
- **constraints**: Contains the Xilinx Design Constraints file.
  - `DigitalAlarmClock_C.xdc`: Constraints file for the digital alarm clock.
- **README.md**: Project documentation.
- **.gitignore**: Git ignore file to exclude unnecessary files.

## 🔧 **Modules**

1. **Clock Divider**: Generates slower clock signals from the main clock.
2. **Debouncer**: Handles switch debounce.
3. **Digital Alarm Clock**: Main module for the digital alarm clock.
4. **Hour and Minute Counter**: Manages hour and minute counting.
5. **Multiplexed Output**: Controls the 7-segment display multiplexing.
6. **N-Bit Counter**: N-bit counter for time counting.
7. **Push Button Detection**: Detects push button presses.
8. **Rising Edge Detection**: Detects rising edges of signals.
9. **Seven Segment Display**: Drives the seven-segment display.
10. **Synchronizer**: Synchronizes asynchronous signals.

## 🚀 **Getting Started**

To get started with this project, clone the repository and navigate to the `src` directory to view the source files.

