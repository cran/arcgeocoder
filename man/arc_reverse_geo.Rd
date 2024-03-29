% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/arc_reverse_geo.R
\name{arc_reverse_geo}
\alias{arc_reverse_geo}
\title{Reverse Geocoding using the ArcGIS REST API}
\usage{
arc_reverse_geo(
  x,
  y,
  address = "address",
  full_results = FALSE,
  return_coords = TRUE,
  verbose = FALSE,
  progressbar = TRUE,
  outsr = NULL,
  langcode = NULL,
  featuretypes = NULL,
  locationtype = NULL,
  custom_query = list()
)
}
\arguments{
\item{x}{longitude values in numeric format. Must be in the range
\eqn{\left[-180, 180 \right]}.}

\item{y}{latitude values in numeric format. Must be in the range
\eqn{\left[-90, 90 \right]}.}

\item{address}{address column name in the output data (default  \code{"address"}).}

\item{full_results}{returns all available data from the API service. If
\code{FALSE} (default) only latitude, longitude and address columns are
returned.}

\item{return_coords}{return input coordinates with results if \code{TRUE}.}

\item{verbose}{if \code{TRUE} then detailed logs are output to the console.}

\item{progressbar}{Logical. If \code{TRUE} displays a progress bar to indicate
the progress of the function.}

\item{outsr}{The spatial reference of the \verb{x,y} coordinates returned by a
geocode request. By default is \code{NULL} (i.e. the parameter won't be used in
the query). See \strong{Details} and \link{arc_spatial_references}.}

\item{langcode}{Sets the language in which reverse-geocoded addresses are
returned.}

\item{featuretypes}{This parameter limits the possible match types returned.
By default is \code{NULL} (i.e. the parameter won't be used in the query).
See \strong{Details}.}

\item{locationtype}{Specifies whether the output geometry of
\code{featuretypes = "PointAddress"} or \code{featuretypes = "Subaddress"} matches
should be the rooftop point or street entrance location. Valid values are
\code{NULL} (i.e. not using the parameter in the query), \code{rooftop} and \code{street}.}

\item{custom_query}{API-specific parameters to be used, passed as a named
list.}
}
\value{
A \code{\link[tibble:tibble]{tibble}} with the corresponding results. The \verb{x,y} values
returned by the API would be named \verb{lon,lat}. Note that these coordinates
correspond to the geocoded feature, and may be different of the \verb{x,y} values
provided as inputs.

See the details of the output in
\href{https://developers.arcgis.com/rest/geocode/api-reference/geocoding-service-output.htm}{ArcGIS REST API Service output}.
}
\description{
Generates an address from a latitude and longitude. Latitudes must be
in the range \eqn{\left[-90, 90 \right]} and longitudes in the range
\eqn{\left[-180, 180 \right]}. This function returns the
\code{\link[tibble:tibble]{tibble}} associated with the query.
}
\details{
More info and valid values in the \href{https://developers.arcgis.com/rest/geocode/api-reference/geocoding-reverse-geocode.htm}{ArcGIS REST docs}.
}
\section{\code{outsr}}{
The spatial reference can be specified as either a well-known ID (WKID). If
not specified, the spatial reference of the output locations is the same as
that of the service ( WGS84, i.e. WKID = 4326)).

See \link{arc_spatial_references} for values and examples.
}

\section{\code{featuretypes}}{
See \code{vignette("featuretypes", package = "arcgeocoder")} for a detailed
explanation of this parameter.

This parameter may be used for filtering the type of feature to be returned
when geocoding. Possible values are:
\itemize{
\item \code{"StreetInt"}
\item \code{"DistanceMarker"}
\item \code{"StreetAddress"}
\item \code{"StreetName"}
\item \code{"POI"}
\item \code{"Subaddress"}
\item \code{"PointAddress"}
\item \code{"Postal"}
\item \code{"Locality"}
}

It is also possible to use several values as a vector
(\code{featuretypes = c("PointAddress", "StreetAddress")}).
}

\examples{
\dontshow{if (arcgeocoder_check_access()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
\donttest{

arc_reverse_geo(x = -73.98586, y = 40.75728)

# Several coordinates
arc_reverse_geo(x = c(-73.98586, -3.188375), y = c(40.75728, 55.95335))

# With options: using some additional parameters
sev <- arc_reverse_geo(
  x = c(-73.98586, -3.188375),
  y = c(40.75728, 55.95335),
  # Restrict to these feautures
  featuretypes = "POI,StreetInt",
  # Result on this WKID
  outsr = 102100,
  verbose = TRUE, full_results = TRUE
)

dplyr::glimpse(sev)
}
\dontshow{\}) # examplesIf}
}
\references{
\href{https://developers.arcgis.com/rest/geocode/api-reference/geocoding-reverse-geocode.htm}{ArcGIS REST \code{reverseGeocode}}.
}
\seealso{
\code{\link[tidygeocoder:reverse_geo]{tidygeocoder::reverse_geo()}}

Other functions for geocoding: 
\code{\link{arc_geo}()},
\code{\link{arc_geo_categories}()},
\code{\link{arc_geo_multi}()}
}
\concept{geocoding}
