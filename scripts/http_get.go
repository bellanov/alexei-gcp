package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {

	url := "https://therundown-therundown-v1.p.rapidapi.com/affiliates"

	req, _ := http.NewRequest("GET", url, nil)

	req.Header.Add("X-RapidAPI-Key", "SIGN-UP-FOR-KEY")
	req.Header.Add("X-RapidAPI-Host", "therundown-therundown-v1.p.rapidapi.com")

	res, _ := http.DefaultClient.Do(req)

	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	fmt.Println(res)
	fmt.Println(string(body))

}
