import { mediaDevices } from 'react-native-webrtc';

/**
 * Start Screen Sharing using WebRTC
 */
export async function startScreenShare() {
  try {
    let stream = await mediaDevices.getDisplayMedia({ video: true });
    
    if (stream) {
      console.log('✅ Screen Sharing Started Successfully:', stream);
      return stream;
    } else {
      console.warn('⚠️ Screen Sharing Stream Not Found!');
      return null;
    }
  } catch (error) {
    console.error('❌ Error in Screen Sharing:', error);
  }
}
