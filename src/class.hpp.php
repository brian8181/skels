#!/bin/php
<?php
	/*
    *  @brief create class skeleton
	*  @file ccsk.php
	*  @date Fri Sep 19 08:08:55 CDT 2025
	*  @version 0.0.1
	*/
    $NAME=$argv[1];
	$BASE_NAME=$argv[2];
	$DTOR=$argv[3];
	$CCTOR=$argv[4];
	$IMP_DEFAULTS=$argv[5];
	$OVERLOAD_EQUAL=$argv[6];
    $VERSION="0.0.1";
	$INFO="auto generated with ccsk, create class skeleton";
	include 'cstyle_file_header.php';
    ?>
#ifndef _<?= "$NAME"; ?>_HPP_
#define _<?= "$NAME"; ?>_HPP_
#include <iostream>
<?php if(!empty($BASE_NAME)) echo "#include \"$BASE_NAME.hpp\"\n"; ?>

/**
  * @brief class <?= "$NAME\n"; ?>
  */
class <?= "$NAME"; if(!empty($BASE_NAME)) echo " : public $BASE_NAME"; echo "\n"; ?>
{
public:
	/**
 * @brief : default ctor
 */
	<?= "$NAME" ?>() = default;

	<?php if($CCTOR == "TRUE"): ?>
	/**
	* @brief : copy ctor
	*/
	<?= "$NAME" ?>( const <?= "$NAME" ?>& src ) = default;
	<?php endif ?>

	<?php if($DTOR == "TRUE"): ?>
	/**
	* @brief : destructor
	*/
	<?= "~$NAME" ?>() = default;
	<?php endif ?>

	<?php
		if($OVERLOAD_EQUAL == "TRUE")
		{
			// Start output buffering
			ob_start();
			include "tmpl/equal_overload.php";
			// Get the buffered content
			$included_content = ob_get_clean();
			// Prepend a tab to every new line in the content
			$tabbed_content = str_replace("\n", "\n\t", $included_content);
			// Prepend the first tab and echo the result
			echo "\t" . $tabbed_content;
		}
	?>

	/**
	<?php
		echo "  * @brief \n\t";
		echo "  * @brief c++ comment ...\n\t";
		echo "  * @brief place future addtions here ...\n\t  *\n";
	?>
	*/

private:

};

#endif
