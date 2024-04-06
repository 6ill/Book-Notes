--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2024-04-06 15:04:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 24817)
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    book_id integer,
    date_created date,
    note text,
    page_num integer NOT NULL
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24816)
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO postgres;

--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 216
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- TOC entry 215 (class 1259 OID 24808)
-- Name: user_books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_books (
    id integer NOT NULL,
    title character varying(100) NOT NULL,
    cover_id bigint,
    date_read date,
    rating integer,
    review text
);


ALTER TABLE public.user_books OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24807)
-- Name: user_books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_books_id_seq OWNER TO postgres;

--
-- TOC entry 3337 (class 0 OID 0)
-- Dependencies: 214
-- Name: user_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_books_id_seq OWNED BY public.user_books.id;


--
-- TOC entry 3179 (class 2604 OID 24820)
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- TOC entry 3178 (class 2604 OID 24811)
-- Name: user_books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_books ALTER COLUMN id SET DEFAULT nextval('public.user_books_id_seq'::regclass);


--
-- TOC entry 3330 (class 0 OID 24817)
-- Dependencies: 217
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notes (id, book_id, date_created, note, page_num) FROM stdin;
5	2	2024-04-01	Wath efnajfka ajifojaf jifoisfjs sifjisjof jiefojs sjifjsf sjifskj	22
4	2	2024-03-31	Wattt	31
7	2	2024-04-01	Lah kok gitu	44
\.


--
-- TOC entry 3328 (class 0 OID 24808)
-- Dependencies: 215
-- Data for Name: user_books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_books (id, title, cover_id, date_read, rating, review) FROM stdin;
3	Harry Potter and the Sorcerer's Stone	6509920	2024-03-31	1	So overrated! I don't how to describe it. Recommend not to read again. However, I use this book as nampan buat potong-potong sayur. MWHAHAAHAH...!!!
2	Hujan	10872657	2023-03-18	4	Novel 'Hujan' karya Tere Liye adalah kisah yang mengharukan tentang perjuangan Alif dalam menghadapi kehidupan. Meskipun beberapa bagian terasa agak lambat, alur cerita yang menarik dan penggambaran karakter yang mendalam membuat novel ini layak dini
8	The Great Gatsby	10590366	2024-04-09	2	
7	The Picture of Dorian Gray	14314858	2024-04-10	5	"The Picture of Dorian Gray" by Oscar Wilde is a compelling exploration of vanity, morality, and the consequences of a life consumed by pleasure and beauty. Wilde's vivid writing and captivating storyline make this novel a timeless classic that delves deep into the human psyche.
14	War and Peace	12621906	2024-04-11	5	Wih bagus banget
15	The Maze Runner	10464801	2019-05-02	5	Goated fr
\.


--
-- TOC entry 3338 (class 0 OID 0)
-- Dependencies: 216
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notes_id_seq', 9, true);


--
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 214
-- Name: user_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_books_id_seq', 15, true);


--
-- TOC entry 3183 (class 2606 OID 24824)
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- TOC entry 3181 (class 2606 OID 24815)
-- Name: user_books user_books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_books
    ADD CONSTRAINT user_books_pkey PRIMARY KEY (id);


--
-- TOC entry 3184 (class 2606 OID 24825)
-- Name: notes notes_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.user_books(id);


-- Completed on 2024-04-06 15:04:16

--
-- PostgreSQL database dump complete
--

