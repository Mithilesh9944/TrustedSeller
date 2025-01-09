const express = require("express");
const app = express();

const PORT = 3000;

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

const userRouter = require("./Routes/userRoute");
app.use("/", userRouter);

//cors
const cors = require('cors');
app.use(cors({
  //origin: '*', // Replace '*' with your Flutter web app URL for better security
  origin: "http://localhost:3000", // Replace with the port your Flutter app is running on
  methods: ['GET', 'POST', 'PUT', 'DELETE'], // Allowed HTTP methods
  credentials: true, // Allow cookies or authentication headers, if needed
}));

app.listen(PORT, () => {
    console.log(`Server is successfully running on port ${PORT}`);
});
