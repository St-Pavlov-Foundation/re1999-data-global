module("modules.logic.versionactivity2_7.act191.define.Activity191Helper", package.seeall)

local var_0_0 = class("Activity191Helper")
local var_0_1 = "<u><link=%s>%s</link></u>"

var_0_0.enBuildDescFmtDict = {
	[Activity191Enum.HyperLinkPattern.EnhanceDestiny] = string.format("[%s]", var_0_1),
	[Activity191Enum.HyperLinkPattern.EnhanceItem] = string.format("\"%s\"", var_0_1),
	[Activity191Enum.HyperLinkPattern.SkillDesc] = string.format("[%s]", var_0_1),
	[Activity191Enum.HyperLinkPattern.Hero] = string.format("[%s]", var_0_1)
}
var_0_0.jpBuildDescFmtDict = {
	[Activity191Enum.HyperLinkPattern.EnhanceItem] = string.format("「%s」", var_0_1)
}
var_0_0.krBuildDescFmtDict = {
	[Activity191Enum.HyperLinkPattern.Hero] = string.format("<%s>", var_0_1)
}

function var_0_0.replaceSymbol(arg_1_0)
	if LangSettings.instance:isJp() then
		arg_1_0 = string.gsub(arg_1_0, "『", "「")
		arg_1_0 = string.gsub(arg_1_0, "』", "」")
	end

	if LangSettings.instance:isEn() then
		arg_1_0 = string.gsub(arg_1_0, "『", "\"")
		arg_1_0 = string.gsub(arg_1_0, "』", "\"")
		arg_1_0 = string.gsub(arg_1_0, "「", "[")
		arg_1_0 = string.gsub(arg_1_0, "」", "]")
		arg_1_0 = string.gsub(arg_1_0, "﹝", "[")
		arg_1_0 = string.gsub(arg_1_0, "﹞", "]")
	end

	return arg_1_0
end

function var_0_0.setFetterIcon(arg_2_0, arg_2_1)
	UISpriteSetMgr.instance:setAct174Sprite(arg_2_0, arg_2_1)
end

function var_0_0.getHeadIconSmall(arg_3_0)
	if arg_3_0.type == Activity191Enum.CharacterType.Hero then
		return ResUrl.getHeadIconSmall(arg_3_0.skinId)
	else
		return ResUrl.monsterHeadIcon(arg_3_0.skinId)
	end
end

function var_0_0.getNodeIcon(arg_4_0)
	arg_4_0 = tonumber(arg_4_0)

	if arg_4_0 == 0 then
		return "act191_progress_largeicon_0"
	elseif arg_4_0 == Activity191Enum.NodeType.MixStore then
		return "act191_progress_largeicon_1"
	elseif var_0_0.isPveBattle(arg_4_0) then
		return "act191_progress_largeicon_2"
	elseif var_0_0.isPvpBattle(arg_4_0) then
		return "act191_progress_largeicon_3"
	elseif arg_4_0 == Activity191Enum.NodeType.RewardEvent or arg_4_0 == Activity191Enum.NodeType.BattleEvent then
		return "act191_progress_largeicon_4"
	elseif arg_4_0 == Activity191Enum.NodeType.MixStore then
		return "act191_progress_largeicon_5"
	elseif arg_4_0 == Activity191Enum.NodeType.RoleShop or arg_4_0 == Activity191Enum.NodeType.CollectionShop or tabletool.indexOf(Activity191Enum.TagShopField, arg_4_0) then
		return "act191_progress_largeicon_6"
	elseif arg_4_0 == Activity191Enum.NodeType.Enhance then
		return "act191_progress_largeicon_7"
	elseif arg_4_0 == Activity191Enum.NodeType.ReplaceEvent or arg_4_0 == Activity191Enum.NodeType.UpgradeEvent then
		return "act191_progress_largeicon_8"
	end
end

function var_0_0.lockScreen(arg_5_0, arg_5_1)
	if arg_5_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(arg_5_0)
	else
		UIBlockMgr.instance:endBlock(arg_5_0)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.getPlayerPrefs(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = PlayerModel.instance:getMyUserId() .. arg_6_0 .. arg_6_1

	return PlayerPrefsHelper.getNumber(var_6_0, arg_6_2)
end

function var_0_0.setPlayerPrefs(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = PlayerModel.instance:getMyUserId() .. arg_7_0 .. arg_7_1

	PlayerPrefsHelper.setNumber(var_7_0, arg_7_2)
end

function var_0_0.calcIndex(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if gohelper.isMouseOverGo(iter_8_1, arg_8_0) then
			return iter_8_0
		end
	end
end

function var_0_0.matchKeyInArray(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0 then
		logError("array is nil")

		return
	end

	arg_9_2 = arg_9_2 or "index"

	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		if iter_9_1[arg_9_2] == arg_9_1 then
			return iter_9_1
		end
	end
end

function var_0_0.isPveBattle(arg_10_0)
	if tabletool.indexOf(Activity191Enum.PveFiled, arg_10_0) then
		return true
	end
end

function var_0_0.isPvpBattle(arg_11_0)
	if tabletool.indexOf(Activity191Enum.PvpFiled, arg_11_0) then
		return true
	end
end

function var_0_0.isShopNode(arg_12_0)
	if arg_12_0 == Activity191Enum.NodeType.MixStore or arg_12_0 == Activity191Enum.NodeType.RoleShop or arg_12_0 == Activity191Enum.NodeType.CollectionShop or tabletool.indexOf(Activity191Enum.TagShopField, arg_12_0) then
		return true
	end
end

function var_0_0.getActiveFetterInfoList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		local var_13_1 = Activity191Config.instance:getRelationCoList(iter_13_0)

		if var_13_1 then
			for iter_13_2 = #var_13_1, 0, -1 do
				local var_13_2 = var_13_1[iter_13_2]

				if iter_13_1 >= var_13_2.activeNum then
					var_13_0[#var_13_0 + 1] = {
						config = var_13_2,
						count = iter_13_1
					}

					break
				end
			end
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		if arg_14_0.config.level == arg_14_1.config.level then
			if arg_14_0.count == arg_14_1.count then
				return arg_14_0.config.id < arg_14_1.config.id
			else
				return arg_14_0.count > arg_14_1.count
			end
		else
			return arg_14_0.config.level > arg_14_1.config.level
		end
	end)

	return var_13_0
end

function var_0_0.sortRoleCo(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.type == Activity191Enum.CharacterType.Hero

	if var_15_0 ~= (arg_15_1.type == Activity191Enum.CharacterType.Hero) then
		return var_15_0
	end

	if arg_15_0.quality ~= arg_15_1.quality then
		return arg_15_0.quality < arg_15_1.quality
	end

	return arg_15_0.roleId < arg_15_1.roleId
end

function var_0_0.sortFetterHeroList(arg_16_0, arg_16_1)
	if arg_16_0.inBag == arg_16_1.inBag then
		if arg_16_0.transfer == arg_16_1.transfer then
			if arg_16_0.config.quality == arg_16_1.config.quality then
				return arg_16_0.config.roleId < arg_16_1.config.roleId
			else
				return arg_16_0.config.quality < arg_16_1.config.quality
			end
		else
			return arg_16_0.transfer < arg_16_1.transfer
		end
	else
		return arg_16_0.inBag > arg_16_1.inBag
	end
end

function var_0_0.getWithBuildBattleHeroInfo(arg_17_0, arg_17_1)
	local var_17_0 = var_0_0.matchKeyInArray(arg_17_0, arg_17_1)

	if not var_17_0 then
		var_17_0 = Activity191Module_pb.Act191BattleHeroInfo()
		var_17_0.index = arg_17_1
		var_17_0.heroId = 0
		var_17_0.itemUid1 = 0
		var_17_0.itemUid2 = 0

		table.insert(arg_17_0, var_17_0)
	end

	return var_17_0
end

function var_0_0.getWithBuildSubHeroInfo(arg_18_0, arg_18_1)
	local var_18_0 = var_0_0.matchKeyInArray(arg_18_0, arg_18_1)

	if not var_18_0 then
		var_18_0 = Activity191Module_pb.Act191SubHeroInfo()
		var_18_0.index = arg_18_1
		var_18_0.heroId = 0

		table.insert(arg_18_0, var_18_0)
	end

	return var_18_0
end

function var_0_0.replaceSkill(arg_19_0, arg_19_1)
	if arg_19_1 then
		local var_19_0 = CharacterDestinyConfig.instance:getDestinyFacets(arg_19_0, 4)

		if var_19_0 then
			local var_19_1 = var_19_0.exchangeSkills

			if not string.nilorempty(var_19_1) then
				local var_19_2 = GameUtil.splitString2(var_19_1, true)

				for iter_19_0 = 1, #arg_19_1 do
					for iter_19_1, iter_19_2 in ipairs(var_19_2) do
						local var_19_3 = iter_19_2[1]
						local var_19_4 = iter_19_2[2]

						if arg_19_1[iter_19_0] == var_19_3 then
							arg_19_1[iter_19_0] = var_19_4
						end
					end
				end
			end
		end
	end

	return arg_19_1
end

function var_0_0.buildDesc(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if arg_20_2 then
		var_20_0 = string.format(luaLang("Activity191Helper_buildDesc"), arg_20_2, "%1")
	else
		var_20_0 = luaLang("Activity191Helper_buildDesc1")
	end

	local var_20_1 = var_0_0[tostring(LangSettings.instance:getCurLang()) .. "BuildDescFmtDict"]

	if var_20_1 then
		local var_20_2 = var_20_1[arg_20_1]

		if var_20_2 then
			var_20_0 = string.format(var_20_2, arg_20_2 or "%1", "%1")
		end
	end

	arg_20_0 = string.gsub(arg_20_0, arg_20_1, var_20_0)
	arg_20_0 = var_0_0.addColor(arg_20_0)

	return arg_20_0
end

function var_0_0.addColor(arg_21_0)
	local var_21_0 = string.format("<color=%s>%s</color>", "#4e6698", "%1")

	arg_21_0 = string.gsub(arg_21_0, "【.-】", var_21_0)

	local var_21_1 = string.format("<color=%s>%s</color>", "#C66030", "%1")

	arg_21_0 = string.gsub(arg_21_0, "[+-]?%d+%.%d+%%", var_21_1)
	arg_21_0 = string.gsub(arg_21_0, "[+-]?%d+%%", var_21_1)

	return arg_21_0
end

function var_0_0.clickHyperLinkDestiny(arg_22_0)
	local var_22_0 = string.splitToNumber(arg_22_0, "#")
	local var_22_1 = {
		config = Activity191Config.instance:getRoleCoByNativeId(var_22_0[1], 1),
		stoneId = var_22_0[2]
	}

	ViewMgr.instance:openView(ViewName.Act191CharacterDestinyView, var_22_1)
end

function var_0_0.clickHyperLinkItem(arg_23_0, arg_23_1)
	if string.find(arg_23_0, "#") then
		local var_23_0 = string.splitToNumber(arg_23_0, "#")[1]

		Activity191Controller.instance:openCollectionTipView({
			itemId = var_23_0
		})
	else
		SkillHelper.defaultClick(arg_23_0, arg_23_1)
	end
end

function var_0_0.clickHyperLinkSkill(arg_24_0, arg_24_1)
	if tonumber(arg_24_0) then
		SkillHelper.defaultClick(arg_24_0, arg_24_1)

		return
	end

	local var_24_0 = {
		effectId = arg_24_0,
		clickPosition = arg_24_1
	}

	ViewMgr.instance:openView(ViewName.Act191BuffTipView, var_24_0)
end

function var_0_0.clickHyperLinkRole(arg_25_0, arg_25_1)
	if string.find(arg_25_0, "#") then
		local var_25_0 = string.splitToNumber(arg_25_0, "#")[1]

		if var_25_0 then
			local var_25_1 = {
				preview = true,
				heroList = {
					tonumber(var_25_0)
				}
			}

			Activity191Controller.instance:openHeroTipView(var_25_1)
		end
	else
		SkillHelper.defaultClick(arg_25_0, arg_25_1)
	end
end

return var_0_0
