#!/bin/bash

logo='broadcom.svg'
products=('CA IDMS' 'CA Endevor®' 'CA JCLCheck™ Workload Automation' 'CA View®' 'CA OPS/MVS®' 'CA z/OS Extended Jobs' 'CA z/OS Extended Files' 'CA MAT Detect' 'CA MAT Analyze' 'CA SYSVIEW® Performance Management' 'CA Endevor® Bridge For Git' 'CA Secure Credential Store' 'CA File Master™ Plus')

for i in ${!products[@]};
do
  product=${products[$i]}
  filename="$(tr [A-Z] [a-z] <<< "$product")"
  filename="${filename// /-}"
  filename="${filename//\//}"
  filename="${filename//®/}"
  filename="${filename//™/}.svg"
  texttoadd="<text x=\"50%\" y=\"50\" style=\"font: 11px sans-serif;alignment-baseline: middle; text-anchor:middle;\">${product}</text></svg>"
  echo "Creating ${filename} for ${product}"
  cp $logo $filename
  sed -i'.original' 's/height="33"/height="70"/g' $filename
  sed -i'.original' "s|</svg>|${texttoadd}|g" $filename
  inkscape $filename --export-text-to-path --export-plain-svg --export-filename=$filename
done