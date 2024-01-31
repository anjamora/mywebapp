# Django WebApp with Blog Feature

This is a simple Django web application featuring a blog. The application serves as a foundation for integrating DevOps tools. Additional features, including login and user profiles, will be incorporated in future updates. Explore, contribute, and stay tuned for enhancements!

## Getting Started

1. **Clone the repository.**
2. **Set up a virtual environment.**
3. **Install dependencies:** `pip install -r requirements.txt`.
4. **Run the development server:** `python manage.py runserver`.

Feel free to reach out for collaboration or contribute to the project's growth.

## GitHub Actions Workflow Overview

### Workflow Name: Django CI

This GitHub Actions workflow, "Django CI," automates Continuous Integration for the Django Blog WebApp project. It runs on code pushes to the `master` branch and pull requests targeting `master`.

### Build Job

Runs on Ubuntu-latest with parallel testing for Python 3.10.12.

1. **Checkout Code:** Fetches the latest code.
2. **Set up Python Environment:** Configures Python 3.10.12.
3. **Set up Environment Variables:** Creates `.env` with `SECRET_KEY`.
4. **Install Dependencies:** Upgrades pip and installs `requirements.txt`.
5. **Run Tests:** Executes Django tests.
6. **Build and Push Docker Image:** Uses Docker action to push `anjamora/projects` with Docker Hub credentials.

This workflow ensures consistent testing and Docker image preparation for the Django Blog WebApp. Keep GitHub Secrets secure for `SECRET_KEY` and Docker credentials.

## Update

I have deicded to work on each technology separetly for better organization and learning.
