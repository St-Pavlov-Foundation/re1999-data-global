module("modules.logic.scene.fight.preloadwork.FightPreloadFirstMonsterSpineWork", package.seeall)

local var_0_0 = class("FightPreloadFirstMonsterSpineWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0

	arg_1_0._spineCountDict = nil

	local var_1_1

	var_1_1, arg_1_0._spineCountDict = arg_1_0:_getSpineUrlList()
	arg_1_0._loader = SequenceAbLoader.New()

	arg_1_0._loader:setPathList(var_1_1)
	arg_1_0._loader:setConcurrentCount(10)
	arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	local var_2_0 = arg_2_0._loader:getAssetItemDict()

	arg_2_0._needCreateList = {}
	arg_2_0._hasCreateList = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		FightSpinePool.setAssetItem(iter_2_0, iter_2_1)

		local var_2_1 = arg_2_0._spineCountDict[iter_2_0]

		for iter_2_2 = 1, var_2_1 do
			table.insert(arg_2_0._needCreateList, iter_2_0)
		end

		arg_2_0.context.callback(arg_2_0.context.callbackObj, iter_2_1)
	end

	local var_2_2 = #arg_2_0._needCreateList

	if var_2_2 > 0 then
		TaskDispatcher.runRepeat(arg_2_0._createSpineGO, arg_2_0, 0.1, var_2_2)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._createSpineGO(arg_3_0)
	local var_3_0 = table.remove(arg_3_0._needCreateList)
	local var_3_1 = FightSpinePool.getSpine(var_3_0)

	gohelper.setActive(var_3_1, false)

	local var_3_2 = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:getEntityContainer()

	gohelper.addChild(var_3_2, var_3_1)
	table.insert(arg_3_0._hasCreateList, {
		var_3_0,
		var_3_1
	})

	if #arg_3_0._needCreateList == 0 then
		TaskDispatcher.cancelTask(arg_3_0._createSpineGO, arg_3_0)
		arg_3_0:_returnSpineToPool()
		arg_3_0:onDone(true)
	end
end

function var_0_0._returnSpineToPool(arg_4_0)
	if arg_4_0._hasCreateList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._hasCreateList) do
			local var_4_0 = iter_4_1[1]
			local var_4_1 = iter_4_1[2]

			iter_4_1[1] = nil
			iter_4_1[2] = nil

			FightSpinePool.putSpine(var_4_0, var_4_1)
		end
	end

	arg_4_0._needCreateList = nil
	arg_4_0._hasCreateList = nil
end

function var_0_0._onPreloadOneFail(arg_5_0, arg_5_1, arg_5_2)
	logError("战斗Spine加载失败：" .. arg_5_2.ResPath)
end

function var_0_0.clearWork(arg_6_0)
	arg_6_0:_returnSpineToPool()
	TaskDispatcher.cancelTask(arg_6_0._createSpineGO, arg_6_0)

	if arg_6_0._loader then
		arg_6_0._loader:dispose()

		arg_6_0._loader = nil
	end
end

function var_0_0._getSpineUrlList(arg_7_0)
	local var_7_0 = FightModel.instance:getFightParam()
	local var_7_1 = var_7_0 and var_7_0.episodeId
	local var_7_2 = var_7_0 and var_7_0.battleId or var_7_1 and DungeonConfig.instance:getEpisodeBattleId(var_7_1)
	local var_7_3 = {}
	local var_7_4 = {}
	local var_7_5 = lua_battle.configDict[var_7_2]

	if var_7_5 then
		local var_7_6 = FightStrUtil.instance:getSplitToNumberCache(var_7_5.monsterGroupIds, "#")
		local var_7_7 = var_7_6 and var_7_6[1]
		local var_7_8 = var_7_7 and lua_monster_group.configDict[var_7_7]
		local var_7_9 = var_7_8 and FightStrUtil.instance:getSplitToNumberCache(var_7_8.monster, "#")

		if var_7_9 then
			for iter_7_0, iter_7_1 in ipairs(var_7_9) do
				arg_7_0:_calcMonster(iter_7_1, var_7_4)
			end
		end
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_4) do
		local var_7_10 = FightConfig.instance:getSkinCO(iter_7_3)

		if var_7_10 and not string.nilorempty(var_7_10.spine) then
			local var_7_11 = ResUrl.getSpineFightPrefabBySkin(var_7_10)

			var_7_3[var_7_11] = var_7_3[var_7_11] and var_7_3[var_7_11] + 1 or 1
		end
	end

	local var_7_12 = {}

	for iter_7_4, iter_7_5 in pairs(var_7_3) do
		table.insert(var_7_12, iter_7_4)
	end

	return var_7_12, var_7_3
end

function var_0_0._calcMonster(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = lua_monster.configDict[arg_8_1]

	table.insert(arg_8_2, var_8_0 and var_8_0.skinId or 0)

	local var_8_1 = arg_8_0:_calcRefMonsterIds(arg_8_1)

	if var_8_1 then
		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			local var_8_2 = lua_monster.configDict[iter_8_1]

			if var_8_2 then
				table.insert(arg_8_2, var_8_2 and var_8_2.skinId or 0)
			else
				logError("怪物" .. arg_8_1 .. "，引用的怪物" .. iter_8_1 .. "不存在")
			end
		end
	end
end

function var_0_0._calcRefMonsterIds(arg_9_0, arg_9_1)
	local var_9_0 = lua_monster.configDict[arg_9_1]

	if not var_9_0 then
		return
	end

	local var_9_1
	local var_9_2 = FightHelper._buildMonsterSkills(var_9_0)

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_3 = lua_skill.configDict[iter_9_1]

		if not var_9_3 then
			logError("怪物配置了一个不存在的技能,怪物id:" .. arg_9_1 .. ", 技能id:" .. iter_9_1)
		end

		for iter_9_2 = 1, FightEnum.MaxBehavior do
			local var_9_4 = var_9_3["behavior" .. iter_9_2]
			local var_9_5 = FightStrUtil.instance:getSplitToNumberCache(var_9_4, "#")
			local var_9_6 = var_9_5[1]
			local var_9_7 = var_9_6 and lua_skill_behavior.configDict[var_9_6]

			if var_9_7 and var_9_7.type == "MonsterChange" then
				var_9_1 = var_9_1 or {}

				table.insert(var_9_1, var_9_5[2])
			end
		end
	end

	return var_9_1
end

return var_0_0
