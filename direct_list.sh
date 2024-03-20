rm -f direct.txt

cordprefix='cord1'
for rows in `cat formula_list.txt`
do
material=`echo $rows | sed 's/[^0-9a-Z]//g'`
if [ -d $material ]; then
cd ./$material/$cordprefix
for cordf in `ls`
do
    if [ -d $cordf ]; then
            cd ./$cordf/band
            gaptype=`grep Character BAND_GAP | awk '{print $3}'`
            if [ $gaptype == 'Direct' ]; then
                    cd ../../
		    break
            else
                    cd ../..
            fi
    fi
done
cd ../..
mv $material Direct_dir
fi
done

