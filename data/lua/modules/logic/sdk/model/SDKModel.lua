module("modules.logic.sdk.model.SDKModel", package.seeall)

local var_0_0 = class("SDKModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()

	arg_1_0._isDmm = SDKMgr.instance:getChannelId() == "301"
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._baseProperties = {}

	arg_2_0:_modifyTrackDefine()
end

function var_0_0.isDmm(arg_3_0)
	return arg_3_0._isDmm
end

function var_0_0._updateBaseProperties(arg_4_0)
	local var_4_0 = SDKDataTrackMgr.instance:getDataTrackProperties()

	if string.nilorempty(var_4_0) then
		var_4_0 = cjson.encode(StatEnum.DefaultBaseProperties)
	end

	arg_4_0._baseProperties = cjson.decode(var_4_0)

	StatRpc.instance:sendUpdateClientStatBaseInfoRequest(var_4_0)
end

function var_0_0.updateBaseProperties(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:_updateBaseProperties()
	SDKController.instance:dispatchEvent(SDKEvent.BasePropertiesChange, arg_5_1, arg_5_2)
end

function var_0_0.isVistor(arg_6_0)
	return SDKMgr.instance:getUserType() == SDKEnum.AccountType.Guest
end

function var_0_0.setAccountBindBonus(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.accountBindBonus

	arg_7_0.accountBindBonus = arg_7_1

	if var_7_0 and var_7_0 ~= arg_7_1 then
		SDKController.instance:dispatchEvent(SDKEvent.UpdateAccountBindBonus, var_7_0, arg_7_1)
	end
end

function var_0_0.getAccountBindBonus(arg_8_0)
	return arg_8_0.accountBindBonus or SDKEnum.RewardType.None
end

function var_0_0._modifyTrackDefine(arg_9_0)
	arg_9_0:_modifyTrackDefine_EventName()
	arg_9_0:_modifyTrackDefine_EventProperties()
	arg_9_0:_modifyTrackDefine_PropertyTypes()
end

function var_0_0._modifyTrackDefine_EventName(arg_10_0)
	SDKDataTrackMgr.EventName.summon_client = "summon_client"
end

function var_0_0._modifyTrackDefine_EventProperties(arg_11_0)
	local var_11_0 = SDKDataTrackMgr.EventProperties

	var_11_0.poolid = "poolid"
	var_11_0.entrance = "entrance"
	var_11_0.position_list = "position_list"
end

function var_0_0._modifyTrackDefine_PropertyTypes(arg_12_0)
	local var_12_0 = SDKDataTrackMgr.PropertyTypes
	local var_12_1 = SDKDataTrackMgr.EventProperties

	var_12_0[var_12_1.poolid] = "number"
	var_12_0[var_12_1.entrance] = "string"
	var_12_0[var_12_1.position_list] = "string"
end

var_0_0.instance = var_0_0.New()

return var_0_0
