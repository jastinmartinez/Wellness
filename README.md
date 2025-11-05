# 🌿 Wellness Sessions App

A modern **iOS wellness app built with SwiftUI** that lets users browse, view details, and favorite sessions such as yoga, meditation, massage, and more.

![SwiftUI](https://img.shields.io/badge/SwiftUI-Ready-blue?logo=swift)
![iOS 16+](https://img.shields.io/badge/iOS-16%2B-lightgrey?logo=apple)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📱 Features

✅ Browse a list of wellness sessions  
✅ View detailed info (instructor, category, duration, date)  
✅ Mark/unmark sessions as favorites ❤️  
✅ Favorite counter in navigation bar  
✅ Local JSON or Remote API data source  
✅ Loading & error states  
✅ Smooth SwiftUI animations and accessibility support  

---

## 🧩 Architecture

**MVVM-style + Async/Await + SwiftUI**

- `WellnessSession` → Model  
- `WellnessViewModel` → ObservableObject managing data and state  
- `WellnessListView`, `WellnessSessionDetailView` UI  
- `LocalWellnessService` / `RemoteWellnessService` → Data access layer  

---

## ⚙️ Setup

### 1️⃣ Clone the repository

```bash
git clone https://github.com/jastinmartinez/Wellness.git
cd WellnessApp
