module("modules.logic.resonance.config.HeroResonanceConfig", package.seeall)

slot0 = class("HeroResonanceConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.resonance_config = nil
	slot0.resonance_cost_config = nil
	slot0.resonance_cube_shape = nil
	slot0.resonance_model_config = nil
	slot0.resonance_style_config = nil
	slot0.resonance_style_cost_config = nil
	slot0.cube_rightful = {}
	slot0.matrix_data = {}
	slot0.cube_lastrowful = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"talent_cube_attr",
		"character_talent",
		"talent_cube_shape",
		"talent_mould",
		"talent_style",
		"talent_style_cost"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "talent_cube_attr" then
		slot0.resonance_config = slot2
	elseif slot1 == "character_talent" then
		slot0.resonance_cost_config = slot2

		slot0:_initCharacterTalent()
	elseif slot1 == "talent_cube_shape" then
		slot0.resonance_cube_shape = slot2
	elseif slot1 == "talent_mould" then
		slot0.resonance_model_config = slot2
	elseif slot1 == "talent_style" then
		slot0.resonance_style_config = slot2

		slot0:initParseTalentStyle()
	elseif slot1 == "talent_style_cost" then
		slot0.resonance_style_cost_config = slot2
	end
end

function slot0._initCharacterTalent(slot0)
	slot0._talentMaxLvMap = {}

	for slot4, slot5 in ipairs(lua_character_talent.configList) do
		slot0._talentMaxLvMap[slot5.heroId] = math.max(slot5.talentId, slot0._talentMaxLvMap[slot5.heroId] or 0)
	end
end

function slot0.getHeroMaxTalentLv(slot0, slot1)
	return slot0._talentMaxLvMap[slot1] or 1
end

function slot0.getCubeConfig(slot0, slot1)
	return slot0.resonance_cube_shape.configDict[slot1] or logError("共鸣形状表找不到id：", slot1)
end

function slot0.getCubeConfigNotError(slot0, slot1)
	return slot0.resonance_cube_shape.configDict[slot1]
end

function slot0.getCubeRightful(slot0, slot1)
	if not slot0.cube_rightful[slot1] then
		slot3 = 0

		for slot8, slot9 in ipairs(string.split(slot0:getCubeConfig(slot1).shape, "#")) do
			for slot14, slot15 in ipairs(string.splitToNumber(slot9, ",")) do
				if slot15 == 1 then
					slot3 = slot3 + 1
				end
			end
		end

		slot0.cube_rightful[slot1] = slot3
	end

	return slot0.cube_rightful[slot1]
end

function slot0.getLastRowfulPos(slot0, slot1)
	if not slot0.cube_lastrowful[slot1] then
		slot4 = string.split(slot0:getCubeConfig(slot1).shape, "#")

		for slot9 = #string.splitToNumber(slot4[#slot4], ","), 1, -1 do
			if slot5[slot9] ~= 1 then
				slot3 = 0 + 1
			else
				slot0.cube_lastrowful[slot1] = slot3

				return slot0.cube_lastrowful[slot1]
			end
		end

		slot0.cube_lastrowful[slot1] = slot3
	end

	return slot0.cube_lastrowful[slot1]
end

function slot0.getCubeMatrix(slot0, slot1)
	if slot0.matrix_data[slot1] then
		return slot0.matrix_data[slot1]
	end

	for slot8 = 0, #string.split(slot0:getCubeConfig(slot1).shape, "#") - 1 do
		slot12 = ","

		for slot12, slot13 in ipairs(string.split(slot4[slot8 + 1], slot12)) do
			slot3[slot8][slot12 - 1] = tonumber(slot13)
		end
	end

	slot0.matrix_data[slot1] = {
		[slot8] = {}
	}

	return slot0.matrix_data[slot1]
end

function slot0.getTalentConfig(slot0, slot1, slot2)
	if not slot0.resonance_cost_config.configDict[slot1] then
		logError("共鸣表找不到,英雄id：", slot1, "共鸣等级：", slot2)
	end

	return slot3 and slot3[slot2]
end

function slot0.getTalentAllShape(slot0, slot1, slot2)
	if not slot0:getTalentModelConfig(slot1, slot2) then
		logError("共鸣表找不到,英雄id：", slot1, "共鸣等级：", slot2)

		return
	end

	return slot3.allShape
end

function slot0.getTalentModelConfig(slot0, slot1, slot2)
	return slot0.resonance_model_config.configDict[slot2] and slot0:getTalentConfig(slot1, slot2) and slot0.resonance_model_config.configDict[slot2][slot0:getTalentConfig(slot1, slot2).talentMould]
end

function slot0.getTalentModelShapeMaxLevel(slot0, slot1)
	if not slot0.max_talent_model_shape_level then
		slot0.max_talent_model_shape_level = {}
	end

	if slot0.max_talent_model_shape_level[slot1] then
		return slot0.max_talent_model_shape_level[slot1]
	end

	slot2 = 0
	slot3 = slot0:getTalentConfig(slot1, 1).talentMould
	slot4 = nil
	slot5 = {}

	for slot9, slot10 in pairs(slot0.resonance_model_config.configDict) do
		for slot14, slot15 in pairs(slot10) do
			if slot15.talentMould == slot3 then
				table.insert(slot5, {
					talentId = slot15.talentId,
					allShape = slot15.allShape
				})

				if slot15.allShape ~= slot4 then
					slot4 = slot15.allShape
					slot2 = slot2 + 1
				end
			end
		end
	end

	table.sort(slot5, function (slot0, slot1)
		return slot0.talentId < slot1.talentId
	end)

	if not slot0.cur_talent_model_shape_level then
		slot0.cur_talent_model_shape_level = {}
	end

	slot0.cur_talent_model_shape_level[slot3] = slot5
	slot0.max_talent_model_shape_level[slot1] = slot2

	return slot2
end

function slot0.getCurTalentModelShapeLevel(slot0, slot1, slot2)
	for slot9, slot10 in ipairs(slot0.cur_talent_model_shape_level[slot0:getTalentConfig(slot1, 1).talentMould]) do
		if slot10.allShape ~= nil then
			slot4 = 0 + 1
			slot5 = slot10.allShape
		end

		if slot2 <= slot10.talentId then
			break
		end
	end

	return slot4
end

function slot0.initParseTalentStyle(slot0)
	slot0.talent_style_replace_cube_list = {}

	if slot0.resonance_style_config then
		for slot4, slot5 in pairs(slot0.resonance_style_config.configList) do
			if slot5 and not string.nilorempty(slot5.replaceCube) then
				for slot10, slot11 in pairs(GameUtil.splitString2(slot5.replaceCube)) do
					slot12 = TalentStyleMo.New()
					slot14 = tonumber(slot11[2])

					if tonumber(slot11[1]) and slot14 then
						slot12:setMo(slot5, slot13, slot14)

						slot15 = slot0.talent_style_replace_cube_list[slot13] or {}
						slot15[slot5.styleId] = slot12
						slot0.talent_style_replace_cube_list[slot13] = slot15
					end
				end
			end
		end

		for slot4, slot5 in pairs(slot0.talent_style_replace_cube_list) do
			slot6 = TalentStyleMo.New()
			slot7, slot8 = next(slot5)

			slot6:setMo(slot0.resonance_style_config.configDict[slot8._styleCo.talentMould][0], slot4, slot4)

			slot5[0] = slot6
		end
	end
end

function slot0.getTalentStyle(slot0, slot1)
	return slot0.talent_style_replace_cube_list and slot0.talent_style_replace_cube_list[slot1]
end

function slot0.getTalentStyleUnlockConsume(slot0, slot1, slot2)
	return slot0:getTalentStyleCostConfig(slot1, slot2) and slot3.consume
end

function slot0.getTalentStyleCostConfig(slot0, slot1, slot2)
	if slot0.resonance_style_cost_config and slot0.resonance_style_cost_config.configDict[slot1] then
		return slot3[slot2]
	end
end

slot0.instance = slot0.New()

return slot0
