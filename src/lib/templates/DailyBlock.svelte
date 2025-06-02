<script lang="ts">
  export let time: string;
  export let lowTemp: number;
  export let highTemp: number;
  export let icon: string;
  export let iconAlt: string;
  export let precipitation: number;
</script>

<div class="daily-block">
  <p>{time}</p>
  <img src="./assets/icons/{icon}.png" alt="{iconAlt}">
  <p>{precipitation}%</p>
  <p>{highTemp}° | {lowTemp}°</p>
</div>

<style>
  .daily-block {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    border: 1px solid black;
    border-radius: 12px;
    padding: 4px;
    width: 15%;
  }
</style>