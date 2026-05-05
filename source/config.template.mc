// Configuration template for Virtual Smart Home API endpoints
// Copy this file to config.mc and fill in your actual tokens

class Config {
    // Map of action symbols to Virtual Smart Home API endpoints
    static var ENDPOINT_URLS as Dictionary<Symbol, String> = {
        :action1 => "https://www.virtualsmarthome.xyz/url_routine_trigger/activate.php?trigger=YOUR_TRIGGER_ID&token=YOUR_TOKEN&response=html",
        :action2 => "https://www.virtualsmarthome.xyz/url_routine_trigger/activate.php?trigger=YOUR_TRIGGER_ID&token=YOUR_TOKEN&response=html",
        :action3 => "https://www.virtualsmarthome.xyz/url_routine_trigger/activate.php?trigger=YOUR_TRIGGER_ID&token=YOUR_TOKEN&response=html",
        :action4 => "https://www.virtualsmarthome.xyz/url_routine_trigger/activate.php?trigger=YOUR_TRIGGER_ID&token=YOUR_TOKEN&response=html"
    };
}
