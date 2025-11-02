**Generic PWM Generator (Verilog)**

**Author:** Rosnnel Moncada 

**Licence:** [CERN Open Hardware Licence Version S (CERN-OHL-S)](LICENSE)

---
The GenericPWM module was designed as a reusable, fully customizable, and parameterized RTL block capable of generating stable PWM signals with precise duty cycle control.
Its flexibility allows seamless adaptation to a wide range of digital control and modulation applications.

The top module is capable to generate **NPWM** modules, each one generating a in phase signal. It also allows to use external selectors called **FreqSel** for quick frequency changes, in this case allowing to 
choose between the **PWMFreq**, two times the **PWMFreq** and  two constant values of 1KHz and 5KHz. The module also allows to choose a **Resolution** value that controls how many bits are going to be used to control the DutyCycle
it is needed to note that the higher the resolution used, the lower PWM frequency signal that can be controlled (It is possible to increase the output max PWM frequency by increasing the **system clock**). 
The DutyCycle inputs as long as the PWMOut outputs are packaged into unified input and output buses using the indexed part-select operator, meaning that for 5 PWM with 8bit resolution there will be an DC input 
of 40bits, and there will be an output bus of 5 bits for each PWM Output signal.

The architecture is divided into three main submodules (one of them was described directly in the TOP module): 

-Flag Generator: Produces a synchronization flag each time the internal counter reaches the end of a PWM period. This flag defines the timing reference for duty cycle updates and frequency control.

-Counter: counts each time the flag is generated, the max count is determined by the resolution.

-Comparator: recreates the PWM signal comparing the actual Count value with the desired duty cycle value.

Next is shown the proposed diagram of the module with the different descriptions of each parameter mentioned: 

<img width="919" height="807" alt="PWM Module" src="https://github.com/user-attachments/assets/c767ccd7-a4b6-4371-ae7c-d503981f1eab" />

The resulting RTL will depend on the different configuration of the parameters, next will be shown some RTL produced based on example parameters.

The first RTL to be generated is the case with 1 NPWM and 4-bit resolution:
<img width="1461" height="363" alt="image" src="https://github.com/user-attachments/assets/23ebfd81-ed62-498d-ae4a-c240f8019d3c" />

The next RTL will be the case of 5PWM with 8-bit resolution:
<img width="1156" height="714" alt="image" src="https://github.com/user-attachments/assets/1925641d-e1b0-4750-b28c-52a931619c58" />

There is a TestBench file included in the project that test the case when there is 5PWM and 8bit resolution, it used teh FreqSel to set the 5KHz PWM example. It sets different PWM duty cycles to be observed in the simulation waveform file. 
The simulation is shown bellow:
<img width="1150" height="395" alt="image" src="https://github.com/user-attachments/assets/2815b291-e143-42b9-9675-c58bc57c155e" />

from the tesbench it is possible to see that the generated period of the PWM is 202.24us, meaning that we have a theoretical output frequency of 4.95KHz!!!.
