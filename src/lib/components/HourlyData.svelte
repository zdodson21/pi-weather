<script lang="ts">
  import type { Hourly } from "../types/Hourly";
  import Chart from 'chart.js/auto'
  import { onMount } from "svelte";

  export let hourlyData: Hourly = [];
  export let twelveHourTime: boolean = false;

  let chartData;
  let popValues: Array<number> = [];
  let tempValues: Array<number> = [];
  let chartLabels: Array<string> = [];
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

      chartLabels.push(`${object.time} ${object.halfOfDay}`);
    } else {
      chartLabels.push(`${object.time}:00`);
    }

    // ! Probability of Precipitation
    object.precipitation = object.precipitation * 100;
    popValues.push(object.precipitation);

    // ! Temperature
    tempValues.push(Math.round(object.temp));
  });

  onMount(async (promise) => {
    ctx = chartCanvas.getContext('2d');
    let chart = new Chart(ctx, {
      data: {
        datasets: [
          {
            type: 'line',
            backgroundColor: '#ffcc63',
            borderColor: '#ffcc63',
            data: tempValues,
            yAxisID: 'temperature'
          },
          {
            type: 'bar',
            backgroundColor: '#00a1e7',
            data: popValues,
            yAxisID: 'precipitation'
          },
        ],
        labels: chartLabels,
      },
      options: {
        plugins: {
          legend: {
            display: false
          }
        },
        scales: {
          x: {
            grid: {
              display: false
            },
            border: {
              display: false
            }
          },
          precipitation: {
            type: 'linear',
            position: 'right',
            min: 0,
            max: 100,
            grid: {
              display: false
            },
            border: {
              display: false
            },
            ticks: {
              callback: function(value) {
                if (value === 0 || value === 100) {
                  return `${value}%`;
                }
                return '';
              }
            }
          },
          temperature: {
            type: 'linear',
            position: 'left',
            grid: {
              display: false
            },
            border: {
              display: false
            },
            ticks: {
              callback: function (value, index, values) {
                const MIN = 2 * Math.floor(Math.min(...tempValues) / 2);
                const MAX = 2 * Math.round(Math.max(...tempValues) / 2);
                if (value === MIN || value === MAX) {
                  return `${value}°`;
                }
                return '';
              }
            }
          }
        }
      }
    });
  });

  console.table(hourlyData);
</script>

<canvas bind:this={chartCanvas} id="myChart"></canvas>