<h1 align="center">Ankle Arrival Back-end API</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000" />
  <a href="https://github.com/johnsonsirv/ankle-arrival-backend#readme" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" />
  </a>
  <a href="https://github.com/johnsonsirv/ankle-arrival-backend/graphs/commit-activity" target="_blank">
    <img alt="Maintenance" src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" />
  </a>
  <a href="https://github.com/johnsonsirv/ankle-arrival-backend/blob/master/LICENSE" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/github/license/johnsonsirv/ankle-arrival-backend" />
  </a>
  <a href="https://twitter.com/vokeugo" target="_blank">
    <img alt="Twitter: vokeugo" src="https://img.shields.io/twitter/follow/vokeugo.svg?style=social" />
  </a>
</p>

<br>

<p>
  <b>Ankle Arrival</b> - Connects sports athletes to physiotherapists and provides an instant diagnosis to sports-related injuries using Artificial Intelligence.

<b>Ankle Arrival</b> runs on a RESTful back-end API that support basic functionalities such as:
</p>

- Users can signup / signin
- Users can view a list of doctors
- Users can book appointment with a doctor
- Users can take **Free Checkup** using the instant diagnosis AI

Ankle Arrival API is hosted on [Heroku](https://heroku.com) and can be tested using [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en) or [Swagger UI](https://anklearrival.herokuapp.com/api-docs/index.html) or any other REST client tool.

### Live URL: https://anklearrival.herokuapp.com

<a href="https://anklearrival.herokuapp.com/api-docs/index.html" target="_blank">
    <img alt="ankle-arrival" src="https://github.com/johnsonsirv/ankle-arrival-backend/blob/ouath/docs/ankle-arrival.png" />
</a>

### Future implementations:

- Add support for Doctors (Physiotherapists) to SignUp and add thier schedules or confirm appointments
- Use Calendly API for easy scheduling of appointments
- Add support to cancel appointments

### Built with:

- Ruby 2.4.0
- Rails 5.2
- PostgreSQL
- JWT
- Heroku
- RSwag
- RSpec

### Installation

##### Clone this repository from your terminal

> `git clone https://github.com/johnsonsirv/ankle-arrival-backend.git`

###### Database setup

in your terminal run

> `rake db:setup`
>
> `rake db:migrate db:test:prepare`

###### Run test suite

###### run integration level tests (request tests `spec/requests/api/v1/` using swagger documentation format)

in your terminal run

> `spec spec/requests/api/v1/ --format documentation --format Rswag::Specs::SwaggerFormatter`

###### run unit level tests (specs location `spec/models`)

in your terminal run

> `rspec spec/models`

### Usage

on your terminal run

> `rails server`

Visit `localhost://3000/api-docs/index.html`

### Contributor(s)

[Victor Okeugo](https://linkedin.com/in/victorokeugo/)

- Github: [@johnsonsirv](https://github.com/johnsonsirv)
- Twitter: [@vokeugo](https://twitter.com/@vokeugo/)
- Email: [okeugo.victor.c@gmail.com]()

### Contributing

1. Fork it (https://github.com/johnsonsirv/ankle-arrival-backend/fork)
2. Create your feature branch (git checkout -b feature/[choose-a-name])
3. Commit your changes (git commit -m 'What this commit will fix/add')
4. Push to the branch (git push origin feature/[chosen name])
5. Create a new Pull Request
   > You can also create [issues](https://github.com/johnsonsirv/ankle-arrival-backend/issues)

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE.md) file for details.