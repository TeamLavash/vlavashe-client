package com.example.kormick.vlavashe_client;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.example.kormick.vlavashe_client.DataBase.ShawarmaDataBase;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        TextView versionView = (TextView)findViewById(R.id.versionTextView);
        versionView.setText(Version.version);

        dBase = new ShawarmaDataBase();

        Button mapButton = (Button)findViewById(R.id.mapButton);
        mapButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getApplicationContext(), MapsActivity.class);
                intent.putExtra("db", dBase);
                startActivity(intent);
            }
        });
    }

    private ShawarmaDataBase dBase;
}
