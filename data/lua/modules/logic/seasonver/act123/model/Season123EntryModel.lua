module("modules.logic.seasonver.act123.model.Season123EntryModel", package.seeall)

local var_0_0 = class("Season123EntryModel", BaseModel)

function var_0_0.release(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.activityId = arg_2_1
	arg_2_0._currentStage = 1
	arg_2_0._currentStageIndex = 1

	arg_2_0:initDatas()
	arg_2_0:initDefaultStage()
end

function var_0_0.getActId(arg_3_0)
	return arg_3_0.activityId
end

function var_0_0.initDatas(arg_4_0)
	arg_4_0.userId = PlayerModel.instance:getMyUserId()

	if not Season123Model.instance:getActInfo(arg_4_0.activityId) then
		logError("Not available season123 data! actId = " .. tostring(arg_4_0.activityId))

		return
	end

	local var_4_0 = Season123Config.instance:getStageCos(arg_4_0.activityId)

	if var_4_0 and #var_4_0 > 0 then
		local var_4_1 = 1

		arg_4_0._currentStage = var_4_0[var_4_1].stage
		arg_4_0._currentStageIndex = var_4_1
	end
end

function var_0_0.initDefaultStage(arg_5_0)
	local var_5_0 = Season123Model.instance:getActInfo(arg_5_0.activityId)

	if not var_5_0 then
		return
	end

	if var_5_0.stage ~= 0 and Season123ProgressUtils.stageInChallenge(arg_5_0.activityId, var_5_0.stage) then
		arg_5_0:setCurrentStage(var_5_0.stage)
	else
		local var_5_1 = Season123Config.instance:getStageCos(arg_5_0.activityId)

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_2 = var_5_0:getStageMO(iter_5_1.stage)

			if var_5_2 and var_5_2:isNeverTry() then
				arg_5_0:setCurrentStage(iter_5_1.stage)
			end
		end
	end
end

function var_0_0.getStageMO(arg_6_0, arg_6_1)
	local var_6_0 = Season123Model.instance:getActInfo(arg_6_0.activityId)

	if not var_6_0 then
		return nil
	end

	return var_6_0:getStageMO(arg_6_1)
end

function var_0_0.getPrevStage(arg_7_0)
	local var_7_0 = Season123Config.instance:getStageCos(arg_7_0.activityId)

	if not var_7_0 then
		return
	end

	if arg_7_0._currentStageIndex > 1 then
		return var_7_0[arg_7_0._currentStageIndex - 1].stage
	end
end

function var_0_0.getNextStage(arg_8_0)
	local var_8_0 = Season123Config.instance:getStageCos(arg_8_0.activityId)

	if not var_8_0 then
		return
	end

	if arg_8_0._currentStageIndex < #var_8_0 then
		return var_8_0[arg_8_0._currentStageIndex + 1].stage
	end
end

function var_0_0.getCurrentStage(arg_9_0)
	return arg_9_0._currentStage
end

function var_0_0.getCurrentStageIndex(arg_10_0)
	return arg_10_0._currentStageIndex
end

function var_0_0.setCurrentStage(arg_11_0, arg_11_1)
	if arg_11_0._currentStage == arg_11_1 then
		return
	end

	local var_11_0 = Season123Config.instance:getStageCos(arg_11_0.activityId)

	if not var_11_0 then
		return
	end

	for iter_11_0 = 1, #var_11_0 do
		if var_11_0[iter_11_0].stage == arg_11_1 then
			arg_11_0._currentStageIndex = iter_11_0
			arg_11_0._currentStage = arg_11_1

			return
		end
	end
end

function var_0_0.getUTTUTicketNum(arg_12_0)
	local var_12_0 = Season123Config.instance:getEquipItemCoin(arg_12_0.activityId, Activity123Enum.Const.UttuTicketsCoin)
	local var_12_1 = CurrencyConfig.instance:getCurrencyCo(var_12_0)

	if var_12_1 then
		local var_12_2 = var_12_1.recoverLimit

		return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_12_0), var_12_2
	else
		return nil, nil
	end
end

function var_0_0.isFirstOpen(arg_13_0)
	local var_13_0 = arg_13_0:getLocalKey()

	if not string.nilorempty(var_13_0) then
		local var_13_1 = PlayerPrefsHelper.getString(var_13_0, "")

		return string.nilorempty(var_13_1)
	end
end

function var_0_0.setAlreadyVisited(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getLocalKey(arg_14_1)

	if not string.nilorempty(var_14_0) then
		PlayerPrefsHelper.setString(var_14_0, "1")
	end
end

function var_0_0.getLocalKey(arg_15_0, arg_15_1)
	if not arg_15_0._localKey then
		local var_15_0 = PlayerModel.instance:getPlayinfo()

		if not var_15_0 or var_15_0.userId == 0 then
			return nil
		end

		arg_15_0._localKey = "Season123EntryModel#FirstEntry#" .. tostring(var_15_0.userId) .. "#" .. tostring(arg_15_1)
	end

	return arg_15_0._localKey
end

function var_0_0.getTrialCO(arg_16_0)
	local var_16_0 = Season123Model.instance:getActInfo(arg_16_0.activityId)

	if var_16_0 and var_16_0.trial ~= 0 then
		return Season123Config.instance:getTrialCO(arg_16_0.activityId, var_16_0.trial)
	end

	return nil
end

function var_0_0.isRetailOpen(arg_17_0)
	local var_17_0 = Season123Config.instance:getSeasonConstNum(arg_17_0.activityId, Activity123Enum.Const.RetailOpenStage)
	local var_17_1 = Season123Model.instance:getActInfo(arg_17_0.activityId)

	if not var_17_1 then
		return false
	end

	local var_17_2 = var_17_1:getStageMO(var_17_0)

	if var_17_2 then
		return var_17_2.isPass
	else
		return false
	end
end

function var_0_0.getRandomRetailRes(arg_18_0)
	local var_18_0 = arg_18_0 % #SeasonEntryEnum.ResPath + 1

	return var_18_0, SeasonEntryEnum.ResPath[var_18_0]
end

function var_0_0.stageIsPassed(arg_19_0, arg_19_1)
	local var_19_0 = Season123Model.instance:getActInfo(arg_19_0.activityId)

	if not var_19_0 then
		return false
	end

	local var_19_1 = var_19_0.stageMap[arg_19_1]

	return var_19_1 and var_19_1.isPass
end

function var_0_0.needPlayUnlockAnim(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:getUnlockKey(arg_20_1, arg_20_2)

	if not string.nilorempty(var_20_0) then
		local var_20_1 = PlayerPrefsHelper.getString(var_20_0, "")

		return string.nilorempty(var_20_1)
	end
end

function var_0_0.setAlreadyUnLock(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getUnlockKey(arg_21_1, arg_21_2)

	if not string.nilorempty(var_21_0) then
		PlayerPrefsHelper.setString(var_21_0, "1")
	end
end

function var_0_0.getUnlockKey(arg_22_0, arg_22_1, arg_22_2)
	return "EntryViewStageUnlock" .. tostring(arg_22_0.userId) .. "#" .. tostring(arg_22_1) .. tostring(arg_22_2)
end

function var_0_0.needPlayUnlockAnim1(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getUnlockKey1(arg_23_1, arg_23_2)

	if not string.nilorempty(var_23_0) then
		local var_23_1 = PlayerPrefsHelper.getString(var_23_0, "")

		return string.nilorempty(var_23_1)
	end
end

function var_0_0.setAlreadyUnLock1(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:getUnlockKey1(arg_24_1, arg_24_2)

	if not string.nilorempty(var_24_0) then
		PlayerPrefsHelper.setString(var_24_0, "1")
	end
end

function var_0_0.getUnlockKey1(arg_25_0, arg_25_1, arg_25_2)
	return "EntryOverviewStageUnlock" .. tostring(arg_25_0.userId) .. "#" .. tostring(arg_25_1) .. tostring(arg_25_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
