<script lang="ts">
  import DataBlock from '../templates/DataBlock.svelte'
  
  export let icon: string = 'undefined';
  export let iconAlt: string = 'undefined';
  export let title: string = 'undefined';
  export let unixTimeValue: number = 0;
  export let twelveHourTime: boolean = false;

  // Convert sunRise & sunSet from unix date time to a readable format
  const CONVERTED_TIME = new Date(unixTimeValue * 1000);

  let halfOfDay: string = 'AM';
  let hour: number = CONVERTED_TIME.getHours();
  if (twelveHourTime && hour > 12) {
    hour -= 12;
    halfOfDay = 'PM';
  }
  const MINUTE: number = CONVERTED_TIME.getMinutes();
  const TIME: string = `${hour}:${MINUTE}`;
</script>

<DataBlock icon={icon} iconAlt={iconAlt} title={title}>
  {TIME}

  {#if twelveHourTime}
    {halfOfDay}
  {/if}
</DataBlock>