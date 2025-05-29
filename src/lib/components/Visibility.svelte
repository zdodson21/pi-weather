<script lang="ts">
  import DataBlock from '../templates/DataBlock.svelte';

  export let visibility: number = 0;

  visibility = Number(visibility * 0.001).toFixed(2);
  console.log(visibility)
  
  let symbol: string;

  if (visibility == 10.00) {
    symbol = '>';
  } else {
    symbol = '~';
  }
</script>

<DataBlock icon="./assets/icons/50n.png" iconAlt="visibility icon" title="Visibility">
  {symbol} {visibility} km
</DataBlock>