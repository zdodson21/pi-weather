<script lang="ts">
  import CurrentWeather from './lib/CurrentWeather.svelte';
  
  let callFailCounter: number = 0;
  const CALL_INTERVAL: number = 600000;

  try {
    // TODO fetch weather from API
    // Set values based on returned values from API

    callFailCounter = 0;
  } catch {
    callFailCounter++;
  }

  if (callFailCounter === 6) {
    console.error(`callFailCounter has reached ${callFailCounter} failed calls (calls occur every ${CALL_INTERVAL} milliseconds)`)
  } 
  // set values from fetched information
</script>

<main>
  <CurrentWeather forecast={"Sunny"} temp={72}/>
</main>

<style>
  
</style>
