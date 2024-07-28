# GptLogBase

### **Welcome to the GptLogBase Repository!**

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Acknowledgements](#acknowledgements)
- [License](#license)
- [Contact](#contact)


## Introduction

GptLogBase is a simple shell script designed to help you manually log and organize your conversations with GPT. The script creates a Markdown file, allowing you to easily copy and paste your message pairs (input and output) for record-keeping. This tool is particularly useful for those who want to maintain a structured archive of their interactions without violating any terms of service that prohibit automated content extraction.

The script offers various options, including setting the number of interaction records, customizing the conversation title, and specifying an output file path. You can also include a personal link to the conversation and append a utilities section to the output file for added functionality.

By using GptLogBase, you can ensure your important GPT conversations are well-documented and easily accessible in a neat and organized format.

## Usage

1. **Basic usage with default settings:**
   ```bash
   ./GptLogBase.sh
   ```

2. **Specify the number of interaction records (i.e. QA message pairs) and a custom title:**
   ```bash
   ./GptLogBase.sh -i 5 -t "My GPT Conversation"
   ```

3. **Specify an output file path and include a conversation link:**
   ```bash
   ./GptLogBase.sh -o /path/to/output.md -l "https://example.com/conversation"
   ```

4. **Include the utilities section in the output file:**
   ```bash
   ./GptLogBase.sh -u
   ```

## Acknowledgements
- **ChatGPT:** Powered by OpenAI, specifically ChatGPT-4. Files in this project vary from between being Content that is completely AI generated to being completely human-generated. The term Content, and other relevant definitions, can be observed on [The OpenAI TOS page](https://openai.com/policies/terms-of-use#using-our-services).

## License
This project is licensed under the [MIT LICENSE](LICENSE) - see the file for details.

## Contact
Axel Gauti Guðmunds Fanneyjar - [@axelgauti](https://twitter.com/axelgauti) - axel@axelgauti.is