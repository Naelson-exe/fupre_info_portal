# Fupre Info Portal

![Fupre Info Portal Logo](app/assets/images/logo.png)

The Fupre Info Portal is a web application built to serve as a centralized source of information for the students and staff of the Federal University of Petroleum Resources, Effurun (FUPRE). It provides timely updates on news, events, and announcements within the university.

## Table of Contents

- [About The Project](#about-the-project)
- [Key Features](#key-features)
- [Built With](#built-with)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Running Tests](#running-tests)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## About The Project

This portal was developed to bridge the information gap within the FUPRE community. It ensures that students and staff have easy access to official information, reducing the spread of misinformation and keeping everyone informed about happenings in the university.

## Key Features

-   **News and Announcements:** View the latest news and announcements from the university management.
-   **Event Calendar:** Keep track of upcoming academic and social events.
-   **Search Functionality:** Easily search for specific information within the portal.
-   **Admin Dashboard:** A dedicated interface for administrators to manage content (posts and events).
-   **Responsive Design:** Accessible on both desktop and mobile devices.

## Built With

This project is built with the following technologies:

*   [Ruby on Rails](https://rubyonrails.org/)
*   [PostgreSQL](https://www.postgresql.org/)
*   [Hotwire](https://hotwired.dev/) (Turbo and Stimulus)
*   [SCSS](https://sass-lang.com/)
*   [RSpec](https://rspec.info/) for testing

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

Make sure you have the following installed on your system:

*   Ruby 3.1.2
*   Bundler
*   Node.js
*   Yarn
*   PostgreSQL

### Installation

1.  **Clone the repository**
    ```sh
    git clone https://github.com/Naelson-exe/fupre_info_portal.git
    cd fupre_info_portal
    ```

2.  **Install dependencies**
    ```sh
    bundle install
    yarn install
    ```

3.  **Set up the database**
    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4.  **Start the development server**
    ```sh
    rails server
    ```
    The application will be available at `http://localhost:3000`.

## Usage

-   The main application is accessible to the public.
-   To access the admin dashboard, navigate to `/admin` and log in with your admin credentials.
-   To create an admin user, run the following command and follow the prompts:
    ```sh
    rails admin:create
    ```

## Running Tests

To run the test suite, use the following command:

```bash
rspec
```

## Deployment

The application is configured for deployment on platforms like Heroku or any other service that supports Rails applications. Ensure you have set up the required environment variables for production, including `DATABASE_URL` and `RAILS_MASTER_KEY`.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## License

This project is licensed under the MIT License. See the `LICENSE` file for more information.

## Contact

Naelson - [@naelson_exe](https://twitter.com/naelson_senpai) - fubaranelson84@gmail.com

Project Link: [https://github.com/Naelson-exe/fupre_info_portal](https://github.com/Naelson-exe/fupre_info_portal)
