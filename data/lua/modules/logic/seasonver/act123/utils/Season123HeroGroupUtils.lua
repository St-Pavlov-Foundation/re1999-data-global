-- chunkname: @modules/logic/seasonver/act123/utils/Season123HeroGroupUtils.lua

module("modules.logic.seasonver.act123.utils.Season123HeroGroupUtils", package.seeall)

local Season123HeroGroupUtils = class("Season123HeroGroupUtils")

function Season123HeroGroupUtils.buildSnapshotHeroGroups(snapshots)
	local list = {}

	for _, v in ipairs(snapshots) do
		local snapMo = HeroGroupMO.New()

		snapMo:setSeasonCardLimit(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)

		local isEmpty = v.heroList == nil or #v.heroList <= 0

		if isEmpty then
			if not Season123HeroGroupUtils.checkFirstCopyHeroGroup(v, snapMo) then
				Season123HeroGroupUtils.createEmptyGroup(v, snapMo)
			end
		else
			snapMo:init(v)
		end

		Season123HeroGroupUtils.formation104Equips(snapMo)

		list[v.groupId] = snapMo
	end

	table.sort(list, function(a, b)
		return a.groupId < b.groupId
	end)

	return list
end

function Season123HeroGroupUtils.checkFirstCopyHeroGroup(snapshot, snapMo)
	if snapshot.groupId == 1 then
		local mainHeroGroupMo = HeroGroupModel.instance:getById(1)

		if mainHeroGroupMo then
			snapMo.id = snapshot.groupId
			snapMo.groupId = snapshot.groupId
			snapMo.name = mainHeroGroupMo.name
			snapMo.heroList = {
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid
			}
			snapMo.aidDict = LuaUtil.deepCopy(mainHeroGroupMo.aidDict)
			snapMo.clothId = mainHeroGroupMo.clothId
			snapMo.equips = LuaUtil.deepCopy(mainHeroGroupMo.equips)
			snapMo.activity104Equips = LuaUtil.deepCopy(mainHeroGroupMo.activity104Equips)

			Season123HeroGroupUtils.formation104Equips(snapMo)

			return true
		end
	end

	return false
end

function Season123HeroGroupUtils.formation104Equips(heroGroup)
	if not heroGroup.activity104Equips then
		heroGroup.activity104Equips = {}
	end

	for pos = 0, Activity123Enum.MainCharPos do
		if not heroGroup.activity104Equips[pos] then
			heroGroup:updateActivity104PosEquips({
				index = pos
			})
		end
	end

	for pos, seasonEquipMO in pairs(heroGroup.activity104Equips) do
		seasonEquipMO:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)

		local count = pos < ModuleEnum.MaxHeroCountInGroup and Activity123Enum.HeroCardNum or Activity123Enum.MainCardNum

		Season123HeroGroupUtils.formationSingle104Equips(seasonEquipMO, count)
	end
end

function Season123HeroGroupUtils.formationSingle104Equips(equipMO, count)
	for index, uid in pairs(equipMO.equipUid) do
		if count < index then
			equipMO.equipUid[index] = nil
		end
	end

	for i = 1, count do
		if equipMO.equipUid[i] == nil then
			equipMO.equipUid[i] = Activity123Enum.EmptyUid
		end
	end
end

function Season123HeroGroupUtils.createEmptyGroup(snapshot, snapMo)
	local mainHeroGroupMo = HeroGroupModel.instance:getById(1)

	snapMo.id = snapshot.groupId
	snapMo.groupId = snapshot.groupId
	snapMo.name = ""
	snapMo.heroList = {
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid,
		Activity123Enum.EmptyUid
	}

	if mainHeroGroupMo then
		snapMo.clothId = mainHeroGroupMo.clothId
	end

	snapMo.equips = {}

	for i = 0, ModuleEnum.MaxHeroCountInGroup - 1 do
		local equipMo = HeroGroupEquipMO.New()

		equipMo:init({
			index = i,
			equipUid = {
				Activity123Enum.EmptyUid
			}
		})

		snapMo.equips[i] = equipMo
	end

	snapMo.activity104Equips = {}

	local maxPos = ModuleEnum.MaxHeroCountInGroup

	for i = 0, maxPos do
		local equipMo = HeroGroupActivity104EquipMo.New()

		equipMo:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)
		equipMo:init({
			index = i,
			equipUid = {
				Activity123Enum.EmptyUid,
				Activity123Enum.EmptyUid
			}
		})

		snapMo.activity104Equips[i] = equipMo
	end
end

function Season123HeroGroupUtils.swapHeroItem(groupPos, otherGroupPos)
	logNormal(string.format("swap hero pos %s to %s", groupPos, otherGroupPos))

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local srcPos = groupPos - 1
	local targetPos = otherGroupPos - 1
	local srcEquipId = heroGroupMO:getPosEquips(srcPos).equipUid[1]
	local targetEquipId = heroGroupMO:getPosEquips(targetPos).equipUid[1]

	heroGroupMO.equips[srcPos].equipUid = {
		targetEquipId
	}
	heroGroupMO.equips[targetPos].equipUid = {
		srcEquipId
	}

	local srcAct104Equips = heroGroupMO:getAct104PosEquips(srcPos).equipUid
	local targetAct104Equips = heroGroupMO:getAct104PosEquips(targetPos).equipUid

	heroGroupMO.activity104Equips[srcPos].equipUid = targetAct104Equips
	heroGroupMO.activity104Equips[targetPos].equipUid = srcAct104Equips

	local srcHeroId = heroGroupMO.heroList[srcPos + 1]
	local targetHeroId = heroGroupMO.heroList[targetPos + 1]

	heroGroupMO.heroList[srcPos + 1] = targetHeroId
	heroGroupMO.heroList[targetPos + 1] = srcHeroId
end

function Season123HeroGroupUtils.syncHeroGroupFromFightGroup(heroGroupMo, fightGroup)
	heroGroupMo.heroList = {}

	for _, v in ipairs(fightGroup.heroList) do
		table.insert(heroGroupMo.heroList, v)
	end

	for _, subHero in ipairs(fightGroup.subHeroList) do
		table.insert(heroGroupMo.heroList, subHero)
	end

	heroGroupMo.clothId = fightGroup.clothId
	heroGroupMo.equips = {}

	for pos, v in ipairs(fightGroup.equips) do
		local index = pos - 1

		if heroGroupMo.equips[index] == nil then
			heroGroupMo.equips[index] = HeroGroupEquipMO.New()
		end

		heroGroupMo.equips[index]:init({
			index = index,
			equipUid = v.equipUid
		})
	end

	heroGroupMo.activity104Equips = {}

	for pos, v in ipairs(fightGroup.activity104Equips) do
		local index = pos - 1

		if heroGroupMo.activity104Equips[index] == nil then
			heroGroupMo.activity104Equips[index] = HeroGroupActivity104EquipMo.New()

			heroGroupMo.activity104Equips[index]:setLimitNum(Season123EquipHeroItemListModel.HeroMaxPos, Season123EquipHeroItemListModel.MaxPos)
		end

		heroGroupMo.activity104Equips[index]:init({
			index = index,
			equipUid = v.equipUid
		})
	end
end

function Season123HeroGroupUtils.getHeroGroupEquipCardId(season123MO, subId, slot, pos)
	local heroGroupMO = season123MO.heroGroupSnapshot[subId]

	if not heroGroupMO then
		return
	end

	local equipUids = heroGroupMO.activity104Equips[pos]

	if not equipUids then
		return
	end

	local itemUid = equipUids.equipUid[slot]
	local itemId = season123MO:getItemIdByUid(itemUid)

	if itemId ~= nil then
		return itemId, itemUid
	elseif itemUid ~= "0" then
		logError(string.format("can't find season123 item, itemUid = %s", itemUid))
	end

	return 0
end

function Season123HeroGroupUtils.processFightGroupAssistHero(heroGroupType, fightGroup, useRecord)
	if heroGroupType ~= ModuleEnum.HeroGroupType.Season123 then
		return
	end

	local battleContext = Season123Model.instance:getBattleContext()

	if battleContext then
		local assistHeroMO, assistMO = Season123Model.instance:getAssistData(battleContext.actId, battleContext.stage)
		local assistHeroUid, assistUserId

		if assistHeroMO and assistMO and assistHeroMO.uid ~= "0" then
			assistHeroUid, assistUserId = assistHeroMO.uid, assistMO.userId
		end

		if assistHeroUid and assistHeroUid ~= "0" then
			local hasFoundAssist = false

			for i = 1, #fightGroup.heroList do
				if assistHeroUid == fightGroup.heroList[i] then
					fightGroup.assistHeroUid = assistHeroUid
					fightGroup.assistUserId = assistUserId
					hasFoundAssist = true
				end
			end

			if not hasFoundAssist then
				for i = 1, #fightGroup.subHeroList do
					if assistHeroUid == fightGroup.subHeroList[i] then
						fightGroup.assistHeroUid = assistHeroUid
						fightGroup.assistUserId = assistUserId
						hasFoundAssist = true
					end
				end
			end
		end
	end
end

function Season123HeroGroupUtils.cleanAllHeroGroup(actId, equipUids)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	for groupIndex, groupMO in pairs(seasonMO.heroGroupSnapshot) do
		Season123HeroGroupUtils.cleanHeroGroup(groupMO, equipUids)
	end
end

function Season123HeroGroupUtils.cleanHeroGroup(heroGroupMO, equipUids)
	for i, heroUid in pairs(heroGroupMO.heroList) do
		heroGroupMO.heroList[i] = Activity123Enum.EmptyUid
	end

	for i = 0, ModuleEnum.MaxHeroCountInGroup - 1 do
		local equipMO = heroGroupMO.equips[i]

		for equipIndex, _ in pairs(equipMO.equipUid) do
			equipMO.equipUid[equipIndex] = Activity123Enum.EmptyUid
		end
	end

	local maxPos = ModuleEnum.MaxHeroCountInGroup

	for i = 0, maxPos do
		local equipMO = heroGroupMO.activity104Equips[i]

		for equipIndex, _ in pairs(equipMO.equipUid) do
			if equipMO.index == maxPos and equipUids then
				equipMO.equipUid[equipIndex] = equipUids[equipIndex] or Activity123Enum.EmptyUid
			else
				equipMO.equipUid[equipIndex] = Activity123Enum.EmptyUid
			end
		end
	end

	Season123HeroGroupUtils.formation104Equips(heroGroupMO)
end

function Season123HeroGroupUtils.getAllHeroActivity123Equips(heroGroupMO)
	local result = {}
	local battleContext = Season123Model.instance:getBattleContext()
	local actId = battleContext and battleContext.actId
	local seasonMO = Season123Model.instance:getActInfo(actId)

	for index, v in pairs(heroGroupMO.activity104Equips) do
		local posIndex = index + 1
		local mo = FightEquipMO.New()

		if posIndex == Season123EquipItemListModel.MainCharPos + 1 then
			mo.heroUid = "-100000"
		else
			mo.heroUid = heroGroupMO.heroList[posIndex] or Activity123Enum.EmptyUid
		end

		for i, _equipUid in ipairs(v.equipUid) do
			if _equipUid and _equipUid ~= Activity123Enum.EmptyUid then
				if seasonMO then
					local equipId = seasonMO:getItemIdByUid(_equipUid)

					v.equipUid[i] = equipId and equipId > 0 and _equipUid or Activity123Enum.EmptyUid
				else
					v.equipUid[i] = Activity123Enum.EmptyUid
				end
			end
		end

		mo.equipUid = v.equipUid

		table.insert(result, mo)
	end

	return result
end

function Season123HeroGroupUtils.fiterFightCardDataList(equips, trialHeroList, actId)
	local dataList = {}
	local trialDict = {}

	if trialHeroList then
		local battleId = FightModel.instance:getBattleId()
		local battleCO = battleId and lua_battle.configDict[battleId]
		local playerMax = battleCO and battleCO.playerMax or ModuleEnum.HeroCountInGroup

		for i, v in ipairs(trialHeroList) do
			local pos = v.pos

			if pos < 0 then
				pos = playerMax - pos
			end

			trialDict[pos] = v.trialId
		end
	end

	Season123HeroGroupUtils.fiterFightCardData(Season123EquipItemListModel.TotalEquipPos, dataList, equips, nil, actId)

	for index = 1, Season123EquipItemListModel.TotalEquipPos - 1 do
		Season123HeroGroupUtils.fiterFightCardData(index, dataList, equips, trialDict, actId)
	end

	return dataList
end

function Season123HeroGroupUtils.fiterFightCardData(index, list, equips, trialDict, actId)
	local pos = index - 1
	local trialId = trialDict and trialDict[index]
	local heroUid = equips and equips[index] and equips[index].heroUid

	if pos == Season123EquipItemListModel.MainCharPos then
		heroUid = nil
	end

	local nullHero = not heroUid or heroUid == Season123EquipItemListModel.EmptyUid

	if nullHero and pos ~= Season123EquipItemListModel.MainCharPos then
		return
	end

	local maxSlot = Season123EquipItemListModel.instance:getEquipMaxCount(pos)
	local count = 1
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	for slot = 1, maxSlot do
		local equipUid = equips and equips[index] and equips[index].equipUid and equips[index].equipUid[slot]
		local equipId

		if equipUid then
			equipId = seasonMO:getItemIdByUid(equipUid)
		end

		if not equipId or equipId == 0 then
			if trialId then
				equipId = HeroConfig.instance:getTrial104Equip(slot, trialId)
			elseif pos == Season123EquipItemListModel.MainCharPos then
				local battleId = FightModel.instance:getBattleId()
				local battleCO = battleId and lua_battle.configDict[battleId]

				equipId = battleCO and battleCO.trialMainAct104EuqipId
			end
		end

		if equipId and equipId > 0 then
			local data = {}

			data.equipId = equipId
			data.heroUid = heroUid
			data.trialId = trialId
			data.count = count
			count = count + 1

			table.insert(list, data)
		end
	end
end

function Season123HeroGroupUtils.getUnlockIndexSlot(unlockIndex)
	if unlockIndex >= 1 and unlockIndex <= 4 then
		return 1
	end

	if unlockIndex >= 5 and unlockIndex <= 8 then
		return 2
	end

	if unlockIndex >= 9 then
		return 3
	end

	return 0
end

function Season123HeroGroupUtils.getUnlockSlotSet(actId)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return {}
	end

	return tabletool.copy(seasonMO.unlockIndexSet)
end

function Season123HeroGroupUtils.setHpBar(imageHp, hpRate)
	if hpRate >= 0.69 then
		SLFramework.UGUI.GuiHelper.SetColor(imageHp, "#63955C")
	elseif hpRate >= 0.3 then
		SLFramework.UGUI.GuiHelper.SetColor(imageHp, "#E99B56")
	else
		SLFramework.UGUI.GuiHelper.SetColor(imageHp, "#BF2E11")
	end
end

return Season123HeroGroupUtils
