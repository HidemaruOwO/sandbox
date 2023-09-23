package main

import (
	"fmt"
	"image"
	"os"

	"image/draw"
	"image/png"
)

func main() {

	originImagePath := "./images/ogp_back.png"
	logoImagePath := "./images/char.png"
	saveImagePath := "./synthetic.png"

	originFile, err := os.Open(originImagePath)
	if err != nil {
		fmt.Println(err)
	}
	logoFile, err := os.Open(logoImagePath)
	if err != nil {
		fmt.Println(err)
	}

	originImg, _, err := image.Decode(originFile)
	if err != nil {
		fmt.Println(err)
	}
	logoImg, _, err := image.Decode(logoFile)
	if err != nil {
		fmt.Println(err)
	}

	// 画像の左上のpixelの位置 w.h
	startPointLogo := image.Point{0, 330}

	logoRectangle := image.Rectangle{startPointLogo, startPointLogo.Add(logoImg.Bounds().Size())}
	originRectangle := image.Rectangle{image.Point{0, 0}, originImg.Bounds().Size()}

	rgba := image.NewRGBA(originRectangle)
	draw.Draw(rgba, originRectangle, originImg, image.Point{0, 0}, draw.Src)
	draw.Draw(rgba, logoRectangle, logoImg, image.Point{0, 0}, draw.Over)

	out, err := os.Create(saveImagePath)
	if err != nil {
		fmt.Println(err)
	}

	png.Encode(out, rgba)
}
