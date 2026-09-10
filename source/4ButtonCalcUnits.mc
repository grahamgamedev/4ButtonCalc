import Toybox.Lang;

module units {
    var conversionTypes as Array<String> = ["Weight", "Length", "Speed", "Volume", "Area", "Temperature", "Pressure", "Power"];

    var unitTypes as Dictionary<String, Array<String>> = {
        "Weight" => ["Kilograms", "Pounds", "Stones", "Ounces", "Grams"],
        "Length" => ["Millimeters", "Centimeters", "Inches", "Feet", "Yards", "Meters", "Kilometers", "Miles"],
        "Speed" => ["MetersPerSecond", "KilometersPerHour", "MilesPerHour", "FeetPerSecond"],
        "Volume" => ["Liters", "Gallons (UK)", "Gallons (US)", "Pints", "Cups", "Milliliters", "CubicMeters"],
        "Area" => ["SquareCentimeters", "SquareInches", "SquareFeet", "SquareMeters", "SquareKilometers", "SquareMiles"],
        "Temperature" => ["Celsius", "Fahrenheit", "Kelvin"],
        "Pressure" => ["KiloPascals", "Bars", "PSI"],
        "Power" => ["Kilowatts", "Horsepower"]
    };

    var conversions as Dictionary<String, Dictionary<String, Float>> = {
        "Weight" => {
            "Kilograms" => 1.0,
            "Grams" => 0.001,
            "Pounds" => 0.453592,
            "Stones" => 6.35029,
            "Ounces" => 0.0283495
        },
        "Length" => {
            "Millimeters" => 0.001,
            "Centimeters" => 0.01,
            "Meters" => 1.0,
            "Kilometers" => 1000.0,
            "Feet" => 0.3048,
            "Miles" => 1609.34,
            "Yards" => 0.9144,
            "Inches" => 0.0254
        },
        "Speed" => {
            "MetersPerSecond" => 1.0,
            "KilometersPerHour" => 0.277778,
            "MilesPerHour" => 0.44704,
            "FeetPerSecond" => 0.3048
        },
        "Volume" => {
            "CubicMeters" => 1000.0,
            "Liters" => 1.0,
            "Milliliters" => 0.001,
            "Gallons (UK)" => 4.54609,
            "Gallons (US)" => 3.78541,
            "Pints" => 0.473176,
            "Cups" => 0.24
        },
        "Area" => {
            "SquareCentimeters" => 0.0001,
            "SquareInches" => 0.00064516,
            "SquareMeters" => 1.0,
            "SquareKilometers" => 1000000.0,
            "SquareFeet" => 0.092903,
            "SquareMiles" => 2589988.11
        },
        "Temperature" => {
            "Celsius" => 1.0,
            "Fahrenheit" => 0.555556,
            "Kelvin" => 1.0
        },
        "Pressure" => {
            "KiloPascals" => 1.0,
            "Bars" => 100.0,
            "PSI" => 6.89476
        },
        "Power" => {
            "Kilowatts" => 1.0,
            "Horsepower" => 0.7457
        }
    };
    var offsetConversions as Dictionary<String, Dictionary<String, Float>> = {
        "Temperature" => {
            "Celsius" => 0.0,
            "Fahrenheit" => -32.0,
            "Kelvin" => -273.15
        }
    };
    var shortUnits as Dictionary<String, Dictionary<String, String>> = {
        "Weight" => {
            "Kilograms" => "kg",
            "Grams" => "g",
            "Pounds" => "lb",
            "Stones" => "st",
            "Ounces" => "oz"
        },
        "Length" => {
            "Millimeters" => "mm",
            "Centimeters" => "cm",
            "Meters" => "m",
            "Kilometers" => "km",
            "Feet" => "ft",
            "Miles" => "mi",
            "Yards" => "yd",
            "Inches" => "in"
        },
        "Speed" => {
            "MetersPerSecond" => "m/s",
            "KilometersPerHour" => "km/h",
            "MilesPerHour" => "mph",
            "FeetPerSecond" => "ft/s"
        },
        "Volume" => {
            "CubicMeters" => "m³",
            "Liters" => "L",
            "Milliliters" => "mL",
            "Gallons (UK)" => "gal",
            "Gallons (US)" => "gal",
            "Pints" => "pt",
            "Cups" => "cup"
        },
        "Area" => {
            "SquareCentimeters" => "cm²",
            "SquareInches" => "in²",
            "SquareMeters" => "m²",
            "SquareKilometers" => "km²",
            "SquareFeet" => "ft²",
            "SquareMiles" => "mi²"
        },
        "Temperature" => {
            "Celsius" => "°C",
            "Fahrenheit" => "°F",
            "Kelvin" => "K"
        },
        "Pressure" => {
            "KiloPascals" => "kPa",
            "Bars" => "bar",
            "PSI" => "psi"
        },
        "Power" => {
            "Kilowatts" => "kW",
            "Horsepower" => "hp"
        }
    };
}