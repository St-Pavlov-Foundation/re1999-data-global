module("modules.logic.versionactivity2_7.act191.define.Activity191Helper", package.seeall)

local var_0_0 = class("Activity191Helper")
local var_0_1 = "<u><link=%s>%s</link></u>"

var_0_0.enBuildDescFmtDict = {
	[Activity191Enum.HyperLinkPattern.EnhanceDestiny] = string.format("[%s]", var_0_1),
	[Activity191Enum.HyperLinkPattern.EnhanceItem] = string.format("\"%s\"", var_0_1),
	[Activity191Enum.HyperLinkPattern.SkillDesc] = string.format("[%s]", var_0_1)
}
var_0_0.jpBuildDescFmtDict = {
	[Activity191Enum.HyperLinkPattern.EnhanceItem] = string.format("「%s」", var_0_1)
}

function var_0_0.setFetterIcon(arg_1_0, arg_1_1)
	UISpriteSetMgr.instance:setAct174Sprite(arg_1_0, arg_1_1)
end

function var_0_0.getHeadIconSmall(arg_2_0)
	if arg_2_0.type == Activity191Enum.CharacterType.Hero then
		return ResUrl.getHeadIconSmall(arg_2_0.skinId)
	else
		return ResUrl.monsterHeadIcon(arg_2_0.skinId)
	end
end

function var_0_0.getNodeIcon(arg_3_0)
	arg_3_0 = tonumber(arg_3_0)

	if arg_3_0 == 0 then
		return "act191_progress_largeicon_0"
	elseif var_0_0.isPveBattle(arg_3_0) then
		return "act191_progress_largeicon_2"
	elseif var_0_0.isPvpBattle(arg_3_0) then
		return "act191_progress_largeicon_3"
	elseif arg_3_0 == Activity191Enum.NodeType.RewardEvent or arg_3_0 == Activity191Enum.NodeType.BattleEvent then
		return "act191_progress_largeicon_4"
	elseif arg_3_0 == Activity191Enum.NodeType.MixStore then
		return "act191_progress_largeicon_5"
	elseif arg_3_0 == Activity191Enum.NodeType.RoleShop or arg_3_0 == Activity191Enum.NodeType.CollectionShop or tabletool.indexOf(Activity191Enum.TagShopField, arg_3_0) then
		return "act191_progress_largeicon_6"
	elseif arg_3_0 == Activity191Enum.NodeType.Enhance then
		return "act191_progress_largeicon_7"
	end
end

function var_0_0.lockScreen(arg_4_0, arg_4_1)
	if arg_4_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(arg_4_0)
	else
		UIBlockMgr.instance:endBlock(arg_4_0)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.getPlayerPrefs(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = PlayerModel.instance:getMyUserId() .. arg_5_0 .. arg_5_1

	return PlayerPrefsHelper.getNumber(var_5_0, arg_5_2)
end

function var_0_0.setPlayerPrefs(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = PlayerModel.instance:getMyUserId() .. arg_6_0 .. arg_6_1

	PlayerPrefsHelper.setNumber(var_6_0, arg_6_2)
end

function var_0_0.calcIndex(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if gohelper.isMouseOverGo(iter_7_1, arg_7_0) then
			return iter_7_0
		end
	end
end

function var_0_0.matchKeyInArray(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0 then
		logError("array is nil")

		return
	end

	arg_8_2 = arg_8_2 or "index"

	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		if iter_8_1[arg_8_2] == arg_8_1 then
			return iter_8_1
		end
	end
end

function var_0_0.isPveBattle(arg_9_0)
	if tabletool.indexOf(Activity191Enum.PveFiled, arg_9_0) then
		return true
	end
end

function var_0_0.isPvpBattle(arg_10_0)
	if tabletool.indexOf(Activity191Enum.PvpFiled, arg_10_0) then
		return true
	end
end

function var_0_0.isShopNode(arg_11_0)
	if arg_11_0 == Activity191Enum.NodeType.MixStore or arg_11_0 == Activity191Enum.NodeType.RoleShop or arg_11_0 == Activity191Enum.NodeType.CollectionShop or tabletool.indexOf(Activity191Enum.TagShopField, arg_11_0) then
		return true
	end
end

function var_0_0.getActiveFetterInfoList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0) do
		local var_12_1 = Activity191Config.instance:getRelationCoList(iter_12_0)

		if var_12_1 then
			for iter_12_2 = #var_12_1, 0, -1 do
				local var_12_2 = var_12_1[iter_12_2]

				if iter_12_1 >= var_12_2.activeNum then
					var_12_0[#var_12_0 + 1] = {
						config = var_12_2,
						count = iter_12_1
					}

					break
				end
			end
		end
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		if arg_13_0.config.level == arg_13_1.config.level then
			if arg_13_0.count == arg_13_1.count then
				return arg_13_0.config.id < arg_13_1.config.id
			else
				return arg_13_0.count > arg_13_1.count
			end
		else
			return arg_13_0.config.level > arg_13_1.config.level
		end
	end)

	return var_12_0
end

function var_0_0.sortRoleCo(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.type == Activity191Enum.CharacterType.Hero

	if var_14_0 ~= (arg_14_1.type == Activity191Enum.CharacterType.Hero) then
		return var_14_0
	end

	if arg_14_0.quality ~= arg_14_1.quality then
		return arg_14_0.quality < arg_14_1.quality
	end

	return arg_14_0.roleId < arg_14_1.roleId
end

function var_0_0.sortFetterHeroList(arg_15_0, arg_15_1)
	if arg_15_0.transfer == arg_15_1.transfer then
		if arg_15_0.config.quality == arg_15_1.config.quality then
			return arg_15_0.config.roleId < arg_15_1.config.roleId
		else
			return arg_15_0.config.quality < arg_15_1.config.quality
		end
	else
		return arg_15_0.transfer < arg_15_1.transfer
	end
end

function var_0_0.getWithBuildBattleHeroInfo(arg_16_0, arg_16_1)
	local var_16_0 = var_0_0.matchKeyInArray(arg_16_0, arg_16_1)

	if not var_16_0 then
		var_16_0 = Activity191Module_pb.Act191BattleHeroInfo()
		var_16_0.index = arg_16_1
		var_16_0.heroId = 0
		var_16_0.itemUid1 = 0
		var_16_0.itemUid2 = 0

		table.insert(arg_16_0, var_16_0)
	end

	return var_16_0
end

function var_0_0.getWithBuildSubHeroInfo(arg_17_0, arg_17_1)
	local var_17_0 = var_0_0.matchKeyInArray(arg_17_0, arg_17_1)

	if not var_17_0 then
		var_17_0 = Activity191Module_pb.Act191SubHeroInfo()
		var_17_0.index = arg_17_1
		var_17_0.heroId = 0

		table.insert(arg_17_0, var_17_0)
	end

	return var_17_0
end

function var_0_0.replaceSkill(arg_18_0, arg_18_1)
	if arg_18_1 then
		local var_18_0 = CharacterDestinyConfig.instance:getDestinyFacets(arg_18_0, 4)

		if var_18_0 then
			local var_18_1 = var_18_0.exchangeSkills

			if not string.nilorempty(var_18_1) then
				local var_18_2 = GameUtil.splitString2(var_18_1, true)

				for iter_18_0 = 1, #arg_18_1 do
					for iter_18_1, iter_18_2 in ipairs(var_18_2) do
						local var_18_3 = iter_18_2[1]
						local var_18_4 = iter_18_2[2]

						if arg_18_1[iter_18_0] == var_18_3 then
							arg_18_1[iter_18_0] = var_18_4
						end
					end
				end
			end
		end
	end

	return arg_18_1
end

function var_0_0.buildDesc(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0

	if arg_19_2 then
		var_19_0 = string.format(luaLang("Activity191Helper_buildDesc"), arg_19_2, "%1")
	else
		var_19_0 = luaLang("Activity191Helper_buildDesc1")
	end

	local var_19_1 = var_0_0[tostring(SettingsModel.instance:getRegionShortcut()) .. "BuildDescFmtDict"]

	if var_19_1 then
		local var_19_2 = var_19_1[arg_19_1]

		if var_19_2 then
			var_19_0 = string.format(var_19_2, arg_19_2 or "%1", "%1")
		end
	end

	arg_19_0 = string.gsub(arg_19_0, arg_19_1, var_19_0)
	arg_19_0 = var_0_0.addColor(arg_19_0)

	return arg_19_0
end

function var_0_0.addColor(arg_20_0)
	local var_20_0 = string.format("<color=%s>%s</color>", "#4e6698", "%1")

	arg_20_0 = string.gsub(arg_20_0, "【.-】", var_20_0)

	local var_20_1 = string.format("<color=%s>%s</color>", "#C66030", "%1")

	arg_20_0 = string.gsub(arg_20_0, "[+-]?%d+%.%d+%%", var_20_1)
	arg_20_0 = string.gsub(arg_20_0, "[+-]?%d+%%", var_20_1)

	return arg_20_0
end

function var_0_0.clickHyperLinkDestiny(arg_21_0)
	local var_21_0 = string.splitToNumber(arg_21_0, "#")
	local var_21_1 = {
		config = Activity191Config.instance:getRoleCoByNativeId(var_21_0[1], 1),
		stoneId = var_21_0[2]
	}

	ViewMgr.instance:openView(ViewName.Act191CharacterDestinyView, var_21_1)
end

function var_0_0.clickHyperLinkItem(arg_22_0, arg_22_1)
	if string.find(arg_22_0, "#") then
		local var_22_0 = string.splitToNumber(arg_22_0, "#")[1]

		Activity191Controller.instance:openCollectionTipView({
			itemId = var_22_0
		})
	else
		SkillHelper.defaultClick(arg_22_0, arg_22_1)
	end
end

function var_0_0.clickHyperLinkSkill(arg_23_0, arg_23_1)
	if tonumber(arg_23_0) then
		SkillHelper.defaultClick(arg_23_0, arg_23_1)

		return
	end

	local var_23_0 = {
		effectId = arg_23_0,
		clickPosition = arg_23_1
	}

	ViewMgr.instance:openView(ViewName.Act191BuffTipView, var_23_0)
end

return var_0_0
