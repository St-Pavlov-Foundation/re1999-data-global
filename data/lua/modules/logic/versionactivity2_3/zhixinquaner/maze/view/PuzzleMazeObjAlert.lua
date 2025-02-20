module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeObjAlert", package.seeall)

slot0 = class("PuzzleMazeObjAlert", PuzzleMazeBaseAlert)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0.image = gohelper.findChildImage(slot0.go, "#image_content")
	slot0.imageTf = slot0.image.transform
	slot0.tf = slot0.go.transform

	UISpriteSetMgr.instance:setPuzzleSprite(slot0.image, PuzzleEnum.MazeAlertResPath, true)
end

function slot0.onEnable(slot0, slot1, slot2)
	gohelper.setActive(slot0.go, true)
	gohelper.setAsLastSibling(slot0.go)

	slot3 = string.splitToNumber(slot2, "_")

	if slot1 == PuzzleEnum.MazeAlertType.VisitBlock or slot1 == PuzzleEnum.MazeAlertType.DisconnectLine then
		slot4, slot5 = PuzzleMazeDrawModel.instance:getLineAnchor(slot3[1], slot3[2], slot3[3], slot3[4])

		recthelper.setAnchor(slot0.tf, slot4 + PuzzleEnum.MazeAlertBlockOffsetX, slot5 + PuzzleEnum.MazeAlertBlockOffsetY)
	elseif slot1 == PuzzleEnum.MazeAlertType.VisitRepeat then
		slot4, slot5 = PuzzleMazeDrawModel.instance:getObjectAnchor(slot3[1], slot3[2])

		recthelper.setAnchor(slot0.tf, slot4 + PuzzleEnum.MazeAlertCrossOffsetX, slot5 + PuzzleEnum.MazeAlertCrossOffsetY)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act176_ForbiddenGo)
end

function slot0.onDisable(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.onRecycle(slot0)
end

function slot0.getKey(slot0)
end

return slot0
