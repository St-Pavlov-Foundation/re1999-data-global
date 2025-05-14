module("modules.logic.versionactivity2_5.autochess.controller.AutoChessHelper", package.seeall)

local var_0_0 = class("AutoChessHelper")

function var_0_0.sameWarZoneType(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0 ~= AutoChessEnum.WarZone.Two
	local var_1_1 = arg_1_1 ~= AutoChessEnum.WarZone.Two

	if var_1_0 and var_1_1 or not var_1_0 and not var_1_1 then
		return true
	end

	return false
end

function var_0_0.getMeshUrl(arg_2_0)
	return string.format("ui/assets/versionactivity_2_5_autochess/%s.asset", arg_2_0)
end

function var_0_0.getMaterialUrl(arg_3_0)
	if arg_3_0 then
		return AutoChessEnum.MaterialPath.Enemy
	else
		return AutoChessEnum.MaterialPath.Player
	end
end

function var_0_0.getEffectUrl(arg_4_0)
	return string.format("ui/viewres/versionactivity_2_5/autochess/skill/%s.prefab", arg_4_0)
end

function var_0_0.getMallRegionByType(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		if lua_auto_chess_mall.configDict[iter_5_1.mallId].type == arg_5_1 then
			return iter_5_1
		end
	end
end

function var_0_0.getBuffEnergy(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		if iter_6_1.id == 1004 or iter_6_1.id == 1005 then
			var_6_0 = var_6_0 + iter_6_1.layer
		end
	end

	return var_6_0
end

function var_0_0.hasUniversalBuff(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		if iter_7_1.id == 1015 then
			return true
		end
	end

	return false
end

function var_0_0.getLeaderSkillEffect(arg_8_0)
	local var_8_0 = lua_auto_chess_master_skill.configDict[arg_8_0]
	local var_8_1 = var_8_0.skillIndex

	if var_8_1 == 3 then
		return string.split(var_8_0.abilities, "#")
	else
		local var_8_2

		if var_8_1 == 1 then
			var_8_2 = tonumber(var_8_0.passiveChessSkills)
		elseif var_8_1 == 2 then
			var_8_2 = tonumber(var_8_0.activeChessSkill)
		end

		local var_8_3 = lua_auto_chess_skill.configDict[var_8_2]

		return string.split(var_8_3.effect1, "#")
	end
end

function var_0_0.getBuyChessCntByType(arg_9_0, arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		if lua_auto_chess.configDict[iter_9_1.chessId][1].race == arg_9_1 then
			var_9_0 = var_9_0 + iter_9_1.num
		end
	end

	return var_9_0
end

function var_0_0.isPrimeNumber(arg_10_0)
	arg_10_0 = tonumber(arg_10_0)

	if arg_10_0 == 2 then
		return true
	elseif arg_10_0 == 1 or arg_10_0 % 2 == 0 then
		return false
	else
		local var_10_0 = math.floor(math.sqrt(arg_10_0)) + 1

		for iter_10_0 = 3, var_10_0, 2 do
			if arg_10_0 % iter_10_0 == 0 then
				return false
			end
		end
	end

	return true
end

function var_0_0.lockScreen(arg_11_0, arg_11_1)
	if arg_11_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(arg_11_0)
	else
		UIBlockMgr.instance:endBlock(arg_11_0)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.getPlayerPrefs(arg_12_0, arg_12_1)
	local var_12_0 = PlayerModel.instance:getMyUserId()
	local var_12_1 = Activity182Model.instance:getCurActId()
	local var_12_2 = var_12_0 .. var_12_1 .. arg_12_0

	return PlayerPrefsHelper.getNumber(var_12_2, arg_12_1)
end

function var_0_0.setPlayerPrefs(arg_13_0, arg_13_1)
	local var_13_0 = PlayerModel.instance:getMyUserId()
	local var_13_1 = Activity182Model.instance:getCurActId()
	local var_13_2 = var_13_0 .. var_13_1 .. arg_13_0

	PlayerPrefsHelper.setNumber(var_13_2, arg_13_1)
end

function var_0_0.buildSkillDesc(arg_14_0)
	arg_14_0 = string.gsub(arg_14_0, "%[(.-)%]", var_0_0._replaceDescTagFunc)
	arg_14_0 = string.gsub(arg_14_0, "【(.-)】", var_0_0._replaceDescTagFunc)

	return arg_14_0
end

function var_0_0._replaceDescTagFunc(arg_15_0)
	local var_15_0 = AutoChessConfig.instance:getSkillEffectDescCoByName(arg_15_0)

	if not var_15_0 then
		return string.format("<b>%s</b>", arg_15_0)
	end

	return string.format("<b><u><link=%s>%s</link></u></b>", var_15_0.id, arg_15_0)
end

function var_0_0.buildEmptyChess()
	local var_16_0 = {}

	var_16_0.uid = 0
	var_16_0.id = 0

	return var_16_0
end

return var_0_0
