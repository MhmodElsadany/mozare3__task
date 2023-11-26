package com.example.mozare3_task.movie_service

data class MovieList(
    val page: Int,
    val total_pages: Int,
    val total_results: Int,
    val results: List<Result>

)



data class Result(
    val id: Int,
    val backdrop_path: String,
    val original_language: String,
    val original_title: String,
    val poster_path: String,
    val release_date: String,
    val title: String,
    val video: Boolean,
    val vote_average: Double,
    val vote_count: Int,
    val overview: String
    )


