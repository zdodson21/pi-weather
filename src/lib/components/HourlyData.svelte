<script lang="ts">
  import type { Hourly } from "../types/Hourly";
  import Chart from 'chart.js/auto'
  import { onMount } from "svelte";

  export let hourlyData: Hourly = [];
  export let twelveHourTime: boolean = false;

  let chartData;
  let chartValues = [];
  let chartLabels = [];
  let ctx;
  let chartCanvas;

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
    chartValues.push(object.precipitation);
    if (twelveHourTime) {
      chartLabels.push(`${object.time} ${object.halfOfDay}`)
    } else {
      chartLabels.push(`${object.time}:00`);
    }
  });

  onMount(async (promise) => {
    ctx = chartCanvas.getContext('2d');
    let chart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: chartLabels,
          datasets: [{
              label: "Rain",
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