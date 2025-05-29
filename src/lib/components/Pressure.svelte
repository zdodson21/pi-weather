<script lang='ts'>
  import DataBlock from '../templates/DataBlock.svelte';

  export let pressure: number = 0;
</script>

<DataBlock icon="./assets/icons/03d.png" iconAlt="pressure icon" title="Pressure">
  {pressure} hPa
</DataBlock>