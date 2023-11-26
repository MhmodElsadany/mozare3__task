// Retrofit interface
package com.example.mozare3_task.movie_service

import retrofit2.Response
import retrofit2.http.GET

interface MovieApi {

    @GET("3/discover/movie?api_key=7826714bce33155200adb2a059306594")
    suspend fun getMoviess( ): Response<MovieList>
}