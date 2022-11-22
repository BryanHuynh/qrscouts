import {storage} from '../../lib/firebase';
import { NextApiRequest, NextApiResponse } from 'next';

type Data = {
  status: boolean
}
// increase the limit of the file size
export const config = {
  api: {
    responseLimit: false,
  },
};


const handler = (req: NextApiRequest, res: NextApiResponse<Data>) => {
  const { id, key, image } = req.query;
  console.log(image);
  if(image != undefined && typeof image == 'string'){
    var storageRef = storage.ref();
    var imageRef = storageRef.child(`user/${id}/${Date.now()}.jpg`);
    imageRef.putString(image, 'data_url').then(function(snapshot: any) {
        res.status(200).json({ status: true })
    });
  }

  res.status(200).json({ status: false })
}

export default handler;
