package main

import (
	"bytes"
	"fmt"
	"image"
	"image/color"
	"image/png"
	"io/ioutil"
	"os"
	"unicode/utf8"

	"github.com/golang/freetype/truetype"
	"golang.org/x/image/font"
	"golang.org/x/image/math/fixed"
)

func main() {
	// load font
	ftBinary, err := ioutil.ReadFile("./fonts/Koruri-Bold.ttf")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	ft, err := truetype.Parse(ftBinary)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	var imageWidth int = 1280
	var imageHeight int = 510
	text := "うんこマンですよ\nお前うんこマン"
	textLength := utf8.RuneCountInString(text)

	var fontsize float64

	if textLength <= 6 {
		fontsize = 150
	} else if textLength <= 10 {
		fontsize = 100
	} else if textLength <= 15 {
		fontsize = 70
	}
	fontsize = 100
	opt := truetype.Options{
		Size:              fontsize,
		DPI:               0,
		Hinting:           0,
		GlyphCacheEntries: 0,
		SubPixelsX:        0,
		SubPixelsY:        0,
	}

	img := image.NewRGBA(image.Rect(0, 0, imageWidth, imageHeight))

	face := truetype.NewFace(ft, &opt)

	dr := &font.Drawer{
		Dst:  img,
		Src:  image.NewUniform(color.RGBA{52, 52, 52, 255}),
		Face: face,
		Dot:  fixed.Point26_6{},
	}

	dr.Dot.X = (fixed.I(imageWidth) - dr.MeasureString(text)) / 2
	dr.Dot.Y = fixed.I(int(fontsize))

	dr.DrawString(text)

	buf := &bytes.Buffer{}
	err = png.Encode(buf, img)

	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	file, err := os.Create(`./images/char.png`)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	defer file.Close()

	file.Write(buf.Bytes())
}
