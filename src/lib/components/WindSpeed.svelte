<script lang="ts">
  import DataBlock from '../templates/DataBlock.svelte';

  export let windSpeed: number = 0;
  export let units: string = "standard";

  let displayedUnits: string = 'm/s';
  if (units === 'imperial') displayedUnits = 'mph';

  // TODO get wind direction and make icons to render for wind direction
</script>

<DataBlock icon="./assets/icons/50d.png" iconAlt="wind icon" title="Wind Speed">
  {windSpeed} {displayedUnits}
</DataBlock>