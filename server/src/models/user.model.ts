// import { Severity, modelOptions, prop } from "@typegoose/typegoose";
// import mongoose from "mongoose";
// import { nanoid } from "nanoid";

import mongoose, { InferSchemaType, Schema } from "mongoose";

// @modelOptions({
//     schemaOptions: {
//         timestamps: true,
//     },
//     options: {
//         allowMixed: Severity.ALLOW
//     }
// })

// export class Address {
//     @prop({ required: true })
//     street: string;

//     @prop({ required: true })
//     city: string;

//     @prop({ required: true })
//     state: string;

//     @prop({ required: true })
//     zip: string;
// }

// export class User {
//     @prop({ required: true, unique: true })
//     username: string;

//     @prop({ lowercase: true, required: true, unique: true })
//     email: string;

//     @prop({ required: true })
//     password: string;

//     @prop({ unique: true, required: true })
//     phoneNum: string;

//     @prop({
//         required: true, default: () => {
//             nanoid()
//         }
//     })
//     verificationCode: string;

//     @prop({ required: true })
//     passwordResetCode: string;

//     @prop({ required: true })
//     verified: boolean;

//     @prop({ required: true })
//     uniqueOrgCode: string;

//     @prop({ required: true, _id: false, type: () => Address })
//     address: Address;
//     static findOrCreate: any;
// }

// // const User = mongoose.model("User", User);

const schema = new Schema({
    'name': { type: String, required: true },
    'email': { type: String, required: true , unique: true, primaryKey: true},
    'password': { type: String, required: true },
    'phoneNumber': { type: String, required: true },
    'uniqueOrgCode': { type: String, required: true },
    'address': { type: String, required: true },
});

type User = InferSchemaType<typeof schema>;

const userModel = mongoose.model('User', schema);

export default userModel;