<script lang="ts">
  import AirQuality from './lib/components/AirQuality.svelte';
  import CurrentWeather from './lib/components/CurrentWeather.svelte';
  import DailyData from './lib/components/DailyData.svelte';
  import HourlyData from './lib/components/HourlyData.svelte';
  import Humidity from './lib/components/Humidity.svelte';
  import Location from './lib/components/Location.svelte';
  import Pressure from './lib/components/Pressure.svelte';
  import SunData from './lib/components/SunData.svelte';
  import UVindex from './lib/components/UVindex.svelte';
  import Visibility from './lib/components/Visibility.svelte';
  import WindSpeed from './lib/components/WindSpeed.svelte';
  import type { Daily } from './lib/types/Daily';
  import type { Geocode } from './lib/types/Geocode';
  import type { Hourly } from './lib/types/Hourly';
  import type { Sun } from './lib/types/Sun';
  import type { Weather } from './lib/types/Weather';
  import type { Wind } from './lib/types/Wind';
  
  /**
   * @description true by default to prevent repeated calling to API when developing. Switch to false for production
  */
  const DEV_MODE: boolean = true;

  // Temperature
  const TEMP_UNITS: string[] = ["standard", "metric", "imperial"];
  const UNITS: string = TEMP_UNITS[2];

  // Languages
  const SUPPORTED_LANGS: string[] = [ // https://openweathermap.org/api/one-call-3#multi
    "sq", // 0: Albanian
    "af", // 1: Afrikaans
    "ar", // 2: Arabic
    "az", // 3: Azerbaijani
    "eu", // 4: Basque
    "be", // 5: Belarusian
    "bg", // 6: Bulgarian
    "ca", // 7: Catalan
    "zh_cn", // 8: Chinese Simplified
    "zh_tw", // 9: Chinese Traditional
    "hr", // 10: Croatian
    "cz", // 11: Czech
    "da", // 12: Danish
    "nl", // 13: Dutch
    "en", // 14: English
    "fi", // 15: Finnish
    "fr", // 16: French
    "gl", // 17: Galician
    "de", // 18: German
    "el", // 19: Greek
    "he", // 20: Hebrew
    "hi", // 21: Hindi
    "hu", // 22: Hungarian
    "is", // 23: Icelandic
    "id", // 24: Indonesian
    "it", // 25: Italian
    "ja", // 26: Japanese
    "kr", // 27: Korean
    "ku", // 28: Kurmanji (Kurdish)
    "la", // 29: Latvian
    "lt", // 30: Lithuanian
    "mk", // 31: Macedonian
    "no", // 32: Norwegian
    "fa", // 33: Persian (Farsi)
    "pl", // 34: Polish
    "pt", // 35: Portuguese
    "pt_br", // 36: Português Brasil
    "ro", // 37: Romanian
    "ru", // 38: Russian
    "sr", // 39: Serbian
    "sk", // 40: Slovak
    "sl", // 41: Slovenian
    "sp", // 42: Spanish
    "se", // 43: Swedish
    "th", // 44: Thai
    "tr", // 45: Turkish
    "uk", // 46: Ukranian
    "vi", // 47: Vietnamese
    "zu", // 48: Zulu
  ];
  const language: string = SUPPORTED_LANGS[14];

  let oneCallAPI: string = `./json/weather-sample.json`;
  if (!DEV_MODE) oneCallAPI = `https://api.openweathermap.org/data/3.0/onecall?lat=${import.meta.env.VITE_LATITUDE}&lon=${import.meta.env.VITE_LONGITUDE}&exclude=minutely&units=${UNITS}&lang=${language}&appid=${import.meta.env.VITE_API_KEY}`;

  let airQualityAPI: string = `./json/air-quality-sample.json`;
  if (!DEV_MODE) airQualityAPI = `http://api.openweathermap.org/data/2.5/air_pollution?lat=${import.meta.env.VITE_LATITUDE}&lon=${import.meta.env.VITE_LONGITUDE}&appid=${import.meta.env.VITE_API_KEY}`;

  let geocodeAPI: string = `./json/geocode-sample.json`
  if (!DEV_MODE) geocodeAPI = `http://api.openweathermap.org/geo/1.0/reverse?lat=${import.meta.env.VITE_LATITUDE}&lon=${import.meta.env.VITE_LONGITUDE}&limit=1&appid=${import.meta.env.VITE_API_KEY}`;

  // Response Values
  let sun: Sun;
  let currTemp: number;
  let pressure: number;
  let humidity: number;
  let dewPoint: number;
  let uvi: number;
  let clouds: number;
  let visibility: number;
  let wind: Wind;

  let currWeather: Weather;
  let hourly: Hourly = [];
  let daily: Daily = [];
  
  let airQualityIndex: number;
  
  let location: Geocode;

  const dataPromise = Promise.all ([
    fetch(oneCallAPI).then(d => d.ok ? d.json(): null).then(data => {
      if (DEV_MODE) console.log(data);

      sun = {
        rise: data.current.sunrise,
        set: data.current.sunset
      }
      currTemp = Number(data.current.temp).toFixed(1);
      pressure = data.current.pressure;
      humidity = data.current.humidity;
      dewPoint = data.current.dew_point;
      uvi = data.current.uvi;
      clouds = data.current.clouds;
      visibility = data.current.visibility;
      wind = {
        speed: data.current.wind_speed,
        deg: data.current.wind_deg,
        gust: data.current.wind_gust
      }
      if (DEV_MODE) console.table(wind)
      
      const WEATHER_VALUE_PATH = data.current.weather[0];
      currWeather = {
        id: WEATHER_VALUE_PATH.id,
        forecast: WEATHER_VALUE_PATH.main,
        description: WEATHER_VALUE_PATH.description.charAt(0).toUpperCase() + WEATHER_VALUE_PATH.description.slice(1),
        icon: WEATHER_VALUE_PATH.icon
      }

      if (DEV_MODE) console.table(currWeather);

      for (let i = 1; i < 13; i++) {
        hourly.push({
          time: data.hourly[i].dt,
          halfOfDay: 'AM',
          precipitation: data.hourly[i].pop,
          temp: data.hourly[i].temp
        })
      }
      if (DEV_MODE) console.table(hourly);

      for (let i = 1; i < 7; i++) {
        daily.push({
          time: data.daily[i].dt,
          lowTemp: data.daily[i].temp.min,
          highTemp: data.daily[i].temp.max,
          weather: data.daily[i].weather[0].icon,
          precipitation: data.daily[i].pop
        })
      }
      if (DEV_MODE) console.table(daily);
    }),

    fetch(airQualityAPI).then(d => d.ok ? d.json(): null).then(data => {
      if (DEV_MODE) console.log(data);

      airQualityIndex = data.list[0].main.aqi;
    }),

    fetch(geocodeAPI).then(d => d.ok ? d.json(): null).then(data => {
      if (DEV_MODE) console.log(data);

      location = {
        name: data[0].name,
        country: data[0].country,
        state: data[0].state
      }

      if (DEV_MODE) console.table(location)
    }),
  ])
</script>

{#if DEV_MODE}
  <div class="dev-mode-message">
    <p>Notice: Developer mode is enabled</p>
  </div>
{/if}

<main>
  {#await dataPromise}
    <div class="loading">Loading weather data...</div>
  {:then data} 
    <div class="top">
      
      <Location name={location.name} state={location.state}/>
    </div>

    <div class="middle">
      <div class="left-side">
        <CurrentWeather temp={currTemp} icon={currWeather.icon} tempUnits={UNITS}>
          <p>{currWeather.description}</p>
        </CurrentWeather>
      </div>
      
      <div class="right-side">
        <div class="column">
          <SunData icon="./assets/icons/01d.png" iconAlt="sun rise icon" title="Sunrise" unixTimeValue={sun.rise} twelveHourTime/>
          <WindSpeed windSpeed={wind.speed} units={UNITS}/>
          <Humidity humidity={humidity} />
          <Visibility visibility={visibility}/>
        </div>

        <div class="column">
          <SunData icon="./assets/icons/01d.png" iconAlt="sun set icon" title="Sunset" unixTimeValue={sun.set} twelveHourTime/>
          <Pressure pressure={pressure} />
          <UVindex uvi={uvi}/>
          <AirQuality aqi={airQualityIndex}/>
        </div>
      </div>
    </div>

    <div class="bottom"> 
      <HourlyData hourlyData={hourly} twelveHourTime/>
      <DailyData dailyData={daily} icon{daily.weather} monthDay/>
    </div>

  {:catch error}
    <div class="error">Error loading weather data: {error.message}</div>
  {/await}
</main>

<style>
  main {
    height: 100vh;
    width: 100vw;
    padding: 8px;
  }
  
  .dev-mode-message {
    background-color: red;
    color: white;
    text-align: center;
  }

  .top {
    text-align: center;
  }

  .middle {
    display: flex;
    justify-content: center;
  }

  .right-side {
    display: flex;
    flex-direction: row;
  }

  .column {
    display: flex;
    flex-direction: column;
  }
</style>
