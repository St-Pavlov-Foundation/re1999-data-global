module("modules.logic.scene.fight.preloadwork.FightPreloadCompareSpineWork", package.seeall)

slot0 = class("FightPreloadCompareSpineWork", BaseWork)

function slot0.onStart(slot0)
	if FightPreloadController.instance.cachePreloadSpine then
		slot2 = {
			[ResUrl.getSpineFightPrefabBySkin(FightConfig.instance:getSkinCO(slot7.skin))] = true
		}
		slot6 = FightEnum.EntitySide.MySide

		for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getNormalList(slot6)) do
			-- Nothing
		end

		for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getMySubList()) do
			slot2[ResUrl.getSpineFightPrefabBySkin(FightConfig.instance:getSkinCO(slot7.skin))] = true
		end

		for slot6, slot7 in pairs(slot1) do
			if not slot2[slot6] then
				FightSpinePool.releaseUrl(slot6)
				FightPreloadController.instance:releaseAsset(slot6)

				slot1[slot6] = nil
			end
		end

		FightPreloadController.instance:cacheFirstPreloadSpine()
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
