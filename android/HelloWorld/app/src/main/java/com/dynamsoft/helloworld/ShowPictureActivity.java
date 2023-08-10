package com.dynamsoft.helloworld;

import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import com.dynamsoft.core.basic_structures.CoreException;
import com.dynamsoft.core.basic_structures.ImageData;

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

		ImageData frame = MainActivity.imageData;

		// Convert to Bitmap from the captured frame.
		Bitmap bitmap = null;
		try {
			bitmap = frame.toBitmap();
		} catch (CoreException e) {
			e.printStackTrace();
		}

		// Display it in ImageView
		ivPicture.setImageBitmap(bitmap);
	}

}
