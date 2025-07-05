import React, { useState, useEffect } from 'react';
import { MapContainer, TileLayer, Marker, Popup, useMap } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';

// Fix default icon issue in Leaflet with React
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
  iconUrl: require('leaflet/dist/images/marker-icon.png'),
  shadowUrl: require('leaflet/dist/images/marker-shadow.png'),
});

const containerStyle = {
  width: '100vw',
  height: '100vh'
};

// Component to recenter the map when location changes
function RecenterMap({ location }) {
  const map = useMap();
  useEffect(() => {
    if (location) {
      map.setView([location.latitude, location.longitude], 15);
    }
  }, [location, map]);
  return null;
}

function App() {
  const [location, setLocation] = useState(null);

  useEffect(() => {
    const ws = new WebSocket('ws://192.168.1.5:8080');
    ws.onopen = () => {
      console.log('Connected to WebSocket server');
    };
    ws.onmessage = async (event) => {
      let message = event.data;
      if (message instanceof Blob) {
        message = await message.text();
      }
      const data = JSON.parse(message);
      setLocation(data);
    };
    ws.onclose = () => {
      console.log('Disconnected from WebSocket server');
    };
    return () => {
      ws.close();
    };
  }, []);

  return (
    <div style={containerStyle}>
      <MapContainer
        center={location ? [location.latitude, location.longitude] : [0, 0]}
        zoom={15}
        style={{ height: "100vh", width: "100vw" }}
      >
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        {location && (
          <Marker position={[location.latitude, location.longitude]}>
            <Popup>
              Latitude: {location.latitude}<br />
              Longitude: {location.longitude}
            </Popup>
          </Marker>
        )}
        <RecenterMap location={location} />
      </MapContainer>
    </div>
  );
}

export default App;