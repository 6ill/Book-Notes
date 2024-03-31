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
app.use(express.static("./public/"));

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
  res.render("new.ejs")
})

app.post("/new/add",  async (req, res) => {
  const title = req.body.title;
  const dateRead = req.body.dateRead;
  const rating = req.body.rating;
  const review = req.body.review;
  try {
    const search_result = await axios.get(SEARCH_API_URL + `search.json?q=${encodeURIComponent(req.body.title)}`)
    const cover_id = search_result.data.docs[0].cover_i
    await db.query(
      "INSERT INTO user_books(title, cover_id, date_read, rating, review) VALUES ($1, $2, $3, $4, $5)",
      [title, cover_id, dateRead, rating, review]
    )
    res.redirect("/");
  } catch (error) {
    console.error("Error occured: ", error.message);
    res.render("index.ejs", {
        error: error.message,
    });
  }
});


app.post("/delete/:id", async (req,res) => {
  const id = req.params.id
  try {
    await db.query("DELETE FROM notes WHERE book_id = $1", [id]);
    await db.query("DELETE FROM user_books WHERE id = $1", [id]);
    res.redirect("/")
  } catch (error) {
    console.error("Error occured: ", error.message);
    res.render("index.ejs", {
        error: error.message,
    });
  }
})

app.get("/add-note/:id", (req, res) => {
  res.render("note.ejs", {bookId: req.params.id})
})

app.post("/add-note/:id", async (req, res) => {
  const pageNumber= Number(req.body.pageNumber);
  const note = req.body.note
  const bookId = Number(req.params.id)
  try {
    await db.query(
      "INSERT INTO notes(book_id, date_created, note, page_num) VALUES($1, NOW(), $2, $3)",
      [bookId, note, pageNumber]
    );
    res.redirect("/");
  } catch (error) {
    console.error("Error occured: ", error.message);
    res.render("index.ejs", {
        error: error.message,
    });
  }
})

app.get("/edit/:id", async (req,res) => {
  const id = Number(req.params.id);
  try {
    const result = await db.query(
      "SELECT id,title,date_read,review,rating FROM user_books WHERE id=$1",
      [id]
    )
    const bookData = result.rows[0]
    console.log(bookData['date_read'].toISOString().slice(0,10))
    res.render("edit.ejs", {bookData: bookData})
  } catch (error) {
    console.error("Error occured: ", error.message);
    res.render("index.ejs", {
        error: error.message,
    });
  }
})

app.post("/edit/:id", async (req,res) => {
  const id = Number(req.params.id);
  const title = req.body.title;
  const dateRead = req.body.dateRead;
  const rating = req.body.rating;
  const review = req.body.review;
  try {
    await db.query(
      "UPDATE user_books SET title=$1, date_read=$2, rating=$3, review=$4 WHERE id=$5",
      [title, dateRead, rating, review, id]
    )

    res.redirect("/")
  } catch (error) {
    console.error("Error occured: ", error.message);
    res.render("index.ejs", {
        error: error.message,
    });
  }
})


app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
 