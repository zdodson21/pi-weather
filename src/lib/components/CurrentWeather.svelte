<script lang="ts">
  export let temp: number = 0;
  export let icon: string = '01d';

  let altText = 'Alt Text'
  switch (icon) {
    case '01d':
      altText = 'day time clear sky icon';
      break;
    case '02d':
      altText = 'day time few clouds icon';
      break;
    case '03d':
      altText = 'day time scattered clouds icon';
      break;
    case '04d':
      altText = 'day time break clouds icon';
      break;
    case '09d':
      altText = 'day time shower rain icon';
      break;
    case '10d':
      altText = 'day time rain icon';
      break;
    case '11d':
      altText = 'day time thunderstorm icon';
      break;
    case '13d': 
      altText = 'day time snow icon';
      break;
    case '50d':
      altText = 'day time mist icon';
      break;
    case '01n':
      altText = 'night time clear sky icon';
      break;
    case '02n':
      altText = 'night time few clouds icon';
      break;
    case '03n':
      altText = 'night time scattered clouds icon';
      break;
    case '04n':
      altText = 'night time break clouds icon';
      break;
    case '09n':
      altText = 'night time shower rain icon';
      break;
    case '10n':
      altText = 'night time rain icon';
      break;
    case '11n':
      altText = 'night time thunderstorm icon';
      break;
    case '13n': 
      altText = 'night time snow icon';
      break;
    case '50n':
      altText = 'night time mist icon';
      break;
    default:
      altText = 'No icon';
  }
</script>

<div class="weather">
  <div class="left">
    <img src="./assets/icons/{icon}.png" alt="{altText}">
  </div>

  <div class="right">
    <p>Temperature: {temp}</p>
  </div>

  <div class="bottom">
    <slot>
      <!-- Description -->
    </slot>
  </div>
</div>