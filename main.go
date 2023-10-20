package main

import (
    "log"
    "fmt"

    "github.com/gofiber/fiber/v2"

    controllers "self-hosted-gh-runner/controllers"
)

func main() {
    app := fiber.New()

    app.Get("/", controllers.HomeController)

    fmt.Println("Go Fiber starting HTTP server on port 3000..")
    log.Fatal(app.Listen(":3000"))
}