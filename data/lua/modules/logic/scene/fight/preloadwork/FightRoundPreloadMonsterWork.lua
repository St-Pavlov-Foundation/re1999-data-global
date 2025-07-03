module("modules.logic.scene.fight.preloadwork.FightRoundPreloadMonsterWork", package.seeall)

local var_0_0 = class("FightRoundPreloadMonsterWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if FightDataHelper.tempMgr.hasNextWave then
		arg_1_0:_onFightWavePush()

		FightDataHelper.tempMgr.hasNextWave = false

		return
	end

	if FightModel.instance.hasNextWave then
		arg_1_0:_onFightWavePush()
	else
		FightController.instance:registerCallback(FightEvent.PushFightWave, arg_1_0._onFightWavePush, arg_1_0)
	end
end

function var_0_0._onFightWavePush(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, arg_2_0._onFightWavePush, arg_2_0)

	local var_2_0

	arg_2_0._spineCountDict = nil

	local var_2_1

	var_2_1, arg_2_0._spineCountDict = arg_2_0:_getSpineUrlList()
	arg_2_0._loader = SequenceAbLoader.New()

	arg_2_0._loader:setPathList(var_2_1)
	arg_2_0._loader:setConcurrentCount(1)
	arg_2_0._loader:setInterval(0.1)
	arg_2_0._loader:setLoadFailCallback(arg_2_0._onPreloadOneFail)
	arg_2_0._loader:startLoad(arg_2_0._onPreloadFinish, arg_2_0)
end

function var_0_0._onPreloadFinish(arg_3_0)
	if not arg_3_0._loader then
		return
	end

	local var_3_0 = arg_3_0._loader:getAssetItemDict()

	arg_3_0._needCreateList = {}
	arg_3_0._hasCreateList = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		FightSpinePool.setAssetItem(iter_3_0, iter_3_1)

		local var_3_1 = arg_3_0._spineCountDict[iter_3_0]

		for iter_3_2 = 1, var_3_1 do
			table.insert(arg_3_0._needCreateList, iter_3_0)
		end

		arg_3_0.context.callback(arg_3_0.context.callbackObj, iter_3_1)
	end

	local var_3_2 = #arg_3_0._needCreateList

	if var_3_2 > 0 then
		TaskDispatcher.runRepeat(arg_3_0._createSpineGO, arg_3_0, 0.1, var_3_2)
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0._createSpineGO(arg_4_0)
	local var_4_0 = table.remove(arg_4_0._needCreateList)
	local var_4_1 = FightSpinePool.getSpine(var_4_0)

	gohelper.setActive(var_4_1, false)

	local var_4_2 = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:getEntityContainer()

	gohelper.addChild(var_4_2, var_4_1)
	table.insert(arg_4_0._hasCreateList, {
		var_4_0,
		var_4_1
	})

	if #arg_4_0._needCreateList == 0 then
		TaskDispatcher.cancelTask(arg_4_0._createSpineGO, arg_4_0)
		arg_4_0:_returnSpineToPool()
		arg_4_0:onDone(true)
	end
end

function var_0_0._returnSpineToPool(arg_5_0)
	if arg_5_0._hasCreateList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._hasCreateList) do
			local var_5_0 = iter_5_1[1]
			local var_5_1 = iter_5_1[2]

			iter_5_1[1] = nil
			iter_5_1[2] = nil

			FightSpinePool.putSpine(var_5_0, var_5_1)
		end
	end

	arg_5_0._needCreateList = nil
	arg_5_0._hasCreateList = nil
end

function var_0_0._onPreloadOneFail(arg_6_0, arg_6_1, arg_6_2)
	logError("战斗Spine加载失败：" .. arg_6_2.ResPath)
end

function var_0_0.clearWork(arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.PushFightWave, arg_7_0._onFightWavePush, arg_7_0)
	arg_7_0:_returnSpineToPool()
	TaskDispatcher.cancelTask(arg_7_0._createSpineGO, arg_7_0)

	if arg_7_0._loader then
		arg_7_0._loader:dispose()

		arg_7_0._loader = nil
	end
end

function var_0_0._getSpineUrlList(arg_8_0)
	local var_8_0 = FightModel.instance:getCurWaveId() + 1
	local var_8_1 = FightModel.instance:getFightParam()
	local var_8_2 = var_8_1 and var_8_1.episodeId
	local var_8_3 = var_8_1 and var_8_1.battleId or var_8_2 and DungeonConfig.instance:getEpisodeBattleId(var_8_2)
	local var_8_4 = {}
	local var_8_5 = {}
	local var_8_6 = lua_battle.configDict[var_8_3]

	if var_8_6 then
		local var_8_7 = string.splitToNumber(var_8_6.monsterGroupIds, "#")
		local var_8_8 = var_8_7 and var_8_7[var_8_0]
		local var_8_9 = var_8_8 and lua_monster_group.configDict[var_8_8]
		local var_8_10 = var_8_9 and string.splitToNumber(var_8_9.monster, "#")

		if var_8_10 then
			for iter_8_0, iter_8_1 in ipairs(var_8_10) do
				arg_8_0:_calcMonster(iter_8_1, var_8_5)
			end
		end
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_5) do
		local var_8_11 = FightConfig.instance:getSkinCO(iter_8_3)

		if var_8_11 and not string.nilorempty(var_8_11.spine) then
			local var_8_12 = ResUrl.getSpineFightPrefabBySkin(var_8_11)

			var_8_4[var_8_12] = var_8_4[var_8_12] and var_8_4[var_8_12] + 1 or 1
		end
	end

	local var_8_13 = {}

	for iter_8_4, iter_8_5 in pairs(var_8_4) do
		table.insert(var_8_13, iter_8_4)
	end

	return var_8_13, var_8_4
end

function var_0_0._calcMonster(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = lua_monster.configDict[arg_9_1]

	table.insert(arg_9_2, var_9_0 and var_9_0.skinId or 0)

	local var_9_1 = arg_9_0:_calcRefMonsterIds(arg_9_1)

	if var_9_1 then
		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			local var_9_2 = lua_monster.configDict[iter_9_1]

			if var_9_2 then
				table.insert(arg_9_2, var_9_2 and var_9_2.skinId or 0)
			else
				logError("怪物" .. arg_9_1 .. "，引用的怪物" .. iter_9_1 .. "不存在")
			end
		end
	end
end

function var_0_0._calcRefMonsterIds(arg_10_0, arg_10_1)
	local var_10_0 = lua_monster.configDict[arg_10_1]

	if not var_10_0 then
		return
	end

	local var_10_1
	local var_10_2 = FightHelper._buildMonsterSkills(var_10_0)

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_3 = lua_skill.configDict[iter_10_1]

		for iter_10_2 = 1, FightEnum.MaxBehavior do
			local var_10_4 = var_10_3["behavior" .. iter_10_2]
			local var_10_5 = string.splitToNumber(var_10_4, "#")
			local var_10_6 = var_10_5[1]
			local var_10_7 = var_10_6 and lua_skill_behavior.configDict[var_10_6]

			if var_10_7 and var_10_7.type == "MonsterChange" then
				var_10_1 = var_10_1 or {}

				table.insert(var_10_1, var_10_5[2])
			end
		end
	end

	return var_10_1
end

return var_0_0
