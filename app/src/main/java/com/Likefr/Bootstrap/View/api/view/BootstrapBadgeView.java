package com.Likefr.Bootstrap.View.api.view;


import androidx.annotation.Nullable;

public interface BootstrapBadgeView {

    /**
     * Retrieves the currently displayed badge text
     *
     * @return the badge text
     */
    @Nullable
    String getBadgeText();

    /**
     * Updates the badge to display a text string
     *
     * @param badgeText the badge text
     */
    void setBadgeText(@Nullable String badgeText);

}
