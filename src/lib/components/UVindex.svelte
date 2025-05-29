<script lang="ts">
  import DataBlock from '../templates/DataBlock.svelte';

  export let uvi: number = 0.00;
</script>

<DataBlock icon="./assets/icons/01d.png" iconAlt="ultra violet index icon" title="UV Index">
  {uvi}
</DataBlock>