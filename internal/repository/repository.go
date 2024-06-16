package repository

import (
	"github.com/cole-maxwell1/realworld-echo-htmx-tailwind/internal/domain"
)

// Defines the functionality each database implementation must provide 
type ConduitRepository interface {
	domain.UserRepository
}
