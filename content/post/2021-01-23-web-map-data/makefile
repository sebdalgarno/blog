mapshape_simplify:
	mapshaper data/logged_yakoun.geojson \
		-dissolve2 fields=year \
		-simplify 1% keep-shapes \
		-o data/logged_simplify.json

tippecanoe_layer:
	tippecanoe -o data/logged-z9.mbtiles --coalesce-densest-as-needed data/logged_simplify.json --force	

sweet_sweet_data:
	make mapshape_simplify
	make tippecanoe_layer



