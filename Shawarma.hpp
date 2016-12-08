/*
 *  Shawarma.hpp
 *
 *  Created on: 08 Dec, 2016
 *      Author: Renat
 *
 */

#ifndef SHAWARMA_HPP
#define SHAWARMA_HPP

#include <QList>
#include <QPair>
#include <QString>

typedef uint64_t ShawarmaId;
typedef QPair<double, double> Coordinates;

struct ShawarmaInfo {
	ShawarmaId id;
	Coordinates coordinates;

	QString address;
	QString name;
	float rating;

	// TODO add photo
};

struct MenuEntry {
	QString name;
	uint32_t price;
	uint32_t wight;
	QString consist;

	// TODO add photo?
};

typedef QList<MenuEntry> Menu;

// TODO comments

class Shawarma
{
public:
	Shawarma();
	~Shawarma();

	void setInfo(ShawarmaInfo _info);
	void setMenu(Menu _menu);

	const ShawarmaInfo getInfo() const;
	const Menu getMenu() const;

private:
	ShawarmaInfo info;
	Menu menu;
};

#endif // SHAWARMA_HPP
