package com.dynamsoft.helloworld;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import androidx.appcompat.app.AppCompatActivity;
import com.dynamsoft.dce.CameraEnhancer;
import com.dynamsoft.dce.CameraEnhancerException;
import com.dynamsoft.dce.DCECameraView;
import com.dynamsoft.dce.DCEFrame;
import com.dynamsoft.dce.DCEFrameListener;
import com.dynamsoft.dce.DCELicenseVerificationListener;

public class MainActivity extends AppCompatActivity {
    DCECameraView cameraView;
    CameraEnhancer mCameraEnhancer;
    Button btnCapture;
    Boolean needCapture = false;
    static DCEFrame mFrame;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Initialize the camera view for previewing video.
        cameraView = findViewById(R.id.cameraView);

        // Add a button to capture frame.
        btnCapture = findViewById(R.id.btn_capture);

        // Initialize license.
        // The string "DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9" here is a 7-day free license. Note that network connection is required for this license to work.
        // You can also request a 30-day trial license in the customer portal: https://www.dynamsoft.com/customer/license/trialLicense?product=dce&utm_source=github&package=android
        CameraEnhancer.initLicense("DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9", new DCELicenseVerificationListener() {
            @Override
            public void DCELicenseVerificationCallback(boolean isSuccess, Exception e) {
                if (!isSuccess) {
                    e.printStackTrace();
                }
            }
        });

        // Create an instance of Dynamsoft Camera Enhancer.
        mCameraEnhancer = new CameraEnhancer(MainActivity.this);

        // Bind the camera view to the Camera Enhancer object.
        mCameraEnhancer.setCameraView(cameraView);

        // Add a frame listener to acquire the latest frame from video streaming.
        mCameraEnhancer.addListener(new DCEFrameListener() {
            @Override
            public void frameOutputCallback(DCEFrame frame, long nowTime) {
                if(needCapture){
                    needCapture = false;

                    // Capture a frame, display it in the image view of the other activity.
                    mFrame = frame;
                    Intent intent = new Intent(MainActivity.this,ShowPictureActivity.class);
                    startActivity(intent);
                }
            }
        });

        btnCapture.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                // Here we just set a flag, the actual capture action will be executed in the `frameOutputCallback`
                needCapture = true;
            }
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