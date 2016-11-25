package com.example.kormick.vlavashe_client.DataBase;

import android.os.Parcel;
import android.os.Parcelable;

import com.example.kormick.vlavashe_client.Shawarma.ShawarmaInfo;
import com.google.android.gms.maps.model.LatLng;

/**
 * Created by Kormick on 25-Nov-16.
 */

public class ShawarmaDataBase implements Parcelable {
    public ShawarmaDataBase() {}

    protected ShawarmaDataBase(Parcel in) {
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
    }

    @Override
    public int describeContents() {
        return 0;
    }

    public static final Creator<ShawarmaDataBase> CREATOR = new Creator<ShawarmaDataBase>() {
        @Override
        public ShawarmaDataBase createFromParcel(Parcel in) {
            return new ShawarmaDataBase(in);
        }

        @Override
        public ShawarmaDataBase[] newArray(int size) {
            return new ShawarmaDataBase[size];
        }
    };

    public ShawarmaInfo getShawarmaInfo(LatLng coords) {
        // TODO request to remote db
        return new ShawarmaInfo(coords, "SomeShawa");
    }
}
