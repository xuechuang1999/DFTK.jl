#!/bin/bash
cd "$(dirname "$0")"
PREFIX="silicon_NLCC"
PSEUDO="Si.upf"
PSEUDO_FAMILY="pd_nc_sr_lda_standard_0.4.1_upf"
URL="https://raw.githubusercontent.com/JuliaMolSim/PseudoLibrary/1bb181334e7298202ceebb4c82e285a9a07ee58f/pseudos/$PSEUDO_FAMILY/$PSEUDO"

if [ ! -f $PSEUDO ]; then
    echo "Downloading pseudopotentials";
    wget $URL
fi

if [ ! -f $PSEUDO ]; then
    echo "Pseudopotential download failed!";
    exit 1
fi

rm -rf ${PREFIX}.out ${PREFIX}.save/ CRASH __ABI_MPIABORTFILE__
mpirun -np 4 pw.x -in ${PREFIX}.in &> ${PREFIX}.out

FILES=(
    ${PREFIX}.save/
    CRASH
    __ABI_MPIABORTFILE__
)
rm -rf ${FILES[@]}
