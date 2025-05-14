module("modules.logic.versionactivity1_3.act125.model.Activity125Model", package.seeall)

local var_0_0 = class("Activity125Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.setActivityInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getById(arg_3_1.activityId)

	if not var_3_0 then
		var_3_0 = Activity125MO.New()

		var_3_0:setInfo(arg_3_1)
		arg_3_0:addAtLast(var_3_0)
	else
		var_3_0:setInfo(arg_3_1)
	end
end

function var_0_0.refreshActivityInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getById(arg_4_1.activityId)

	if not var_4_0 then
		return
	end

	var_4_0:updateInfo(arg_4_1.updateAct125Episodes)
end

function var_0_0.isEpisodeFinished(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getById(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:isEpisodeFinished(arg_5_2)
end

function var_0_0.isEpisodeUnLock(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	if not var_6_0 then
		return
	end

	return var_6_0:isEpisodeUnLock(arg_6_2)
end

function var_0_0.isEpisodeDayOpen(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getById(arg_7_1)

	if not var_7_0 then
		return
	end

	return var_7_0:isEpisodeDayOpen(arg_7_2)
end

function var_0_0.isEpisodeReallyOpen(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getById(arg_8_1)

	if not var_8_0 then
		return
	end

	return var_8_0:isEpisodeReallyOpen(arg_8_2)
end

function var_0_0.getLastEpisode(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getById(arg_9_1)

	if not var_9_0 then
		return
	end

	return var_9_0:getLastEpisode()
end

function var_0_0.setLocalIsPlay(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getById(arg_10_1)

	if not var_10_0 then
		return
	end

	var_10_0:setLocalIsPlay(arg_10_2)
end

function var_0_0.checkLocalIsPlay(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getById(arg_11_1)

	if not var_11_0 then
		return
	end

	return var_11_0:checkLocalIsPlay(arg_11_2)
end

function var_0_0.getEpisodeCount(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getById(arg_12_1)

	if not var_12_0 then
		return
	end

	return var_12_0:getEpisodeCount()
end

function var_0_0.getEpisodeList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getById(arg_13_1)

	if not var_13_0 then
		return
	end

	return var_13_0:getEpisodeList()
end

function var_0_0.getEpisodeConfig(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getById(arg_14_1)

	if not var_14_0 then
		return
	end

	return var_14_0:getEpisodeConfig(arg_14_2)
end

function var_0_0.setSelectEpisodeId(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getById(arg_15_1)

	if not var_15_0 then
		return
	end

	return var_15_0:setSelectEpisodeId(arg_15_2)
end

function var_0_0.getSelectEpisodeId(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getById(arg_16_1)

	if not var_16_0 then
		return
	end

	return var_16_0:getSelectEpisodeId()
end

function var_0_0.setOldEpisode(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getById(arg_17_1)

	if not var_17_0 then
		return
	end

	var_17_0:setOldEpisode(arg_17_2)
end

function var_0_0.checkIsOldEpisode(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getById(arg_18_1)

	if not var_18_0 then
		return
	end

	return var_18_0:checkIsOldEpisode(arg_18_2)
end

function var_0_0.isAllEpisodeFinish(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getById(arg_19_1)

	if not var_19_0 then
		return
	end

	return var_19_0:isAllEpisodeFinish()
end

function var_0_0.isHasEpisodeCanReceiveReward(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getById(arg_20_1)

	if not var_20_0 then
		return
	end

	return var_20_0:isHasEpisodeCanReceiveReward(arg_20_2)
end

function var_0_0.isFirstCheckEpisode(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getById(arg_21_1)

	if not var_21_0 then
		return
	end

	return var_21_0:isFirstCheckEpisode(arg_21_2)
end

function var_0_0.setHasCheckEpisode(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getById(arg_22_1)

	if not var_22_0 then
		return
	end

	return var_22_0:setHasCheckEpisode(arg_22_2)
end

function var_0_0.hasEpisodeCanCheck(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getById(arg_23_1)

	if not var_23_0 then
		return
	end

	return var_23_0:hasEpisodeCanCheck()
end

function var_0_0.hasEpisodeCanGetReward(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getById(arg_24_1)

	if not var_24_0 then
		return
	end

	return var_24_0:hasEpisodeCanGetReward()
end

function var_0_0.hasRedDot(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getById(arg_25_1)

	if not var_25_0 then
		return
	end

	return var_25_0:hasRedDot()
end

function var_0_0.isActivityOpen(arg_26_0, arg_26_1)
	if ActivityModel.instance:isActOnLine(arg_26_1) == false then
		return false
	end

	local var_26_0 = ActivityModel.instance:getActMO(arg_26_1)

	return var_26_0:isOpen() and not var_26_0:isExpired()
end

var_0_0.instance = var_0_0.New()

return var_0_0
