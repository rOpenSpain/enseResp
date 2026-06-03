# regional_map

Polygon coordinates for Spanish autonomous communities (CCAA), suitable
for choropleth mapping.

## Usage

``` r
regional_map
```

## Format

A data frame with 40111 rows and 11 variables:

- `long`:

  longitude of polygon vertex

- `lat`:

  latitude of polygon vertex

- `order`:

  vertex order within the polygon

- `hole`:

  logical; TRUE if the polygon is a hole

- `piece`:

  polygon piece identifier

- `group`:

  group identifier for the polygon

- `id`:

  region identifier

- `ccaa`:

  name of the autonomous community

- `id_ense`:

  ENSE region code matching the CCAA column in survey datasets

- `lat_c`:

  latitude of the region centroid

- `long_c`:

  longitude of the region centroid
