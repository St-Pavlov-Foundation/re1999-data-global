module("modules.logic.seasonver.act166.model.Season166TrainModel", package.seeall)

local var_0_0 = class("Season166TrainModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:cleanData()
end

function var_0_0.cleanData(arg_3_0)
	arg_3_0.curTrainId = 0
	arg_3_0.curTrainConfig = nil
	arg_3_0.curEpisodeId = nil
end

function var_0_0.initTrainData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.actId = arg_4_1
	arg_4_0.curTrainId = arg_4_2
	arg_4_0.curTrainConfig = Season166Config.instance:getSeasonTrainCo(arg_4_1, arg_4_2)
	arg_4_0.curEpisodeId = arg_4_0.curTrainConfig and arg_4_0.curTrainConfig.episodeId
end

function var_0_0.checkIsFinish(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = Season166Model.instance:getActInfo(arg_5_1).trainInfoMap[arg_5_2]

	return var_5_0 and var_5_0.passCount > 0
end

function var_0_0.getCurTrainPassCount(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = Season166Config.instance:getSeasonTrainCos(arg_6_1)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if arg_6_0:checkIsFinish(arg_6_1, iter_6_1.trainId) then
			var_6_0 = var_6_0 + 1
		end
	end

	return var_6_0
end

function var_0_0.isHardEpisodeUnlockTime(arg_7_0, arg_7_1)
	local var_7_0 = ActivityModel.instance:getActMO(arg_7_1)
	local var_7_1 = Season166Config.instance:getSeasonConstNum(arg_7_1, Season166Enum.SpOpenTimeConstId)
	local var_7_2 = var_7_1 > 0 and var_7_1 - 1
	local var_7_3 = ServerTime.now() - var_7_0:getRealStartTimeStamp()
	local var_7_4 = math.floor(var_7_3 / TimeUtil.OneDaySecond)
	local var_7_5 = var_7_2 <= var_7_4
	local var_7_6 = var_7_2 - var_7_4

	return var_7_5, var_7_6
end

function var_0_0.getUnlockTrainInfoMap(arg_8_0, arg_8_1)
	local var_8_0 = Season166Model.instance:getActInfo(arg_8_1)

	return tabletool.copy(var_8_0.trainInfoMap)
end

var_0_0.instance = var_0_0.New()

return var_0_0
