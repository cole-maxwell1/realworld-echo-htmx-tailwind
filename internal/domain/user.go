package domain

import "time"

type NewUserRequest struct {
	Username string `json:"username"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

type UserLoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type UserResponse struct {
	User struct {
		Username string `json:"username"`
		Email    string `json:"email"`
		Bio      string `json:"bio"`
		Image    string `json:"image"`
		Token    string `json:"token"`
	} `json:"user"`
}

type User struct {
	Id        int
	Username  string
	Email     string
	Password  string
	Bio       string
	Image     string
	CreatedAt time.Time
	UpdatedAt time.Time
}

type UserService interface {
	Register(user NewUserRequest) (UserResponse, error)
}

type UserRepository interface {
	WriteNewUser(user User) error
}
