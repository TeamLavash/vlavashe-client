/*
 *  Shawarma.cpp
 *
 *  Created on: 08 Dec, 2016
 *      Author: Renat
 *
 */

#include "Shawarma.hpp"

Shawarma::Shawarma()
{}

Shawarma::~Shawarma()
{}

void Shawarma::setInfo(ShawarmaInfo _info)
{
	info = _info;
}

void Shawarma::setMenu(Menu _menu)
{
	menu = _menu;
}

const ShawarmaInfo Shawarma::getInfo() const
{
	return info;
}

const Menu Shawarma::getMenu() const
{
	return menu;
}
