module("modules.logic.fight.view.work.FightSuccShowExtraBonusWork", package.seeall)

slot0 = class("FightSuccShowExtraBonusWork", BaseWork)
slot1 = 0.05
slot2 = 0.05
slot3 = 0.45
slot4 = 175
slot5 = 0.5

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0:initParam(slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
end

function slot0.initParam(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0._bonusGOList = slot1
	slot0._bonusGOCount = slot0._bonusGOList and #slot0._bonusGOList or 0
	slot0._containerGODict = slot2
	slot0._showEffectCb = slot3
	slot0._showEffectCbObj = slot4
	slot0._moveBonusGOList = slot5
	slot0._delayTime = slot7
	slot0._itemDelay = slot8
	slot0._bonusItemContainer = slot6
end

function slot0.onStart(slot0)
	if slot0._bonusGOCount <= 0 then
		slot0:onDone(true)

		return
	end

	slot0:_moveBonus()
end

function slot0._moveBonus(slot0)
	for slot4, slot5 in ipairs(slot0._moveBonusGOList) do
		slot6 = slot5.transform
		slot6.parent = slot6.parent.parent

		ZProj.TweenHelper.DOAnchorPosX(slot6, recthelper.getAnchorX(slot6) + slot0._bonusGOCount * uv0, uv1, nil, , , EaseType.InOutCubic)
	end

	TaskDispatcher.runDelay(slot0._startShowBonus, slot0, uv2)

	if slot0._showEffectCb then
		TaskDispatcher.runDelay(slot0._showEffectCb, slot0._showEffectCbObj, uv3)
	end
end

function slot0._startShowBonus(slot0)
	slot1 = (slot0._bonusGOCount - 1) * slot0._delayTime + slot0._itemDelay + uv0
	slot0._bonusTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot1, slot1, slot0._bonusTweenFrame, slot0._bonusTweenFinish, slot0, nil, EaseType.Linear)
end

function slot0._bonusTweenFrame(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._bonusGOList) do
		if slot1 >= (slot5 - 1) * slot0._delayTime then
			gohelper.setActive(slot6, true)
		end
	end

	for slot5, slot6 in pairs(slot0._containerGODict) do
		if slot5 <= slot1 then
			gohelper.setActive(slot6, true)
		end
	end
end

function slot0._bonusTweenFinish(slot0)
	for slot5, slot6 in ipairs(slot0._bonusGOList) do
		gohelper.setActive(slot6, true)
		table.insert({}, slot6)
	end

	for slot5, slot6 in pairs(slot0._containerGODict) do
		gohelper.setActive(slot6, true)
	end

	for slot5, slot6 in ipairs(slot0._moveBonusGOList) do
		table.insert(slot1, slot6)
	end

	slot0._moveBonusGOList = slot1

	slot0:_moveBonusDone()
	slot0:onDone(true)
end

function slot0._moveBonusDone(slot0)
	for slot4, slot5 in ipairs(slot0._moveBonusGOList) do
		slot5.transform.parent = slot0._bonusItemContainer.transform
	end
end

function slot0.clearWork(slot0)
	if slot0._bonusTweenId then
		ZProj.TweenHelper.KillById(slot0._bonusTweenId)
	end

	TaskDispatcher.cancelTask(slot0._startShowBonus, slot0)

	if slot0._showEffectCb then
		TaskDispatcher.cancelTask(slot0._showEffectCb, slot0._showEffectCbObj)
	end

	slot0:initParam()
end

return slot0
