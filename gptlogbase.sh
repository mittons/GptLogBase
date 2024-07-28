#!/bin/bash

# Initialize default values
NUM_RECORDS=1
CONVERSATION_TITLE="Untitled Conversation"
OUTPUT_FILE="GPT_Record_$(date +%y%m%d_%Hh%Mm%Ss)__TITLEPLACEHOLDER.md"
CUSTOM_OUT_PATH=false
CONVERSATION_LINK="## \"No link has been provided.\""
LINK_PROVIDED=false
INCLUDE_TOOLS=false


# Usage message
usage() {
    echo "Usage: $0 [OPTIONS]..."
    echo "Optional Arguments:"
    echo "  -i, --interaction-records <num_records>       Number of interaction records (default is 1)"
	echo "  -t, --title <conversation_title>              Title for the conversation"
    echo "  -o, --output-file <output_file_path>          Path to output file (including filename)"
    echo "  -l, --conversation-link <conversation_link>   Conversation link"
    echo "  -u, --append-utlis-section                    Include utils section in the output"
    exit 1
}

# Define options
SHORT=i:t:o:l:u
LONG=interaction-records:,title:,output-file:,conversation-link:,append-utils-section:

# Parse the options
OPTIONS=$(getopt -a -n "$0" --options $SHORT --longoptions $LONG -- "$@")
VALID_ARGS=$?
if [ "$VALID_ARGS" != "0" ]; then
    usage
fi

eval set -- "$OPTIONS"
while true; do
    case "$1" in
        -i | --interaction-records)
            NUM_RECORDS="$2"
            shift 2
            ;;
        -t | --title)
            CONVERSATION_TITLE="$2"
            shift 2
            ;;			
        -o | --output-file)
            OUTPUT_FILE="$2"
			CUSTOM_OUT_PATH=true
            shift 2
            ;;
        -l | --conversation-link)
            CONVERSATION_LINK="$2"
			LINK_PROVIDED=true
            shift 2
            ;;
        -u | --append-utlis-section)
            INCLUDE_UTILS=true
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            usage
            break
            ;;
    esac
done

# Validate NUM_RECORDS to be a positive integer
if ! [[ "$NUM_RECORDS" =~ ^[1-9][0-9]*$ ]]; then
    echo "Error: --interaction-records (-ir) must be a positive integer."
    exit 1
fi

if [ "$CUSTOM_OUT_PATH" = false ]; then
    # Replace all spaces in CONVERSATION_TITLE with underscores
    MODIFIED_TITLE=$(echo "$CONVERSATION_TITLE" | sed 's/ /_/g')
    
    # Check for illegal file name characters
    if echo "$MODIFIED_TITLE" | grep -q "[\/:*?\"<>|]"; then
        echo "The conversation title contains illegal file name characters. Please avoid these characters: /:*?\"<>|"
        exit 1
    fi

    # Replace TITLEPLACEHOLDER in OUTPUT_FILE with the modified title
    OUTPUT_FILE=$(echo "$OUTPUT_FILE" | sed "s/TITLEPLACEHOLDER/$MODIFIED_TITLE/")
fi


# Generate the log file
{
echo "# **===ChatLog===**"
echo "---"

echo "### Conversation_title:"
echo ":label: ${CONVERSATION_TITLE}"
echo

echo "### Personal_link:"
if [ "$LINK_PROVIDED" = false ]; then
	echo ":sparkles: [Unavailable](${CONVERSATION_LINK})"
else
	echo ":sparkles: [Personal_link](${CONVERSATION_LINK})"
fi
echo

echo "### Interaction_Log_File_Creation_Date:"
echo ":calendar: $(date +%Y-%m-%d,\ %Hh%Mm%Ss)."
echo

echo "---"
echo 

for ((i=1; i<=NUM_RECORDS; i++)); do
    echo "# **User_question:**"
    echo
	echo
    echo "# **ChatGPT_answer:**"
    echo
	echo
done

if [ "$INCLUDE_UTILS" = true ]; then
    echo "<div style=\"page-break-after: always;\"></div>"
    echo
    echo "# Utils"
    echo
    echo "### Page-break"
    echo
    echo "<div style=\"page-break-after: always;\"></div>"
    echo
fi

} > "$OUTPUT_FILE"

echo "Generated file: $OUTPUT_FILE"
