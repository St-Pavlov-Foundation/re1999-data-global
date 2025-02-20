module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeNormalObj", package.seeall)

slot0 = class("PuzzleMazeNormalObj", PuzzleMazeBaseObj)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._image = gohelper.findChildImage(slot0.go, "#image_content")
	slot0._gochecked = gohelper.findChild(slot0.go, "#go_checked")

	gohelper.setActive(slot0._gochecked, false)
end

function slot0._getIcon(slot0)
	return slot0._image
end

return slot0
