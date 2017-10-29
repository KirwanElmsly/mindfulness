--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

-- Started on 2017-10-29 10:19:47 GMT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE mindfulness;
--
-- TOC entry 2206 (class 1262 OID 16386)
-- Name: mindfulness; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE mindfulness WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_GB.UTF-8' LC_CTYPE = 'en_GB.UTF-8';


\connect mindfulness

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12427)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 192 (class 1259 OID 16541)
-- Name: played; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE played (
    play_id integer NOT NULL,
    song_id integer,
    date date
);


--
-- TOC entry 191 (class 1259 OID 16539)
-- Name: played_play_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE played_play_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 191
-- Name: played_play_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE played_play_id_seq OWNED BY played.play_id;


--
-- TOC entry 186 (class 1259 OID 16390)
-- Name: songs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE songs (
    song_id integer NOT NULL,
    title text,
    url text,
    day integer,
    user_id integer
);


--
-- TOC entry 185 (class 1259 OID 16388)
-- Name: songs_song_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE songs_song_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 185
-- Name: songs_song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE songs_song_id_seq OWNED BY songs.song_id;


--
-- TOC entry 187 (class 1259 OID 16394)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    name text,
    in_office boolean DEFAULT false,
    user_id integer NOT NULL
);


--
-- TOC entry 188 (class 1259 OID 16406)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 188
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- TOC entry 190 (class 1259 OID 16430)
-- Name: votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE votes (
    vote_id integer NOT NULL,
    song_id integer,
    user_id integer,
    vote bit(1)
);


--
-- TOC entry 189 (class 1259 OID 16428)
-- Name: votes_vote_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE votes_vote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 189
-- Name: votes_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE votes_vote_id_seq OWNED BY votes.vote_id;


--
-- TOC entry 2063 (class 2604 OID 16544)
-- Name: played play_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY played ALTER COLUMN play_id SET DEFAULT nextval('played_play_id_seq'::regclass);


--
-- TOC entry 2059 (class 2604 OID 16393)
-- Name: songs song_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY songs ALTER COLUMN song_id SET DEFAULT nextval('songs_song_id_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 16408)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- TOC entry 2062 (class 2604 OID 16433)
-- Name: votes vote_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes ALTER COLUMN vote_id SET DEFAULT nextval('votes_vote_id_seq'::regclass);


--
-- TOC entry 2078 (class 2606 OID 16546)
-- Name: played played_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY played
    ADD CONSTRAINT played_pkey PRIMARY KEY (play_id);


--
-- TOC entry 2080 (class 2606 OID 16548)
-- Name: played played_song_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY played
    ADD CONSTRAINT played_song_id_key UNIQUE (song_id);


--
-- TOC entry 2066 (class 2606 OID 16421)
-- Name: songs song_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY songs
    ADD CONSTRAINT song_id PRIMARY KEY (song_id);


--
-- TOC entry 2068 (class 2606 OID 16537)
-- Name: songs songs_url_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY songs
    ADD CONSTRAINT songs_url_key UNIQUE (url);


--
-- TOC entry 2070 (class 2606 OID 16416)
-- Name: users user_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT user_id PRIMARY KEY (user_id);


--
-- TOC entry 2072 (class 2606 OID 16514)
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- TOC entry 2076 (class 2606 OID 16435)
-- Name: votes vote_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT vote_id PRIMARY KEY (vote_id);


--
-- TOC entry 2073 (class 1259 OID 16441)
-- Name: fki_song_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_song_id ON votes USING btree (song_id);


--
-- TOC entry 2064 (class 1259 OID 16427)
-- Name: fki_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_user_id ON songs USING btree (user_id);


--
-- TOC entry 2074 (class 1259 OID 16452)
-- Name: fki_user_id2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_user_id2 ON votes USING btree (user_id);


--
-- TOC entry 2084 (class 2606 OID 16549)
-- Name: played played_song_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY played
    ADD CONSTRAINT played_song_id_fkey FOREIGN KEY (song_id) REFERENCES songs(song_id);


--
-- TOC entry 2082 (class 2606 OID 16436)
-- Name: votes song_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT song_id FOREIGN KEY (song_id) REFERENCES songs(song_id);


--
-- TOC entry 2081 (class 2606 OID 16422)
-- Name: songs user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY songs
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 2083 (class 2606 OID 16447)
-- Name: votes user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-10-29 10:19:48 GMT

--
-- PostgreSQL database dump complete
--
