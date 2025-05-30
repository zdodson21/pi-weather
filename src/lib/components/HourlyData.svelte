<script lang="ts">
  import type { Hourly } from "../types/Hourly";
  import Chart from 'chart.js/auto'
  import { onMount } from "svelte";

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

  let chartData;
  let chartValues = [20, 10, 5, 2, 20, 30, 45];
  let chartLabels = ['January', 'February', 'March', 'April', 'May', 'June', 'July'];
  let ctx;
  let chartCanvas;

  onMount(async (promise) => {
      ctx = chartCanvas.getContext('2d');
      let chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: chartLabels,
            datasets: [{
                label: 'Revenue',
                backgroundColor: 'rgb(255, 99, 132)',
                borderColor: 'rgb(255, 99, 132)',
                data: chartValues
            }]
        }
    });
  });

  console.table(hourlyData);
</script>

<canvas bind:this={chartCanvas} id="myChart"></canvas>