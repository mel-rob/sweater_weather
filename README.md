# Sweater Weather API

This API is live at: https://mel-rob-sweater-weather.herokuapp.com/

## Overview

Sweater Weather is back-end Rails API designed to serve weather and trip information to a front-end app. It consumes 5 different APIs and exposes data to help road-trippers plan for weather and food options given a destination and estimated arrival time. The application consumes:

- Dark Sky API for weather forecasts and prediction data
- Google Geocode API for latitude & longitude of trip origin and destination inputs
- Google Directions API to pull trip travel time for forecast predictions
- Yelp API to pull restaurant option by cuisine that is open at estimated time of arrival
- Unsplash API for relevant photos of trip

## Technologies & Architecture

- Framework: Ruby on Rails
- Testing: RSpec
- Deployment: Heroku
- CI/CD: TravisCI
- JSON Serializer: FastJsonAPI
- 3rd Party APIs:
  - Google Direction Matrix API
  - Google Geocoding API
  - Yelp API
  - Unsplash API
  - DarkSky API
- Response Caching: VCR & Webmock
- Linting: Rubocop
- Test Coverage: SimpleCov

## Endpoints

All endpoints are built on this API URL:
```
https://mel-rob-sweater-weather.herokuapp.com/api/v1
```
Note the appropriate HTTP verb for each endpoint.

### Forecast

Retrieve detailed weather information for a given city, including:
- Current conditions
- Location details
- Tonight's weather (at 8pm, or currently if between 8pm and midnight)
- Hourly forecasts for next 8 hours
- Daily forecasts for next 5 days

Endpoint:
```
/forecast
```

Query Parameter(s):
- `location`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").

HTTP Request Example:
```
GET https://mel-rob-sweater-weather.herokuapp.com/api/v1/forecast?location=denver,co
```

Response example:
```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "full_forecast": {
                "time_zone": "UTC",
                "location": "Denver, CO, USA",
                "currently": {
                    "summary": "Clear",
                    "feels_like": 85.45,
                    "humidity": 0.08,
                    "visibility": 3.855,
                    "uv_index": 1,
                    "temp": 85.45,
                    "icon": "clear-day",
                    "time": [
                        1590019002,
                        "Clear",
                        85.45,
                        0.08,
                        3.855,
                        1,
                        85.45,
                        "clear-day"
                    ]
                },
                "today": {
                    "tonight_summary": "Clear",
                    "high": 89.12,
                    "low": 50.4,
                    "date": "2020-05-20",
                    "today_summary": [
                        "Clear throughout the day.",
                        "Clear",
                        89.12,
                        50.4,
                        "2020-05-20"
                    ]
                },
                "hourly": [
                    {
                        "temp": 87.54,
                        "icon": "clear-day",
                        "time": [
                            1590015600,
                            87.54,
                            "clear-day"
                        ]
                    },
                    {
                        "temp": 85.27,
                        "icon": "clear-day",
                        "time": [
                            1590019200,
                            85.27,
                            "clear-day"
                        ]
                    },
                    {
                        "temp": 81.04,
                        "icon": "clear-day",
                        "time": [
                            1590022800,
                            81.04,
                            "clear-day"
                        ]
                    },
                    {
                        "temp": 74.12,
                        "icon": "clear-day",
                        "time": [
                            1590026400,
                            74.12,
                            "clear-day"
                        ]
                    },
                    {
                        "temp": 70.08,
                        "icon": "clear-night",
                        "time": [
                            1590030000,
                            70.08,
                            "clear-night"
                        ]
                    },
                    {
                        "temp": 65.83,
                        "icon": "clear-night",
                        "time": [
                            1590033600,
                            65.83,
                            "clear-night"
                        ]
                    },
                    {
                        "temp": 62.79,
                        "icon": "clear-night",
                        "time": [
                            1590037200,
                            62.79,
                            "clear-night"
                        ]
                    },
                    {
                        "temp": 59.87,
                        "icon": "clear-night",
                        "time": [
                            1590040800,
                            59.87,
                            "clear-night"
                        ]
                    }
                ],
                "daily": [
                    {
                        "precipitation_prob": 0.05,
                        "precipitation_type": "rain",
                        "high": 89.12,
                        "low": 50.4,
                        "day": "Wednesday",
                        "icon": "clear-day",
                        "summary": [
                            "Clear throughout the day.",
                            0.05,
                            "rain",
                            89.12,
                            50.4,
                            "Wednesday",
                            "clear-day"
                        ]
                    },
                    {
                        "precipitation_prob": 0.04,
                        "precipitation_type": "rain",
                        "high": 76.77,
                        "low": 50.06,
                        "day": "Thursday",
                        "icon": "clear-day",
                        "summary": [
                            "Clear throughout the day.",
                            0.04,
                            "rain",
                            76.77,
                            50.06,
                            "Thursday",
                            "clear-day"
                        ]
                    },
                    {
                        "precipitation_prob": 0.05,
                        "precipitation_type": "rain",
                        "high": 82.09,
                        "low": 53.79,
                        "day": "Friday",
                        "icon": "clear-day",
                        "summary": [
                            "Clear throughout the day.",
                            0.05,
                            "rain",
                            82.09,
                            53.79,
                            "Friday",
                            "clear-day"
                        ]
                    },
                    {
                        "precipitation_prob": 0.13,
                        "precipitation_type": "rain",
                        "high": 80.27,
                        "low": 46.17,
                        "day": "Saturday",
                        "icon": "partly-cloudy-day",
                        "summary": [
                            "Mostly cloudy throughout the day.",
                            0.13,
                            "rain",
                            80.27,
                            46.17,
                            "Saturday",
                            "partly-cloudy-day"
                        ]
                    },
                    {
                        "precipitation_prob": 0.83,
                        "precipitation_type": "rain",
                        "high": 54.16,
                        "low": 44.07,
                        "day": "Sunday",
                        "icon": "rain",
                        "summary": [
                            "Rain until evening.",
                            0.83,
                            "rain",
                            54.16,
                            44.07,
                            "Sunday",
                            "rain"
                        ]
                    }
                ]
            }
        }
    }
}
```

### Backgrounds

Retrieve a background image URL from Unsplash for a given city, which can be resized to fit one's needs.

Endpoint:
```
/backgrounds
```

Query Parameter(s):
- `location`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").

HTTP Request Example:
```
GET https://mel-rob-sweater-weather.herokuapp.com/api/v1/backgrounds?location=denver,co
```

Response example:
```json
{
    "data": {
        "id": null,
        "type": "background",
        "attributes": {
            "background_url": "https://images.unsplash.com/photo-1546156929-a4c0ac411f47?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjExODM0MX0"
        }
    }
}
```

### Users

Submit a user's email, password, and password confirmation to create that user in the database and receive a unique API key for the user.

POST Request Body Parameter(s):
- `email`, which is a string value and must be unique in the database.
- `password`, which is a string value.
- `password_confirmation`, which is a string value and must be present and match the `password`.

Endpoint:
```
/users
```

HTTP Request example:
```
POST http://mel-rob-sweater-weather.herokuapp.com/api/v1/users
```
Headers example:
```
Content-Type: application/json
Accept: application/json
```
Body example:
```json
{
  "email": "email@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

Response example:
```json
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "api_key": "2spUEHk5he9QyaejHsPKcYV6"
        }
    }
}
```

If there is a problem with the parameters provided, a JSON:API error object will be returned containing details about which parameter caused the error.

Error example:
```json
{
    "errors": [
        {
            "status": "400",
            "source": {
                "pointer": "/api/v1/users",
                "parameter": "email, password_confirmation"
            },
            "title": "Invalid Request",
            "detail": "Email has already been taken, Password confirmation doesn't match Password."
        }
    ]
}
```

### Sessions

Submit an existing user's email and password and receive their unique API key generated by the previous endpoint.

Endpoint:
```
/sessions
```

POST Request Body Parameter(s):
- `email`, which is a string value and must be unique in the database.
- `password`, which is a string value.


HTTP Request example:
```
POST http://mel-rob-sweater-weather.herokuapp.com/api/v1/sessions
```
Headers example:
```
Content-Type: application/json
Accept: application/json
```
Body example:
```json
{
  "email": "email@example.com",
  "password": "password",
}
```

Response example:
```json
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "api_key": "2spUUHk5he9QyaejKsPKcYV6"
        }
    }
}
```

If there is a problem with the parameters provided, a JSON:API error object will be returned containing details about which parameter caused the error.

Error example:
```json
{
    "errors": [
        {
            "status": "400",
            "source": {
                "pointer": "/api/v1/sessions",
                "parameter": "email"
            },
            "title": "Invalid Credentials",
            "detail": "Invalid email."
        }
    ]
}
```

### Road Trip

Submit an origin and a destination along with a user's API key and receive information on travel time and the temperature and weather upon arrival.

Endpoint:
```
/road_trip
```

POST Request Body Parameter(s):
- `origin`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").
- `destination`, which should be another string containing a city and state, comma-separated (e.g., "pueblo,co").
- `api_key`, which should be a valid 24-character API key acquired from either the `/users` or `/sessions` endpoints above, as a string.

HTTP Request example:
```
POST http://mel-rob-sweater-weather.herokuapp.com/api/v1/road_trip
```
Headers example:
```
Content-Type: application/json
Accept: application/json
```
Body example:
```
{
  "origin": "denver,co",
  "destination": "pueblo,co",
  "api_key": "2spUUHk5he9QyaejKsPKcYV6"
}
```

Example response:
```json
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "origin": "denver,co",
            "destination": "pueblo,co",
            "travel_time": "1 hour 48 mins",
            "arrival_forecast": {
                "summary": "Clear",
                "temp": 79.55
            }
        }
    }
}
```

If there is a problem with the API key provided, a JSON:API error object will be returned containing details.

Error example:
```json
{
    "errors": [
        {
            "status": "401",
            "source": {
                "pointer": "/api/v1/road_trip",
                "parameter": "api_key"
            },
            "title": "Unauthorized Request",
            "detail": "The API key provided was invalid."
        }
    ]
}
```

### Munchies

Submit start and end locations and a preferred food type, and receive information about travel time, weather conditions upon arrival, and the closest restaurant to your arrival location that will be open at your arrival time.

Endpoint:
```
/munchies
```

Query Parameter(s):
- `start`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").
- `end`, which should be another string containing a city and state, comma-separated (e.g., "pueblo,co").
- `food`, a preferred food type as a string value.

Example request:
```
GET http://mel-rob-sweater-weather.herokuapp.com/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese
```

Example response:
```json
{
  "data": {
    "id": "null",
    "type": "munchie",
    "attributes": {
      "end_location": "Pueblo, CO",
      "travel_time": "1 hours 48 min",
      "forecast": "Partly cloudy"
      "restaurant": {
        "name": "Chinese Restaurant",
        "address": "4602 N. Elizabeth St, Ste 120, Pueblo, CO 81008"
      }
    }
  }
}
```
