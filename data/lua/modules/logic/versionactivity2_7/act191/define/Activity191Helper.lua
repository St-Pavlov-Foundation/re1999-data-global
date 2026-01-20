-- chunkname: @modules/logic/versionactivity2_7/act191/define/Activity191Helper.lua

module("modules.logic.versionactivity2_7.act191.define.Activity191Helper", package.seeall)

local Activity191Helper = class("Activity191Helper")
local kLinkFmt = "<u><link=%s>%s</link></u>"

Activity191Helper.enBuildDescFmtDict = {
	[Activity191Enum.HyperLinkPattern.EnhanceDestiny] = string.format("[%s]", kLinkFmt),
	[Activity191Enum.HyperLinkPattern.EnhanceItem] = string.format("\"%s\"", kLinkFmt),
	[Activity191Enum.HyperLinkPattern.SkillDesc] = string.format("[%s]", kLinkFmt),
	[Activity191Enum.HyperLinkPattern.Hero] = string.format("[%s]", kLinkFmt)
}
Activity191Helper.jpBuildDescFmtDict = {
	[Activity191Enum.HyperLinkPattern.EnhanceItem] = string.format("「%s」", kLinkFmt)
}
Activity191Helper.krBuildDescFmtDict = {
	[Activity191Enum.HyperLinkPattern.Hero] = string.format("<%s>", kLinkFmt)
}

function Activity191Helper.replaceSymbol(_txtDesc)
	if LangSettings.instance:isJp() then
		_txtDesc = string.gsub(_txtDesc, "『", "「")
		_txtDesc = string.gsub(_txtDesc, "』", "」")
	end

	if LangSettings.instance:isEn() then
		_txtDesc = string.gsub(_txtDesc, "『", "\"")
		_txtDesc = string.gsub(_txtDesc, "』", "\"")
		_txtDesc = string.gsub(_txtDesc, "「", "[")
		_txtDesc = string.gsub(_txtDesc, "」", "]")
		_txtDesc = string.gsub(_txtDesc, "﹝", "[")
		_txtDesc = string.gsub(_txtDesc, "﹞", "]")
	end

	return _txtDesc
end

function Activity191Helper.setFetterIcon(image, resName)
	UISpriteSetMgr.instance:setAct174Sprite(image, resName)
end

function Activity191Helper.getHeadIconSmall(config)
	if config.type == Activity191Enum.CharacterType.Hero then
		return ResUrl.getHeadIconSmall(config.skinId)
	else
		return ResUrl.monsterHeadIcon(config.skinId)
	end
end

function Activity191Helper.getNodeIcon(nodeType)
	nodeType = tonumber(nodeType)

	if nodeType == 0 then
		return "act191_progress_largeicon_0"
	elseif nodeType == Activity191Enum.NodeType.MixStore then
		return "act191_progress_largeicon_1"
	elseif Activity191Helper.isPveBattle(nodeType) then
		return "act191_progress_largeicon_2"
	elseif Activity191Helper.isPvpBattle(nodeType) then
		return "act191_progress_largeicon_3"
	elseif nodeType == Activity191Enum.NodeType.RewardEvent or nodeType == Activity191Enum.NodeType.BattleEvent then
		return "act191_progress_largeicon_4"
	elseif nodeType == Activity191Enum.NodeType.MixStore then
		return "act191_progress_largeicon_5"
	elseif nodeType == Activity191Enum.NodeType.RoleShop or nodeType == Activity191Enum.NodeType.CollectionShop or tabletool.indexOf(Activity191Enum.TagShopField, nodeType) then
		return "act191_progress_largeicon_6"
	elseif nodeType == Activity191Enum.NodeType.Enhance then
		return "act191_progress_largeicon_7"
	elseif nodeType == Activity191Enum.NodeType.ReplaceEvent or nodeType == Activity191Enum.NodeType.UpgradeEvent then
		return "act191_progress_largeicon_8"
	end
end

function Activity191Helper.lockScreen(key, lock)
	if lock then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(key)
	else
		UIBlockMgr.instance:endBlock(key)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function Activity191Helper.getPlayerPrefs(actId, key, defaultValue)
	local userId = PlayerModel.instance:getMyUserId()
	local prefsKey = userId .. actId .. key

	return PlayerPrefsHelper.getNumber(prefsKey, defaultValue)
end

function Activity191Helper.setPlayerPrefs(actId, key, value)
	local userId = PlayerModel.instance:getMyUserId()
	local prefsKey = userId .. actId .. key

	PlayerPrefsHelper.setNumber(prefsKey, value)
end

function Activity191Helper.calcIndex(position, trList)
	for k, tr in pairs(trList) do
		if gohelper.isMouseOverGo(tr, position) then
			return k
		end
	end
end

function Activity191Helper.matchKeyInArray(array, value, key)
	if not array then
		logError("array is nil")

		return
	end

	key = key or "index"

	for _, v in ipairs(array) do
		if v[key] == value then
			return v
		end
	end
end

function Activity191Helper.isPveBattle(type)
	if tabletool.indexOf(Activity191Enum.PveFiled, type) then
		return true
	end
end

function Activity191Helper.isPvpBattle(type)
	if tabletool.indexOf(Activity191Enum.PvpFiled, type) then
		return true
	end
end

function Activity191Helper.isShopNode(type)
	if type == Activity191Enum.NodeType.MixStore or type == Activity191Enum.NodeType.RoleShop or type == Activity191Enum.NodeType.CollectionShop or tabletool.indexOf(Activity191Enum.TagShopField, type) then
		return true
	end
end

function Activity191Helper.getActiveFetterInfoList(fetterCntDic)
	local fetterInfoList = {}

	for tag, cnt in pairs(fetterCntDic) do
		local fetterCoList = Activity191Config.instance:getRelationCoList(tag)

		if fetterCoList then
			for i = #fetterCoList, 0, -1 do
				local fetterCo = fetterCoList[i]

				if cnt >= fetterCo.activeNum then
					fetterInfoList[#fetterInfoList + 1] = {
						config = fetterCo,
						count = cnt
					}

					break
				end
			end
		end
	end

	table.sort(fetterInfoList, function(a, b)
		if a.config.level == b.config.level then
			if a.count == b.count then
				return a.config.id < b.config.id
			else
				return a.count > b.count
			end
		else
			return a.config.level > b.config.level
		end
	end)

	return fetterInfoList
end

function Activity191Helper.sortRoleCo(a, b)
	local aIsHero = a.type == Activity191Enum.CharacterType.Hero
	local bIsHero = b.type == Activity191Enum.CharacterType.Hero

	if aIsHero ~= bIsHero then
		return aIsHero
	end

	if a.quality ~= b.quality then
		return a.quality < b.quality
	end

	return a.roleId < b.roleId
end

function Activity191Helper.sortFetterHeroList(a, b)
	if a.inBag == b.inBag then
		if a.transfer == b.transfer then
			if a.config.quality == b.config.quality then
				return a.config.roleId < b.config.roleId
			else
				return a.config.quality < b.config.quality
			end
		else
			return a.transfer < b.transfer
		end
	else
		return a.inBag > b.inBag
	end
end

function Activity191Helper.getWithBuildBattleHeroInfo(battleHeroInfos, index)
	local battleHeroInfo = Activity191Helper.matchKeyInArray(battleHeroInfos, index)

	if not battleHeroInfo then
		battleHeroInfo = Activity191Module_pb.Act191BattleHeroInfo()
		battleHeroInfo.index = index
		battleHeroInfo.heroId = 0
		battleHeroInfo.itemUid1 = 0
		battleHeroInfo.itemUid2 = 0

		table.insert(battleHeroInfos, battleHeroInfo)
	end

	return battleHeroInfo
end

function Activity191Helper.getWithBuildSubHeroInfo(subHeroInfos, index)
	local subHeroInfo = Activity191Helper.matchKeyInArray(subHeroInfos, index)

	if not subHeroInfo then
		subHeroInfo = Activity191Module_pb.Act191SubHeroInfo()
		subHeroInfo.index = index
		subHeroInfo.heroId = 0

		table.insert(subHeroInfos, subHeroInfo)
	end

	return subHeroInfo
end

function Activity191Helper.replaceSkill(stoneId, skillIdList)
	if skillIdList then
		local co = CharacterDestinyConfig.instance:getDestinyFacets(stoneId, 4)

		if co then
			local exchangeSkills = co.exchangeSkills

			if not string.nilorempty(exchangeSkills) then
				local splitSkillId = GameUtil.splitString2(exchangeSkills, true)

				for i = 1, #skillIdList do
					for _, skillId in ipairs(splitSkillId) do
						local orignSkillId = skillId[1]
						local newSkillId = skillId[2]

						if skillIdList[i] == orignSkillId then
							skillIdList[i] = newSkillId
						end
					end
				end
			end
		end
	end

	return skillIdList
end

function Activity191Helper.buildDesc(desc, pattern, linkParam)
	local repl

	if linkParam then
		repl = string.format(luaLang("Activity191Helper_buildDesc"), linkParam, "%1")
	else
		repl = luaLang("Activity191Helper_buildDesc1")
	end

	local fmtDict = Activity191Helper[tostring(LangSettings.instance:getCurLang()) .. "BuildDescFmtDict"]

	if fmtDict then
		local fmt = fmtDict[pattern]

		if fmt then
			repl = string.format(fmt, linkParam or "%1", "%1")
		end
	end

	desc = string.gsub(desc, pattern, repl)
	desc = Activity191Helper.addColor(desc)

	return desc
end

function Activity191Helper.addColor(desc)
	local bracketColorFormat = string.format("<color=%s>%s</color>", "#4e6698", "%1")

	desc = string.gsub(desc, "【.-】", bracketColorFormat)

	local percentColorFormat = string.format("<color=%s>%s</color>", "#C66030", "%1")

	desc = string.gsub(desc, "[+-]?%d+%.%d+%%", percentColorFormat)
	desc = string.gsub(desc, "[+-]?%d+%%", percentColorFormat)

	return desc
end

function Activity191Helper.clickHyperLinkDestiny(typeParam)
	local params = string.splitToNumber(typeParam, "#")
	local param = {
		config = Activity191Config.instance:getRoleCoByNativeId(params[1], 1),
		stoneId = params[2]
	}

	ViewMgr.instance:openView(ViewName.Act191CharacterDestinyView, param)
end

function Activity191Helper.clickHyperLinkItem(param, clickPosition)
	if string.find(param, "#") then
		local itemId = string.splitToNumber(param, "#")[1]

		Activity191Controller.instance:openCollectionTipView({
			itemId = itemId
		})
	else
		SkillHelper.defaultClick(param, clickPosition)
	end
end

function Activity191Helper.clickHyperLinkSkill(name, clickPosition)
	if tonumber(name) then
		SkillHelper.defaultClick(name, clickPosition)

		return
	end

	local param = {
		effectId = name,
		clickPosition = clickPosition
	}

	ViewMgr.instance:openView(ViewName.Act191BuffTipView, param)
end

function Activity191Helper.clickHyperLinkRole(param, clickPosition)
	if string.find(param, "#") then
		local id = string.splitToNumber(param, "#")[1]

		if id then
			local viewParam = {
				preview = true,
				heroList = {
					tonumber(id)
				}
			}

			Activity191Controller.instance:openHeroTipView(viewParam)
		end
	else
		SkillHelper.defaultClick(param, clickPosition)
	end
end

return Activity191Helper
