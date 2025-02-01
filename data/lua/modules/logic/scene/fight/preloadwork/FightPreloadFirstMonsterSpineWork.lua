module("modules.logic.scene.fight.preloadwork.FightPreloadFirstMonsterSpineWork", package.seeall)

slot0 = class("FightPreloadFirstMonsterSpineWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._spineCountDict = nil
	slot3, slot0._spineCountDict = slot0:_getSpineUrlList()
	slot0._loader = SequenceAbLoader.New()

	slot0._loader:setPathList(slot3)
	slot0._loader:setConcurrentCount(10)
	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0)
	slot0._needCreateList = {}
	slot0._hasCreateList = {}

	for slot5, slot6 in pairs(slot0._loader:getAssetItemDict()) do
		FightSpinePool.setAssetItem(slot5, slot6)

		for slot11 = 1, slot0._spineCountDict[slot5] do
			table.insert(slot0._needCreateList, slot5)
		end

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
	slot2 = FightModel.instance:getFightParam() and slot1.episodeId
	slot4 = {}
	slot5 = {}

	if lua_battle.configDict[slot1 and slot1.battleId or slot2 and DungeonConfig.instance:getEpisodeBattleId(slot2)] then
		slot8 = FightStrUtil.instance:getSplitToNumberCache(slot6.monsterGroupIds, "#") and slot7[1]
		slot9 = slot8 and lua_monster_group.configDict[slot8]

		if slot9 and FightStrUtil.instance:getSplitToNumberCache(slot9.monster, "#") then
			for slot14, slot15 in ipairs(slot10) do
				slot0:_calcMonster(slot15, slot5)
			end
		end
	end

	for slot10, slot11 in ipairs(slot5) do
		if FightConfig.instance:getSkinCO(slot11) and not string.nilorempty(slot12.spine) then
			slot4[slot13] = slot4[ResUrl.getSpineFightPrefabBySkin(slot12)] and slot4[slot13] + 1 or 1
		end
	end

	slot7 = {}

	for slot11, slot12 in pairs(slot4) do
		table.insert(slot7, slot11)
	end

	return slot7, slot4
end

function slot0._calcMonster(slot0, slot1, slot2)
	table.insert(slot2, lua_monster.configDict[slot1] and slot3.skinId or 0)

	if slot0:_calcRefMonsterIds(slot1) then
		for slot8, slot9 in ipairs(slot4) do
			if lua_monster.configDict[slot9] then
				table.insert(slot2, slot10 and slot10.skinId or 0)
			else
				logError("怪物" .. slot1 .. "，引用的怪物" .. slot9 .. "不存在")
			end
		end
	end
end

function slot0._calcRefMonsterIds(slot0, slot1)
	if not lua_monster.configDict[slot1] then
		return
	end

	slot3 = nil

	for slot8, slot9 in ipairs(FightHelper._buildMonsterSkills(slot2)) do
		if not lua_skill.configDict[slot9] then
			logError("怪物配置了一个不存在的技能,怪物id:" .. slot1 .. ", 技能id:" .. slot9)
		end

		for slot14 = 1, FightEnum.MaxBehavior do
			if FightStrUtil.instance:getSplitToNumberCache(slot10["behavior" .. slot14], "#")[1] and lua_skill_behavior.configDict[slot17] and slot18.type == "MonsterChange" then
				table.insert(slot3 or {}, slot16[2])
			end
		end
	end

	return slot3
end

return slot0
