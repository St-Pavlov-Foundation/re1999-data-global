module("modules.logic.room.utils.RoomBackBlockHelper", package.seeall)

return {
	State = {
		Near = 2,
		Back = 0,
		Map = 1
	},
	isCanBack = function (slot0, slot1)
		if uv0.isHasInitBlock(slot1) then
			return false
		end

		return uv0._isCanBackBlocks(uv0._createMapDic(slot0), slot1, true)
	end,
	resfreshInitBlockEntityEffect = function ()
		slot2 = RoomMapBlockModel.instance:getBackBlockModel()
		slot3 = GameSceneMgr.instance:getCurScene()

		for slot7 = 1, #RoomConfig.instance:getInitBlockList() do
			if RoomMapBlockModel.instance:getFullBlockMOById(slot1[slot7].blockId) then
				if RoomMapBlockModel.instance:isBackMore() then
					slot2:remove(slot9)
					slot9:setOpState(RoomBlockEnum.OpState.Back, false)
				else
					slot9:setOpState(RoomBlockEnum.OpState.Normal)
				end

				if slot3.mapmgr:getBlockEntity(slot9.id, SceneTag.RoomMapBlock) then
					slot10:refreshBlock()
				end
			end
		end
	end,
	sortBackBlockMOList = function (slot0, slot1)
		if not slot1 or not slot0 or uv0.isHasInitBlock(slot1) then
			return slot1
		end

		slot3 = {}

		tabletool.addValues({}, slot1)

		slot5 = uv0._createMapDic(slot0)

		for slot9 = 1, #slot1 do
			for slot13 = 1, #slot2 do
				table.insert(slot3, slot2[slot13])

				if uv0._isCanBackBlocks(slot5, slot3) then
					table.remove(slot2, slot13)

					break
				else
					table.remove(slot3, #slot3)
				end
			end

			if slot9 > #slot3 then
				break
			end
		end

		tabletool.addValues(slot3, slot2)

		for slot9 = 1, #slot3 do
			slot1[slot9] = slot3[slot9]
		end

		return slot1
	end,
	isHasInitBlock = function (slot0)
		slot1 = RoomConfig.instance

		for slot5 = 1, #slot0 do
			if slot1:getInitBlock(slot0[slot5].id) then
				return true
			end
		end

		return false
	end,
	_isCanBackBlocks = function (slot0, slot1, slot2)
		if slot2 == true then
			uv0._restMapDic(slot0)
		end

		uv0._setBackBlockMOList(slot0, slot1)
		uv0._findNearCount(slot0, 0, 0)

		return uv0._sumCountByState(slot0, uv0.State.Map) == 0
	end,
	_setBackBlockMOList = function (slot0, slot1)
		slot2 = uv0.State.Back

		for slot6 = 1, #slot1 do
			if slot1[slot6].hexPoint and slot0[slot7.x] and slot8[slot7.y] and slot9 ~= slot2 then
				slot8[slot7.y] = slot2
			end
		end
	end,
	_sumCountByState = function (slot0, slot1)
		slot2 = 0

		for slot6, slot7 in pairs(slot0) do
			for slot11, slot12 in pairs(slot7) do
				if slot12 == slot1 then
					slot2 = slot2 + 1
				end
			end
		end

		return slot2
	end,
	_restMapDic = function (slot0)
		slot1 = uv0.State.Map

		for slot5, slot6 in pairs(slot0) do
			for slot10, slot11 in pairs(slot6) do
				slot6[slot10] = slot1
			end
		end
	end,
	_createMapDic = function (slot0)
		slot1 = {}
		slot2 = uv0.State.Map

		for slot6 = 1, #slot0 do
			if not slot1[slot0[slot6].hexPoint.x] then
				slot1[slot7.x] = {}
			end

			slot8[slot7.y] = slot2
		end

		return slot1
	end,
	_findNearCount = function (slot0, slot1, slot2, slot3)
		if (slot0[slot1] and slot0[slot1][slot2]) == uv0.State.Map then
			slot0[slot1][slot2] = uv0.State.Near

			for slot8 = 1, 6 do
				slot9, slot10 = uv0._getNearXY(slot1, slot2, slot8)
				slot3 = uv0._findNearCount(slot0, slot9, slot10, (slot3 or 0) + 1)
			end
		end

		return slot3
	end,
	_getNearXY = function (slot0, slot1, slot2)
		if slot2 == 1 then
			return slot0 - 1, slot1 + 1
		elseif slot2 == 2 then
			return slot0 - 1, slot1
		elseif slot2 == 3 then
			return slot0, slot1 - 1
		elseif slot2 == 4 then
			return slot0 + 1, slot1 - 1
		elseif slot2 == 5 then
			return slot0 + 1, slot1
		elseif slot2 == 6 then
			return slot0, slot1 + 1
		end
	end
}
