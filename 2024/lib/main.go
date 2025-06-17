package lib

import (
	"bufio"
	"os"
	"strings"
	// "strings"
)

func ReadDataFile(fname string) (string, error) {
	file, err := os.Open(fname)
	if err != nil {
		return "", err
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	lines := ""
	for scanner.Scan() {
		lines += scanner.Text()
	}
	return lines, nil
}

// Reads file sections separated by empty line
func ReadSections(fname string) ([]string, error) {
	file, err := os.Open(fname)
	if err != nil {
		return []string{}, err
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	section := ""
	sections := []string{}
	for scanner.Scan() {
		line := scanner.Text()
		if strings.Trim(line, "\n\t ") == "" {
			sections = append(sections, strings.Trim(section, "\n"))
			section = ""
		} else {
			section += line + "\n"
		}
	}
	sections = append(sections, strings.Trim(section, "\n"))
	return sections, nil
}

func ReadLines(fname string) ([]string, error) {
	file, err := os.Open(fname)
	if err != nil {
		return []string{}, err
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	lines := []string{}
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, nil
}
