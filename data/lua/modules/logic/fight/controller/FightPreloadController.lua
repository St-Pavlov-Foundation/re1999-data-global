module("modules.logic.fight.controller.FightPreloadController", package.seeall)

slot0 = class("FightPreloadController", BaseController)

function slot0.onInit(slot0)
	slot0._preloadSequence = nil
	slot0._firstSequence = slot0:_buildFirstFlow()
	slot0._secondSequence = slot0:_buildSecondFlow()
	slot0._allResLoadFlow = FlowSequence.New()

	slot0._allResLoadFlow:addWork(slot0:_buildFirstFlow(true))
	slot0._allResLoadFlow:addWork(slot0:_buildSecondFlow())

	slot0._reconnectSequence = slot0:_buildReconnectFlow()
	slot0._context = {
		callback = slot0._onPreloadOneFinish,
		callbackObj = slot0
	}
end

function slot0._buildFirstFlow(slot0, slot1)
	slot2 = FlowSequence.New()

	slot2:addWork(FightPreloadTimelineFirstWork.New())
	slot2:addWork(FightPreloadTimelineRefWork.New())
	slot2:addWork(FightRoundPreloadEffectWork.New())
	slot2:addWork(FightPreloadFirstMonsterSpineWork.New())
	slot2:addWork(FightPreloadHeroGroupSpineWork.New())
	slot2:addWork(FightPreloadViewWork.New())

	if not slot1 then
		slot2:addWork(FightPreloadDoneWork.New())
	end

	slot2:addWork(FightPreloadRoleCardWork.New())
	slot2:addWork(FightPreloadCameraAni.New({}))
	slot2:addWork(FightPreloadEntityAni.New())
	slot2:addWork(FightPreloadRolesTimeline.New())
	slot2:addWork(FightPreloadOthersWork.New())
	slot2:addWork(FightPreloadEffectWork.New())

	return slot2
end

function slot0._buildSecondFlow(slot0)
	slot1 = FlowSequence.New()

	slot1:addWork(FightPreloadCompareSpineWork.New())
	slot1:addWork(FightPreloadTimelineFirstWork.New())
	slot1:addWork(FightPreloadSpineWork.New())
	slot1:addWork(FightPreloadRoleCardWork.New())
	slot1:addWork(FightPreloadOthersWork.New())
	slot1:addWork(FightPreloadViewWork.New())
	slot1:addWork(FightPreloadCameraAni.New())
	slot1:addWork(FightPreloadEntityAni.New())
	slot1:addWork(FightPreloadRolesTimeline.New())
	slot1:addWork(FightPreloadEffectWork.New())
	slot1:addWork(FightPreloadDoneWork.New())
	slot1:addWork(FightPreloadCardInitWork.New())
	slot1:addWork(FightPreloadWaitReplayWork.New())
	slot1:addWork(FightPreloadRoleEffectWork.New())

	return slot1
end

function slot0._buildReconnectFlow(slot0)
	slot1 = FlowSequence.New()

	slot1:addWork(FightPreloadTimelineFirstWork.New())
	slot1:addWork(FightPreloadSpineWork.New())
	slot1:addWork(FightPreloadRoleCardWork.New())
	slot1:addWork(FightPreloadOthersWork.New())
	slot1:addWork(FightPreloadViewWork.New())
	slot1:addWork(FightPreloadCameraAni.New())
	slot1:addWork(FightPreloadEntityAni.New())
	slot1:addWork(FightPreloadRolesTimeline.New())
	slot1:addWork(FightPreloadEffectWork.New())
	slot1:addWork(FightPreloadDoneWork.New())
	slot1:addWork(FightPreloadCardInitWork.New())
	slot1:addWork(FightPreloadWaitReplayWork.New())
	slot1:addWork(FightPreloadRoleEffectWork.New())

	return slot1
end

function slot0.reInit(slot0)
	slot0:dispose()
end

function slot0.isPreloading(slot0)
	return slot0._preloadSequence and slot0._preloadSequence.status == WorkStatus.Running
end

function slot0.hasPreload(slot0, slot1)
	return slot0._battleId == slot1 and slot0._preloadSequence and slot0._preloadSequence.status == WorkStatus.Done
end

function slot0.preloadFirst(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0:_startPreload(slot0._firstSequence, slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0.preloadSecond(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if FightModel.instance:getBattleId() ~= slot0._battleId then
		slot0:dispose()
		slot0:_startPreload(slot0._allResLoadFlow, slot1, slot2, slot3, slot4, slot5, slot6)
	else
		slot0:_startPreload(slot0._secondSequence, slot1, slot2, slot3, slot4, slot5, slot6)
	end
end

function slot0.preloadReconnect(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0:_startPreload(slot0._reconnectSequence, slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0._startPreload(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0:__onInit()

	if slot0._preloadSequence and slot0._preloadSequence.status == WorkStatus.Running then
		slot0._preloadSequence:stop()
	end

	slot0._assetItemDict = slot0._assetItemDict or slot0:getUserDataTb_()
	slot0._battleId = slot2
	slot0._preloadSequence = slot1

	slot0._preloadSequence:registerDoneListener(slot0._onPreloadDone, slot0)
	slot0._preloadSequence:start(slot0:_getContext(slot2, slot3, slot4, slot5, slot6, slot7))
end

function slot0._getContext(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._context.battleId = slot1
	slot0._context.myModelIds = slot2
	slot0._context.mySkinIds = slot3
	slot0._context.enemyModelIds = slot4
	slot0._context.enemySkinIds = slot5
	slot0._context.subSkinIds = slot6

	return slot0._context
end

function slot0.dispose(slot0)
	slot0._battleId = nil

	if slot0._preloadSequence then
		slot0._preloadSequence:stop()
		slot0._preloadSequence:unregisterDoneListener(slot0._onPreloadDone, slot0)

		slot0._preloadSequence = nil
	end

	FightEffectPool.dispose()
	FightSpineMatPool.dispose()
	FightSpinePool.dispose()

	if slot0._assetItemDict then
		for slot4, slot5 in pairs(slot0._assetItemDict) do
			slot5:Release()
		end

		slot0._assetItemDict = nil
	end

	slot0.roleCardAssetItemDict = nil
	slot0.timelineRefAssetItemDict = nil

	slot0:cacheFirstPreloadSpine()

	slot0._context.timelineDict = nil

	ZProj.SkillTimelineAssetHelper.ClearAssetJson()
	slot0:__onDispose()
end

function slot0._onPreloadDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnPreloadFinish)
end

function slot0._onPreloadOneFinish(slot0, slot1)
	if not slot0._assetItemDict[slot1.ResPath] then
		slot0._assetItemDict[slot2] = slot1

		slot1:Retain()
	end
end

function slot0.addRoleCardAsset(slot0, slot1)
	slot0.roleCardAssetItemDict = slot0.roleCardAssetItemDict or {}
	slot0.roleCardAssetItemDict[slot1.ResPath] = slot1
end

function slot0.releaseRoleCardAsset(slot0)
	if not slot0.roleCardAssetItemDict then
		return
	end

	for slot4, slot5 in pairs(slot0.roleCardAssetItemDict) do
		slot0.roleCardAssetItemDict[slot4] = nil
		slot0._assetItemDict[slot4] = nil

		slot5:Release()
	end

	slot0.roleCardAssetItemDict = nil
end

function slot0.addTimelineRefAsset(slot0, slot1)
	slot0.timelineRefAssetItemDict = slot0.timelineRefAssetItemDict or {}
	slot0.timelineRefAssetItemDict[slot1.ResPath] = slot1
end

function slot0.releaseTimelineRefAsset(slot0)
	if not slot0.timelineRefAssetItemDict then
		return
	end

	for slot4, slot5 in pairs(slot0.timelineRefAssetItemDict) do
		slot0.timelineRefAssetItemDict[slot4] = nil
		slot0._assetItemDict[slot4] = nil

		slot5:Release()
	end

	slot0.timelineRefAssetItemDict = nil
end

function slot0.getFightAssetItem(slot0, slot1)
	if slot0._assetItemDict[slot1] then
		return slot2
	end

	logWarn(slot1 .. " need preload")
end

function slot0.releaseAsset(slot0, slot1)
	if slot0._assetItemDict and slot0._assetItemDict[slot1] then
		slot2:Release()

		slot0._assetItemDict[slot1] = nil
	end
end

function slot0.cacheFirstPreloadSpine(slot0, slot1)
	if slot1 then
		slot0.cachePreloadSpine = {}

		for slot5, slot6 in ipairs(slot1) do
			slot0.cachePreloadSpine[slot6[1]] = slot6[2]
		end
	else
		slot0.cachePreloadSpine = nil
	end
end

slot0.instance = slot0.New()

return slot0
