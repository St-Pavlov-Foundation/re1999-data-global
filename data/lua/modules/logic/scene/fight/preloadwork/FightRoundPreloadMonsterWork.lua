module("modules.logic.scene.fight.preloadwork.FightRoundPreloadMonsterWork", package.seeall)

slot0 = class("FightRoundPreloadMonsterWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if FightModel.instance.hasNextWave then
		slot0:_onFightWavePush()
	else
		FightController.instance:registerCallback(FightEvent.PushFightWave, slot0._onFightWavePush, slot0)
	end
end

function slot0._onFightWavePush(slot0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, slot0._onFightWavePush, slot0)

	slot0._spineCountDict = nil
	slot2, slot0._spineCountDict = slot0:_getSpineUrlList()
	slot0._loader = SequenceAbLoader.New()

	slot0._loader:setPathList(slot2)
	slot0._loader:setConcurrentCount(1)
	slot0._loader:setInterval(0.1)
	slot0._loader:setLoadFailCallback(slot0._onPreloadOneFail)
	slot0._loader:startLoad(slot0._onPreloadFinish, slot0)
end

function slot0._onPreloadFinish(slot0)
	if not slot0._loader then
		return
	end

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
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, slot0._onFightWavePush, slot0)
	slot0:_returnSpineToPool()
	TaskDispatcher.cancelTask(slot0._createSpineGO, slot0)

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0._getSpineUrlList(slot0)
	slot3 = FightModel.instance:getFightParam() and slot2.episodeId
	slot5 = {}
	slot6 = {}

	if lua_battle.configDict[slot2 and slot2.battleId or slot3 and DungeonConfig.instance:getEpisodeBattleId(slot3)] then
		slot9 = string.splitToNumber(slot7.monsterGroupIds, "#") and slot8[FightModel.instance:getCurWaveId() + 1]
		slot10 = slot9 and lua_monster_group.configDict[slot9]

		if slot10 and string.splitToNumber(slot10.monster, "#") then
			for slot15, slot16 in ipairs(slot11) do
				slot0:_calcMonster(slot16, slot6)
			end
		end
	end

	for slot11, slot12 in ipairs(slot6) do
		if FightConfig.instance:getSkinCO(slot12) and not string.nilorempty(slot13.spine) then
			slot5[slot14] = slot5[ResUrl.getSpineFightPrefabBySkin(slot13)] and slot5[slot14] + 1 or 1
		end
	end

	slot8 = {}

	for slot12, slot13 in pairs(slot5) do
		table.insert(slot8, slot12)
	end

	return slot8, slot5
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
		for slot14 = 1, FightEnum.MaxBehavior do
			if string.splitToNumber(lua_skill.configDict[slot9]["behavior" .. slot14], "#")[1] and lua_skill_behavior.configDict[slot17] and slot18.type == "MonsterChange" then
				table.insert(slot3 or {}, slot16[2])
			end
		end
	end

	return slot3
end

return slot0
