module("modules.logic.fight.view.work.FightSuccShowBonusWork", package.seeall)

slot0 = class("FightSuccShowBonusWork", BaseWork)
slot1 = 0.2

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:initParam(slot1, slot2, slot3, slot4)
end

function slot0.initParam(slot0, slot1, slot2, slot3, slot4)
	slot0._bonusGOList = slot1
	slot0._bonusGOCount = slot0._bonusGOList and #slot0._bonusGOList or 0
	slot0._containerGODict = slot2
	slot0._delayTime = slot3
	slot0._itemDelay = slot4
end

function slot0.onStart(slot0)
	if slot0._bonusGOCount <= 0 then
		slot0:onDone(true)

		return
	end

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
	for slot4, slot5 in ipairs(slot0._bonusGOList) do
		gohelper.setActive(slot5, true)
	end

	for slot4, slot5 in pairs(slot0._containerGODict) do
		gohelper.setActive(slot5, true)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._bonusTweenId then
		ZProj.TweenHelper.KillById(slot0._bonusTweenId)
	end

	slot0:initParam()
end

return slot0
