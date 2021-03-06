const express = require("express");
const path = require("path");

const app = express();
const PATH = path.resolve(__dirname, "build");

app.use(express.static(PATH, {
    extensions: ["html", "js", "css"],
}));

app.listen("3000");
