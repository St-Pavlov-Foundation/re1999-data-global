module("modules.logic.scene.fight.preloadwork.FightRoundPreloadTimelineWork", package.seeall)

local var_0_0 = class("FightRoundPreloadTimelineWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getTimelineUrlList()

	if not GameResMgr.IsFromEditorDir then
		arg_1_0.context.timelineDict = arg_1_0.context.timelineDict or {}

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_1 = FightPreloadController.instance:getFightAssetItem(ResUrl.getRolesTimeline())

			arg_1_0.context.timelineDict[iter_1_1] = var_1_1
		end

		arg_1_0:onDone(true)

		return
	end

	arg_1_0._loader = SequenceAbLoader.New()

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		arg_1_0._loader:addPath(iter_1_3)
	end

	local var_1_2 = 10

	arg_1_0._loader:setConcurrentCount(var_1_2)
	arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	local var_2_0 = arg_2_0._loader:getAssetItemDict()

	arg_2_0.context.timelineDict = arg_2_0.context.timelineDict or {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_0.context.timelineDict[iter_2_0] = iter_2_1

		arg_2_0.context.callback(arg_2_0.context.callbackObj, iter_2_1)
	end

	arg_2_0:onDone(true)
end

function var_0_0._onPreloadOneFail(arg_3_0, arg_3_1, arg_3_2)
	logError("Timeline加载失败：" .. arg_3_2.ResPath)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._loader then
		arg_4_0._loader:dispose()

		arg_4_0._loader = nil
	end
end

function var_0_0._getTimelineUrlList(arg_5_0)
	local var_5_0 = arg_5_0.context.timelineDict or {}

	arg_5_0.context.timelineUrlDict = {}
	arg_5_0.context.timelineSkinDict = {}

	if SkillEditorMgr.instance.inEditMode then
		arg_5_0:_clacEditor()
	else
		arg_5_0:_calcFightCards()
	end

	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0.context.timelineUrlDict) do
		if var_5_0[iter_5_0] == nil then
			table.insert(var_5_1, iter_5_0)
		end
	end

	return var_5_1
end

function var_0_0._clacEditor(arg_6_0)
	arg_6_0.context.timelineUrlDict = {}
	arg_6_0.context.timelineSkinDict = {}

	local var_6_0 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1.modelId
		local var_6_2 = iter_6_1.skin

		arg_6_0:_gatherModelSkillIds(FightEnum.EntitySide.MySide, var_6_1, var_6_2)
	end

	local var_6_3 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_6_2, iter_6_3 in ipairs(var_6_3) do
		local var_6_4 = iter_6_3.modelId
		local var_6_5 = iter_6_3.skin

		arg_6_0:_gatherModelSkillIds(FightEnum.EntitySide.EnemySide, var_6_4, var_6_5)
	end
end

function var_0_0._calcFightCards(arg_7_0)
	local var_7_0 = FightDataHelper.roundMgr:getRoundData()
	local var_7_1 = var_7_0 and var_7_0:getAIUseCardMOList()
	local var_7_2 = FightDataHelper.handCardMgr.handCard

	if var_7_1 then
		for iter_7_0, iter_7_1 in ipairs(var_7_1) do
			local var_7_3 = FightDataHelper.entityMgr:getById(iter_7_1.uid)

			if var_7_3 then
				arg_7_0:_gatherSkill(FightEnum.EntitySide.EnemySide, var_7_3.skin, iter_7_1.skillId)
			end
		end
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_2) do
		local var_7_4 = FightDataHelper.entityMgr:getById(iter_7_3.uid)

		if var_7_4 then
			local var_7_5 = FightHelper.processSkinId(var_7_4, iter_7_3)

			arg_7_0:_gatherSkill(FightEnum.EntitySide.MySide, var_7_5, iter_7_3.skillId)
		end
	end

	local var_7_6 = FightModel.instance:getFightParam().battleId
	local var_7_7 = lua_battle.configDict[var_7_6]
	local var_7_8 = var_7_7 and var_7_7.additionRule
	local var_7_9 = var_7_7 and var_7_7.hiddenRule

	arg_7_0:_checkBattleRuleSkill(var_7_8)
	arg_7_0:_checkBattleRuleSkill(var_7_9)
end

function var_0_0._checkBattleRuleSkill(arg_8_0, arg_8_1)
	if not string.nilorempty(arg_8_1) then
		local var_8_0 = FightStrUtil.instance:getSplitString2Cache(arg_8_1, true, "|", "#")

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			local var_8_1 = iter_8_1[1]
			local var_8_2 = iter_8_1[2]
			local var_8_3 = lua_rule.configDict[var_8_2]

			if var_8_3 and var_8_3.type == DungeonEnum.AdditionRuleType.FightSkill then
				local var_8_4 = tonumber(var_8_3.effect)

				arg_8_0:_gatherSkill(FightEnum.EntitySide.BothSide, nil, var_8_4)

				break
			end
		end
	end
end

function var_0_0._gatherModelSkillIds(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = FightHelper.buildSkills(arg_9_2)

	if not var_9_0 then
		logError(arg_9_2 .. " no skill")
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if not lua_skill.configDict[iter_9_1] then
			local var_9_1 = lua_character.configDict[arg_9_2] and "角色：" or "怪物："

			logError(var_9_1 .. arg_9_2 .. "，技能id不存在：" .. iter_9_1)
		end

		arg_9_0:_gatherSkill(arg_9_1, arg_9_3, iter_9_1)
	end
end

function var_0_0._gatherSkill(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = FightConfig.instance:getSkinSkillTimeline(arg_10_2, arg_10_3)

	if not string.nilorempty(var_10_0) then
		local var_10_1 = FightHelper.getTimelineListByName(var_10_0, arg_10_2)

		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			local var_10_2 = iter_10_1
			local var_10_3 = ResUrl.getSkillTimeline(var_10_2)
			local var_10_4 = arg_10_0.context.timelineUrlDict[var_10_3]

			if not var_10_4 then
				arg_10_0.context.timelineUrlDict[var_10_3] = arg_10_1
			elseif var_10_4 == FightEnum.EntitySide.MySide and arg_10_1 == FightEnum.EntitySide.EnemySide then
				arg_10_0.context.timelineUrlDict[var_10_3] = FightEnum.EntitySide.BothSide
			elseif var_10_4 == FightEnum.EntitySide.EnemySide and arg_10_1 == FightEnum.EntitySide.MySide then
				arg_10_0.context.timelineUrlDict[var_10_3] = FightEnum.EntitySide.BothSide
			end

			arg_10_2 = arg_10_2 or 0
			arg_10_0.context.timelineSkinDict[var_10_3] = arg_10_0.context.timelineSkinDict[var_10_3] or {}
			arg_10_0.context.timelineSkinDict[var_10_3][arg_10_2] = true
		end
	end
end

return var_0_0
