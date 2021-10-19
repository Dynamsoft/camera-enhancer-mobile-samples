package com.dynamsoft.helloworld;

import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import com.dynamsoft.dce.DCEFrame;

public class ShowPictureActivity extends AppCompatActivity {
    private Toolbar toolbar;
    ImageView ivPicture;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_show_picture);
        ivPicture = findViewById(R.id.iv_picture);

        toolbar = findViewById(R.id.toolbar);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });

        DCEFrame frame = MainActivity.mFrame;

        // Convert to Bitmap from the captured frame.
        Bitmap bitmap = frame.toBitmap();

        // Rotate it to the nature device orientation.
        bitmap = rotateBitmap(bitmap, frame.getOrientation());

        // Display it in ImageView
        ivPicture.setImageBitmap(bitmap);
    }

    private Bitmap rotateBitmap(Bitmap origin, float degree) {
        if (origin == null) {
            return null;
        }
        int width = origin.getWidth();
        int height = origin.getHeight();
        Matrix matrix = new Matrix();
        matrix.setRotate(degree);
        //if use the front camera, delete the above line of code and use the following two lines of code
        /*matrix.setRotate(-degree);
        matrix.postScale(-1,1);*/
        Bitmap newBM = Bitmap.createBitmap(origin, 0, 0, width, height, matrix, false);
        origin.recycle();
        return newBM;
    }

}
