package main

import (
	"fmt"
	"net/http"

	"github.com/julienschmidt/httprouter"
)

func TestHandler(rw http.ResponseWriter, r *http.Request, p httprouter.Params) {
	http.Error(rw, "Success", http.StatusOK)
}

func main() {
	r := httprouter.New()
	r.GET("/test", TestHandler)
	fmt.Println("[+]Starting Server\n[+]Listening at :8007")
	http.ListenAndServe(":8007", r)
}
