for i in videos/lc/*.avi videos/sc/*.avi videos/rc/*.avi; do
	python ./videoParserV3.py $i $i.frames -c 30;
	python ./frameSplitterV3.py $i.frames $i.frames.virtual ./calibration.2M.yml
	# avconv -i $i -f ffmetadata - | grep creation_time > $i.creationtime;
	# mkdir $i.frames;
	# avconv -i $i -ss 00:00:01 -vsync 1 -r 1 -an -y $i.frames/%08d.jpg
done

