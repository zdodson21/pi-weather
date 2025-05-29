<script lang="ts">
  export let icon: string = 'Undefined';
  export let iconAlt: string = 'Undefined';
</script>

<div class="data-display">
  <img src="{icon}" alt="{iconAlt}">
  <slot></slot>
</div>