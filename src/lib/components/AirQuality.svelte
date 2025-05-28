<script lang="ts">
  import ExtraInfo from "./ExtraInfo.svelte";
  
  export let aqi: number = 0;

  let airQuality: string;

  switch(aqi) {
    case 1: 
      airQuality = "Good";
      break;
    case 2: 
      airQuality = "Fair";
      break;
    case 3: 
      airQuality = "Moderate";
      break;
    case 4: 
      airQuality = "Poor";
      break;
    case 5: 
      airQuality = "Very Poor";
      break;
    default: 
      airQuality = "ERROR";
  }
</script>

<ExtraInfo>
  <div class="air-quality">
    <p>Air Quality: {airQuality}</p>
  </div>
</ExtraInfo>