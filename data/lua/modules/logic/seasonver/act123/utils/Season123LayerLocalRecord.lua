module("modules.logic.seasonver.act123.utils.Season123LayerLocalRecord", package.seeall)

local var_0_0 = class("Season123LayerLocalRecord")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1
	arg_1_0.reasonKey = PlayerPrefsKey.Season123LayerAnimAlreadyPlay
	arg_1_0._localKey = arg_1_0:getLocalKey()
	arg_1_0._dict = nil

	arg_1_0:initLocalSave()
end

function var_0_0.initLocalSave(arg_2_0)
	local var_2_0 = PlayerPrefsHelper.getString(arg_2_0._localKey, "")

	if not string.nilorempty(var_2_0) then
		local var_2_1 = cjson.decode(var_2_0)

		if var_2_1 then
			arg_2_0._dict = var_2_1
		else
			arg_2_0._dict = {}
		end
	else
		arg_2_0._dict = {}
	end
end

function var_0_0.add(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 > (arg_3_0._dict[arg_3_1] or 0) then
		arg_3_0._dict[arg_3_1] = arg_3_2

		arg_3_0:save()
	end
end

function var_0_0.contain(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return arg_4_2 > (arg_4_0._dict[arg_4_1] or 0)
end

function var_0_0.save(arg_5_0)
	PlayerPrefsHelper.setString(arg_5_0._localKey, cjson.encode(arg_5_0._dict))
end

function var_0_0.getLocalKey(arg_6_0)
	return tostring(arg_6_0.reasonKey) .. "#" .. tostring(arg_6_0.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return var_0_0
