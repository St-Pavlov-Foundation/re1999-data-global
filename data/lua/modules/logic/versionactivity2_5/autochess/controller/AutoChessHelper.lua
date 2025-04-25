module("modules.logic.versionactivity2_5.autochess.controller.AutoChessHelper", package.seeall)

slot0 = class("AutoChessHelper")

function slot0.sameWarZoneType(slot0, slot1)
	slot3 = slot1 ~= AutoChessEnum.WarZone.Two

	if slot0 ~= AutoChessEnum.WarZone.Two and slot3 or not slot2 and not slot3 then
		return true
	end

	return false
end

function slot0.getMeshUrl(slot0)
	return string.format("ui/assets/versionactivity_2_5_autochess/%s.asset", slot0)
end

function slot0.getMaterialUrl(slot0)
	if slot0 then
		return AutoChessEnum.MaterialPath.Enemy
	else
		return AutoChessEnum.MaterialPath.Player
	end
end

function slot0.getEffectUrl(slot0)
	return string.format("ui/viewres/versionactivity_2_5/autochess/skill/%s.prefab", slot0)
end

function slot0.getMallRegionByType(slot0, slot1)
	for slot5, slot6 in ipairs(slot0) do
		if lua_auto_chess_mall.configDict[slot6.mallId].type == slot1 then
			return slot6
		end
	end
end

function slot0.getBuffEnergy(slot0)
	for slot5, slot6 in ipairs(slot0) do
		if slot6.id == 1004 or slot6.id == 1005 then
			slot1 = 0 + slot6.layer
		end
	end

	return slot1
end

function slot0.hasUniversalBuff(slot0)
	for slot4, slot5 in ipairs(slot0) do
		if slot5.id == 1015 then
			return true
		end
	end

	return false
end

function slot0.getLeaderSkillEffect(slot0)
	if lua_auto_chess_master_skill.configDict[slot0].skillIndex == 3 then
		return string.split(slot1.abilities, "#")
	else
		slot3 = nil

		if slot2 == 1 then
			slot3 = tonumber(slot1.passiveChessSkills)
		elseif slot2 == 2 then
			slot3 = tonumber(slot1.activeChessSkill)
		end

		return string.split(lua_auto_chess_skill.configDict[slot3].effect1, "#")
	end
end

function slot0.getBuyChessCntByType(slot0, slot1)
	for slot6, slot7 in ipairs(slot0) do
		if lua_auto_chess.configDict[slot7.chessId][1].race == slot1 then
			slot2 = 0 + slot7.num
		end
	end

	return slot2
end

function slot0.isPrimeNumber(slot0)
	if tonumber(slot0) == 2 then
		return true
	elseif slot0 == 1 or slot0 % 2 == 0 then
		return false
	else
		for slot5 = 3, math.floor(math.sqrt(slot0)) + 1, 2 do
			if slot0 % slot5 == 0 then
				return false
			end
		end
	end

	return true
end

function slot0.lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(slot0)
	else
		UIBlockMgr.instance:endBlock(slot0)
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function slot0.getPlayerPrefs(slot0, slot1)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. Activity182Model.instance:getCurActId() .. slot0, slot1)
end

function slot0.setPlayerPrefs(slot0, slot1)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. Activity182Model.instance:getCurActId() .. slot0, slot1)
end

function slot0.buildSkillDesc(slot0)
	return string.gsub(string.gsub(slot0, "%[(.-)%]", uv0._replaceDescTagFunc), "【(.-)】", uv0._replaceDescTagFunc)
end

function slot0._replaceDescTagFunc(slot0)
	if not AutoChessConfig.instance:getSkillEffectDescCoByName(slot0) then
		return string.format("<b>%s</b>", slot0)
	end

	return string.format("<b><u><link=%s>%s</link></u></b>", slot1.id, slot0)
end

function slot0.buildEmptyChess()
	return {
		uid = 0,
		id = 0
	}
end

return slot0
