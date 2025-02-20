module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBaseObj", package.seeall)

slot0 = class("PuzzleMazeBaseObj", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
end

function slot0.onInit(slot0, slot1)
	slot0.mo = slot1
	slot0.isEnter = false

	slot0:_setVisible(true)
	slot0:_setPosition()
	slot0:_setIcon(slot0.isEnter)
end

function slot0.onEnter(slot0)
	slot0.isEnter = true

	slot0:_setIcon(slot0.isEnter)
end

function slot0.onExit(slot0)
	slot0.isEnter = false

	slot0:_setIcon(slot0.isEnter)
end

function slot0.onAlreadyEnter(slot0)
end

function slot0.getKey(slot0)
end

function slot0.HasEnter(slot0)
	return slot0.isEnter
end

function slot0._setPosition(slot0)
	slot1, slot2 = nil

	if slot0.mo.positionType == PuzzleEnum.PositionType.Point then
		slot1, slot2 = PuzzleMazeDrawModel.instance:getObjectAnchor(slot0.mo.x, slot0.mo.y)
	else
		slot1, slot2 = PuzzleMazeDrawModel.instance:getLineObjectAnchor(slot0.mo.x1, slot0.mo.y1, slot0.mo.x2, slot0.mo.y2)
	end

	recthelper.setAnchor(slot0.go.transform, slot1, slot2)
end

function slot0._setIcon(slot0, slot1)
	UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(slot0:_getIcon(), slot0:_getIconUrl(slot1), true)
end

function slot0._getIcon(slot0)
end

function slot0._getIconUrl(slot0, slot1)
	if not slot0.mo or not slot0.mo.iconUrl then
		return
	end

	return slot0.mo and slot0.mo.iconUrl
end

function slot0._setVisible(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.destroy(slot0)
	gohelper.destroy(slot0.go)

	slot0.isEnter = false

	slot0:__onDispose()
end

return slot0
