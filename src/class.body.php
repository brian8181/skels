#!/usr/bin/env php
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
	?>
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
		echo "TEST";
		if($OVERLOAD_EQUAL == "TRUE")
		{
			echo "TEST2";
			echo tabify_include("tmpl/equal_overload.php");
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
