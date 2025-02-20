module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeLine", package.seeall)

slot0 = class("PuzzleMazeLine", PuzzleMazeBaseLine)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1)

	slot0._fillOrigin_left = slot2
	slot0._fillOrigin_right = slot3
	slot0._gomap = gohelper.findChild(slot0.go, "#go_map")
	slot0._gopath = gohelper.findChild(slot0.go, "#go_path")
	slot0.image = gohelper.findChildImage(slot0.go, "#go_path/image_horizon")
	slot0.imageTf = slot0.image.transform

	gohelper.setActive(slot0._gomap, false)
	gohelper.setActive(slot0._gopath, true)
end

function slot0.onInit(slot0, slot1, slot2, slot3, slot4)
	uv0.super.onInit(slot0, slot1, slot2, slot3, slot4)

	slot5, slot6 = PuzzleMazeDrawModel.instance:getLineAnchor(slot1, slot2, slot3, slot4)

	recthelper.setAnchor(slot0.go.transform, slot5, slot6)
end

function slot0.onAlert(slot0, slot1)
end

function slot0.onCrossHalf(slot0, slot1, slot2)
	if slot0.dir == nil and slot1 ~= nil then
		slot0:setDir(slot1)
	end

	if slot0.dir ~= nil then
		if slot0:isReverseDir(slot0.dir) then
			slot2 = 1 - slot2
		end

		slot0:setProgress(slot2)
	end
end

function slot0.setProgress(slot0, slot1)
	uv0.super.setProgress(slot0, slot1)

	slot0.image.fillAmount = slot0:getProgress()
end

function slot0.setDir(slot0, slot1)
	uv0.super.setDir(slot0, slot1)
	slot0:refreshLineDir()
end

function slot0.refreshLineDir(slot0)
	slot1 = 0
	slot2 = 0
	slot3 = 0
	slot4 = PuzzleEnum.mazeUILineHorizonUIWidth
	slot0.image.fillOrigin = slot0._fillOrigin_left

	if slot0.dir == PuzzleEnum.dir.left then
		slot3 = 180
	elseif slot0.dir == PuzzleEnum.dir.up then
		slot4 = PuzzleEnum.mazeUILineVerticalUIWidth
		slot3 = 90
	elseif slot0.dir == PuzzleEnum.dir.down then
		slot4 = PuzzleEnum.mazeUILineVerticalUIWidth
		slot3 = -90
	end

	transformhelper.setLocalRotation(slot0.imageTf, slot1, slot2, slot3)
	recthelper.setWidth(slot0.imageTf, slot4)
end

function slot0.isReverseDir(slot0, slot1)
	return slot1 == PuzzleEnum.dir.left or slot1 == PuzzleEnum.dir.down
end

return slot0
