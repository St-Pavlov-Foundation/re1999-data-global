module("modules.logic.rouge.map.map.itemcomp.RougeMapBaseActorComp", package.seeall)

slot0 = class("RougeMapBaseActorComp", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.map = slot2
	slot0.goActor = slot1

	slot0:initActor()
end

function slot0.initActor(slot0)
	slot0.trActor = slot0.goActor.transform
	slot1, slot2 = slot0.map:getActorPos()

	transformhelper.setLocalPos(slot0.trActor, slot1, slot2, RougeMapHelper.getOffsetZ(slot2))
end

function slot0.getActorWordPos(slot0)
	return slot0.trActor.position
end

function slot0.moveToMapItem(slot0, slot1, slot2, slot3)
	logNormal("base move to map item")
end

function slot0.moveToPieceItem(slot0, slot1, slot2, slot3)
	logNormal("base move to piece item")
end

function slot0.onMovingDone(slot0)
	slot0:endBlock()
	AudioMgr.instance:trigger(AudioEnum.UI.StopMoveAudio)

	slot0.movingTweenId = nil

	if slot0.callback then
		slot0.callback(slot0.callbackObj)
	end

	slot0.callback = nil
	slot0.callbackObj = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorMovingDone)
end

function slot0.startBlock(slot0)
	UIBlockMgr.instance:startBlock(RougeMapEnum.MovingBlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function slot0.endBlock(slot0)
	UIBlockMgr.instance:endBlock(RougeMapEnum.MovingBlock)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.clearTween(slot0)
	if slot0.movingTweenId then
		ZProj.TweenHelper.KillById(slot0.movingTweenId)

		slot0.movingTweenId = nil
	end
end

function slot0.destroy(slot0)
	slot0:endBlock()

	slot0.callback = nil
	slot0.callbackObj = nil

	slot0:clearTween()
	slot0:__onDispose()
end

return slot0
