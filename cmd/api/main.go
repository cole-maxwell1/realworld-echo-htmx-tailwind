package main

import (
	"fmt"
	"github.com/cole-maxwell1/realworld-echo-htmx-tailwind/internal/server"
)

func main() {

	server := server.NewServer()

	err := server.ListenAndServe()
	if err != nil {
		panic(fmt.Sprintf("cannot start server: %s", err))
	}
}
