import mongoose from "mongoose";

const { MONGO_URI } = process.env;

export const connectWithRetry = () => {
    mongoose.connect(MONGO_URI).then(() => {
        console.log('MongoDB is connected')
    }).catch(err => {
        console.log('MongoDB connection unsuccessful, retry after 5 seconds.')
        setTimeout(connectWithRetry, 5000)
    })
}


