# 🐧 Linux Task 1
## File System & User Management Commands

### 📁 Question 1: Understanding /etc/passwd File
**Task**: Read and extract user information from /etc/passwd  
**Format**: `username:x:UID:GID:description:home_directory:login_shell`  
**Command**:
```bash
grep $USER /etc/passwd
```

### 📄 Question 2: File Display Commands Comparison
**Task**: Compare cat and more commands
| Command | Function |
|---------|----------|
| `cat` | Displays entire file content at once |
| `more` | Displays content screen by screen with scrolling capability |

### 🗑️ Question 3: Directory Removal Commands
**Task**: Compare rm and rmdir using man pages
| Command | Purpose |
|---------|----------|
| `rm` | Removes files or directories  |
| `rmdir` | Removes only empty directories |

### 📂 Question 4: Directory Hierarchy Management
**Task**: Create and manipulate directory structure

1. Creating hierarchy:
```bash
mkdir -p dir1/dir11 dir1/dir12
```

2. Removing dir11:
- Initial attempt: `rmdir dir1/dir11` ❌
  - Error: Directory not empty
- Solution: `rm -r dir1/dir11` ✅

3. Removing dir12:
```bash
rmdir -p dir1/dir12
```
**Note**: This command removes the entire path recursively

### 📋 Question 5: File Copy Operation
**Task**: Copy passwd file to home directory
```bash
cp /etc/passwd ~/mypasswd
```

### ✏️ Question 6: File Rename Operation
**Task**: Rename mypasswd to oldpasswd
```bash
mv ~/mypasswd ~/oldpasswd
```

### 🔍 Question 7: Listing Specific Commands
**Task**: List commands starting with 'w' in /usr/bin
```bash
ls /usr/bin/w*
```

### 👀 Question 8: View File Beginning
**Task**: Show first 4 lines of /etc/passwd
```bash
head -n 4 /etc/passwd
```

### 📑 Question 9: View File Ending
**Task**: Display last 7 lines of /etc/passwd
```bash
tail -n 7 /etc/passwd
```

### 👥 Question 10: Current User Sessions
**Task**: Display currently logged-in users
```bash
who
```

### 📚 Question 11: Manual Pages Navigation
**Task**: Display man pages for passwd command and file
```bash
man passwd; man 5 passwd
```

### 📖 Question 12: Specific Manual Page
**Task**: Display passwd file manual
```bash
man 5 passwd
```

### 🔎 Question 13: Manual Page Keyword Search
**Task**: List commands with 'passwd' in their man pages
```bash
apropos passwd
```

## 🎯 Summary of Key Concepts
- File system navigation and manipulation
- User management and information retrieval
- Directory creation and removal
- File operations (copy, rename)
- Command documentation and manual pages
- Text file viewing and manipulation

---
*Note: All commands were tested in a Linux environment and follow standard Unix/Linux conventions.*