Welcome to Enhanced Transportation Flow Open-source Microscopic Model (ETFOMM) project. 

ETFOMM inherits 40 years of FHWA development of traffic simulation algorithms and flow theories while overcoming CORSIM’s limitations in supporting research. For more detail functions about ETFOMM, please refer to https://www.fhwa.dot.gov/publications/research/operations/17028/17028.pdf. For tutoring and technical support, please visit ETFOMM.org or email ngsim@ngsim.com

This project also includes ETFOMM Application Programming Interface (ETAPI) that provides communications between ETFOMM core simulation engine and user-developed applications (Apps) through ETRunner, a Windows console program.

Here are the folders included in this project:

ETFOMM (DLL): this folder contains the Visual Studio 2012 solution files for ETFOMM or you can use this folder to have all source code files to compile ETRunner executable and ETFOMM.DLL

ETRunner: The command line excutable program to start ETFOMM (DLL) simulation.

ETAPI: this folder contains the Visual Studio 2012 solution files for ETAPI.
	APIClient: this folder contains the source code of a console client program.
	eTFOMM Web: this folder contains the source code of a web client program.
	etRunner64: this folder contains the source code of the console program that runs ETFOMM.
	include: this folder contains the head file shared by all programs in this solution.
	WCFServer: this folder contains the source code of the WCF Server used by etRunner and client programs.

Documentations: this folder contains documents of ETFOMM project.

