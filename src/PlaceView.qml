/*
 * PlaceView.qml
 * Copyright (C) Damien Caliste 2014 <dcaliste@free.fr>
 *
 * PlaceView.qml is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaListView {
    id: placeview
    property variant currentPlace
    signal selection(string place, real lat, real lon)

    delegate: ListItem {
	
	contentHeight: Theme.itemSizeSmall
        Image {
            id: img_go
            source: "image://theme/icon-m-right"
            anchors.right: parent.right
            anchors.leftMargin: Theme.paddingSmall
            anchors.rightMargin: Theme.paddingSmall
            anchors.verticalCenter: parent.verticalCenter
        }
	Label {
            text: model.name
	    font.pixelSize: Theme.fontSizeSmall
            truncationMode: TruncationMode.Fade
            anchors.leftMargin: Theme.paddingSmall
            anchors.left: parent.left
            anchors.right: img_go.left
            anchors.top: parent.top
            anchors.topMargin: Theme.paddingMedium
	    color: highlighted ? Theme.highlightColor : Theme.primaryColor
	}
	Label {
            text: model.country
	    font.pixelSize: Theme.fontSizeExtraSmall
            anchors.leftMargin: Theme.paddingLarge
            anchors.bottom: parent.bottom
            anchors.left: parent.left
	    color: highlighted ? Theme.highlightColor : Theme.secondaryColor
	}
	Label {
	    property real dist: currentPlace.distanceTo(model.coordinate)
	    font.pixelSize: Theme.fontSizeExtraSmall
	    text: dist >= 1000 ? "at " + (dist / 1000).toFixed(1) + " km" : "at " + dist.toFixed(0) + " m"
	    color: Theme.secondaryColor
	    anchors.right: img_go.left
	    anchors.bottom: parent.bottom
	}
	onClicked: placeview.selection(model.name, model.coordinate.latitude,
                                       model.coordinate.longitude)
    }
    VerticalScrollDecorator { flickable: placeview }
}