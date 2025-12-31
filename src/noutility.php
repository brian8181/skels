<?php
	/*
    *  @brief function with no utility
	*  @file noutility.php
	*  @date Mon, Dec 29, 2025  3:42:23 PM
	*  @version 0.0.1
	*/

    function tabify_include($file)
    {
        // start output buffering
        ob_start();
        include "$file";
        // get buffered content
        $included_content = ob_get_clean();
        // prepend a tab to every new line in content
        $tabbed_content = str_replace("\n", "\n\t", $included_content);
        // prepend first tab and return result
        echo sprintf("\t%s", $tabbed_content);
    }

    ?>
