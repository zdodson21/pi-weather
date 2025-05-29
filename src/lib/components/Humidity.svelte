<script lang="ts">
  import DataBlock from '../templates/DataBlock.svelte';

  export let humidity: number = 0;
</script>

<DataBlock icon="./assets/icons/50d.png" iconAlt="humidity icon" title="Humidity">
  {humidity}%
</DataBlock>