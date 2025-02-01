module("modules.logic.scene.fight.comp.FightSceneFightLogComp", package.seeall)

slot0 = class("FightSceneFightLogComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	slot0._cacheProto = {}

	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:registerCallback(FightEvent.CacheFightProto, slot0._onCacheFightProto, slot0)
	FightController.instance:registerCallback(FightEvent.GMCopyRoundLog, slot0._onGMCopyRoundLog, slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
end

function slot0._onRestartStageBefore(slot0)
	slot0._cacheProto = {}
end

function slot0._onGMCopyRoundLog(slot0)
	if SLFramework.FrameworkSettings.IsEditor and slot0._lastRoundProto then
		ZProj.UGUIHelper.CopyText(tostring(slot0._lastRoundProto.proto))
	end
end

function slot0._onCacheFightProto(slot0, slot1, slot2)
	if slot0._cacheProto then
		table.insert(slot0._cacheProto, {
			protoType = slot1,
			proto = slot2,
			round = FightModel.instance:getCurRoundId()
		})

		if slot1 == FightEnum.CacheProtoType.Round then
			slot0._lastRoundProto = slot3
		end
	end
end

function slot0.getProtoList(slot0)
	return slot0._cacheProto
end

function slot0.getLastRoundProto(slot0)
	return slot0._lastRoundProto
end

function slot0.onSceneClose(slot0, slot1, slot2)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:unregisterCallback(FightEvent.CacheFightProto, slot0._onCacheFightProto, slot0)
	FightController.instance:unregisterCallback(FightEvent.GMCopyRoundLog, slot0._onGMCopyRoundLog, slot0)
end

return slot0
