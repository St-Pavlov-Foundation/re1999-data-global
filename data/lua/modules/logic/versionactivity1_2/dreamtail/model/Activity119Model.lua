module("modules.logic.versionactivity1_2.dreamtail.model.Activity119Model", package.seeall)

local var_0_0 = class("Activity119Model", BaseModel)

function var_0_0.reInit(arg_1_0)
	arg_1_0.data = nil
	arg_1_0.userData = nil
end

function var_0_0.getData(arg_2_0)
	if not arg_2_0.data then
		local var_2_0 = tostring(PlayerModel.instance:getMyUserId())
		local var_2_1 = PlayerPrefsHelper.getString(PlayerPrefsKey.DreamTailKey, "")

		if not string.nilorempty(var_2_1) then
			arg_2_0.data = cjson.decode(var_2_1)
			arg_2_0.userData = arg_2_0.data[var_2_0]

			if arg_2_0.data.activityId ~= VersionActivity1_2Enum.ActivityId.DreamTail then
				arg_2_0.data = nil
				arg_2_0.userData = nil
			end
		end

		if not arg_2_0.data then
			arg_2_0.data = {}
			arg_2_0.data.activityId = VersionActivity1_2Enum.ActivityId.DreamTail
		end

		if not arg_2_0.userData then
			arg_2_0.userData = {}
			arg_2_0.userData.unLockDay = 1
			arg_2_0.userData.lastSelectDay = 1
			arg_2_0.userData.lastSelectModel = 1
			arg_2_0.userData.unLockHardList = {}
			arg_2_0.data[var_2_0] = arg_2_0.userData

			arg_2_0:saveData()
		end
	end

	return arg_2_0.userData
end

function var_0_0.saveData(arg_3_0)
	if not arg_3_0.data then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.DreamTailKey, cjson.encode(arg_3_0.data))
end

var_0_0.instance = var_0_0.New()

return var_0_0
