function initAutocomplete() {
  const input = document.getElementById('address-input');
  const autocomplete = new google.maps.places.Autocomplete(input);

  autocomplete.setFields(['address_components']);  // Set to fetch only the address components

  autocomplete.addListener('place_changed', function() {
    const place = autocomplete.getPlace();
    let postalCode = '';

    // Loop through the address components to find the postal code
    for (const component of place.address_components) {
      const componentType = component.types[0];
      if (componentType === 'postal_code') {
        postalCode = component.long_name;
        break;
      }
    }

    // Set the hidden field value
    document.getElementById('zipcode-field').value = postalCode;
  });
}
