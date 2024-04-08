package main

import (
	"github.com/gofiber/fiber/v3"
)

func main() {
	app := fiber.New()
	//r.Use(
	//	gin.LoggerWithWriter(gin.DefaultWriter,  "/dev/null"),
	//	gin.Recovery(),
	//)
	app.Get("/test/", func(ctx fiber.Ctx) error {
		return ctx.Status(200).SendString("Status")

	})
	app.Listen(":8004") // listen and serve on 0.0.0.0:8004 (for windows "localhost:8004")
}
