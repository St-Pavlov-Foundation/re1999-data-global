module("modules.logic.versionactivity2_5.act186.model.Activity186SignModel", package.seeall)

local var_0_0 = class("Activity186SignModel", BaseModel)

function var_0_0.getSignStatus(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if ActivityType101Model.instance:isType101RewardGet(arg_1_1, arg_1_3) then
		return Activity186Enum.SignStatus.Hasget
	end

	if not ActivityType101Model.instance:isType101RewardCouldGet(arg_1_1, arg_1_3) then
		return Activity186Enum.SignStatus.None
	end

	if Activity186Model.instance:getLocalPrefsState(Activity186Enum.LocalPrefsKey.SignMark, arg_1_2, arg_1_3, 0) == 0 then
		return Activity186Enum.SignStatus.Canplay
	end

	return Activity186Enum.SignStatus.Canget
end

var_0_0.instance = var_0_0.New()

return var_0_0
