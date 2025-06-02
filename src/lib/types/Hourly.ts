export type Hourly = {
  time: number; // dt
  halfOfDay: string; // AM or PM for 12 hour clock
  precipitation: number; // Probability of precipitation (pop) 0 = 0% / 1 = 100%
  temp: number;
}[];
