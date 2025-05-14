module("modules.logic.activity.controller.ActivityEnterMgr", package.seeall)

local var_0_0 = class("ActivityEnterMgr", BaseController)

function var_0_0.init(arg_1_0)
	arg_1_0:loadEnteredActivityDict()
end

function var_0_0.enterActivityByList(arg_2_0, arg_2_1)
	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if not arg_2_0:isEnteredActivity(iter_2_1) then
			var_2_0 = true

			table.insert(arg_2_0.enteredActList, arg_2_0:getActId(iter_2_1))
		end
	end

	if var_2_0 then
		PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), table.concat(arg_2_0.enteredActList, ";"))
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
	end
end

function var_0_0.enterActivity(arg_3_0, arg_3_1)
	if arg_3_0:isEnteredActivity(arg_3_1) then
		return
	end

	table.insert(arg_3_0.enteredActList, arg_3_0:getActId(arg_3_1))
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), table.concat(arg_3_0.enteredActList, ";"))
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
end

function var_0_0.loadEnteredActivityDict(arg_4_0)
	arg_4_0.enteredActList = {}

	local var_4_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), "")

	if string.nilorempty(var_4_0) then
		return
	end

	arg_4_0.enteredActList = string.splitToNumber(var_4_0, ";")
end

function var_0_0.isEnteredActivity(arg_5_0, arg_5_1)
	return tabletool.indexOf(arg_5_0.enteredActList, arg_5_0:getActId(arg_5_1))
end

function var_0_0.getActId(arg_6_0, arg_6_1)
	local var_6_0 = ActivityConfig.instance:getActivityCo(arg_6_1)

	if var_6_0 and var_6_0.isRetroAcitivity == 1 then
		arg_6_1 = -arg_6_1
	end

	return arg_6_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
