package com.sakano.qr

import android.os.Bundle
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity
import com.squareup.picasso.Picasso
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET
import retrofit2.http.Query

interface ApiService {
    @GET("qr")
    suspend fun getQRCode(
        @Query("amount") amount: String,
        @Query("currency") currency: String,
        @Query("paymentReference") paymentReference: String
    ): QRResponse
}

data class QRResponse(val qrCode: String)

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val api = Retrofit.Builder()
            .baseUrl("https://your-api-gateway-url/")
            .client(OkHttpClient())
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)

        val qrImageView: ImageView = findViewById(R.id.qrImageView)

        // Fetch QR code (replace values as needed)
        lifecycleScope.launch {
            val response = api.getQRCode("100", "USD", "REF12345")
            Picasso.get().load(response.qrCode).into(qrImageView)
        }
    }
}
