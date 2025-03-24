import BackgroundService from 'react-native-background-actions';

const task = async () => {
  console.log("🔄 Background Task Running...");
  while (true) {
    await new Promise(resolve => setTimeout(resolve, 5000)); // 5 sec delay
    console.log("✅ App is running in the background...");
  }
};

const options = {
  taskName: 'BackgroundTask',
  taskTitle: 'Hidden Parental Control',
  taskDesc: 'Monitoring active...',
  taskIcon: { name: 'ic_launcher', type: 'mipmap' },
  parameters: { delay: 1000 },
};

async function startBackgroundTask() {
  try {
    console.log("🚀 Starting Background Task...");
    await BackgroundService.start(task, options);
    await BackgroundService.updateNotification({ taskDesc: 'Monitoring Enabled' });
  } catch (error) {
    console.error("❌ Error Starting Background Task:", error);
  }
}

export { startBackgroundTask };
