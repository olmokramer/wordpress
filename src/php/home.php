<?php

get_header();

if (have_posts()) {
	while (have_posts()) {
		the_post();

		// ...
	}
} else {
	// no posts to display
}

get_footer();

