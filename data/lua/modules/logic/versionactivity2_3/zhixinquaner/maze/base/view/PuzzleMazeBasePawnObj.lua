module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBasePawnObj", package.seeall)

slot0 = class("PuzzleMazeBasePawnObj", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
end

function slot0.onInit(slot0, slot1)
	slot0._mo = slot1
end

function slot0.onBeginDrag(slot0)
end

function slot0.onDraging(slot0, slot1, slot2)
	slot0:setPos(slot1, slot2)
end

function slot0.onEndDrag(slot0, slot1, slot2)
	slot0:setPos(slot1, slot2)
end

function slot0.setDir(slot0, slot1)
	slot0.dir = slot1
end

function slot0.getDir(slot0)
	return slot0.dir
end

function slot0.setPos(slot0, slot1, slot2)
	slot0.x = slot1 or 0
	slot0.y = slot2 or 0
end

function slot0.getPos(slot0)
	return slot0.x or 0, slot0.y or 0
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
