# Document Outline Extractor – Adobe India Hackathon Round 1A

### Overview
Our solution is a lightweight, offline-first PDF structure extractor built for **Round 1A – Understand Your Document** of the Adobe India Hackathon. It analyzes any PDF, identifies the document title and key headings (H1, H2, H3), and produces a clean, hierarchical JSON outline.

Designed for offline use and containerized via Docker, this system adheres to all performance and size constraints while enabling smarter document experiences such as semantic search, insight generation, and content mapping.

---

### Project Structure

The solution is organized as a standalone containerized service. Users place PDFs in an input folder and retrieve structured JSON outputs from an output folder.

```
/document-outline-extractor/
├── input/
│   └── sample.pdf
├── output/
│   └── sample.json
├── main.py
├── Dockerfile
├── requirements.txt
└── README.md
```

---

### Methodology

Our approach avoids brittle assumptions about document formatting and instead uses **rule-based heuristics** grounded in layout analysis.

**1. PDF Parsing:**
- We use `PyMuPDF` to extract raw text blocks along with positional data, font sizes, and weights.
- This allows for precise reading order reconstruction and formatting context.

**2. Heading Detection Heuristics:**
- **Font Weight & Size:** Larger, bold text likely indicates section titles.
- **Positional Cues:** Centered or widely spaced lines are treated as probable headers.
- **Text Patterns:** Lines with no punctuation and fewer words are prioritized.
- **Hierarchical Logic:** Font size relative to body text guides heading level (H1, H2, H3).

**3. Output Construction:**
- The title and headings are compiled into a structured JSON format specifying:
  - `title`: main document title
  - `outline`: list of headings with `level`, `text`, and `page_number`

---

### Sample Input & Output

**PDF Input:**  
A document containing titled sections and sub-sections.

**Expected Output:**
```json
{
  "title": "Application form for grant of LTC advance",
  "outline": [
    {
      "level": "H1",
      "text": "1. Name of the Government Servant",
      "page_number": 1
    },
    {
      "level": "H1",
      "text": "2. Designation",
      "page_number": 1
    }
  ]
}
```

---

### Libraries & Constraints

- **Language**: Python
- **Core Library**: `PyMuPDF (fitz)` – Fast, offline-capable PDF parser
- **No ML Models**: Fully rule-based and under 200MB
- **Runs Offline**: No external dependencies

---

### Running the Project (Dockerized)

#### 1. Build the Docker Image
```bash
docker build --platform linux/amd64 -t outline-extractor:latest .
```

#### 2. Create Input and Output Folders
```bash
mkdir input
mkdir output
```
Place your `.pdf` files in the `input/` directory.

#### 3. Run the Container
```bash
docker run --rm \
  -v "$(pwd)/input:/app/input" \
  -v "$(pwd)/output:/app/output" \
  --network none \
  outline-extractor:latest
```

The script will:
- Process all `.pdf` files in `/app/input`
- Output `.json` files in `/app/output`
- Exit automatically after processing

---

### Notes

- This project is **robust to formatting noise** in real-world documents.
- Designed as a plug-and-play service for larger document understanding pipelines.
- Tested across multiple document types with varying layouts.

---

### Authors

**Uthra Balakrishna and Vallabh S Ghantasala** 

---

### Acknowledgments

Thanks to **Adobe India** for organizing this insightful challenge that pushes the boundaries of document intelligence. Looking forward to what the next rounds bring!
