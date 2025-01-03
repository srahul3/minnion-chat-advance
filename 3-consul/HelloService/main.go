package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	// resp, err := http.Get("http://localhost:6060/response") // Static URL
	resp, err := http.Get("http://localhost:9090/response") // Static URL of sidecar proxy
	if err != nil {
		http.Error(w, "Failed to contact ResponseService", http.StatusInternalServerError)
		return
	}
	defer resp.Body.Close()

	response := make(map[string]interface{})
	json.NewDecoder(resp.Body).Decode(&response)

	response["message"] = "Hello from HelloService!"
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func main() {
	http.HandleFunc("/hello", helloHandler)
	http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	})
	fmt.Println("HelloService running on port 5050...")
	log.Fatal(http.ListenAndServe(":5050", nil))
}
