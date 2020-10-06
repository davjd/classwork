package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strings"
	"time"
)

// WinTargetNum : Number of wins required to win game.
const WinTargetNum = 3

var itemSelections = [3]string{"rock", "paper", "scissor"}

func isValidSelection(sel string) bool {
	for _, b := range itemSelections {
		if b == strings.ToLower(sel) {
			return true
		}
	}
	return false
}

func getRand(min, max int) int {
	// NOTE: Initialize seed before use.
	return rand.Intn(max-min+1) + min
}

func selectionToInt(sel string) int {
	switch strings.ToLower(sel) {
	case "rock", "r":
		return 0
	case "paper", "p":
		return 1
	case "scissor", "s":
		return 2
	default:
		return -1
	}
}

func main() {
	playerScore := 0
	cpuScore := 0
	rand.Seed(time.Now().UnixNano())
	reader := bufio.NewReader(os.Stdin)

	for {
		fmt.Print("\nEnter selection (rock, paper, scissor): ")
		userInput, _ := reader.ReadString('\n')
		userSelection := strings.TrimRight(userInput, "\n")
		if !isValidSelection(userSelection) {
			fmt.Printf("Please select a valid option (`rock`, `paper`, `scissor`.")
			continue
		}

		cpuSelection := itemSelections[getRand(0, 2)]
		fmt.Printf("cpu: %v\n", cpuSelection)

		if userSelection == "rock" && cpuSelection == "scissor" {
			fmt.Printf("%v beats %v, you win.", userSelection, cpuSelection)
			playerScore++
		} else if userSelection == "scissor" && cpuSelection == "rock" {
			fmt.Printf("%v beats %v, you lose.", cpuSelection, userSelection)
			cpuScore++
		} else if userSelection == cpuSelection {
			fmt.Printf("It's a tie, continue!")
		} else if selectionToInt(userSelection) > selectionToInt(cpuSelection) {
			fmt.Printf("%v beats %v, you win.", userSelection, cpuSelection)
			playerScore++
		} else {
			fmt.Printf("%v beats %v, you lose.", cpuSelection, userSelection)
			cpuScore++
		}

		if playerScore == WinTargetNum {
			fmt.Printf("\nYou won, congrats!\n")
			break
		} else if cpuScore == WinTargetNum {
			fmt.Printf("\nYou lost!\n")
			break
		}
	}
}
