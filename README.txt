Welcome to Enhanced Transportation Flow Open-source Microscopic Model (ETFOMM) project. 

ETFOMM inherits 40 years of FHWA development of traffic simulation algorithms and flow theories while overcoming CORSIM’s limitations in supporting research. 
 
This project includes ETFOMM Application Programming Interface (ETAPI) that provides communications between ETFOMM core simulation engine and user-developed applications (Apps) through ETRunner, a Windows console program.

Here are the folders included in this project:

DLL: this folder contains the Visual Studio 2012 solution files for ETFOMM.

ETAPI: this folder contains the Visual Studio 2012 solution files for ETAPI.
	APIClient: this folder contains the source code of a console client program.
	eTFOMM Web: this folder contains the source code of a web client program.
	etRunner64: this folder contains the source code of the console program that runs ETFOMM.
	include: this folder contains the head file shared by all programs in this solution.
	WCFServer: this folder contains the source code of the WCF Server used by etRunner and client programs.

ETRunner: this folder contains a stand-alone etRunner, the console program that runs ETFOMM from TRF file.
