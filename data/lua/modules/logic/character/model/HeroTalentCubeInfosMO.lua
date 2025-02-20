module("modules.logic.character.model.HeroTalentCubeInfosMO", package.seeall)

slot0 = pureTable("HeroTalentCubeInfosMO")

function slot0.init(slot0, slot1)
	slot0.data_list = {}

	for slot5 = 1, #slot1 do
		slot0.data_list[slot5] = {
			cubeId = slot1[slot5].cubeId,
			direction = slot1[slot5].direction,
			posX = slot1[slot5].posX,
			posY = slot1[slot5].posY
		}
	end
end

function slot0.clearData(slot0)
	slot0.data_list = {}
end

function slot0.setOwnData(slot0, slot1, slot2)
	slot0.own_cube_dic = {}
	slot0.own_cube_list = {}

	if HeroResonanceConfig.instance:getTalentConfig(slot1, slot2) then
		slot0.own_cube_list = {}

		if slot3 then
			slot0.own_cube_dic = {}

			if string.splitToNumber(slot3.exclusive, "#") and #slot4 > 0 then
				slot0.own_cube_dic[slot4[1]] = {
					own = 1,
					use = 0,
					id = slot4[1],
					level = slot4[2]
				}
				slot0.own_main_cube_id = slot4[1]
			end
		end

		slot8 = slot2

		for slot8 = 10, 20 do
			if string.splitToNumber(HeroResonanceConfig.instance:getTalentModelConfig(slot1, slot8)["type" .. slot8], "#") and #slot9 > 0 then
				if not slot0.own_cube_dic[slot8] then
					slot0.own_cube_dic[slot8] = {}
				end

				slot0.own_cube_dic[slot8].id = slot8
				slot0.own_cube_dic[slot8].own = slot9[1]
				slot0.own_cube_dic[slot8].level = slot9[2]
				slot0.own_cube_dic[slot8].use = 0
			end
		end

		for slot8 = #slot0.data_list, 1, -1 do
			if slot0.own_cube_dic[slot0.data_list[slot8].cubeId] then
				slot0.own_cube_dic[slot9.cubeId].own = slot0.own_cube_dic[slot9.cubeId].own - 1
				slot0.own_cube_dic[slot9.cubeId].use = slot0.own_cube_dic[slot9.cubeId].use + 1
			else
				table.remove(slot0.data_list, slot8)
			end
		end

		for slot8, slot9 in pairs(slot0.own_cube_dic) do
			if slot9.own > 0 then
				table.insert(slot0.own_cube_list, slot9)
			end
		end
	end

	return slot0.own_cube_dic, slot0.own_cube_list
end

function slot0.getMainCubeMo(slot0)
	return slot0.own_cube_dic[slot0.own_main_cube_id]
end

return slot0
