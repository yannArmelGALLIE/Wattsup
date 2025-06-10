
# ⚡ WattsUp

WattsUp is a real-time power consumption monitoring application.
It uses a microcontroller (ESP32) to collect data, a Django backend to store it, and a Flutter mobile app to display it.

---

## 🛠️ Built with

| Outil         | Badge                                       |
|--------------|---------------------------------------------|
| Last Commit    | ![Last Commit](https://img.shields.io/github/last-commit/yannArmelGALLIE/wattsup)|
| Markdown     | ![Markdown](https://img.shields.io/badge/Markdown-000000?logo=markdown) |
| Django       | ![Django](https://img.shields.io/badge/Django-092E20?logo=django&logoColor=white) |
| Python       | ![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white) |
| Flutter      | ![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white) |
| Dart      | ![Dart](https://img.shields.io/badge/Dart-02569B?logo=dart&logoColor=white) |
| Arduino      | ![Arduino](https://img.shields.io/badge/Arduino-00979D?logo=arduino&logoColor=white) |
| SQLite       | ![SQLite](https://img.shields.io/badge/SQLite-003B57?logo=sqlite&logoColor=white) |
| PostgreSQL       | ![SQLite](https://img.shields.io/badge/PostgreSQL-3776AB?logo=postgresql&logoColor=white) |
| Languages Count      | ![Languages Count](https://img.shields.io/github/languages/count/yannArmelGALLIE/wattsup) |


---

## 🧩 Project architecture
```
wattsup/
│
├── merchex/                     # Django Project (API REST)
│   ├── manage.py
│   ├── .env
│   ├── db.sqlite3
│   ├── merchex/                 # Main Django Project
│   │   ├── settings.py
│   │   ├── urls.py
│   │   └── ...
│   └── api/                     # Main App 
│       ├── models.py
│       ├── views.py
│       ├── serializers.py
│       └── ...
│
├── wattsup/           # Flutter Project
│   ├── android/
│   ├── ios/
│   ├── lib/
│   ├── pubspec.yaml
│   └── ...
│
├── requirements.txt
│
├── .gitignore
│
└── README.md                   
```
---

## 🚀 Installation

Build Wattsup from the source and install dependencies:

1. 📥 Clone the repository
```
git clone https://git@github.com:yannArmelGALLIE/Wattsup.git
```
2. 📂 Navigate to the project directory
```
cd Wattsup
```
3. 📂 Navigate to the backend directory
```
cd merchex
```
4. 📦 Create and activate virtual environment
```
python -m venv env
source env/Scripts/activate
```
5. 📚 Install the dependencies
```
pip install -r requirements.txt
```
6. 🔧 Apply migrations
```
python manage.py makemigrations
python manage.py migrate
```
7. 🏁 Run the development server
```
python manage.py runserver
```
8. 📂 Navigate to the project directory
```
cd ..
```
9. 📂 Navigate to the flutter app directory
```
cd wattsup
```
10. 🏁 Run the app
```
flutter run 
```
---

## 🧠 Key Features
* 🔌 Electrical readings (voltage, current, power)

* 👤 User management

* 📊 Data visualization

* 🌐 REST API for communicating with Flutter

* 📡 Arduino integration to capture measurements

---

## 👨‍💻 Authors
Yann-Armel GALLIE – [github](https://github.com/yannArmelGALLIE/)








