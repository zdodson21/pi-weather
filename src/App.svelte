<script lang="ts">
  import AirQuality from './lib/components/AirQuality.svelte';
  import CurrentWeather from './lib/components/CurrentWeather.svelte';
  import Location from './lib/components/Location.svelte';
  import type { Geocode } from './lib/types/Geocode';
  import type { Weather } from './lib/types/Weather';
  import type { Wind } from './lib/types/Wind';
  
  const DEV_MODE: boolean = true;

  // TODO might not be needed
  const CALL_INTERVAL: number = 600000; // 10 minutes

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
    "sp, es", // 42: Spanish
    "sv, se", // 43: Swedish
    "th", // 44: Thai
    "tr", // 45: Turkish
    "ua, uk", // 46: Ukranian
    "vi", // 47: Vietnamese
    "zu", // 48: Zulu
  ];
  const language: string = SUPPORTED_LANGS[14];

  let oneCallAPI: string;
  if (DEV_MODE) {
    oneCallAPI = `../json/weather-sample.json`;
  } else {
    oneCallAPI = `https://api.openweathermap.org/data/3.0/onecall?lat=${import.meta.env.VITE_LATITUDE}&lon=${import.meta.env.VITE_LONGITUDE}&exclude=minutely&units=${UNITS}&lang=${language}&appid=${import.meta.env.VITE_API_KEY}`
  }

  let airQualityAPI: string;
  if (DEV_MODE) {
    airQualityAPI = `../json/air-quality-sample.json`;
  } else {
    airQualityAPI = `http://api.openweathermap.org/data/2.5/air_pollution?lat=${import.meta.env.VITE_LATITUDE}&lon=${import.meta.env.VITE_LONGITUDE}&appid=${import.meta.env.VITE_API_KEY}`
  }

  let geocodeAPI: string;
  if (DEV_MODE) {
    geocodeAPI = `../json/geocode-sample.json`;
  } else {
    geocodeAPI = `http://api.openweathermap.org/geo/1.0/reverse?lat=${import.meta.env.VITE_LATITUDE}&lon=${import.meta.env.VITE_LONGITUDE}&limit=1&appid=${import.meta.env.VITE_API_KEY}`
  }

  // Response Values
  let sunRise: number;
  let sunSet: number;
  let currTemp: number;
  let pressure: number;
  let humidity: number;
  let dewPoint: number;
  let uvi: number;
  let clouds: number;
  let visibility: number;
  let wind: Wind;
  let currWeather: Weather;
  
  let airQualityIndex: number;
  
  let location: Geocode;

  const dataPromise = Promise.all ([
    fetch(oneCallAPI)
    .then(d => d.ok ? d.json(): null)
    .then(data => {
      if (DEV_MODE) console.log(data);

      sunRise = data.current.sunrise;
      sunSet = data.current.sunSet;
      currTemp = data.current.temp;
      pressure = data.current.pressure;
      humidity = data.current.humidity;
      dewPoint = data.current.dew_point;
      uvi = data.current.uvi;
      clouds = data.current.clouds;
      visibility = data.current.visibility;
      wind = {
        windSpeed: data.current.wind_speed,
        windDeg: data.current.wind_deg,
        windGust: data.current.wind_gust
      }
      if (DEV_MODE) console.table(wind)
      
      const WEATHER_VALUE_PATH = data.current.weather[0];
      currWeather = {
        id: WEATHER_VALUE_PATH.id,
        forecast: WEATHER_VALUE_PATH.main,
        description: WEATHER_VALUE_PATH.description,
        icon: WEATHER_VALUE_PATH.icon
      }
      if (DEV_MODE) console.table(currWeather);
    }),

    fetch(airQualityAPI)
    .then(d => d.ok ? d.json(): null)
    .then(data => {
      console.log(data);

      airQualityIndex = data.list[0].main.aqi;
    }),

    fetch(geocodeAPI)
    .then(d => d.ok ? d.json(): null)
    .then(data => {
      console.log(data);

      location = {
        name: data[0].name,
        country: data[0].country,
        state: data[0].state
      }

      console.table(location)
    }),
  ])
</script>

<main>
  {#await dataPromise}
    <div class="loading">Loading weather data...</div>
  {:then data} 
    {#if DEV_MODE}
      <div class="dev-mode-message">
        <p>Notice: Developer mode is enabled</p>
      </div>
    {/if}

    <Location name={location.name} state={location.state}/>
    <CurrentWeather forecast={"Sunny"} temp={72}/>
    <AirQuality aqi={airQualityIndex}/>
  {:catch error}
    <div class="error">Error loading weather data: {error.message}</div>
  {/await}
</main>

<style>
  
</style>
