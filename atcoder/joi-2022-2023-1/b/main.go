package main

import (
	"fmt"
	"strconv"
)

func main() {
	var N int
	fmt.Scanf("%d", &N)
	var NStr string = strconv.Itoa(N)

	if !(10 <= N && N <= 99) {
		fmt.Println("値の範囲は10<= N <= 99です")
	} else {
		if NStr[0] == NStr[1] {
			fmt.Println("1")
		} else {
			fmt.Println("0")
		}
	}
}
