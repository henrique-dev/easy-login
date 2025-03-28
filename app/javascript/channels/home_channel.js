import consumer from "channels/consumer";

consumer.subscriptions.create("HomeChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    try {
      const location = data.location;

      const locationInfoDiv = document.getElementById("location_info");
      locationInfoDiv.classList =
        "d-flex flex-column align-items-center gap-2 p-2";
      locationInfoDiv.textContent = "";

      const infoSpan = document.createElement("span");
      infoSpan.textContent = "You are in:";

      const citySpan = document.createElement("span");
      citySpan.textContent = location.city;
      citySpan.classList = "fs-3";

      console.log(`https://flagcdn.com/48x36/${location.country}.png`);

      const countryImg = document.createElement("img");
      countryImg.src = `https://flagcdn.com/48x36/${location.country.toLowerCase()}.png`;

      const regionSpan = document.createElement("span");
      regionSpan.textContent = location.region;
      regionSpan.classList = "fs-5";

      locationInfoDiv.appendChild(infoSpan);
      locationInfoDiv.appendChild(citySpan);
      locationInfoDiv.appendChild(countryImg);
      locationInfoDiv.appendChild(regionSpan);
    } catch (error) {
      console.warn("cannot retrieve the location");
      console.warn(error);
    }
  },
});
