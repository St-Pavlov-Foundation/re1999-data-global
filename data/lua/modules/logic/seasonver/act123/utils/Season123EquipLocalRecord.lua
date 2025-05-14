module("modules.logic.seasonver.act123.utils.Season123EquipLocalRecord", package.seeall)

local var_0_0 = class("Season123EquipLocalRecord")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityId = arg_1_1
	arg_1_0.reasonKey = arg_1_2
	arg_1_0._list = nil
	arg_1_0._dict = nil

	arg_1_0:initLocalSave()
end

function var_0_0.initLocalSave(arg_2_0)
	arg_2_0._dict = {}

	local var_2_0 = PlayerPrefsHelper.getString(arg_2_0:getLocalKey(), "")

	if not string.nilorempty(var_2_0) then
		arg_2_0._list = cjson.decode(var_2_0)

		for iter_2_0, iter_2_1 in ipairs(arg_2_0._list) do
			arg_2_0._dict[iter_2_1] = 1
		end
	else
		arg_2_0._list = {}
	end
end

function var_0_0.recordAllItem(arg_3_0)
	local var_3_0 = Season123Model.instance:getAllUnlockAct123EquipIds(arg_3_0.activityId) or {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		arg_3_0:add(iter_3_0)
	end

	arg_3_0:save()
end

function var_0_0.add(arg_4_0, arg_4_1)
	if not arg_4_0._dict[arg_4_1] then
		table.insert(arg_4_0._list, arg_4_1)

		arg_4_0._dict[arg_4_1] = 1
	end
end

function var_0_0.contain(arg_5_0, arg_5_1)
	return arg_5_0._dict[arg_5_1]
end

function var_0_0.save(arg_6_0)
	PlayerPrefsHelper.setString(arg_6_0:getLocalKey(), cjson.encode(arg_6_0._list))
end

function var_0_0.getLocalKey(arg_7_0)
	return tostring(arg_7_0.reasonKey) .. "#" .. tostring(arg_7_0.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return var_0_0
