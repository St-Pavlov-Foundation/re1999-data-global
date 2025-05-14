module("modules.logic.settings.model.SettingsKeyListModel", package.seeall)

local var_0_0 = class("SettingsKeyListModel", ListScrollModel)

function var_0_0.Init(arg_1_0)
	arg_1_0._keyMaps = PCInputController.instance:getKeyMap()
end

function var_0_0.SetActivity(arg_2_0, arg_2_1)
	arg_2_0:clear()

	local var_2_0 = arg_2_0._keyMaps[arg_2_1]

	if var_2_0 then
		local var_2_1 = {}

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if iter_2_1.editable == 1 then
				table.insert(var_2_1, {
					id = iter_2_1.id,
					value = iter_2_1
				})
			end
		end

		table.sort(var_2_1, function(arg_3_0, arg_3_1)
			return arg_3_0.id < arg_3_1.id
		end)
		arg_2_0:setList(var_2_1)
	end
end

function var_0_0.Reset(arg_4_0, arg_4_1)
	PCInputModel.instance:Reset(arg_4_1)

	arg_4_0._keyMaps = PCInputController.instance:getKeyMap()

	arg_4_0:SetActivity(arg_4_1)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function var_0_0.modifyKey(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0._keyMaps[arg_5_1]

	if not var_5_0 or not var_5_0[arg_5_2] then
		logError("SettingsKeyListModel:modifyKey error, activityId = %s, keyId = %s", arg_5_1, arg_5_2)

		return
	end

	var_5_0[arg_5_2][4] = arg_5_3

	arg_5_0:SetActivity(arg_5_1)
	arg_5_0:saveKeyMap()
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function var_0_0.checkDunplicateKey(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._keyMaps[arg_6_1]

	if not var_6_0 then
		logError("SettingsKeyListModel:checkDunplicateKey error, activityId = %s, keyId = %s", arg_6_1, arg_6_2)

		return
	end

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1.key == arg_6_2 then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.saveKeyMap(arg_7_0)
	PCInputController.instance:saveKeyMap(arg_7_0._keyMaps)
end

var_0_0.instance = var_0_0.New()

return var_0_0
