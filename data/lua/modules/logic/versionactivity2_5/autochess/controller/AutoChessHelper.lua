module("modules.logic.versionactivity2_5.autochess.controller.AutoChessHelper", package.seeall)

local var_0_0 = class("AutoChessHelper")

function var_0_0.sameWarZoneType(arg_1_0, arg_1_1)
	return (arg_1_0 == AutoChessEnum.WarZone.Two and 1 or 0) == (arg_1_1 == AutoChessEnum.WarZone.Two and 1 or 0)
end

function var_0_0.getMeshUrl(arg_2_0)
	return string.format("ui/assets/versionactivity_2_5_autochess/%s.asset", arg_2_0)
end

function var_0_0.getMaterialUrl(arg_3_0)
	if arg_3_0 then
		return "ui/materials/dynamic/outlinesprite_lw_ui_00.mat"
	else
		return "ui/materials/dynamic/outlinesprite_lw_ui_01.mat"
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

function var_0_0.getBuffCnt(arg_6_0, arg_6_1)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
			if iter_6_1.id == iter_6_3 then
				var_6_0 = var_6_0 + iter_6_1.layer
			end
		end
	end

	return var_6_0
end

function var_0_0.universalMix(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		if iter_7_1.id == 1015 then
			return true
		else
			local var_7_0 = lua_auto_chess_buff.configDict[iter_7_1.id]
			local var_7_1 = string.split(var_7_0.effect, "#")

			if var_7_0.type == 1015 and var_7_1[1] == "UniversalBabyRace" and (var_7_1[2] == "None" or var_7_1[2] == arg_7_0) and (var_7_1[3] == "None" or var_7_1[3] == arg_7_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.canMix(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.id
	local var_8_1 = arg_8_1.id
	local var_8_2 = tabletool.indexOf(AutoChessEnum.PenguinChessIds, var_8_0)
	local var_8_3 = tabletool.indexOf(AutoChessEnum.PenguinChessIds, var_8_1)

	if var_8_2 and var_8_3 then
		local var_8_4 = arg_8_0.buffContainer.buffs

		for iter_8_0, iter_8_1 in ipairs(var_8_4) do
			local var_8_5 = lua_auto_chess_buff.configDict[iter_8_1.id]
			local var_8_6 = string.split(var_8_5.effect, "#")

			if var_8_5.type == 1015 and var_8_6[1] == "PenguinTeam" then
				for iter_8_2 = 2, #var_8_6 do
					if string.splitToNumber(var_8_6[iter_8_2], ",")[1] == var_8_1 then
						return true, true
					end
				end
			end
		end

		return false, ToastEnum.AutoChessPenguinMix
	elseif not var_8_2 and not var_8_3 then
		local var_8_7 = AutoChessConfig.instance:getChessCfgById(var_8_0, arg_8_0.star)

		if var_8_0 == var_8_1 or var_0_0.universalMix(var_8_7.race, var_8_7.subRace, arg_8_1.buffContainer.buffs) then
			return true
		end
	end

	return false, ToastEnum.AutoChessBuyTargetError
end

function var_0_0.getLeaderSkillEffect(arg_9_0)
	local var_9_0 = lua_auto_chess_master_skill.configDict[arg_9_0]
	local var_9_1 = var_9_0.skillIndex

	if var_9_1 == 3 then
		return string.split(var_9_0.abilities, "#")
	else
		local var_9_2

		if var_9_1 == 1 then
			var_9_2 = tonumber(var_9_0.passiveChessSkills)
		elseif var_9_1 == 2 then
			var_9_2 = tonumber(var_9_0.activeChessSkill)
		end

		local var_9_3 = lua_auto_chess_skill.configDict[var_9_2]

		if var_9_3 then
			return string.split(var_9_3.effect1, "#")
		end
	end
end

function var_0_0.getBuyChessCnt(arg_10_0, arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
		if iter_10_1.chessId == arg_10_1 then
			return iter_10_1.num
		end
	end

	return var_10_0
end

function var_0_0.getBuyChessCntByType(arg_11_0, arg_11_1)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		local var_11_1 = AutoChessConfig.instance:getChessCfgById(iter_11_1.chessId)
		local var_11_2, var_11_3 = next(var_11_1)

		if var_11_3 and var_11_3.race == arg_11_1 then
			var_11_0 = var_11_0 + iter_11_1.num
		end
	end

	return var_11_0
end

function var_0_0.isPrimeNumber(arg_12_0)
	arg_12_0 = tonumber(arg_12_0)

	if arg_12_0 == 2 then
		return true
	elseif arg_12_0 == 1 or arg_12_0 % 2 == 0 then
		return false
	else
		local var_12_0 = math.floor(math.sqrt(arg_12_0)) + 1

		for iter_12_0 = 3, var_12_0, 2 do
			if arg_12_0 % iter_12_0 == 0 then
				return false
			end
		end
	end

	return true
end

function var_0_0.lockScreen(arg_13_0, arg_13_1)
	if arg_13_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(arg_13_0)
	else
		UIBlockMgr.instance:endBlock(arg_13_0)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.getPlayerPrefs(arg_14_0, arg_14_1)
	local var_14_0 = PlayerModel.instance:getMyUserId()
	local var_14_1 = Activity182Model.instance:getCurActId()
	local var_14_2 = var_14_0 .. var_14_1 .. arg_14_0

	return PlayerPrefsHelper.getNumber(var_14_2, arg_14_1)
end

function var_0_0.setPlayerPrefs(arg_15_0, arg_15_1)
	local var_15_0 = PlayerModel.instance:getMyUserId()
	local var_15_1 = Activity182Model.instance:getCurActId()
	local var_15_2 = var_15_0 .. var_15_1 .. arg_15_0

	PlayerPrefsHelper.setNumber(var_15_2, arg_15_1)
end

function var_0_0.buildSkillDesc(arg_16_0)
	arg_16_0 = string.gsub(arg_16_0, "%[(.-)%]", var_0_0._replaceDescTagFunc)
	arg_16_0 = string.gsub(arg_16_0, "【(.-)】", var_0_0._replaceDescTagFunc)

	return arg_16_0
end

function var_0_0._replaceDescTagFunc(arg_17_0)
	local var_17_0 = AutoChessConfig.instance:getSkillEffectDescCoByName(arg_17_0)

	if not var_17_0 then
		return string.format("<b>%s</b>", arg_17_0)
	end

	return string.format("<b><u><link=%s>%s</link></u></b>", var_17_0.id, arg_17_0)
end

function var_0_0.buildEmptyChess()
	local var_18_0 = {}

	var_18_0.uid = 0
	var_18_0.id = 0

	return var_18_0
end

return var_0_0
