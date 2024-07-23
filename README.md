# Medium Parser

The Medium Parser is a Flutter application designed to parse articles from Medium and extract relevant data such as the title, author, publication date, and content. This tool can be used for various purposes, including data analysis, content aggregation, and more.

## Features

- Extract article titles, authors, publication dates, and content from Medium.
- Handle multiple articles parsing.
- Efficiently process large amounts of data.
- User-friendly interface with Flutter.

## UI

<div style="display: flex; justify-content: space-around;">
    <img src="./images/homescreen.png" alt="Homescreen" width="200"/>
    <img src="./images/article.png" alt="Article" width="200"/>
</div>

## Installation

To install and run the Medium Parser, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/medium-parser.git
   cd medium-parser
   ```

2. **Install Flutter:**

   Make sure you have Flutter installed. If not, follow the instructions [here](https://flutter.dev/docs/get-started/install).

3. **Get dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the application:**

   ```bash
   flutter run
   ```

## Usage

1. **Add URLs:**

   - Open the app and enter the URLs of Medium articles you want to parse. Each URL should be added separately.

2. **Run the parser:**

   - Click the parse button to extract the data from the provided URLs.

3. **Output:**
   - The parsed data will be displayed in the app and can be saved or exported as needed.

## Configuration

The configuration of the Medium Parser can be modified in the app settings. You can adjust settings such as the output directory, logging level, and more.

## Contributing

We welcome contributions to improve the Medium Parser. If you have suggestions, bug reports, or want to contribute code, please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/YourFeature`
3. Commit your changes: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/YourFeature`
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Thanks to the Medium community for providing the content.
- Inspired by various web scraping and data parsing projects.

---

Happy Parsing!
