<script lang="ts">
  export let icon: string = 'undefined';
  export let iconAlt: string = 'undefined';
  export let title: string = 'undefined';
</script>

<div class="data-block">
  <img src="{icon}" alt="{iconAlt}">

  <div class="right">
    <p>{title}</p>
    <p>
      <slot>
        <!-- Data -->
      </slot>
    </p>
  </div>
</div>

<style>
  .data-block {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
  }

  .right {
    text-align: center;
  }
</style>