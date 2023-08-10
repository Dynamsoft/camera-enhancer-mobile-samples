package com.dynamsoft.helloworld;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

import com.dynamsoft.core.basic_structures.ImageData;
import com.dynamsoft.dce.CameraEnhancer;
import com.dynamsoft.dce.CameraEnhancerException;
import com.dynamsoft.dce.CameraView;
import com.dynamsoft.dce.utils.PermissionUtil;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    private CameraView cameraView;
    CameraEnhancer mCameraEnhancer;
    Button btnCapture;
    Boolean needCapture = false;

    static ImageData imageData;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        PermissionUtil.requestCameraPermission(this);

        // Initialize the camera view for previewing video.
        cameraView = findViewById(R.id.cameraView);

        // Add a button to capture frame.
        btnCapture = findViewById(R.id.btn_capture);



        // Create an instance of Dynamsoft Camera Enhancer.
        mCameraEnhancer = new CameraEnhancer(cameraView, this);

        // Add a frame listener to acquire the latest frame from video streaming.
        mCameraEnhancer.addListener((frame, nowTime) -> {
            if(needCapture){
                needCapture = false;
                imageData = frame;
                // Capture a frame, display it in the image view of the other activity.
                Intent intent = new Intent(MainActivity.this,ShowPictureActivity.class);
                startActivity(intent);
            }
        });

        btnCapture.setOnClickListener(v -> {
            // Here we just set a flag, the actual capture action will be executed in the `frameOutputCallback`
            needCapture = true;
        });

    }

    @Override
    protected void onResume() {
        super.onResume();
        needCapture = false;
        try {
            // open the default camera.
            mCameraEnhancer.open();
        } catch (CameraEnhancerException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        try {
            // close the default camera.
            mCameraEnhancer.close();
        } catch (CameraEnhancerException e) {
            e.printStackTrace();
        }
    }

}