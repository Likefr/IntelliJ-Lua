package com.Likefr.Bootstrap.View.api.view;

import com.Likefr.Bootstrap.View.BootstrapBadge;

/**
 * Classes which implement this interface can be used as BootstrapBadge container.
 * For example, a Button can be set up with BootstrapBadge.
 */
public interface BadgeContainerView extends BootstrapBadgeView {

    String KEY = "com.Likefr.Bootstrap.View.api.view.BadgeContainerView";

    /**
     * Sets the badge object to be used inside a container.
     *
     * @param badge BootstrapBadge to setup
     */
    void setBadge(BootstrapBadge badge);

    /**
     * Retrieves BootstrapBadge object from container view.
     *
     * @return BootstrapBadge if exist or null if not
     */
    BootstrapBadge getBootstrapBadge();

    /**
     * Method where badge display logic must be implemented
     *
     */
    void displayBadgeDrawable();
}
