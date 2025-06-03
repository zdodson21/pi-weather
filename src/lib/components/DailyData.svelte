<script lang="ts">
  import DailyBlock from '../templates/DailyBlock.svelte';
  import type { Daily } from '../types/Daily'

  export let dailyData: Daily = [];
  export let icon: string = '01d';
  export let monthDay: boolean = false; // 'month day' instead of 'day month' (ex: May 1 instead of 1 May)
  let iconAlt: string = 'alt text';

  dailyData.forEach(object => {
    // ! Time
    const CONVERTED_TIME: Date = new Date(object.time * 1000);

    object.time = CONVERTED_TIME.getDay();
    
    switch (object.time) {
      case 0:
        object.time = 'Sun.';
        break;
      case 1:
        object.time = 'Mon.';
        break;
      case 2:
        object.time = 'Tues.';
        break;
      case 3:
        object.time = 'Wed.';
        break;
      case 4:
        object.time = 'Thurs.';
        break;
      case 5:
        object.time = 'Fri.';
        break;
      case 6:
        object.time = 'Sat.';
        break;
      default:
        object.time = 'error';
    }

    let month: string;
    switch(CONVERTED_TIME.getMonth()) {
      case 0:
        month = 'Jan.'
        break;
      case 1:
        month = 'Feb.'
        break;
      case 2:
        month = 'Mar.'
        break;
      case 3:
        month = 'Apr.'
        break;
      case 4:
        month = 'May'
        break;
      case 5:
        month = 'June'
        break;
      case 6:
        month = 'July'
        break;
      case 7:
        month = 'Aug.'
        break;
      case 8:
        month = 'Sept.'
        break;
      case 9:
        month = 'Oct.'
        break;
      case 10:
        month = 'Nov.'
        break;
      case 11:
        month = 'Dec.'
        break;
      default:
        month = 'error'
    }

    if (monthDay) {
      object.time = `${object.time} (${month} ${CONVERTED_TIME.getDate()})`;
    } else {
      object.time = `${object.time} (${CONVERTED_TIME.getDate()} ${month})`;
    }

    // Temperature
    object.lowTemp = Number(object.lowTemp).toFixed(0);
    object.highTemp = Number(object.highTemp).toFixed(0);

    // ! Weather Icon
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

    // ! Precipitation
    object.precipitation = Number(object.precipitation * 100).toFixed(0);
  });
</script>

<div class="daily-data">
  {#each dailyData as object}
    <DailyBlock 
      time={object.time} 
      icon={object.weather}
      iconAlt={iconAlt}
      precipitation={object.precipitation}
      lowTemp={object.lowTemp}
      highTemp={object.highTemp}
    />
  {/each}
</div>

<style>
  .daily-data {
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    height: auto;
  }
</style>