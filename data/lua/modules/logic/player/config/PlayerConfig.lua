module("modules.logic.player.config.PlayerConfig", package.seeall)

local var_0_0 = class("PlayerConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.playconfig = nil
	arg_1_0._clothSkillDict = nil
	arg_1_0.playerClothConfig = nil
	arg_1_0.playerBgDict = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"player_level",
		"cloth",
		"cloth_level",
		"player_bg"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "player_level" then
		arg_3_0.playconfig = arg_3_2
	elseif arg_3_1 == "cloth_level" then
		arg_3_0._clothSkillDict = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			arg_3_0:_initClothSkill(iter_3_1, 1)
			arg_3_0:_initClothSkill(iter_3_1, 2)
			arg_3_0:_initClothSkill(iter_3_1, 3)
		end
	elseif arg_3_1 == "cloth" then
		arg_3_0.playerClothConfig = arg_3_2

		arg_3_0:buildPlayerConfigRare()
	elseif arg_3_1 == "player_bg" then
		arg_3_0.playerBgDict = {}

		for iter_3_2, iter_3_3 in ipairs(arg_3_2.configList) do
			arg_3_0.playerBgDict[iter_3_3.item] = iter_3_3
		end
	end
end

function var_0_0.buildPlayerConfigRare(arg_4_0)
	if not arg_4_0.playerClothConfig then
		return
	end

	local var_4_0 = getmetatable(lua_cloth.configList[1])
	local var_4_1 = {
		__index = function(arg_5_0, arg_5_1)
			if arg_5_1 == "rare" then
				return 5
			end

			return var_4_0.__index(arg_5_0, arg_5_1)
		end,
		__newindex = var_4_0.__newindex
	}

	for iter_4_0, iter_4_1 in ipairs(lua_cloth.configList) do
		setmetatable(iter_4_1, var_4_1)
	end
end

function var_0_0.getBgCo(arg_6_0, arg_6_1)
	return arg_6_0.playerBgDict[arg_6_1]
end

function var_0_0._initClothSkill(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.id
	local var_7_1 = arg_7_1.level
	local var_7_2 = arg_7_1["skill" .. arg_7_2]

	if var_7_2 and var_7_2 > 0 then
		if not arg_7_0._clothSkillDict[var_7_0] then
			arg_7_0._clothSkillDict[var_7_0] = {}
		end

		if not arg_7_0._clothSkillDict[var_7_0][arg_7_2] then
			arg_7_0._clothSkillDict[var_7_0][arg_7_2] = {
				var_7_2,
				var_7_1
			}
		end
	end
end

function var_0_0.getPlayerLevelCO(arg_8_0, arg_8_1)
	return arg_8_0.playconfig.configDict[arg_8_1]
end

function var_0_0.getPlayerClothConfig(arg_9_0, arg_9_1)
	return arg_9_0.playerClothConfig.configDict[arg_9_1]
end

function var_0_0.getClothSkill(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._clothSkillDict then
		local var_10_0 = arg_10_0._clothSkillDict[arg_10_1]

		if var_10_0 then
			return var_10_0[arg_10_2]
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
