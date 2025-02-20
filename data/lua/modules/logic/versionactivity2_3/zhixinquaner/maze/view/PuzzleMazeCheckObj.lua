module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeCheckObj", package.seeall)

slot0 = class("PuzzleMazeCheckObj", PuzzleMazeBaseObj)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._image = gohelper.findChildImage(slot0.go, "#image_content")
	slot0._gochecked = gohelper.findChild(slot0.go, "#go_checked")
	slot0._goflag = gohelper.findChild(slot0.go, "#go_flag")
end

function slot0.onInit(slot0, slot1)
	uv0.super.onInit(slot0, slot1)
	slot0:setCheckIconVisible(false)
	gohelper.setActive(slot0._goflag, slot1.objType == PuzzleEnum.MazeObjType.End)
end

function slot0.onEnter(slot0)
	uv0.super.onEnter(slot0)
	slot0:setCheckIconVisible(true)
end

function slot0.onExit(slot0)
	uv0.super.onExit(slot0)
	slot0:setCheckIconVisible(false)
end

function slot0.setCheckIconVisible(slot0, slot1)
	gohelper.setActive(slot0._gochecked, slot1)
end

function slot0._setIcon(slot0, slot1)
	uv0.super._setIcon(slot0, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._image.gameObject, not slot1)
end

function slot0._getIcon(slot0)
	return slot0._image
end

return slot0
