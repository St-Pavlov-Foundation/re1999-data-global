module("modules.logic.resonance.model.HeroResonaceModel", package.seeall)

slot0 = class("HeroResonaceModel", BaseModel)

function slot0.onInit(slot0)
	slot0._copyShareCode = nil
end

function slot0.reInit(slot0)
	slot0._copyShareCode = nil
end

function slot0.getCurLayoutShareCode(slot0, slot1)
	if slot1.talentCubeInfos.data_list and tabletool.len(slot2) > 0 then
		table.insert({}, slot1:getHeroUseCubeStyleId() or 0)

		for slot8, slot9 in ipairs(slot2) do
			if slot9.cubeId > 100 then
				slot4 = slot10 % 10
				slot10 = math.floor(slot10 / 10)
			end

			table.insert(slot3, bit.lshift(slot10 - 1, 2) + slot9.direction)
			table.insert(slot3, bit.lshift(slot9.posX, 4) + slot9.posY)
		end

		return Base64Util.encode(string.char(unpack(slot3)))
	end
end

function slot0.decodeLayoutShareCode(slot0, slot1)
	slot2 = Base64Util.decode(slot1)
	slot3 = {}
	slot4 = string.byte(slot2, 1)

	for slot8 = 1, string.len(slot2) / 2 do
		if not string.byte(slot2, slot8 * 2) or not string.byte(slot2, slot8 * 2 + 1) then
			return
		end

		if slot9 < 0 then
			slot9 = slot9 + 256
		end

		table.insert(slot3, {
			cubeId = bit.rshift(slot9, 2) + 1,
			direction = bit.band(slot9, 3),
			posX = bit.rshift(slot10, 4),
			posY = bit.band(slot10, 15)
		})
	end

	return slot3, slot4
end

function slot0.canUseLayoutShareCode(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not slot0:decodeLayoutShareCode(slot2) or tabletool.len(slot3) == 0 then
		if not string.nilorempty(slot2) then
			return false, ToastEnum.CharacterTalentCopyCodeError
		end

		return
	end

	slot4 = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(slot1.heroId, slot1.talent), ",")
	slot5 = {}

	for slot9, slot10 in ipairs(slot3) do
		if HeroResonanceConfig.instance:getCubeConfigNotError(slot10.cubeId) then
			slot13 = {}

			for slot17 = 1, #GameUtil.splitString2(slot11.shape, true, "#", ",") do
				for slot21 = 1, #slot12[slot17] do
					if not slot13[slot17 - 1] then
						slot13[slot17 - 1] = {}
					end

					slot13[slot17 - 1][slot21 - 1] = slot12[slot17][slot21]
				end
			end

			if slot0:_isOverCell(slot0:rotationMatrix(slot13, slot10.direction), slot4, slot10) then
				return
			end

			if not slot5[slot10.cubeId] then
				slot5[slot10.cubeId] = 0
			end

			slot5[slot10.cubeId] = slot5[slot10.cubeId] + 1
		else
			return false, ToastEnum.CharacterTalentCopyCodeError
		end
	end

	for slot10, slot11 in pairs(slot5) do
		if not slot1.talentCubeInfos.own_cube_dic[slot10] or slot11 > slot12.own + slot12.use then
			return
		end
	end

	return true
end

function slot0._isOverCell(slot0, slot1, slot2, slot3)
	slot4, slot5 = slot0:getMatrixRange(slot1, slot3)

	return slot2[1] < slot4 or slot2[2] < slot5
end

function slot0.getMatrixRange(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 0

	if slot1 then
		for slot8 = 0, GameUtil.getTabLen(slot1) - 1 do
			for slot13 = 0, GameUtil.getTabLen(slot1[slot8]) - 1 do
				if slot9[slot13] == 1 then
					if slot3 < slot13 then
						slot3 = slot13
					end

					if slot4 < slot8 then
						slot4 = slot8
					end
				end
			end
		end
	end

	return slot2.posX + slot3 + 1, slot2.posY + slot4 + 1
end

function slot0.rotationMatrix(slot0, slot1, slot2)
	slot3 = slot1

	while slot2 > 0 do
		slot3 = {
			[slot9] = {}
		}
		slot4 = GameUtil.getTabLen(slot1)

		for slot9 = 0, GameUtil.getTabLen(slot1[0]) - 1 do
			for slot13 = 0, slot4 - 1 do
				slot3[slot9][slot13] = slot1[slot4 - slot13 - 1][slot9]
			end
		end

		if slot2 - 1 > 0 then
			slot1 = slot3
		end
	end

	return slot3
end

function slot0._isUseTalentStyle(slot0, slot1, slot2)
	if slot2 and slot2 > 0 then
		return TalentStyleModel.instance:getCubeMoByStyle(slot1, slot2)._isUse
	end
end

function slot0._isUnlockTalentStyle(slot0, slot1, slot2)
	if slot2 and slot2 > 0 then
		slot3 = TalentStyleModel.instance:getCubeMoByStyle(slot1, slot2)

		return slot3._isUnlock, slot3
	end
end

function slot0.getShareTalentAttrInfos(slot0, slot1, slot2, slot3)
	if not slot2 then
		return {}
	end

	slot5 = {}
	slot6 = slot1:getTalentGain()
	slot7 = slot1.talentCubeInfos.own_main_cube_id
	slot8 = SkillConfig.instance:getTalentDamping()
	slot9 = {}

	for slot13, slot14 in ipairs(slot2) do
		if not slot9[slot14.cubeId] then
			slot9[slot15] = {}
		end

		table.insert(slot9[slot15], slot14)
	end

	for slot13, slot14 in pairs(slot9) do
		slot15 = {}
		slot16 = slot13

		if slot7 == slot13 and slot3 ~= 0 and TalentStyleModel.instance:getCubeMoByStyle(slot1.heroId, slot3) and slot17._isUnlock then
			slot16 = slot17._replaceId
		end

		slot18 = slot8[1][1] <= #slot14 and (slot8[2][1] <= slot17 and slot8[2][2] or slot8[1][2]) or nil

		for slot22 = 1, slot17 do
			slot1:getTalentAttrGainSingle(slot16, slot15)
		end

		for slot22, slot23 in pairs(slot15) do
			if slot18 then
				slot15[slot22] = slot23 * slot18 / 1000
			end

			if slot15[slot22] > 0 then
				slot5[slot22] = (slot5[slot22] or 0) + slot15[slot22]
			end
		end
	end

	for slot13, slot14 in pairs(slot5) do
		table.insert(slot4, {
			key = slot13,
			value = slot6[slot13] and slot15.value or 0,
			shareValue = slot14 or 0
		})
	end

	for slot13, slot14 in pairs(slot6) do
		if not slot0:_isHasAttr(slot4, slot13) then
			table.insert(slot4, {
				key = slot13,
				value = slot14 and slot14.value or 0,
				shareValue = 0
			})
		end
	end

	table.sort(slot4, slot0._sortAttr)

	return slot4
end

function slot0._isHasAttr(slot0, slot1, slot2)
	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			if slot7.key == slot2 then
				return true
			end
		end
	end
end

function slot0._sortAttr(slot0, slot1)
	return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
end

function slot0.saveShareCode(slot0, slot1)
	slot0._copyShareCode = slot1
end

function slot0.getShareCode(slot0)
	return slot0._copyShareCode
end

function slot0.getSpecialCn(slot0, slot1)
	return luaLang("talent_character_talentcn" .. (slot1 and CharacterEnum.TalentTxtByHeroType[slot1.config.heroType] or 1))
end

slot0.instance = slot0.New()

return slot0
