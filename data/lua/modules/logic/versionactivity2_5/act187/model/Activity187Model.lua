module("modules.logic.versionactivity2_5.act187.model.Activity187Model", package.seeall)

local var_0_0 = class("Activity187Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0:setLoginCount()
	arg_3_0:setRemainPaintingCount()
	arg_3_0:setFinishPaintingIndex()
	arg_3_0:setAccrueRewardIndex()

	arg_3_0._paintingRewardDict = {}
end

function var_0_0.checkActId(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getAct187Id()
	local var_4_1 = arg_4_1 == var_4_0

	if not var_4_1 then
		logError(string.format("Activity187Model:setServerInfo error, not same actId, server:%s, local:%s", arg_4_1, var_4_0))
	end

	return var_4_1
end

function var_0_0.setAct187Info(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_0:setLoginCount(arg_5_1.loginCount)
	arg_5_0:setRemainPaintingCount(arg_5_1.haveGameCount)
	arg_5_0:setFinishPaintingIndex(arg_5_1.finishGameCount)
	arg_5_0:setAccrueRewardIndex(arg_5_1.acceptRewardGameCount)
	arg_5_0:setAllPaintingReward(arg_5_1.randomBonusInfos)
end

function var_0_0.setLoginCount(arg_6_0, arg_6_1)
	arg_6_0._loginCount = arg_6_1 or 0
end

function var_0_0.setRemainPaintingCount(arg_7_0, arg_7_1)
	arg_7_0._remainPaintingCount = arg_7_1 or 0
end

function var_0_0.setFinishPaintingIndex(arg_8_0, arg_8_1)
	arg_8_0._finishPaintingIndex = arg_8_1 or 0
end

function var_0_0.setAccrueRewardIndex(arg_9_0, arg_9_1)
	arg_9_0._accrueRewardIndex = arg_9_1 or 0
end

function var_0_0.setAllPaintingReward(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		arg_10_0:setPaintingRewardList(iter_10_0, iter_10_1.randomBonusList)
	end
end

function var_0_0.setPaintingRewardList(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		local var_11_1 = MaterialDataMO.New()

		var_11_1:initValue(iter_11_1.materilType, iter_11_1.materilId, iter_11_1.quantity)
		table.insert(var_11_0, var_11_1)
	end

	arg_11_0._paintingRewardDict[arg_11_1] = var_11_0
end

function var_0_0.getAct187Id(arg_12_0)
	return VersionActivity2_5Enum.ActivityId.LanternFestival
end

function var_0_0.isAct187Open(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1
	local var_13_2
	local var_13_3 = arg_13_0:getAct187Id()

	if ActivityModel.instance:getActivityInfo()[var_13_3] then
		var_13_0, var_13_1, var_13_2 = ActivityHelper.getActivityStatusAndToast(var_13_3)
	else
		var_13_1 = ToastEnum.ActivityEnd
	end

	if arg_13_1 and var_13_1 then
		GameFacade.showToast(var_13_1, var_13_2)
	end

	return var_13_0 == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.getAct187RemainTimeStr(arg_14_0)
	local var_14_0 = ""
	local var_14_1 = arg_14_0:getAct187Id()
	local var_14_2 = ActivityModel.instance:getActMO(var_14_1)

	if var_14_2 then
		local var_14_3 = var_14_2:getRemainTimeStr3()

		var_14_0 = string.format(luaLang("remain"), var_14_3)
	end

	return var_14_0
end

function var_0_0.getLoginCount(arg_15_0)
	return arg_15_0._loginCount
end

function var_0_0.getRemainPaintingCount(arg_16_0)
	return arg_16_0._remainPaintingCount
end

function var_0_0.getFinishPaintingIndex(arg_17_0)
	return arg_17_0._finishPaintingIndex
end

function var_0_0.getAccrueRewardIndex(arg_18_0)
	return arg_18_0._accrueRewardIndex
end

function var_0_0.getPaintingRewardList(arg_19_0, arg_19_1)
	return arg_19_0._paintingRewardDict and arg_19_0._paintingRewardDict[arg_19_1] or {}
end

function var_0_0.getPaintingRewardId(arg_20_0, arg_20_1)
	local var_20_0
	local var_20_1 = arg_20_0:getPaintingRewardList(arg_20_1)

	if var_20_1 and #var_20_1 then
		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			local var_20_2 = string.format("%s#%s", iter_20_1.materilType, iter_20_1.materilId)

			if string.nilorempty(var_20_0) then
				var_20_0 = var_20_2
			else
				var_20_0 = string.format("%s|%s", var_20_0, var_20_2)
			end
		end
	end

	return var_20_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
