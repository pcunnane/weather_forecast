function initAutocomplete() {
  const input = document.getElementById('address-input');
  const autocomplete = new google.maps.places.Autocomplete(input);

  autocomplete.setFields(['address_components']);  // Set to fetch only the address components

  autocomplete.addListener('place_changed', function() {
    const place = autocomplete.getPlace();
    let zipcode = '';
    let stateName = '';
    let cityName = '';

    // Loop through the address components to set city, state and zipcode
    for (const component of place.address_components) {
      const componentType = component.types[0];

      switch (componentType) {
        case 'postal_code':
          zipcode = component.long_name;
          break;
        case 'administrative_area_level_1':
          stateName = component.short_name;
          break;
        case 'locality':
          cityName = component.long_name;
          break;
      }
    }

    // Set the hidden field values
    document.getElementById('zipcode-field').value = zipcode;
    document.getElementById('city-field').value = cityName;
    document.getElementById('state-field').value = stateName;

    // Enable the submit button
    document.getElementById('submit-button').disabled = false;
  });
}
