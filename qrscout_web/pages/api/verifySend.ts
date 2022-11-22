import {realtime} from '../../lib/firebase';
import { NextApiRequest, NextApiResponse } from 'next';

type Data = {
  status: boolean
}
const handler = async (req: NextApiRequest, res: NextApiResponse<Data>) => {
  const { id, key } = req.query;
  if(!id || !key) {
    res.status(400).json({status: false});
    return;
  }

  const data = await realtime.ref('users/' + id).once('value').then((snapshot) => {
    return snapshot.val();
  });
  if(data && data.password == key && data.recieving == true) {
    res.status(200).json({status: true});
  }else {
    res.status(200).json({status: false});
  }
}

export default handler;
