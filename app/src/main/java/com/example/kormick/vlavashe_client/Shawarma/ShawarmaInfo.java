package com.example.kormick.vlavashe_client.Shawarma;

import com.google.android.gms.maps.model.LatLng;

/**
 * Created by Kormick on 25-Nov-16.
 */

public class ShawarmaInfo {
    public ShawarmaInfo(LatLng _coords, String _name) {
        coords = _coords;
        name = _name;
    }

    public LatLng coords;
    public String name;
}
