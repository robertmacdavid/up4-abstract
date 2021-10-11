# up4-abstract
This project provides a reference P4 implementation of the 
mobile core dataplane (the User Plane Function (UPF) in 5G and 
the SPGW-u in 4G/LTE) forwarding model and serves as a companion 
to the SOSR'21 paper 
"[A P4-based 5G User Plane Function](https://doi.org/10.1145/3482898.3483358)". 
The dataplane implements GTP encapsulation/decapsulation, usage accounting, mobility anchoring,
and Downlink Data Notifications (DDNs). It does not provide buffering for idle devices 
or QoS enforcement. This project does not intend to provide a fully-functional 
mobile dataplane, but it instead
provides clear documentation of a mobile dataplane in an unambiguous language. 
A fully functional 4G/5G mobile core is provided by the broader
[Aether 5G Connected Edge platform](https://opennetworking.org/aether/) from which
this project was extracted. The complete UP4 project within the Aether platform is
available open-source to Aether members and academic partners and is located
[here](https://github.com/omec-project/up4).

### Getting started
The available operations, including compilation and execution of the P4 program,
can be found in the [Makefile](./Makefile). Although the makefile includes
a step for downloading some prerequisites, it is expected that you will
have working installations of Python3.x and Docker beforehand.
#### Downloading Prerequisites
    make deps
#### Building the P4 Program
    make build
#### Running PTF Tests on the P4 Program
    make check
