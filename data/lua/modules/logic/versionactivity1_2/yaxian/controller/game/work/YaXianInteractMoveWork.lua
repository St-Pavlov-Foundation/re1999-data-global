module("modules.logic.versionactivity1_2.yaxian.controller.game.work.YaXianInteractMoveWork", package.seeall)

slot0 = class("YaXianInteractMoveWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.transform = slot1.transform
	slot0.targetX = slot1.targetX
	slot0.targetY = slot1.targetY
	slot0.targetZ = slot1.targetZ
	slot0.duration = slot1.duration
	slot0.isPlayer = slot1.isPlayer
	slot0.interactMo = slot1.interactMo
end

function slot0.onStart(slot0)
	if slot0.isPlayer then
		if slot0:isPassedWall() then
			AudioMgr.instance:trigger(AudioEnum.YaXian.ThroughWall)
		else
			AudioMgr.instance:trigger(AudioEnum.YaXian.YaXianMove)
		end
	end

	slot0.tweenId = ZProj.TweenHelper.DOLocalMove(slot0.transform, slot0.targetX, slot0.targetY, slot0.targetZ, slot0.duration or YaXianGameEnum.MoveDuration, slot0.onMoveCompleted, slot0, nil, EaseType.Linear)
end

function slot0.isPassedWall(slot0)
	if not slot0.isPlayer then
		return false
	end

	if not slot0.interactMo then
		logError("not found interactMo ... ")

		return false
	end

	if YaXianGameModel.instance:getCanWalkPos2Direction()[YaXianGameHelper.getPosHashKey(slot0.interactMo.posX, slot0.interactMo.posY)] then
		return YaXianGameModel.instance:getCanWalkTargetPosDict() and slot3[slot2] and slot3[slot2].passedWall
	end

	return false
end

function slot0.onMoveCompleted(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

return slot0
