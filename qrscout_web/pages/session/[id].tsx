import Head from 'next/head'
import styles from '../../styles/session.module.css'
import Webcam from 'react-webcam'
import React from 'react';
import { storage, realtime} from '../../lib/firebase';
import { useRouter } from 'next/router'
import { GiSadCrab } from 'react-icons/gi';


export default function Home() {
  // get screen size
  const [width, setWidth] = React.useState(0);
  const [height, setHeight] = React.useState(0);
  const [cameraDevice, setCameraDevice] = React.useState(false);
  const [hostRecieving, setHostRecieving] = React.useState(false);
  const router = useRouter()
  const { id } = router.query

  React.useEffect(() => {
    setWidth(window.innerWidth);
    setHeight(window.innerHeight);
  }, []);


  React.useEffect(() => {
    console.log(hostRecieving);
  }, [hostRecieving]);

  const swapCamera = () => {
    setCameraDevice(!cameraDevice);
  }

  const videoConstraints = {
    width: width,
    height: height,
    facingMode: cameraDevice ? "user" : "environment"
  };

  realtime.ref('users/' + id ).on('value', (snapshot: any) => {
    if(snapshot.val() != null && snapshot.val().recieving != null){
      const recieving = snapshot.val().recieving;
      if(hostRecieving != recieving){
        setHostRecieving(recieving);
      }
    }
  })

  

  const WebcamCapture = () => {
    const webcamRef = React.useRef<Webcam>(null);
    const capture = React.useCallback(
      async () => {
        if(webcamRef.current){
          const imageSrc = webcamRef.current.getScreenshot();
          if(imageSrc == null) return;

            if(hostRecieving === true){
              var storageRef = storage.ref();
              var imageRef = storageRef.child(`user/${id}/${Date.now()}.jpg`);
              imageRef.putString(imageSrc, 'data_url').then(function(snapshot: any) {
                console.log('Uploaded image!');
              });
            }else{
              console.log("Host is not recieving");
            }
          


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

  const NoHost = () => {
    return (
      <div className={styles.noHost}>
        <h1>Host is not recieving </h1>
        <GiSadCrab size={100} />
        

      </div>
    )
  }
  
  return (
    <div className={styles.container}>
      <Head>
        <title>Qr Scout</title>
        <meta name="description" content="Qr Scout" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <div>
        {hostRecieving ? <WebcamCapture /> : <NoHost />}
      </div>

    </div>
  )
}
