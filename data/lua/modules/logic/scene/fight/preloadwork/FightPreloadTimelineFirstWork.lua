module("modules.logic.scene.fight.preloadwork.FightPreloadTimelineFirstWork", package.seeall)

local var_0_0 = class("FightPreloadTimelineFirstWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getTimelineUrlList()

	if not GameResMgr.IsFromEditorDir then
		arg_1_0.context.timelineDict = {}

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

	arg_1_0._loader:setConcurrentCount(10)
	arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
	arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	local var_2_0 = arg_2_0._loader:getAssetItemDict()

	arg_2_0.context.timelineDict = {}

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
	arg_5_0.context.timelineUrlDict = {}
	arg_5_0.context.timelineSkinDict = {}

	local var_5_0 = lua_battle.configDict[arg_5_0.context.battleId]

	if var_5_0 then
		local var_5_1 = FightStrUtil.instance:getSplitToNumberCache(var_5_0.monsterGroupIds, "#")

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_2 = lua_monster_group.configDict[iter_5_1]

			if not string.nilorempty(var_5_2.appearTimeline) then
				local var_5_3 = ResUrl.getSkillTimeline(var_5_2.appearTimeline)

				arg_5_0.context.timelineUrlDict[var_5_3] = FightEnum.EntitySide.EnemySide
				arg_5_0.context.timelineSkinDict[var_5_3] = arg_5_0.context.timelineSkinDict[var_5_3] or {}
				arg_5_0.context.timelineSkinDict[var_5_3][0] = true
			end
		end
	end

	local var_5_4 = {}

	for iter_5_2, iter_5_3 in pairs(arg_5_0.context.timelineUrlDict) do
		table.insert(var_5_4, iter_5_2)
	end

	return var_5_4
end

return var_0_0
