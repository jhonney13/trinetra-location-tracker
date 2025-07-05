# Trinetra Location Tracker

A real-time location tracking application built with Flutter, Node.js, and React. The app allows you to track your location in real-time and view it on a web-based admin panel with an interactive map.

## 🚀 Features

- **Real-time Location Tracking**: Get live GPS coordinates from your mobile device
- **WebSocket Communication**: Real-time data transmission between components
- **Interactive Map**: View location on OpenStreetMap using Leaflet
- **Cross-platform**: Works on Android, iOS (with Mac), and Web
- **No API Keys Required**: Uses free OpenStreetMap tiles

## 📱 Components

### 1. Flutter Mobile App (`trinetra_app/`)
- **Platform**: Android, iOS, Web
- **Features**: 
  - GPS location tracking
  - Real-time WebSocket communication
  - Location permission handling
- **Dependencies**: `geolocator`, `web_socket_channel`

### 2. Node.js Backend (`backend/`)
- **Platform**: Cross-platform
- **Features**:
  - WebSocket server for real-time communication
  - Message broadcasting to all connected clients
- **Dependencies**: `express`, `ws`

### 3. React Admin Panel (`admin-panel/`)
- **Platform**: Web browser
- **Features**:
  - Interactive map using Leaflet and OpenStreetMap
  - Real-time location marker updates
  - Responsive design
- **Dependencies**: `react`, `react-leaflet`, `leaflet`

## 🛠️ Installation & Setup

### Prerequisites
- **Flutter SDK** (^3.8.1 or higher)
- **Node.js** (14.x or higher)
- **Android Studio** (for Android development)
- **Xcode** (for iOS development, Mac only)

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/trinetra-location-tracker.git
cd trinetra-location-tracker
```

### 2. Setup Flutter App
```bash
cd trinetra_app
flutter pub get
```

### 3. Setup Backend
```bash
cd backend
npm install
```

### 4. Setup Admin Panel
```bash
cd admin-panel
npm install
```

## 🚀 Running the Application

### 1. Start the Backend Server
```bash
cd backend
npm start
```
The WebSocket server will start on port 8080.

### 2. Start the Admin Panel
```bash
cd admin-panel
npm start
```
The admin panel will open at `http://localhost:3000`.

### 3. Run the Flutter App
```bash
cd trinetra_app
flutter run
```
Select your target platform (Android emulator, iOS simulator, or web browser).

## 🔧 Configuration

### IP Address Configuration
Update the WebSocket URL in both the Flutter app and admin panel to match your local IP address:

**Flutter App** (`trinetra_app/lib/main.dart`):
```dart
channel = WebSocketChannel.connect(Uri.parse('ws://YOUR_IP_ADDRESS:8080'));
```

**Admin Panel** (`admin-panel/src/App.js`):
```javascript
const ws = new WebSocket('ws://YOUR_IP_ADDRESS:8080');
```

### Finding Your IP Address
- **Windows**: Run `ipconfig` in Command Prompt
- **Mac/Linux**: Run `ifconfig` or `ip addr` in Terminal

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| **Android** | ✅ Full Support | Location tracking, real-time updates |
| **iOS** | ✅ Full Support | Requires Mac for development |
| **Web** | ⚠️ Limited | Location may not work in all browsers |
| **Windows** | ⚠️ Limited | Location tracking not supported |

## 🔒 Security Considerations

- **Network Security**: Ensure all devices are on the same secure network
- **Location Privacy**: Location data is only transmitted locally
- **No External APIs**: Uses free OpenStreetMap tiles, no API keys required

## 🐛 Troubleshooting

### Common Issues

1. **"Location permissions are denied"**
   - Grant location permissions in your device settings
   - On Windows, location tracking is not supported

2. **WebSocket connection failed**
   - Check if backend server is running on port 8080
   - Verify IP address configuration
   - Ensure firewall allows port 8080

3. **Map not loading**
   - Check internet connection (required for OpenStreetMap tiles)
   - Verify Leaflet dependencies are installed

4. **Location not updating on map**
   - Check browser console for WebSocket errors
   - Verify both Flutter app and admin panel are connected

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

If you encounter any issues or have questions, please:
1. Check the troubleshooting section above
2. Search existing issues in the repository
3. Create a new issue with detailed information

---

**Happy Tracking! 🗺️📍** 