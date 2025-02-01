module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementShape", package.seeall)

slot0 = class("FairyLandElementShape", FairyLandElementBase)

function slot0.onInitView(slot0)
	slot0.stateGoDict = {}

	for slot4, slot5 in pairs(FairyLandEnum.ShapeState) do
		if not gohelper.isNil(gohelper.findChild(slot0._go, tostring(slot5))) then
			slot7 = slot0:getUserDataTb_()
			slot7.go = slot6
			slot7.rootGo = gohelper.findChild(slot6, "root")
			slot7.rootAnim = slot7.rootGo:GetComponent(typeof(UnityEngine.Animator))
			slot0.stateGoDict[slot5] = slot7
		end
	end

	for slot5, slot6 in pairs(slot0.stateGoDict) do
		gohelper.setActive(slot6.go, slot5 == slot0:getState())
	end
end

function slot0.getClickGO(slot0)
	return slot0._go
end

function slot0.refresh(slot0)
	for slot5, slot6 in pairs(slot0.stateGoDict) do
		slot7 = slot5 == slot0:getState()

		gohelper.setActive(slot6.go, slot7)

		if slot7 then
			slot6.rootAnim:Play("open", 0, 0)
		end
	end
end

function slot0.getState(slot0)
	if FairyLandModel.instance:isFinishElement(slot0:getElementId()) then
		return FairyLandEnum.ShapeState.Hide
	end

	if not FairyLandConfig.instance:getElementConfig(slot1 - 1) then
		return FairyLandEnum.ShapeState.CanClick
	end

	if FairyLandEnum.ConfigType2ElementType[slot3.type] == FairyLandEnum.ElementType.NPC then
		if slot0._elements.elementDict[slot2] then
			return FairyLandEnum.ShapeState.Hide
		end

		slot7 = true

		for slot11, slot12 in ipairs(string.splitToNumber(slot3.puzzleId, "#")) do
			slot7 = false
			slot13 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(slot12)

			if FairyLandModel.instance:isPassPuzzle(slot12) and (slot13.storyTalkId == 0 or FairyLandModel.instance:isFinishDialog(slot13.storyTalkId)) then
				slot7 = true
			end

			if not slot7 then
				break
			end
		end

		if slot7 then
			return FairyLandEnum.ShapeState.CanClick
		else
			return FairyLandEnum.ShapeState.Hide
		end
	elseif slot5 then
		if slot5:getState() == FairyLandEnum.ShapeState.Hide then
			return FairyLandEnum.ShapeState.Hide
		end

		if slot6 == FairyLandEnum.ShapeState.CanClick then
			return FairyLandEnum.ShapeState.NextCanClick
		end

		if slot6 == FairyLandEnum.ShapeState.NextCanClick then
			return FairyLandEnum.ShapeState.LockClick
		end

		return FairyLandEnum.ShapeState.LockClick
	end

	return FairyLandEnum.ShapeState.CanClick
end

function slot0.onClick(slot0)
	if slot0:getState() == FairyLandEnum.ShapeState.CanClick and not slot0._elements:isMoveing() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_symbol_click)
		slot0:setFinish()
	end
end

function slot0.finish(slot0)
	slot0:onFinish()
end

function slot0.onFinish(slot0)
	if slot0.stateGoDict[FairyLandEnum.ShapeState.CanClick] then
		slot1.rootAnim:Play("click", 0, 0)
		TaskDispatcher.runDelay(slot0._finishCallback, slot0, 1)
	end

	FairyLandModel.instance:setPos(slot0:getPos(), true)
	slot0._elements:characterMove()
end

function slot0._finishCallback(slot0)
	slot0:onDestroy()
end

function slot0.onDestroyElement(slot0)
	TaskDispatcher.cancelTask(slot0._finishCallback, slot0)
end

return slot0
