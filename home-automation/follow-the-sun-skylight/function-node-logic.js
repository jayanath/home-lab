let lux = parseFloat(msg.payload);
if (isNaN(lux)) return null;

const wasOff = context.get('isOff') || false;
const threshold = wasOff ? 5.0 : 2.0;
const isOff = lux < threshold;
context.set('isOff', isOff);

if (isOff) {
    msg.payload = { "state": "OFF" };
    return msg;
}

// Log scaling across outdoor range: ~2 lux (dusk) to ~50,000 lux (bright sun)
const MIN_LOG = Math.log10(2);
const MAX_LOG = Math.log10(5000);
let brightness = Math.round(((Math.log10(lux) - MIN_LOG) / (MAX_LOG - MIN_LOG)) * 253 + 1);

brightness = Math.min(254, Math.max(1, brightness));

msg.payload = {
    "state": "ON",
    "brightness": brightness,
    "transition": 20
};

node.warn(`Lux: ${lux}, Brightness: ${brightness}`);

return msg;