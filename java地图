// 定义天气类型
const WeatherType = {
  Sunny: "Sunny",
  Rainy: "Rainy",
  Cloudy: "Cloudy",
  Stormy: "Stormy",
};

// 定义地图大小
const mapWidth = 10;
const mapHeight = 10;

// 创建一个空地图
const map = [];

// 随机生成天气状态
function getRandomWeather() {
  const weatherTypes = Object.values(WeatherType);
  const randomIndex = Math.floor(Math.random() * weatherTypes.length);
  return weatherTypes[randomIndex];
}

// 生成地图
for (let y = 0; y < mapHeight; y++) {
  const row = [];
  for (let x = 0; x < mapWidth; x++) {
    const weather = getRandomWeather();
    row.push({ x, y, weather });
  }
  map.push(row);
}

// 打印地图
console.log(map);
