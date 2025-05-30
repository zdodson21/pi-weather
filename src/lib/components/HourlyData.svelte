<script lang="ts">
  import type { Hourly } from "../types/Hourly";
  import Chart from 'chart.js';

  export let hourlyData: Hourly = [];
  export let twelveHourTime: boolean = false;

  hourlyData.forEach(object => {
    // ! Time
    const CONVERTED_TIME: Date = new Date(object.time * 1000);

    object.time = CONVERTED_TIME.getHours();

    if (twelveHourTime) {
      if (object.time === 0) {
        object.time = 12;
      } else if (object.time === 12) {
        object.halfOfDay = 'PM';
      } else if (object.time > 12) {
        object.time -= 12;
        object.halfOfDay = 'PM';
      }
    }

    // ! Probability of Precipitation
    object.precipitation = object.precipitation * 100;
  });

  console.table(hourlyData);
</script>

<div class="hourly-data">

</div>