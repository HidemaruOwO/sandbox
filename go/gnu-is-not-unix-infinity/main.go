package main

import (
	"fmt"
	"time"
)

func main() {
	message := "GNU is not unix"
	for {
		fmt.Println(message)
		message += " is not unix"
		time.Sleep(time.Millisecond * 100)
	}
}
