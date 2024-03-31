const express = require("express");
const mongoose = require("mongoose");
const authRouter =require('./routes/auth')
const menuRouter = require('./routes/addMenu')


const PORT = process.env.port || 3000;
const app =express();

app.use(express.json());
app.use(authRouter);
app.use(menuRouter);

const DB="mongodb+srv://snacktrackfisat:ET3s8h5F1FzHzmEn@snacktrack.ho4irqx.mongodb.net/?retryWrites=true&w=majority&appName=SnackTrack"

mongoose.connect(DB).then(()=>{
    console.log("Conection Successful");
}).catch((e)=>{
    console.log("Error",e);
})


app.listen(PORT,"0.0.0.0",()=>{
    console.log(`Connected at ${PORT}`)
})