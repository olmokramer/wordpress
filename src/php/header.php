<!DOCTYPE html>
<html <?php language_attributes('html'); ?>>

<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link rel="stylesheet" href="<?= get_template_directory_uri() ?>/style.css">

	<script src="<?= get_template_directory_uri() ?>/bundle.js"></script>

	<?php wp_head(); ?>

</head>

<body <?= body_class(); ?>>

