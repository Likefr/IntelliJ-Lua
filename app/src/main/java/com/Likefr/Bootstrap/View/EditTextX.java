package com.Likefr.Bootstrap.View;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.Gravity;
import android.widget.EditText;
import androidx.annotation.NonNull;
import com.Likefr.Bootstrap.View.api.attributes.BootstrapBrand;
import com.Likefr.Bootstrap.View.api.defaults.DefaultBootstrapBrand;
import com.Likefr.Bootstrap.View.api.defaults.DefaultBootstrapSize;
import com.Likefr.Bootstrap.View.api.view.BootstrapBrandView;
import com.Likefr.Bootstrap.View.api.view.BootstrapSizeView;
import com.Likefr.Bootstrap.View.api.view.RoundableView;
import com.Likefr.Bootstrap.View.utils.DimenUtils;
import com.Likefr.Bootstrap.View.utils.ViewUtils;
import com.Likefr.LuaJava.R;

import java.io.Serializable;

/**
 * BootstrapEditText allows users to enter values like a regular Android EditText, and allows coloring
 * via BootstrapBrand, and rounding of its background.
 */
public class EditTextX extends EditText implements BootstrapBrandView, RoundableView,
        BootstrapSizeView {

    private static final String TAG = "com.Likefr.Bootstrap.View.BootstrapEditText";

    private float baselineFontSize;
    private float baselineVertPadding;
    private float baselineHoriPadding;
    private float baselineStrokeWidth;
    private float baselineCornerRadius;

    private BootstrapBrand bootstrapBrand;
    private float bootstrapSize;
    private boolean rounded;

    public EditTextX(Context context) {
        super(context);
        initialise(null);
    }

    public EditTextX(Context context, AttributeSet attrs) {
        super(context, attrs);
        initialise(attrs);
    }

    public EditTextX(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        initialise(attrs);
    }

    private void initialise(AttributeSet attrs) {
        TypedArray a = getContext().obtainStyledAttributes(attrs, R.styleable.EditTextX);

        try {
            this.rounded = a.getBoolean(R.styleable.EditTextX_roundedCorners, false);

            int typeOrdinal = a.getInt(R.styleable.EditTextX_bootstrapBrand, -1);
            int sizeOrdinal = a.getInt(R.styleable.EditTextX_bootstrapSize, -1);

            this.bootstrapBrand = DefaultBootstrapBrand.fromAttributeValue(typeOrdinal);
            this.bootstrapSize = DefaultBootstrapSize.fromAttributeValue(sizeOrdinal).scaleFactor();
        }
        finally {
            a.recycle();
        }

        baselineFontSize = DimenUtils.pixelsFromSpResource(getContext(), R.dimen.bootstrap_edit_text_default_font_size);
        baselineVertPadding = DimenUtils.pixelsFromDpResource(getContext(), R.dimen.bootstrap_edit_text_vert_padding);
        baselineHoriPadding = DimenUtils.pixelsFromDpResource(getContext(), R.dimen.bootstrap_edit_text_hori_padding);
        baselineStrokeWidth = DimenUtils.pixelsFromDpResource(getContext(), R.dimen.bootstrap_edit_text_edge_width);
        baselineCornerRadius = DimenUtils.pixelsFromDpResource(getContext(), R.dimen.bootstrap_edit_text_corner_radius);

        a = getContext().obtainStyledAttributes(attrs, new int[] {android.R.attr.gravity});
        try {
            setGravity(a.getInt(0, Gravity.CENTER_VERTICAL)); // center text vertically by default
        } finally {
            a.recycle();
        }
        updateBootstrapState();
        invalidate();
    }

    @Override public Parcelable onSaveInstanceState() {
        Bundle bundle = new Bundle();
        bundle.putParcelable(TAG, super.onSaveInstanceState());
        bundle.putBoolean(RoundableView.KEY, rounded);
        bundle.putFloat(BootstrapSizeView.KEY, bootstrapSize);
        bundle.putSerializable(BootstrapBrand.KEY, bootstrapBrand);
        return bundle;
    }

    @Override public void onRestoreInstanceState(Parcelable state) {
        if (state instanceof Bundle) {
            Bundle bundle = (Bundle) state;
            this.rounded = bundle.getBoolean(RoundableView.KEY);
            this.bootstrapSize = bundle.getFloat(BootstrapSizeView.KEY);

            Serializable brand = bundle.getSerializable(BootstrapBrand.KEY);

            if (brand instanceof BootstrapBrand) {
                bootstrapBrand = (BootstrapBrand) brand;
            }
            state = bundle.getParcelable(TAG);
        }
        super.onRestoreInstanceState(state);
        updateBootstrapState();
    }

    private void updateBootstrapState() {
        int vPadding = (int) (baselineVertPadding * bootstrapSize);
        int hPadding = (int) (baselineHoriPadding * bootstrapSize);
        setPadding(vPadding, hPadding, vPadding, hPadding);

        int strokeWidth = (int) (baselineStrokeWidth * bootstrapSize);
        float cornerRadius = baselineCornerRadius * bootstrapSize;

        final float fontSize = baselineFontSize * bootstrapSize;
        setTextSize(fontSize);

        Drawable bg = BootstrapDrawableFactory.bootstrapEditText(
                getContext(),
                bootstrapBrand,
                strokeWidth,
                cornerRadius,
                rounded);

        ViewUtils.setBackgroundDrawable(this, bg);
    }

    /*
     * Getters/Setters
     */

    @Override public void setBootstrapBrand(@NonNull BootstrapBrand bootstrapBrand) {
        this.bootstrapBrand = bootstrapBrand;
        updateBootstrapState();
    }

    @NonNull @Override public BootstrapBrand getBootstrapBrand() {
        return bootstrapBrand;
    }

    @Override public void setRounded(boolean rounded) {
        this.rounded = rounded;
        updateBootstrapState();
    }

    @Override public boolean isRounded() {
        return rounded;
    }

    @Override public float getBootstrapSize() {
        return bootstrapSize;
    }

    @Override public void setBootstrapSize(float bootstrapSize) {
        this.bootstrapSize = bootstrapSize;
        updateBootstrapState();
    }

    @Override public void setBootstrapSize(DefaultBootstrapSize bootstrapSize) {
        setBootstrapSize(bootstrapSize.scaleFactor());
    }

}
