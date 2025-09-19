module("modules.logic.permanent.model.PermanentModel", package.seeall)

local var_0_0 = class("PermanentModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.localReadDic = {}
end

function var_0_0.getActivityDic(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = PermanentConfig.instance:getPermanentDic()

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		local var_3_2 = ActivityModel.instance:getActMO(iter_3_0)

		if var_3_2 then
			var_3_0[iter_3_0] = var_3_2
		end
	end

	return var_3_0
end

function var_0_0.undateActivityInfo(arg_4_0, arg_4_1)
	local var_4_0 = {}

	if arg_4_1 then
		var_4_0[1] = arg_4_1
	else
		local var_4_1 = PermanentConfig.instance:getPermanentDic()

		for iter_4_0, iter_4_1 in pairs(var_4_1) do
			local var_4_2 = ActivityModel.instance:getActMO(iter_4_0)

			if var_4_2 and var_4_2:isOnline() then
				var_4_0[#var_4_0 + 1] = iter_4_0
			end
		end
	end

	if #var_4_0 > 0 then
		ActivityRpc.instance:sendGetActivityInfosWithParamRequest(var_4_0)
	end
end

function var_0_0.hasActivityOnline(arg_5_0)
	local var_5_0 = arg_5_0:getActivityDic()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if iter_5_1.online then
			return true
		end
	end

	return false
end

function var_0_0.setActivityLocalRead(arg_6_0, arg_6_1)
	arg_6_0:_initLocalRead()

	if arg_6_1 then
		arg_6_1 = tostring(arg_6_1)
		arg_6_0.localReadDic[arg_6_1] = true
	else
		local var_6_0 = arg_6_0:getActivityDic()

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			iter_6_0 = tostring(iter_6_0)

			if not arg_6_0.localReadDic[iter_6_0] then
				arg_6_0.localReadDic[iter_6_0] = true
			end
		end
	end

	arg_6_0:_saveLocalRead()
end

function var_0_0.isActivityLocalRead(arg_7_0, arg_7_1)
	arg_7_0:_initLocalRead()

	local var_7_0 = arg_7_0:getActivityDic()

	if not arg_7_1 then
		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			local var_7_1 = ActivityModel.instance:isActOnLine(iter_7_0)

			iter_7_0 = tostring(iter_7_0)

			if var_7_1 and not arg_7_0.localReadDic[iter_7_0] then
				return false
			end
		end

		return true
	end

	arg_7_1 = tostring(arg_7_1)

	return arg_7_0.localReadDic[arg_7_1]
end

function var_0_0._initLocalRead(arg_8_0)
	if next(arg_8_0.localReadDic) then
		return
	end

	local var_8_0 = PlayerModel.instance:getMyUserId()
	local var_8_1 = PlayerPrefsHelper.getString(PlayerPrefsKey.PermanentLocalRead .. var_8_0)

	if not string.nilorempty(var_8_1) then
		arg_8_0.localReadDic = cjson.decode(var_8_1)
	end
end

function var_0_0._saveLocalRead(arg_9_0)
	local var_9_0 = PlayerModel.instance:getMyUserId()
	local var_9_1 = cjson.encode(arg_9_0.localReadDic)

	PlayerPrefsHelper.setString(PlayerPrefsKey.PermanentLocalRead .. var_9_0, var_9_1)
end

function var_0_0.IsDotShowPermanent2_1(arg_10_0)
	local var_10_0 = VersionActivity2_1Enum.ActivityId.EnterView
	local var_10_1 = ActivityModel.instance:getActMO(var_10_0)

	if not var_10_1 then
		return false
	end

	if not var_10_1:isPermanentUnlock() then
		return false
	end

	local var_10_2 = false

	for iter_10_0, iter_10_1 in ipairs(Permanent2_1EnterView.kRoleIndex2ActId or {}) do
		local var_10_3 = iter_10_1.actId
		local var_10_4 = iter_10_1.redDotId or 0

		var_10_2 = RedDotModel.instance:isDotShow(var_10_4, var_10_3)

		if var_10_2 then
			break
		end
	end

	var_10_2 = var_10_2 or Activity165Model.instance:isShowAct165Reddot()

	return var_10_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
