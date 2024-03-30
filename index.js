import express from "express";
import bodyParser from "body-parser";
import pg from "pg";
import axios from "axios";

const app = express();
const port = 3000;
const SEARCH_API_URL = "https://openlibrary.org/"  
const COVER_API_URL = "https://covers.openlibrary.org/b/"

const db = new pg.Client({
  user: "postgres",
  host: "localhost",
  database: "book_notes",
  password: "",
  port: 5432,
});
db.connect();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));

async function getAllUserBooks(){
  const result = await db.query(
    "SELECT * FROM user_books"
  )

  return result.rows
}

app.get("/",  async (req, res) => {
  try {
    const allUserBooks = await getAllUserBooks()
    res.render("index.ejs", {allUserBooks:allUserBooks, totalBookNumber:allUserBooks.length})
  } catch (error) {
    console.error("Failed to make request:", error.message);
    res.render("index.ejs", {
        error: error.message,
    });
  }
});


app.get("/new", (req, res) => {

})

// app.post("/new/add",  async (req, res) => {
//   const title = "The Maze Runner"
//   try {
//     const search_result = await axios.get(SEARCH_API_URL + `search.json?q=${encodeURIComponent(title)}`)
//     console.log(search_result.data.docs[0])
//     const cover_id = search_result.data.docs[0].cover_i
//     res.render("index.ejs", {response:search_result.data.docs[0], coverUrl: COVER_API_URL + `id/${cover_id}-L.jpg`});

//   } catch (error) {
//     console.error("Failed to make request:", error.message);
//     res.render("index.ejs", {
//         error: error.message,
//     });
//   }
// });


app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
