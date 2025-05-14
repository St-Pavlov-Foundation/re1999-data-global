module("modules.logic.versionactivity2_4.pinball.controller.PinballStatHelper", package.seeall)

local var_0_0 = class("PinballStatHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0._gameBeginDt = 0
	arg_1_0._cityBeginDt = 0
	arg_1_0._useBallList = {}
end

function var_0_0.resetGameDt(arg_2_0)
	arg_2_0._gameBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.resetCityDt(arg_3_0)
	arg_3_0._cityBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.setCurUseBallList(arg_4_0, arg_4_1)
	arg_4_0._useBallList = arg_4_1
end

function var_0_0.sendGameFinish(arg_5_0)
	local var_5_0 = PinballModel.instance.leftEpisodeId
	local var_5_1 = lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_5_0]

	if not var_5_1 then
		return
	end

	local var_5_2 = {}

	for iter_5_0, iter_5_1 in pairs(PinballModel.instance.gameAddResDict) do
		table.insert(var_5_2, {
			id = iter_5_0,
			num = iter_5_1
		})
	end

	StatController.instance:track(StatEnum.EventName.act178_game_finish, {
		[StatEnum.EventProperties.EpisodeId_Num] = var_5_1.id,
		[StatEnum.EventProperties.EpisodeType_Num] = var_5_1.type,
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_5_0._gameBeginDt,
		[StatEnum.EventProperties.Act178BallList] = arg_5_0._useBallList,
		[StatEnum.EventProperties.Act178RewardInfo] = var_5_2,
		[StatEnum.EventProperties.Act178CityObj] = arg_5_0:_getCityInfo()
	})
end

function var_0_0.sendExitCity(arg_6_0)
	StatController.instance:track(StatEnum.EventName.act178_interface_exit, {
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - arg_6_0._cityBeginDt,
		[StatEnum.EventProperties.Act178CityObj] = arg_6_0:_getCityInfo()
	})
end

function var_0_0.sendResetCity(arg_7_0)
	StatController.instance:track(StatEnum.EventName.act178_reset, {
		[StatEnum.EventProperties.Act178CityObj] = arg_7_0:_getCityInfo()
	})
end

function var_0_0._getCityInfo(arg_8_0)
	local var_8_0 = {
		wood = PinballModel.instance:getResNum(PinballEnum.ResType.Wood),
		mine = PinballModel.instance:getResNum(PinballEnum.ResType.Mine),
		stone = PinballModel.instance:getResNum(PinballEnum.ResType.Stone),
		food = PinballModel.instance:getResNum(PinballEnum.ResType.Food),
		play = PinballModel.instance:getResNum(PinballEnum.ResType.Play),
		complaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint),
		score = PinballModel.instance:getResNum(PinballEnum.ResType.Score),
		day = PinballModel.instance.day,
		building_list = {}
	}

	for iter_8_0, iter_8_1 in pairs(PinballModel.instance._buildingInfo) do
		table.insert(var_8_0.building_list, string.format("%d_%d", iter_8_1.baseCo.id, iter_8_1.level))
	end

	var_8_0.talent_list = {}

	for iter_8_2, iter_8_3 in pairs(PinballModel.instance._unlockTalents) do
		table.insert(var_8_0.talent_list, iter_8_3.co.id)
	end

	return var_8_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
