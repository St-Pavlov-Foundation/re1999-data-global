module("modules.logic.scene.fight.preloadwork.FightPreloadSpineWork", package.seeall)

slot0 = class("FightPreloadSpineWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._loader = SequenceAbLoader.New()

	for slot6, slot7 in ipairs(slot0:_getSpineUrlList()) do
		slot0._loader:addPath(slot7)
	end

	slot0._loader:setConcurrentCount(10)
	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0)
	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		slot0.context.callback(slot0.context.callbackObj, slot6)
	end

	slot0:onDone(true)
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("战斗Spine加载失败：" .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getSpineUrlList(slot0)
	for slot5, slot6 in ipairs(slot0.context.mySkinIds) do
		if FightConfig.instance:getSkinCO(slot6) and not string.nilorempty(slot7.spine) then
			-- Nothing
		end

		FightHelper.setZongMaoShaLiMianJuSpineUrl(slot6, {
			[ResUrl.getSpineFightPrefabBySkin(slot7)] = true
		})
	end

	for slot5, slot6 in ipairs(slot0.context.enemySkinIds) do
		if FightConfig.instance:getSkinCO(slot6) and not string.nilorempty(slot7.spine) then
			slot1[ResUrl.getSpineFightPrefabBySkin(slot7)] = true
		end
	end

	for slot5, slot6 in ipairs(slot0.context.subSkinIds) do
		if FightConfig.instance:getSkinCO(slot6) and not string.nilorempty(slot7.alternateSpine) then
			slot1[ResUrl.getSpineFightPrefab(slot7.alternateSpine)] = true
		end

		FightHelper.setZongMaoShaLiMianJuSpineUrl(slot6, slot1)
	end

	slot2 = FightHelper.preloadXingTiSpecialUrl(slot0.context.myModelIds, slot0.context.enemyModelIds)
	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		if FightHelper.XingTiSpineUrl2Special[slot7] and slot2 then
			if slot2 == 1 then
				slot7 = FightHelper.XingTiSpineUrl2Special[slot7]
			elseif slot2 == 2 then
				table.insert(slot3, FightHelper.XingTiSpineUrl2Special[slot7])
			end
		end

		table.insert(slot3, slot7)
	end

	return slot3
end

return slot0
