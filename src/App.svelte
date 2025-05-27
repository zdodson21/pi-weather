<script lang="ts">
  import CurrentWeather from './lib/components/CurrentWeather.svelte';
  
  // Call data
  let callFailCounter: number = 0;
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

  try { // One Call Weather API
    fetch(`https://api.openweathermap.org/data/3.0/onecall?lat=${import.meta.env.VITE_LATITUDE}&lon=${import.meta.env.VITE_LONGITUDE}&exclude=minutely&units=${UNITS}&lang=${language}&appid=${import.meta.env.VITE_API_KEY}`);
    // TODO get sample json
    callFailCounter = 0;
  } catch {
    callFailCounter++;
  }

  try { // Air Quality
    fetch(`http://api.openweathermap.org/data/2.5/air_pollution?lat=${import.meta.env.VITE_LATITUDE}&lon=${import.meta.env.VITE_LONGITUDE}&appid=${import.meta.env.VITE_API_KEY}`);
    // get & fetch sample json
  } catch {

  }

  if (callFailCounter === 6) {
    console.error(`callFailCounter has reached ${callFailCounter} failed calls (calls occur every ${CALL_INTERVAL} milliseconds)`)
  } 
</script>

<main>
  <CurrentWeather forecast={"Sunny"} temp={72}/>
</main>

<style>
  
</style>
