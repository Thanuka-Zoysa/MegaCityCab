<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ page import="Model.Customer,DAO.CustomerDAO,Controller.LoginServlet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Calculate Journey</title>
    <link rel="stylesheet" href="CSS/journey.css">
</head>
<body>
    <div class="container">
        <header>
            <h2>Calculate Your Journey Distance</h2>
        </header>

        <section class="form-section">
            <form id="journey-form">
                <label for="pickup-location">Pickup Location:</label>
                <input type="text" id="pickup-location" name="pickup-location" placeholder="Enter Pickup Location" required>
                
                <label for="dropoff-location">Drop-off Location:</label>
                <input type="text" id="dropoff-location" name="dropoff-location" placeholder="Enter Drop-off Location" required>
            </form>
            <div id="distance-result"></div>
        </section>

        <section class="map-section">
            <div id="map"></div>
        </section>

        <!-- The Next button is initially hidden -->
        <button id="next-btn" style="display:none;" onclick="redirectToNextPage()">Next</button>
    </div>

    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD6R7FD0YvwvyBf6rWv8yfHzgBVvtqzJpc&libraries=places&callback=initMap" defer></script>
    
    <script>
        let map, directionsService, directionsRenderer;
        let pickupLocation, dropoffLocation;
        let marker1, marker2;
        let selectedPickup = false;
        let selectedDropoff = false;
        
        // Retrieve the parameters from the request
        let carId = <%= request.getParameter("carId") != null ? request.getParameter("carId") : 0 %>;
        let carModel = "<%= request.getParameter("carModel") != null ? request.getParameter("carModel") : "" %>"; // Get car model
        let fee = <%= request.getParameter("fee") != null ? request.getParameter("fee") : 0 %>;
        let customerId = <%= request.getParameter("customerId") != null ? request.getParameter("customerId") : 0 %>; // Retrieve customer ID
        let distance = ''; // Store calculated distance

        // Initialize the map
        function initMap() {
            map = new google.maps.Map(document.getElementById("map"), {
                zoom: 7,
                center: { lat: 7.8731, lng: 80.7718 }, // Coordinates of Sri Lanka's approximate center
            });

            directionsService = new google.maps.DirectionsService();
            directionsRenderer = new google.maps.DirectionsRenderer({
                map: map,
                preserveViewport: true,  // Keep the viewport the same when route is displayed
            });

            const geocoder = new google.maps.Geocoder();
            const sriLankaBounds = new google.maps.LatLngBounds(
                new google.maps.LatLng(5.9, 79.9),
                new google.maps.LatLng(9.9, 82.0)
            );

            const pickupInput = document.getElementById("pickup-location");
            const dropoffInput = document.getElementById("dropoff-location");

            const pickupAutocomplete = new google.maps.places.Autocomplete(pickupInput, {
                bounds: sriLankaBounds,
                componentRestrictions: { country: "LK" }
            });

            const dropoffAutocomplete = new google.maps.places.Autocomplete(dropoffInput, {
                bounds: sriLankaBounds,
                componentRestrictions: { country: "LK" }
            });

            pickupAutocomplete.addListener("place_changed", function () {
                const place = pickupAutocomplete.getPlace();
                if (place.geometry) {
                    pickupLocation = place.geometry.location;
                    if (!selectedPickup) {
                        placeMarker(pickupLocation, "pickup");
                        selectedPickup = true;
                        if (selectedDropoff) {
                            calculateRoute();  // Calculate the route if both locations are selected
                        }
                    }
                }
            });

            dropoffAutocomplete.addListener("place_changed", function () {
                const place = dropoffAutocomplete.getPlace();
                if (place.geometry) {
                    dropoffLocation = place.geometry.location;
                    if (!selectedDropoff) {
                        placeMarker(dropoffLocation, "dropoff");
                        selectedDropoff = true;
                        if (selectedPickup) {
                            calculateRoute();  // Calculate the route if both locations are selected
                        }
                    }
                }
            });

            map.addListener("click", function (e) {
                const clickedLocation = e.latLng;
                geocoder.geocode({ location: clickedLocation }, function (results, status) {
                    if (status === "OK" && results[0]) {
                        if (!selectedPickup) {
                            document.getElementById("pickup-location").value = results[0].formatted_address;
                            pickupLocation = clickedLocation;
                            placeMarker(pickupLocation, "pickup");
                            selectedPickup = true;
                        } else if (!selectedDropoff) {
                            document.getElementById("dropoff-location").value = results[0].formatted_address;
                            dropoffLocation = clickedLocation;
                            placeMarker(dropoffLocation, "dropoff");
                            selectedDropoff = true;
                        }

                        // Calculate the route once both locations are selected
                        if (selectedPickup && selectedDropoff) {
                            calculateRoute();
                        }
                    }
                });
            });
        }

        function placeMarker(location, type) {
            const marker = new google.maps.Marker({
                position: location,
                map: map,
                title: type === "pickup" ? "Pickup Location" : "Dropoff Location"
            });

            if (type === "pickup") {
                marker1 = marker;
            } else {
                marker2 = marker;
            }

            // Fit the map to the bounds of the markers
            if (marker1 && marker2) {
                const bounds = new google.maps.LatLngBounds();
                bounds.extend(marker1.getPosition());
                bounds.extend(marker2.getPosition());
                map.fitBounds(bounds);
            }
        }

        function calculateRoute() {
            const request = {
                origin: pickupLocation,
                destination: dropoffLocation,
                travelMode: 'DRIVING'
            };

            directionsService.route(request, function (result, status) {
                if (status === 'OK') {
                    directionsRenderer.setDirections(result);
                    distance = result.routes[0].legs[0].distance.text;
                    document.getElementById("distance-result").innerHTML = "Distance: " + distance;

                    // Enable the next button after distance is calculated
                    document.getElementById("next-btn").style.display = "block";
                } else {
                    document.getElementById("distance-result").innerHTML = "Unable to calculate the route.";
                }
            });
        }

        // Redirect to the next page when the Next button is clicked
        function redirectToNextPage() {
            if (customerId && carId && distance) {
                window.location.href = "admin_BookingConfirmation.jsp?carId=" + carId + "&carModel=" + encodeURIComponent(carModel) + "&customerId=" + customerId + "&distance=" + distance + "&fee=" + fee;
            } else {
                alert("Please make sure all fields are filled out correctly.");
            }
        }
    </script>
</body>
</html>
