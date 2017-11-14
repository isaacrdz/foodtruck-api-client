//
//  Constants.swift
//  foodtruck-api.client
//
//  Created by Isaac Rodriguez on 11/13/17.
//  Copyright © 2017 Isaac Rodriguez. All rights reserved.
//

import Foundation

//Callbacks
//Typealias for callbacks used in DataService
typealias callback = (_ success: Bool) ->()

//Base URL
let BASE_API_URL = "http://localhost:3005/api/v1"

//GET all foodtrucks
let GET_ALL_FT_URL = "\(BASE_API_URL)/foodtruck"

//GET all  reviews for a specific foodtruck
let GET_ALL_FT_Reviews = "\(BASE_API_URL)/foodtruck/reviews"

//POST Add new FoodTruck
let POST_ADD_NEW_FOODTRUCK = "\(BASE_API_URL)/foodtruck/add"
//POST Add new review for an specific FoodTruck
let POST_ADD_NEW_REVIEW = "\(BASE_API_URL)/foodtruck/reviews/add"


//Boolean  auth UserDefaults keys
let DEFAULTS_REGISTERED = "isRegistered"
let DEFAULTS_AUTHENTICATED = "isAuthenticated"

//Auth Email
let DEFAULTS_EMAIL = "email"

//Auth Token
let DEFAULTS_TOKEN = "authToken"

//Register url
let POST_REGISTER_ACCOUNT = "\(BASE_API_URL)/account/register"
let POST_LOGIN_ACCOUNT = "\(BASE_API_URL)/account/login"






















