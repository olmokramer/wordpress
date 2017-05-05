<?php

get_header();

if (have_posts()) {
	the_post();

	// ...
} else {
	// no post to display
}

get_footer();

