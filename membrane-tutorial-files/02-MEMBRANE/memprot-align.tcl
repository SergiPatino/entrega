package require membrane
membrane -l POPC -x 80 -y 80 -o popc
set popc [atomselect top all]
set kcsamol [mol load psf ../01-BUILD/6xdc_autopsf.psf pdb ../01-BUILD/6xdc_autopsf.pdb]
set kcsa [atomselect $kcsamol all]
$popc moveby [vecinvert [measure center $popc weight mass]]
$popc writepdb popc_TEMP.pdb
set vest [atomselect $kcsamol "protein and (resid 45 to 65 or resid 69 to 77 or resid 79 to 92 or resid 94 or resid 96 or resid 101 to 128 or resid 139 or resid 142 or resid 206)"]
$kcsa moveby [vecinvert [measure center $vest weight mass]]
display resetview
$kcsa move [transaxis z -25]
$kcsa writepdb kcsa_TEMP.pdb
mol delete all
package require psfgen
resetpsf
readpsf popc.psf
coordpdb popc_TEMP.pdb
readpsf ../01-BUILD/6xdc_autopsf.psf
coordpdb kcsa_TEMP.pdb
writepsf kcsa_popc_raw.psf
writepdb kcsa_popc_raw.pdb
file delete kcsa_TEMP.pdb
file delete popc_TEMP.pdb
exit


