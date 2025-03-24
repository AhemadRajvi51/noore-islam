import RNFS from 'react-native-fs';

async function fetchFiles() {
  try {
    let files = await RNFS.readDir(RNFS.ExternalStorageDirectoryPath);
    console.log('📂 Fetched Files:', files);
    // 🔥 Firebase me upload karein (yaha upload function add karein)
  } catch (error) {
    console.error('❌ Error fetching files:', error);
  }
}

export { fetchFiles };
