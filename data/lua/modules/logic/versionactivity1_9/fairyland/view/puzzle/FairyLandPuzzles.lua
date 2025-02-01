module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzles", package.seeall)

slot0 = class("FairyLandPuzzles", BaseView)

function slot0.onInitView(slot0)
	slot0.goPuzzle = gohelper.findChild(slot0.viewGO, "main/#go_Root/#go_Puzzle")
	slot0.goText = gohelper.findChild(slot0.viewGO, "main/#go_Root/#go_Text")
	slot0.animText = slot0.goText:GetComponent(typeof(UnityEngine.Animator))

	slot0:setTextVisible(true)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.SetTextBgVisible, slot0.setTextVisible, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.ElementFinish, slot0.refreshView, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.DialogFinish, slot0.refreshView, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.ElementLoadFinish, slot0.refreshView, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.ResolveSuccess, slot0.refreshView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.refreshView(slot0)
	slot0:changePuzzle(FairyLandModel.instance:getCurPuzzle())
end

function slot0.changePuzzle(slot0, slot1)
	if slot1 == slot0.puzzleId then
		return
	end

	slot0.puzzleId = slot1
	slot3 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(slot1)

	if slot0.compId == slot0:getCompId(slot1) then
		if slot0.puzzleComp then
			slot0.puzzleComp:refresh(slot3)
		end

		return
	end

	slot0.compId = slot2

	slot0:closePuzzle()
	slot0:startPuzzle(slot3)
end

function slot0.startPuzzle(slot0, slot1)
	if not slot1 then
		if FairyLandModel.instance:isPuzzleAllStepFinish(10) then
			slot0:setTextVisible(false)
		else
			slot0:setTextVisible(true)
		end

		return
	end

	slot0.puzzleComp = _G["FairyLandPuzzle" .. tostring(slot0.compId)].New()

	slot0.puzzleComp:init({
		config = slot1,
		viewGO = slot0.viewGO
	})
	slot0:setTextVisible(false)
end

function slot0.getCompId(slot0, slot1)
	if slot1 > 3 then
		return 4
	end

	return slot1
end

function slot0.closePuzzle(slot0)
	if slot0.puzzleComp then
		slot0.puzzleComp:destory()

		slot0.puzzleComp = nil
	end
end

function slot0.setTextVisible(slot0, slot1)
	if slot0.textVisible == (slot1 and true or false) then
		return
	end

	slot0.textVisible = slot1

	if slot1 then
		gohelper.setActive(slot0.goText, false)
		gohelper.setActive(slot0.goText, true)
	else
		slot0.animText:Play("close")
	end
end

function slot0.onDestroyView(slot0)
	slot0:closePuzzle()
end

return slot0
