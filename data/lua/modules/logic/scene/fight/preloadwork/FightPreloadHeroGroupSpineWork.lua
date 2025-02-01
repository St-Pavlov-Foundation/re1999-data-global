module("modules.logic.scene.fight.preloadwork.FightPreloadHeroGroupSpineWork", package.seeall)

slot0 = class("FightPreloadHeroGroupSpineWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if slot0:_getSpineUrlList() and #slot2 > 0 then
		slot0._loader = SequenceAbLoader.New()

		slot0._loader:setPathList(slot2)
		slot0._loader:setConcurrentCount(10)
		slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
		slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onPreloadFinish(slot0)
	slot0._needCreateList = {}
	slot0._hasCreateList = {}

	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		FightSpinePool.setAssetItem(slot5, slot6)
		table.insert(slot0._needCreateList, slot5)
		slot0.context.callback(slot0.context.callbackObj, slot6)
	end

	if #slot0._needCreateList > 0 then
		TaskDispatcher.runRepeat(slot0._createSpineGO, slot0, 0.1, slot2)
	else
		slot0:onDone(true)
	end
end

function slot0._createSpineGO(slot0)
	slot1 = table.remove(slot0._needCreateList)
	slot2 = FightSpinePool.getSpine(slot1)

	gohelper.setActive(slot2, false)
	gohelper.addChild(GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:getEntityContainer(), slot2)
	table.insert(slot0._hasCreateList, {
		slot1,
		slot2
	})

	if #slot0._needCreateList == 0 then
		FightPreloadController.instance:cacheFirstPreloadSpine(slot0._hasCreateList)
		TaskDispatcher.cancelTask(slot0._createSpineGO, slot0)
		slot0:_returnSpineToPool()
		slot0:onDone(true)
	end
end

function slot0._returnSpineToPool(slot0)
	if slot0._hasCreateList then
		for slot4, slot5 in ipairs(slot0._hasCreateList) do
			slot5[1] = nil
			slot5[2] = nil

			FightSpinePool.putSpine(slot5[1], slot5[2])
		end
	end

	slot0._needCreateList = nil
	slot0._hasCreateList = nil
end

function slot0._onPreloadOneFail(slot0, slot1, slot2)
	logError("战斗Spine加载失败：" .. slot2.ResPath)
end

function slot0.clearWork(slot0)
	slot0:_returnSpineToPool()
	TaskDispatcher.cancelTask(slot0._createSpineGO, slot0)

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getSpineUrlList(slot0)
	slot1 = {}

	for slot5 = 1, 3 do
		slot6 = HeroSingleGroupModel.instance:getById(slot5)
		slot8 = slot6:getMonsterCO()
		slot9 = nil

		if slot6:getHeroMO() then
			slot9 = slot7.skin
		elseif slot8 then
			slot9 = slot8.skinId
		end

		if slot9 then
			slot10 = true

			if FightHelper.getZongMaoShaLiMianJuPath(slot9) then
				slot10 = false
			end

			if slot10 then
				table.insert(slot1, ResUrl.getSpineFightPrefabBySkin(FightConfig.instance:getSkinCO(slot9)))
			end
		end
	end

	return slot1
end

return slot0
