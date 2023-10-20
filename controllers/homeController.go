package controllers

import (
    "github.com/gofiber/fiber/v2"
)

type HomeResponse struct {
	Msg string
  }

func HomeController(c *fiber.Ctx) error {
	res := HomeResponse{
		Msg: "self-hosted-gh-runner",
	}
	return c.JSON(res)
}