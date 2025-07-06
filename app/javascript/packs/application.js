// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import axios from 'axios'
import $ from 'jquery'

document.addEventListener('DOMContentLoaded', () => {
  $('.account_name').on('click', () => {
    window.alert('CLICKED')
  })
})