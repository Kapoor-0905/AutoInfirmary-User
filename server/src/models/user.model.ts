import { Severity, modelOptions, prop } from "@typegoose/typegoose";
import { nanoid } from "nanoid";

@modelOptions({
    schemaOptions: {
        timestamps: true,
    },
    options: {
        allowMixed: Severity.ALLOW
    }
})

export class Address {
    @prop({ required: true })
    street: string;

    @prop({ required: true })
    city: string;

    @prop({ required: true })
    state: string;

    @prop({ required: true })
    zip: string;
}

export class User {
    @prop({ required: true, unique: true })
    username: string;

    @prop({ lowercase: true, required: true, unique: true })
    email: string;

    @prop({ required: true })
    password: string;

    @prop({ unique: true, required: true })
    phoneNum: string;

    @prop({
        required: true, default: () => {
            nanoid()
        }
    })
    verificationCode: string;

    @prop({ required: true })
    passwordResetCode: string;

    @prop({ required: true })
    verified: boolean;

    @prop({ required: true })
    uniqueOrgCode: string;

    @prop({ required: true, _id: false, type: () => Address })
    address: Address;
    static findOrCreate: any;
}