package main

import "net/http"

func handler(rw http.ResponseWriter, r *http.Request) {
	println("'" + r.URL.Path + "'")
	println("'" + r.URL.RawPath + "'")
	println("'" + r.URL.RawQuery + "'")
	for name, values := range r.Header {
		// Loop over all values for the name.
		for _, value := range values {
			println(name, value)
		}
	}
	rw.WriteHeader(200)
	rw.Write([]byte(`OK`))
	return
}

func main() {

	http.HandleFunc("/", handler)
	http.ListenAndServe("0.0.0.0:8080", nil)
}
