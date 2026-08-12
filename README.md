# Neuromorphic Wake-on Event

A **neuromorphic-inspired event detection system** designed using **Verilog HDL** and verified through simulation.

##  What is Neuromorphic Computing?

**Neuromorphic computing** is a computing approach inspired by the way the **human brain processes information**. Instead of continuously processing every input value, neuromorphic systems can represent important changes in information as short **spikes or events**.

This event-based approach can reduce unnecessary processing and can be useful for **low-power, real-time sensing and intelligent edge devices**.

##  Project Overview

This project implements a **Neuromorphic Wake-on Event system** that detects significant changes in incoming sensor/data signals and generates a **wake/event signal** when an abnormal or meaningful pattern is detected.

The design uses a spike-based processing approach where changes in the input are converted into events and processed by digital neuron-inspired logic.

The complete design was developed using **Verilog HDL** and its functionality was verified through **RTL simulation**.

##  How the Project Works

The system follows an event-based processing flow:

**Input Signal → Change/Spike Detection → Neuron Processing → Pattern/Anomaly Detection → Wake Signal**

### 1. Input

The system receives a digital input signal representing the data being monitored.

### 2. Spike Encoding

The incoming data is analyzed for significant changes. When a sufficient change is detected, it is represented as a **spike/event**.

### 3. Neuron Processing

The generated spikes are processed using neuron-inspired digital logic. The neuron accumulates the incoming events and responds when the required activity level is reached.

### 4. Event / Pattern Detection

The processed spike activity is evaluated to identify a meaningful or abnormal pattern.

### 5. Wake Signal

When the required event or pattern is detected, the system generates a **wake-on event signal**, indicating that further processing or system activity can be triggered.

##  Tools & Technologies

* Verilog HDL
* RTL Design
* ModelSim / Vivado Simulator
* Digital Spike Encoding
* Neuron-inspired Processing
* Event-based Detection
* Finite State / Sequential Logic

## Project Files

* neuromorphic_wakeon.v – Main Verilog design
* neuromorphic_wakeon_tb.v – Verilog testbench
* neuromrophic_wakeon_simulation.png-Simualation waveform 

##  Simulation

The complete design was verified through RTL simulation.

The simulation was used to verify:

* Input signal processing
* Spike/event generation
* Neuron response
* Pattern detection
* Wake signal generation
* Reset and sequential operation

##  Expected Output

When the input does not contain a significant event, the system remains in its normal monitoring state.

When the required pattern or abnormal event is detected:

**Input Change → Spike → Neuron Response → Pattern Match → Wake = 1**

The simulation waveform is used to verify the complete event-detection sequence.

##  Key Features

* Brain-inspired event-based processing
* Spike-based input representation
* Digital neuron-inspired processing
* Pattern/anomaly detection
* Wake-on-event output
* RTL simulation and functional verification

##  Author

**Voo Upasana**

