import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'
import Webcam from 'react-webcam'
import React from 'react';

export default function Home() {
  // get screen size
  const [width, setWidth] = React.useState(0);
  const [height, setHeight] = React.useState(0);
  const [cameraDevice, setCameraDevice] = React.useState(false);

  React.useEffect(() => {
    setWidth(window.innerWidth);
    setHeight(window.innerHeight);
    console.log(width, height);
  }, []);

  const swapCamera = () => {
    setCameraDevice(!cameraDevice);
  }

  const videoConstraints = {
    width: width,
    height: height,
    facingMode: cameraDevice ? "user" : "environment"
  };

  const WebcamCapture = () => {
    const webcamRef = React.useRef<Webcam>(null);
    const capture = React.useCallback(
      () => {
        if(webcamRef.current){
          const imageSrc = webcamRef.current.getScreenshot();
        }
      },
      [webcamRef]
    );
    return (
      <div className={styles.webcamContainer}
        style={{width: width, height: height}}
      
      >
        <Webcam
          className={styles.webcam}
          audio={false}
          height={'100%'}
          ref={webcamRef}
          screenshotFormat="image/jpeg"
          width={width}
          videoConstraints={videoConstraints}
        />
        <div className={styles.buttonContainer}>
          <button onClick={capture}>Capture photo</button>
          <button onClick={swapCamera}> Flip Camera</button>
        </div>

      </div>
    );
  };
  
  return (
    <div className={styles.container}>
      <Head>
        <title>Qr Scout</title>
        <meta name="description" content="Qr Scout" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <div>
        <WebcamCapture />
        
      </div>

    </div>
  )
}
