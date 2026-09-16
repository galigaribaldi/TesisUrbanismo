--
-- PostgreSQL database dump
--

\restrict GyAlDf9FQQe3kjqb3rr2Jkfb0ZfHbMobExEERrZfqtOdu0GbaLxYStP2iwHhavw

-- Dumped from database version 15.8 (Debian 15.8-1.pgdg110+1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

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

--
-- Data for Name: lineas; Type: TABLE DATA; Schema: public; Owner: admin_apimetro
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.lineas DISABLE TRIGGER ALL;

INSERT INTO public.lineas VALUES (1200, 'Mexibús Línea 1', 'MEXIBÚS', NULL, NULL, NULL, 17.4922072721187, true, NULL, NULL, NULL, NULL, '1', 'existente', 'masivo_mediano', 'confinado', 160);
INSERT INTO public.lineas VALUES (1201, 'Mexicable Línea 1', 'MEXICABLE', NULL, NULL, NULL, 4.87675932532183, true, NULL, NULL, NULL, NULL, '1', 'existente', 'masivo_mediano', 'exclusivo', 10);
INSERT INTO public.lineas VALUES (1203, 'Mexibús Línea 2', 'MEXIBÚS', NULL, NULL, NULL, 22.6975233115342, true, NULL, NULL, NULL, NULL, '2', 'existente', 'masivo_mediano', 'confinado', 160);
INSERT INTO public.lineas VALUES (1204, 'Mexibús Línea 4', 'MEXIBÚS', NULL, NULL, NULL, 26.136464320219, true, NULL, NULL, NULL, NULL, '4', 'existente', 'masivo_mediano', 'confinado', 160);
INSERT INTO public.lineas VALUES (1205, 'Mexibús Línea 01', 'MEXIBÚS', NULL, NULL, NULL, 21.0644177279656, true, NULL, NULL, NULL, NULL, '01', 'existente', 'masivo_mediano', 'confinado', 160);
INSERT INTO public.lineas VALUES (1202, 'Mexibús Línea 3', 'MEXIBÚS', NULL, NULL, NULL, 22.5479513821731, true, NULL, NULL, NULL, NULL, '3', 'existente', 'masivo_mediano', 'confinado', 160);
INSERT INTO public.lineas VALUES (1206, 'Mexibús Línea 2A', 'MEXIBÚS', NULL, NULL, NULL, 17.2038605856222, true, NULL, NULL, NULL, NULL, '2A', 'existente', 'masivo_mediano', 'confinado', 160);
INSERT INTO public.lineas VALUES (1207, 'Mexicable Línea 2', 'MEXICABLE', NULL, NULL, NULL, 8.19656209047072, true, NULL, NULL, NULL, NULL, '2', 'existente', 'masivo_mediano', 'exclusivo', 10);