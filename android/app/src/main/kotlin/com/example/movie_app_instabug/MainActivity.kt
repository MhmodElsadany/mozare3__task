package com.example.mozare3_task

import io.flutter.embedding.android.FlutterActivity


import com.example.mozare3_task.movie_service.MovieApi
import com.example.mozare3_task.movie_service.RetrofitHelper
import com.example.mozare3_task.movie_service.Result

import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import android.util.Log


import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.google.gson.Gson
import kotlin.Exception

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor,
            "openNetworkChannel"
        ).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            if (call.method == "show") {

                    val moviesApi = RetrofitHelper.getInstance().create(MovieApi::class.java)
                    if (moviesApi != null) {
                        GlobalScope.launch {
                            try {
                                val data = moviesApi.getMoviess()
                                val movieslist: List<Result>? = data.body()?.results;
                                val jsonElements = Gson().toJsonTree(data.body())
                                result.success(jsonElements.toString())
                            }
                            catch (e: Exception) {
//                     e.printStackTrace();
                            }

                        }
                    }



            } else {
                result.notImplemented()
            }
        }


    }


}
