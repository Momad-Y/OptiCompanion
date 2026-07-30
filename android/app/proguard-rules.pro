# tflite_v2 references the TensorFlow Lite GPU delegate even when it isn't
# used at runtime, which R8 flags as missing classes during minification.
-dontwarn org.tensorflow.**
-keep class org.tensorflow.** { *; }
-keep interface org.tensorflow.** { *; }
