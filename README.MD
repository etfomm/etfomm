ETFOMM 2.2 Release Notes
New Global Systems, September 30, 2024

1. Acknowledgement and Credit

a) Christian Breau, Ehsan Amini, Samantha Taningco, Samuel Kerbo, Shen Dong, Fabio Sasahara, and other engineers and staff at the McTrans Center supported this phase of updates to the ETFOMM. Their contributions, including software development, quality control, and extensive software testing, were essential in ensuring the reliability and performance of the final product. We sincerely thank them for their hard work and dedication to this project.

b) Special thanks to Thomas Simmerman for his invaluable assistance in troubleshooting and debugging the ETFOMM component,  greatly improved its overall functionality.

c) Dr. Li Zhang of New Global Systems made the most substantial contributions to the codebase, apart from the ETFOMM debugs. His contributions included implementing key code changes, conducting thorough testing, and addressing critical bugs. Dr. Zhang devoted a significant amount of his personal time to this project as part of his ongoing commitment to community service.



2. Significantly improved TRAFVU file generations
a) Re-write the code to match the vehicle trajectory file and link file, correct buggies

b) Added code to prevent infinite loop on surface street processing

c) Fixed bugs in reading ETFOMM text file for TRAFVU when there is no accident in the simulation

d) Generate 32-bit ETFOMM to interface with TSIS, reprocess 64-bit text file, and generate TS0 file for TRAFVU

e) Add compiler directives to the processing CORSIM style lane configuration and detector matching, making ETFOMM64 actuated works   

f) Add compiler directives to generate 64 DLLs that write TRAFVU compatible text output.

g) Other fixes

3. ETFOMM Simulation logic bug fixes

a) Bugs in the Freeway deceleration lane, tested five deceleration lane

b) Bugs when vehicles emitted from the ramp to the surface street

c) Fully implemented record types 12 and 13 to specify up to 20 street lanes, tested up to five left and right turning lanes, variable lengths of turning lanes (limited by TRAVU)

d) Crashes when array out of bound on the freeway

e) Rewrite the  Erlang distribution to generate a realistic headway, correct bugs in 2.1 and earlier vision with vehicle emit headway

f) Fixed some maximum recall deficiencies. (see known Issues too)

g) Fixed an 8xxx node entry node bug that required an entry link to be through a movement node. The restriction is no longer there.

h) Other fixes

4. ETRunner

a) Streamlined it to call ETFOMM directly without the overhead of other programs. Those programs were disconnected:
* WCF interface (kind of upgraded version of RTE)
* DTALite
* BSM generations (another FHWA open source)
* SSAM (you can still run SSAM as post-processing of trajectory file)

b) correct bug to read files with long file names with spaces

c) Crushes caused by data definition inconsistency with ETFOMM

d) Merge ETRunner and ETFOMM visual studio projects into ETRunner solutions. Now you can build ETRunner and ETFOmm in one Visual Studio 2022. Easy to use Visual Studio debugs in two projects.

e) Other fixes

5. Know issues
a) The ETFOMM feature developed in 2.1 needs to be documented, and CORSIM style record types still need to be added. Those functions were created by the owner s private funding outside FHWA funding. Most, if not all, are related to transit and tram operations, signal priority, and preemption. Those parameters are input through a close loop and preoperatory software ETEditor.

b) Due to the nature of floating-point arithmetic, small negative values were observed in variables representing some MOEs where there is no or minimal traffic volume. These values likely result from rounding errors inherent in floating-point operations, where precision limitations can cause slight inaccuracies. To ensure consistency and avoid misinterpretation, any small negative values were subsequently reported as zero, reflecting their intended representations.

c) ETFORMM controller logic may not work in cases where the max recalls are used, in some cases



