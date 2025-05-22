# AXI4-Lite Protocol Interfaced with Memory

## 📝 Description

This project demonstrates the integration of the **AXI4-Lite (Advanced eXtensible Interface - Lite)** protocol with a simple memory module. AXI4-Lite is a lightweight subset of the AXI4 protocol, widely used in SoC architectures for control register access. This design illustrates how to use AXI4-Lite signals to perform read and write operations on a memory block, implemented in Verilog HDL.

## 🔧 Modules Description

### 1. `axi_lite_master.v`
- Initiates AXI4-Lite read/write transactions.
- Generates signals: `AWVALID`, `WVALID`, `ARVALID`, `BREADY`, `RREADY`, `AWADDR`, `WDATA`, etc.

### 2. `axi_lite_slave.v`
- Decodes AXI4-Lite transactions.
- Integrated with the memory block.
- Responds with `BRESP`, `BVALID`, `RDATA`, `RVALID`.

### 3. `top.v`
- Connects the AXI4-Lite master and slave.
- Top-level module to integrate all components.

### 4. `tb_top.v`
- Testbench to simulate AXI4-Lite read/write operations.
- Generates clock and reset.
- Monitors outputs and validates correct operation.

---

## 🧪 Testbench Features

- Simulates:
  - Write operation to a specific memory address.
  - Read operation from the same address.
  - Checks correctness of `RDATA` during read.
- Outputs observed using `$display` or waveform viewer.

---

## 📌 AXI4-Lite Protocol Summary

| Signal      | Direction | Description                                 |
|-------------|-----------|---------------------------------------------|
| `ACLK`      | Input     | Clock signal                                |
| `ARESETn`   | Input     | Active-low reset                            |
| `AWADDR`    | Input     | Write address                               |
| `AWVALID`   | Input     | Write address valid                         |
| `WVALID`    | Input     | Write data valid                            |
| `WDATA`     | Input     | Write data                                  |
| `BREADY`    | Input     | Master ready to accept write response       |
| `ARADDR`    | Input     | Read address                                |
| `ARVALID`   | Input     | Read address valid                          |
| `RREADY`    | Input     | Master ready to accept read data            |
| `AWREADY`   | Output    | Slave ready to accept write address         |
| `WREADY`    | Output    | Slave ready to accept write data            |
| `BRESP`     | Output    | Write response                              |
| `BVALID`    | Output    | Write response valid                        |
| `ARREADY`   | Output    | Slave ready to accept read address          |
| `RDATA`     | Output    | Read data                                   |
| `RRESP`     | Output    | Read response                               |
| `RVALID`    | Output    | Read data valid                             |

---

## ✅ Simulation Tool

- **ModelSim / QuestaSim / XSIM / Icarus Verilog**
- **Waveform Viewing:** GTKWave or simulator-integrated viewer

---

## 🚀 How to Run

1. Compile all Verilog RTL and testbench files.
2. Run the testbench (`tb_top.v`) simulation.
3. Observe AXI4-Lite transactions on the waveform or console.
4. Verify memory data integrity.

---

## 📚 Future Improvements

- Support multiple slaves with address decoding.
- Add timeout and error signaling (`SLVERR`).
- Extend to AXI4 full protocol with burst and ID support.
- Connect to real peripherals like UART, GPIO, Timers.

---

## 👨‍💻 Author

**Anikait Sarkar**  
RSA SEIP VLSI Trainee
