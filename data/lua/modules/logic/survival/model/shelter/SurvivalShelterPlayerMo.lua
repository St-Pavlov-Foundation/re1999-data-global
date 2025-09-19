module("modules.logic.survival.model.shelter.SurvivalShelterPlayerMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterPlayerMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.shelterMapId = arg_1_1

	if arg_1_2 then
		arg_1_0:deleteLocalData()
	end

	local var_1_0 = arg_1_0:getLocalkKey()
	local var_1_1 = PlayerPrefsHelper.getString(var_1_0)

	if string.nilorempty(var_1_1) then
		var_1_1 = SurvivalConfig.instance:getShelterPlayerInitPos(arg_1_1)

		local var_1_2 = string.splitToNumber(var_1_1, "#")

		arg_1_0:setPos(var_1_2[1], var_1_2[2], var_1_2[3])

		arg_1_0.dir = SurvivalEnum.Dir.Right
	else
		local var_1_3 = string.splitToNumber(var_1_1, "#")

		arg_1_0.dir = var_1_3[4] or SurvivalEnum.Dir.Right

		arg_1_0:setPos(var_1_3[1], var_1_3[2], var_1_3[3])
	end
end

function var_0_0.setPos(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:getPos():set(arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.getPos(arg_3_0)
	if arg_3_0.pos == nil then
		arg_3_0.pos = SurvivalHexNode.New()
	end

	return arg_3_0.pos
end

function var_0_0.setPosAndDir(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2 and arg_4_0.dir ~= arg_4_2
	local var_4_1 = arg_4_1 and arg_4_0.pos ~= arg_4_1

	if var_4_1 then
		arg_4_0:setPos(arg_4_1.q, arg_4_1.r, arg_4_1.s)
	end

	if var_4_0 then
		arg_4_0.dir = arg_4_2
	end

	if var_4_1 or var_4_0 then
		arg_4_0:savePosAndDir()
	end

	if var_4_1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShelterMapPlayerPosChange)
	end
end

function var_0_0.savePosAndDir(arg_5_0)
	local var_5_0 = arg_5_0:getLocalkKey()

	PlayerPrefsHelper.setString(var_5_0, string.format("%s#%s#%s#%s", arg_5_0.pos.q, arg_5_0.pos.r, arg_5_0.pos.s, arg_5_0.dir))
end

function var_0_0.getLocalkKey(arg_6_0)
	return (string.format("%s_survival_shelter_playerpos_%s", PlayerModel.instance:getPlayinfo().userId, arg_6_0.shelterMapId))
end

function var_0_0.deleteLocalData(arg_7_0)
	local var_7_0 = arg_7_0:getLocalkKey()

	PlayerPrefsHelper.deleteKey(var_7_0)
end

return var_0_0
