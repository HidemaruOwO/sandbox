package main

import (
	"log"

	"github.com/tucnak/store"
)

func init() {
	// You must init store with some truly unique path first!
	store.Init("cats-n-dogs/project-hotel")
}

type Cat struct {
	Name   string `toml:"naym"`
	Clever bool   `toml:"ayy"`
}

type Hotel struct {
	Name string
}

func main() {
	var hotel Hotel = Hotel{"hage"}

	if err := store.Load("hotel.toml", &hotel); err != nil {
		log.Println("failed to load the cat hotel:", err)
		return
	}

	// ...

	if err := store.Save("hotel.toml", &hotel); err != nil {
		log.Println("failed to save the cat hotel:", err)
		return
	}
}