# Design of AHB2APB Bridge

## Project Overview

This project focuses on the design, implementation, and verification of an AHB2APB (Advanced High-performance Bus to Advanced Peripheral Bus) Bridge. This bridge facilitates communication between high-performance devices and low-peripheral devices within a system compliant with the AMBA (Advanced Microcontroller Bus Architecture) Specification. The primary goal is to provide an efficient interface for data and control signal exchange between these two distinct bus standards.

## Aim of the Project

The core aim of this project is to design a bridge that enables seamless communication between the Advanced High-performance Bus (AHB) and the Advanced Peripheral Bus (APB), both defined within the AMBA Specification. This bridge allows high-performance devices to interact with lower-speed peripheral devices.

## Objectives of the Project

1.  **Study the Top Module Block Diagram:** Gain a comprehensive understanding of the overall architecture.
2.  **Write Verilog Code:** Develop the hardware description language (Verilog) code for the various modules comprising the AHB2APB Bridge.
3.  **Verify using a Test Bench:** Validate the functionality and correctness of the designed bridge using a dedicated test bench.
4.  **Generate Output Waveforms:** Produce relevant output waveforms for better visualization and understanding of the bridge's operation, timing, synchronization, and overall performance.

<img width="1543" height="688" alt="image" src="https://github.com/user-attachments/assets/9cc55c08-1a26-4433-8611-bd7d74127be2" />


## Methodology and Functionalities

The project involves a thorough discussion of the AHB to APB bridge's design and implementation. This includes:

*   **Top Module Block Diagram:** A detailed representation highlighting the main structural elements and their interconnections.
*   **Sub-block Explanation:** An outline of the precise function each sub-block performs in facilitating communication between the AHB and APB buses.
*   **Output Waveform Analysis:** Examination of the signals and data flow through the bridge during operation to assess its efficiency, dependability, and general performance.

Key functionalities of the Top Module include:

*   **Bus Protocol Conversion:** Converts the AHB bus protocol to the APB bus protocol, handling signal, data format, and bus timing conversions.
*   **Address Decoding:** Identifies if the matching memory or peripheral is on the APB side by decoding incoming AHB addresses and mapping them to proper APB addresses.
*   **Bus Arbitration:** Manages bus arbitration and establishes transaction precedence when multiple AHB masters attempt to access the bridge, ensuring equitable access to the APB bus.
*   **Data Transfer Control:** Manages data movement between the AHB and APB buses, including initiating read/write operations, controlling data flow, and managing handshaking signals.
*   **Error Handling:** Provides systems for error detection and reporting, monitoring bus transactions for issues like congestion, protocol infractions, or timeouts.

## Key Components and Interfaces

The bridge's top module primarily consists of two main parts: the AHB slave interface and the APB controller.

### AHB Slave Interface

This component allows peripheral devices or memories to connect to the AHB bus as slaves, providing necessary signals and protocols for communication with AHB masters. Important signals include:

*   **HADDR:** Address bus signal for the accessed location or peripheral.
*   **HSEL:** Slave select signal for specific AHB slave selection.
*   **HREADY:** Indicates if the AHB slave is ready for the next transaction.
*   **HRESP:** Response signal conveying the status of the prior transaction (e.g., OKAY, ERROR).

### APB Controller

An essential part of the AHB2APB bridge architecture, the APB Controller manages data transmission and control activities as an interface between AHB masters and APB slaves. The APB interface signals include:

*   **PCLK (Peripheral Clock):** The clock signal for the APB bus.
*   **PRESETn (Peripheral Reset):** Active low signal to reset APB slave devices.
*   **PADDR (Peripheral Address):** Carries address information for APB transactions.
*   **PSELn (Peripheral Select):** Active low signal for selecting specific APB slave devices.
*   **PEnable (Peripheral Enable):** Active high signal indicating the start and completion of an APB transaction.
*   **PWRITE (Peripheral Write):** Control signal determining read (low) or write (high) operation.
*   **PWDATA (Peripheral Write Data):** Carries data to be written to the APB slave.
*   **PRDATA (Peripheral Read Data):** Carries data read from the APB slave.
*   **PREADY (Peripheral Ready):** Active high signal indicating the APB slave's readiness for the next transaction.

### State Machine for AHB to APB Interface

The bridge utilizes a state machine with states such as:

*   **ST_IDLE:** PSEL and PENABLE lines are LOW, APB buses and PWRITE maintain recent values.
*   **ST_READ:** PADDR receives decoded address, pertinent PSEL line is HIGH, PWRITE is LOW.
*   **ST_WWAIT:** A wait state to allow the AHB side of the write transfer to finish, ensuring synchronization.
*   **ST_WRITE:** Address is decoded to PADDR, relevant PSEL is HIGH, and PWRITE is HIGH for write operations.

  <img width="1540" height="990" alt="image" src="https://github.com/user-attachments/assets/84464c2c-5a69-424a-9517-ebaecccbd191" />


## Software and Synthesis Tools

*   **HDL Used:** Verilog
*   **Simulator Tool Used:** ModelSIM
*   **Synthesis Tool Used:** Quartus Prime

## Authors

*   **Varun Ram S** (20BAC10038)
    *   Email Id: varun.ram2020@vitbhopal.ac.in
    *   College: Vellore Institute of Technology, Bhopal


## Report Submission Date

*   29 June 2023

---

This README provides a comprehensive overview of the AHB2APB Bridge project. 

