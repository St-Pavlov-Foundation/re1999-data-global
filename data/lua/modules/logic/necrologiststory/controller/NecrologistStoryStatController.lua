module("modules.logic.necrologiststory.controller.NecrologistStoryStatController", package.seeall)

local var_0_0 = class("NecrologistStoryStatController")

function var_0_0.startGameStat(arg_1_0)
	arg_1_0.startGameTime = ServerTime.now()
end

function var_0_0.startStoryStat(arg_2_0)
	arg_2_0.startStoryTime = ServerTime.now()
end

function var_0_0.statStoryEnd(arg_3_0, arg_3_1)
	arg_3_0:_statStoryEnd(arg_3_1, StatEnum.Result.Completion)
end

function var_0_0.statStoryInterrupt(arg_4_0, arg_4_1)
	arg_4_0:_statStoryEnd(arg_4_1, StatEnum.Result.Abort)
end

function var_0_0._statStoryEnd(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.startStoryTime then
		return
	end

	local var_5_0 = arg_5_1.heroStoryId
	local var_5_1 = RoleStoryConfig.instance:getStoryById(var_5_0)

	if not var_5_1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.NecrologistStoryEnd, {
		[StatEnum.EventProperties.HeroStoryId] = tostring(var_5_0),
		[StatEnum.EventProperties.HeroStoryQueryVersion] = var_5_1.queryVersion,
		[StatEnum.EventProperties.HeroStoryPlotGroup] = tostring(arg_5_1.plotGroup),
		[StatEnum.EventProperties.HeroStoryResult] = StatEnum.Result2Cn[arg_5_2],
		[StatEnum.EventProperties.HeroStoryTime] = ServerTime.now() - arg_5_0.startStoryTime,
		[StatEnum.EventProperties.HeroStorySkipNum] = arg_5_1.skipNum,
		[StatEnum.EventProperties.HeroStoryLastText] = arg_5_1.lastText,
		[StatEnum.EventProperties.HeroStoryEntrance] = arg_5_1.entrance
	})

	arg_5_0.startStoryTime = nil
end

function var_0_0.statStorySkip(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.heroStoryId
	local var_6_1 = RoleStoryConfig.instance:getStoryById(var_6_0)

	if not var_6_1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.NecrologistStorySkip, {
		[StatEnum.EventProperties.HeroStoryId] = tostring(var_6_0),
		[StatEnum.EventProperties.HeroStoryQueryVersion] = var_6_1.queryVersion,
		[StatEnum.EventProperties.HeroStoryPlotGroup] = tostring(arg_6_1.plotGroup),
		[StatEnum.EventProperties.HeroStoryLastText] = arg_6_1.lastText,
		[StatEnum.EventProperties.HeroStoryEntrance] = arg_6_1.entrance
	})
end

function var_0_0.statStorySettlement(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.startGameTime then
		return
	end

	local var_7_0 = arg_7_1.heroStoryId
	local var_7_1 = RoleStoryConfig.instance:getStoryById(var_7_0)

	if not var_7_1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.NecrologistStorySettlement, {
		[StatEnum.EventProperties.HeroStoryId] = tostring(var_7_0),
		[StatEnum.EventProperties.HeroStoryQueryVersion] = var_7_1.queryVersion,
		[StatEnum.EventProperties.HeroStoryResult] = StatEnum.Result2Cn[arg_7_2],
		[StatEnum.EventProperties.HeroStoryUseTime] = ServerTime.now() - arg_7_0.startGameTime,
		[StatEnum.EventProperties.HeroStoryStrongHold] = tostring(arg_7_1.baseId),
		[StatEnum.EventProperties.HeroStoryStrongTime] = arg_7_1.time
	})

	arg_7_0.startGameTime = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
