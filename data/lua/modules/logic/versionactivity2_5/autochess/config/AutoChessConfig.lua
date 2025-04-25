module("modules.logic.versionactivity2_5.autochess.config.AutoChessConfig", package.seeall)

slot0 = class("AutoChessConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"auto_chess_enemy",
		"auto_chess_enemy_formation",
		"auto_chess_episode",
		"auto_chess_master",
		"auto_chess_master_skill",
		"auto_chess_mall",
		"auto_chess_mall_item",
		"auto_chess_mall_coin",
		"auto_chess_mall_refresh",
		"auto_chess",
		"auto_chess_skill",
		"auto_chess_translate",
		"auto_chess_buff",
		"auto_chess_skill_eff_desc",
		"auto_chess_round",
		"auto_chess_rank",
		"autochess_task",
		"auto_chess_const",
		"auto_chess_effect"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "auto_chess_skill_eff_desc" then
		slot0.skillEffectDescConfig = slot2
	end
end

function slot0.getItemBuyCost(slot0, slot1)
	if string.nilorempty(slot0:getChessCoByItemId(slot1).specialShopCost) then
		return AutoChessStrEnum.CostType.Coin, lua_auto_chess_mall_item.configDict[slot1].cost
	else
		slot4 = string.split(slot3.specialShopCost, "#")

		return slot4[1], tonumber(slot4[2])
	end
end

function slot0.getChessCoByItemId(slot0, slot1)
	if lua_auto_chess_mall_item.configDict[slot1] then
		slot3 = string.splitToNumber(slot2.context, "#")

		if lua_auto_chess.configDict[slot3[1]][slot3[2]] then
			return slot4
		else
			logError(string.format("异常:不存在棋子配置ID%s星级%s", slot3[1], slot3[2]))
		end
	else
		logError(string.format("异常:不存在商品ID%s", slot1))
	end
end

function slot0.getTaskByActId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(lua_autochess_task.configList) do
		if slot7.activityId == slot1 then
			slot2[#slot2 + 1] = slot7
		end
	end

	return slot2
end

function slot0.getSkillEffectDesc(slot0, slot1)
	if not slot0.skillEffectDescConfig.configDict[slot1] then
		logError(string.format("异常:技能概要ID '%s' 不存在!!!", slot1))
	end

	return slot2
end

function slot0.getSkillEffectDescCoByName(slot0, slot1)
	slot2 = LangSettings.instance:getCurLang() or -1

	if not slot0.skillBuffDescConfigByName then
		slot0.skillBuffDescConfigByName = {}
	end

	if not slot0.skillBuffDescConfigByName[slot2] then
		for slot7, slot8 in ipairs(slot0.skillEffectDescConfig.configList) do
			-- Nothing
		end

		slot0.skillBuffDescConfigByName[slot2] = {
			[slot8.name] = slot8
		}
	end

	if not slot0.skillBuffDescConfigByName[slot2][slot1] then
		logError(string.format("异常:技能概要名称 '%s' 不存在!!!", tostring(slot1)))
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
