module("modules.logic.pcInput.model.PCInputModel", package.seeall)

local var_0_0 = class("PCInputModel", BaseModel)

var_0_0.Activity = {
	CommonDialog = 11,
	storyDialog = 10,
	room = 4,
	thrityDoor = 2,
	MainActivity = 1,
	battle = 3
}
var_0_0.Configfield = {
	description = 3,
	key = 4,
	hud = 1,
	editable = 5,
	id = 2
}
var_0_0.blockField = {
	mlstring = 2,
	hud = 1,
	blockkey = 3
}
var_0_0.ReplaceField = {
	replace = 2,
	keyName = 1
}
var_0_0.MainActivityFun = {
	curActivity = 10,
	Room = 13,
	hide = 9,
	activityCenter = 11,
	Role = 14,
	Enter = 12,
	Summon = 15
}
var_0_0.RoomActivityFun = {
	buy = 9,
	layout = 10,
	hide = 6,
	edit = 12,
	guting = 7,
	place = 11
}
var_0_0.battleActivityFun = {
	skillUp = 21,
	skillDown = 22,
	showSkill = 20
}
var_0_0.thrityDoorFun = {
	map = 5,
	Item1 = 7,
	bag = 6
}

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.checkKeyBinding(arg_2_0)
	if arg_2_0.keyBinding == nil then
		arg_2_0.keyBinding = arg_2_0:load()
	end
end

function var_0_0.Save(arg_3_0, arg_3_1)
	arg_3_0.keyBinding = arg_3_1

	local var_3_0 = cjson.encode(arg_3_0.keyBinding)

	PlayerPrefsHelper.setString("keyBinding", var_3_0)
end

function var_0_0.load(arg_4_0)
	local var_4_0 = PlayerPrefsHelper.getString("keyBinding")
	local var_4_1 = arg_4_0:loadFromConfig()

	if var_4_0 and var_4_0 ~= "null" then
		local var_4_2 = cjson.decode(var_4_0)

		GameUtil.removeJsonNull(var_4_2)

		return arg_4_0:CheckConfigUpdate(var_4_2, var_4_1)
	end

	return var_4_1
end

function var_0_0.CheckConfigUpdate(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = LuaUtil.deepCopy(arg_5_2)

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			if arg_5_1[iter_5_3.hud] and arg_5_1[iter_5_3.hud][iter_5_3.id] then
				getmetatable(iter_5_3).__newindex = nil
				iter_5_3[var_0_0.Configfield.key] = arg_5_1[iter_5_3.hud][iter_5_3.id][var_0_0.Configfield.key]
			end
		end
	end

	return var_5_0
end

function var_0_0.loadFromConfig(arg_6_0)
	return pcInputConfig.instance:getKeyBinding()
end

function var_0_0.findActivityById(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(var_0_0.Activity) do
		if iter_7_1 == arg_7_1 then
			return iter_7_0
		end
	end

	return nil
end

function var_0_0.getActivityKeys(arg_8_0, arg_8_1)
	arg_8_0:checkKeyBinding()

	local var_8_0 = arg_8_0:findActivityById(arg_8_1)

	if not var_8_0 then
		logError("activity not exist in PCInputModel.Activity")

		return nil
	end

	local var_8_1 = arg_8_0.keyBinding[var_0_0.Activity[var_8_0]]

	if not var_8_1 then
		logError("activity not exist in keyBinding")

		return nil
	end

	return var_8_1
end

function var_0_0.getkeyidBykeyName(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getkeyconfigBykeyName(arg_9_1, arg_9_2)

	if var_9_0 then
		return var_9_0[2]
	end
end

function var_0_0.getkeyconfigBykeyName(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getActivityKeys(arg_10_1)

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_1[4] == arg_10_2 then
			return iter_10_1
		end
	end
end

function var_0_0.getThirdDoorMoveKey(arg_11_0)
	local var_11_0 = arg_11_0:getActivityKeys(var_0_0.Activity.thrityDoor)

	return var_11_0[1][var_0_0.Configfield.key], var_11_0[2][var_0_0.Configfield.key], var_11_0[3][var_0_0.Configfield.key], var_11_0[4][var_0_0.Configfield.key]
end

function var_0_0.getKeyBinding(arg_12_0)
	arg_12_0:checkKeyBinding()

	return arg_12_0.keyBinding
end

function var_0_0.checkKeyCanModify(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.keyBinding[arg_13_1] then
		local var_13_0 = pcInputConfig.instance:getKeyBlock()[arg_13_1]

		if var_13_0 then
			for iter_13_0, iter_13_1 in pairs(var_13_0[var_0_0.blockField.blockkey]) do
				if iter_13_1 == arg_13_2 then
					return false
				end
			end
		end
	end

	return true
end

function var_0_0.getKey(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:checkKeyBinding()

	local var_14_0 = arg_14_0.keyBinding[arg_14_1]

	if var_14_0 then
		local var_14_1 = var_14_0[arg_14_2]

		if var_14_1 then
			return var_14_1[var_0_0.Configfield.key]
		end
	end

	return ""
end

function var_0_0.Reset(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:loadFromConfig()

	arg_15_0.keyBinding[arg_15_1] = var_15_0[arg_15_1]

	arg_15_0:Save(arg_15_0.keyBinding)
end

function var_0_0.ReplaceKeyName(arg_16_0, arg_16_1)
	local var_16_0 = pcInputConfig.instance:getKeyNameReplace()

	if var_16_0 then
		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			if iter_16_1[var_0_0.ReplaceField.keyName] == arg_16_1 then
				return iter_16_1[var_0_0.ReplaceField.replace]
			end
		end
	end

	return arg_16_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
