module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeBaseLine", package.seeall)

slot0 = class("PuzzleMazeBaseLine", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
end

function slot0.onInit(slot0, slot1, slot2, slot3, slot4)
	slot0.y2 = slot4
	slot0.x2 = slot3
	slot0.y1 = slot2
	slot0.x1 = slot1

	slot0:setDir(PuzzleMazeHelper.getFromToDir(slot1, slot2, slot3, slot4))
end

function slot0.onCrossFull(slot0, slot1)
	slot0:setDir(slot1)
	slot0:setProgress(1)
end

function slot0.onCrossHalf(slot0, slot1, slot2)
	slot0:setDir(slot1)
	slot0:setProgress(slot2)
end

function slot0.onAlert(slot0, slot1)
end

function slot0.setProgress(slot0, slot1)
	slot0.progress = slot1 or 0
end

function slot0.getProgress(slot0)
	return slot0.progress or 0
end

function slot0.setDir(slot0, slot1)
	slot0.dir = slot1
end

function slot0.getDir(slot0)
	return slot0.dir
end

function slot0.clear(slot0)
	slot0:setProgress(0)

	slot0.dir = nil
end

function slot0.destroy(slot0)
	gohelper.destroy(slot0.go)
	slot0:__onDispose()
end

return slot0
