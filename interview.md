# 🌐 What Happens When You Type a URL in the Browser

Have you ever wondered about the complex journey that unfolds in milliseconds when you enter a simple URL? Let's follow the fascinating path from keystrokes to displayed webpage!

## 1. **URL Parsing: Breaking Down the Address**

When you type something like:
```
http://www.example.com
```

Your browser intelligently dissects this into components:
* **Protocol**: `http`
* **Domain**: `www.example.com`
* **Path**: `/` (the homepage)

## 2. **DNS Lookup: Finding the Digital Address** ✅

Your browser needs to translate that human-friendly domain into a machine-readable IP address.

It follows a clever lookup hierarchy:
* First, it checks its own cache memory
* Then, it checks your operating system's cache (Windows/Linux)
* If not found, it contacts a DNS server (your ISP's or public ones like Google's `8.8.8.8`)

This process converts `www.example.com` → `93.184.216.34`

## 3. **Establishing a TCP Connection** ✅

Now your browser needs to create a communication channel with the server:
* It initiates a **TCP connection** with the server on port 80 (for HTTP)
* This connection is established through the famous **3-way Handshake**:
   * Your device: 👋 (SYN - "Let's connect!")
   * Server: 👋👌 (SYN-ACK - "I hear you and agree!")
   * Your device: 👌 (ACK - "Connection confirmed!")

## 4. **HTTP Request: Asking for Content** ✅

Your browser sends a formal request to the server:

```
GET / HTTP/1.1
Host: www.example.com
```

This simple message says: "Please send me the homepage of www.example.com."

## 5. **Server Response: Delivering the Content** ✅

The server processes your request and replies:

```
HTTP/1.1 200 OK
Content-Type: text/html
<html>...</html>
```

The `200 OK` status means "request successful," and the server sends back the HTML code for the page.

## 6. **Rendering: Bringing the Page to Life** ✅

Your browser transforms code into the visual webpage through several steps:
* Constructs the page structure from HTML
* Downloads and applies CSS styling
* Loads and executes JavaScript
* Renders the complete page on your screen

## 7. **Mission Accomplished!** ✅

The webpage is now fully loaded and ready for you to interact with.

## Extra: HTTPS Connection 🔒

If the URL begins with HTTPS instead of HTTP:
* A **TLS Handshake** occurs first to establish a secure, encrypted connection
* This ensures all data exchanged between you and the server remains private and tamper-proof

## In a Nutshell 🧠

```
Type URL → DNS Lookup → IP Address → TCP Connection → HTTP Request → Server Response → HTML Rendered
```

This entire process typically happens in less than a second—a testament to the remarkable engineering behind modern web browsing!