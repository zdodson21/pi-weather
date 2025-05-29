<script lang="ts">
  import ExtraInfo from "./ExtraInfo.svelte";

  export let unixSunRise: number = 0;
  export let unixSunSet: number = 0;
  export let twelveHourTime: boolean = false;

  // Convert sunRise & sunSet from unix date time to a readable format
  const CONVERTED_SUN_RISE = new Date(unixSunRise * 1000);
  const CONVERTED_SUN_SET = new Date(unixSunSet * 1000);

  let riseHalfOfDay: string = 'AM';
  let sunRiseHour: number = CONVERTED_SUN_RISE.getHours();
  if (twelveHourTime && sunRiseHour > 12) {
    sunRiseHour -= 12;
    riseHalfOfDay = 'PM';
  }
  const SUN_RISE_MINUTE: number = CONVERTED_SUN_RISE.getMinutes();
  const SUN_RISE: string = `${sunRiseHour}:${SUN_RISE_MINUTE}`;

  let setHalfOfDay: string = 'AM';
  let sunSetHour: number = CONVERTED_SUN_SET.getHours();
  if (twelveHourTime && sunSetHour > 12) {
    sunSetHour -= 12;
    setHalfOfDay = 'PM';
  }
  const SUN_SET_MINUTE: number = CONVERTED_SUN_SET.getMinutes();
  const SUN_SET: string = `${sunSetHour}:${SUN_SET_MINUTE}`;
</script>

<ExtraInfo>
  <div class="sun-data">
    <div class="sun-rise">
      <p>
        Sun Rise: {SUN_RISE}
        {#if twelveHourTime}
          {riseHalfOfDay}
        {/if}
      </p>
    </div>

    <div class="sun-set">
      <p>
        Sun Set: {SUN_SET}
        {#if twelveHourTime}
          {setHalfOfDay}
        {/if}
      </p>
    </div>
  </div>
</ExtraInfo>
