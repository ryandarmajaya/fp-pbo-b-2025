### 🚀 Running the Project

1. **Clone the Repository into Apache Tomcat's `webapps` Folder**

```bash
cd "C:/Program Files/Apache Software Foundation/Tomcat 9.0/webapps"
git clone <your-repo-url>
```

This allows Tomcat to automatically detect and deploy the application.

---

2. **Start MySQL Server**

You can use:
- **XAMPP** → Start the *MySQL* module  
- **Laragon** → Start *MySQL/MariaDB* service  

Make sure the database is imported and configured correctly.

---

3. **Start Apache Tomcat**

Start the Tomcat service through:
- `services.msc`  
- Windows Service Manager  
- Tomcat Monitor  
- Or your IDE (Eclipse/IntelliJ)  

Once Tomcat is running, access the app at:

```
http://localhost:8080/<project-folder-name>/
```

---

NB: Use user `admin` password `admin` to access all feature
