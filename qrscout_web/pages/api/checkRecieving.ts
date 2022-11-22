import {realtime} from '../../lib/firebase';
import { NextApiRequest, NextApiResponse } from 'next';

type Data = {
  status: boolean
}
const handler = (req: NextApiRequest, res: NextApiResponse<Data>) => {
  const { id } = req.query;
  realtime.ref('users/' + id).once('value', (snapshot) => {
    const data = snapshot.val();
    console.log(data);
    res.status(200).json({ status: data.recieving })
  });
}

export default handler;
