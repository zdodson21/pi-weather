<script lang="ts">
  export let temp: number = 0;
  export let icon: string = '01d';
  export let tempUnits: string = 'standard';
  let iconAlt: string = 'Alt Text';

  switch (icon) {
    case '01d':
      iconAlt = 'day time clear sky icon';
      break;
    case '02d':
      iconAlt = 'day time few clouds icon';
      break;
    case '03d':
      iconAlt = 'day time scattered clouds icon';
      break;
    case '04d':
      iconAlt = 'day time break clouds icon';
      break;
    case '09d':
      iconAlt = 'day time shower rain icon';
      break;
    case '10d':
      iconAlt = 'day time rain icon';
      break;
    case '11d':
      iconAlt = 'day time thunderstorm icon';
      break;
    case '13d': 
      iconAlt = 'day time snow icon';
      break;
    case '50d':
      iconAlt = 'day time mist icon';
      break;
    case '01n':
      iconAlt = 'night time clear sky icon';
      break;
    case '02n':
      iconAlt = 'night time few clouds icon';
      break;
    case '03n':
      iconAlt = 'night time scattered clouds icon';
      break;
    case '04n':
      iconAlt = 'night time break clouds icon';
      break;
    case '09n':
      iconAlt = 'night time shower rain icon';
      break;
    case '10n':
      iconAlt = 'night time rain icon';
      break;
    case '11n':
      iconAlt = 'night time thunderstorm icon';
      break;
    case '13n': 
      iconAlt = 'night time snow icon';
      break;
    case '50n':
      iconAlt = 'night time mist icon';
      break;
    default:
      iconAlt = 'No icon';
  }

  let unit: string;
  switch (tempUnits) {
    case 'standard':
      unit = 'K';
      break;
    case 'metric':
      unit = 'C';
      break;
    case 'imperial':
      unit = 'F';
      break;
    default:
      unit = 'K';
  }
</script>

<div class="weather">
  <div class="top">
    <div class="left">
      <img src="./assets/icons/{icon}.png" alt="{iconAlt}">
    </div>
  
    <div class="right">
      <p>{temp}&#176; {unit}</p>
    </div>
  </div>

  <div class="bottom">
    <slot>
      <!-- Description -->
    </slot>
  </div>
</div>

<style>
  .top {
    display: flex;
    flex-direction: row;
    align-items: center;
  }

  .bottom {
    text-align: center;
  }
</style>