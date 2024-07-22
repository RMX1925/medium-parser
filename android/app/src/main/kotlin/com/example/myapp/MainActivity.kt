package com.example.myapp

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() 
// {
//     override fun onCreate(savedInstanceState: Bundle?) {
//         super.onCreate(savedInstanceState)
//         handleIntent(intent)
//     }
// 
//     override fun onNewIntent(intent: Intent) {
//         super.onNewIntent(intent)
//         handleIntent(intent)
//     }
// 
//     private fun handleIntent(intent: Intent) {
//         val action = intent.action
//         val data: Uri? = intent.data
// 
//         if (Intent.ACTION_VIEW == action && data != null) {
//             // Get the URL and pass it to Flutter
//             val url = data.toString()
//             flutterEngine?.navigationChannel?.pushRoute(url)
//         } else if (Intent.ACTION_SEND == action && intent.type == "text/plain") {
//             val sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
//             if(sharedText != null) {
//                 flutterEngine?.navigationChannel?.pushRoute(sharedText)
//             }
//         }
//     }
// 
//     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//         GeneratedPluginRegistrant.registerWith(flutterEngine)
//     }
// }
