# Covid Safety App

## Overview
The **Covid Safety** app is designed to guide individuals infected by the coronavirus (COVID-19) and monitor their health status during their quarantine period. The app provides daily questionnaires to assess symptoms such as fever and breathing difficulty, offering personalized guidance, reassurance, and recommendations based on the patient's health status.

The app helps individuals determine if their condition is safe or if medical attention is necessary, offering features such as access to the nearest hospitals and emergency call options. It also includes a coronavirus test for initial screening, an option to create an account, and a daily tracker for managing medications and quarantine procedures.

## Features
### 1. **Initial COVID-19 Test**
- The app offers an initial COVID-19 test to help users determine whether they are infected with the virus.
- Based on the result, users can decide to create an account for further guidance during their quarantine.

### 2. **Daily Health Questionnaire**
- Users are prompted to complete a daily health questionnaire, assessing symptoms like fever, loss of taste and smell, temperature, and oxygen levels.
- The questionnaire helps track the patient's health status and provides real-time feedback:
  - **Safe**: The app reassures the user.
  - **Not Safe**: Alerts the user to seek medical help, with directions to the nearest hospitals and the option for emergency calls.

### 3. **Medicine Management**
- The app allows users to log their medications and set alarms for timely reminders.
- Provides an easy-to-use interface to track the medication schedule, ensuring adherence to prescribed treatments.

### 4. **COVID-19 Tips & FAQs**
- The app offers useful tips and answers to frequently asked questions to help users navigate their sickness with more information and less anxiety.

### 5. **Hospital Locator**
- If the user shows moderate or severe symptoms, the app uses the user's location to provide a map showing the nearest hospitals.
- In case of severe symptoms, the app facilitates emergency calls.

## Project Aim & Objectives
The **Covid Safety** app aims to reduce the anxiety of people infected with COVID-19 by providing a sense of security and reliable guidance through their quarantine period. The project focuses on:
- Tracking the patient's health status daily.
- Offering personalized recommendations based on health conditions.
- Enabling users to manage their medications with timely reminders.
- Providing easy access to emergency services, hospital locations, and FAQs.

## App Screenshots

### Figure 11: **Sign In & Sign Up**
This is the intro screen where users can sign in to an existing account, sign up for a new account, take the coronavirus test, or view the FAQs.

![Figure 11: Sign In & Sign Up](https://github.com/user-attachments/assets/1655c7c6-9596-4f61-8113-600acd9c1d4f)

### Figure 12: **Dashboard**
The dashboard is the main interface where patients can access all the app's features and services. This is the primary screen for user interaction.

![Figure 12: Dashboard](path/to/image12.png)

### Figure 13: **Fever Symptom Question**
Users are asked about fever during the coronavirus test to help assess if they exhibit common symptoms.

![Figure 13: Fever](path/to/image13.png)

### Figure 14: **Loss of Taste and Smell**
This screen asks users about the common symptom of losing their sense of taste and smell, helping to evaluate if COVID-19 might be present.

![Figure 14: Loss of Taste and Smell](path/to/image14.png)

### Figure 15: **Temperature and Oxygen Levels**
The app prompts users to input their temperature and oxygen levels daily to monitor their health status.

![Figure 15: Temperature and Oxygen Levels](path/to/image15.png)

### Figure 16: **Breathing Monitoring**
A daily questionnaire asks users about their breathing to assess respiratory health, an important indicator for COVID-19 patients.

![Figure 16: Breathing](path/to/image16.png)

### Figure 17: **My Medic**
This section allows users to log their medications and set reminders for taking them.

![Figure 17: My Medic](path/to/image17.png)

### Figure 18: **COVID-19 Tips**
The app provides helpful tips and recommendations for managing symptoms and staying healthy during quarantine.

![Figure 18: COVID-19 Tips](path/to/image18.png)

### Figure 19: **Hospital Locator**
If the questionnaire indicates moderate or severe symptoms, the app provides a map to show the nearest hospitals.

![Figure 19: Hospital Locator](path/to/image19.png)

### Figure 20: **Emergency Call**
If a user has severe symptoms and cannot reach the hospital, the app provides the option to call for emergency help.

![Figure 20: Emergency Call](path/to/image20.png)

## Technologies Used
- **Flutter**: Cross-platform framework for building the app.
- **Google Maps API**: For locating nearby hospitals.
- **Firebase**: For user authentication, data storage, and notifications.
- **Local Notifications**: For medication reminders.

## Installation
Clone the repository and run the following commands to set up the app on your local machine:

```bash
git clone https://github.com/yourusername/covid-safety-app.git
cd covid-safety-app
flutter pub get
flutter run
