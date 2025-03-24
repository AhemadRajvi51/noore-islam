import { launchCamera } from 'react-native-image-picker';

async function captureImage() {
  launchCamera({ saveToPhotos: false }, response => {
    if (response.didCancel) {
      console.log('❌ User cancelled image capture');
    } else if (response.error) {
      console.error('❌ Camera error:', response.error);
    } else {
      console.log('📸 Image Captured:', response.assets);
      // 🔥 Firebase me image upload karein (yaha upload function add karein)
    }
  });
}

export { captureImage };
