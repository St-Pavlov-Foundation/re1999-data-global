module("modules.logic.versionactivity2_2.eliminate.model.EliminateChessModel", package.seeall)

slot0 = class("EliminateChessModel", BaseModel)

function slot0.onInit(slot0)
	slot0._chessMo = {}
	slot0._chessConfig = {}
	slot0._chessBoardConfig = {}
	slot0._maxRow = 0
	slot0._maxCol = 0
	slot0._tips = nil
end

function slot0.reInit(slot0)
	slot0._chessMo = {}
	slot0._chessConfig = {}
	slot0._chessBoardConfig = {}
	slot0._maxRow = 0
	slot0._maxCol = 0
	slot0._tips = nil
end

function slot0.mockData(slot0)
	slot1 = T_lua_eliminate_level[1]
	slot2 = slot1.chess
	slot3 = slot1.chessBoard
	slot0._maxRow = #slot2

	for slot7 = 1, #slot2 do
		if slot0._chessMo then
			slot0._chessMo[slot7] = {}
		end

		slot8 = slot2[slot7]
		slot0._maxCol = #slot8

		for slot12 = 1, #slot8 do
			slot14 = EliminateChessMO.New()

			slot14:setXY(slot7, slot12)
			slot14:setStartXY(slot7, slot12)
			slot14:setChessId(slot8[slot12])
			slot14:setChessBoardType(slot3[slot7][slot12])

			slot0._chessMo[slot7][slot12] = slot14
		end
	end
end

function slot0.initChessInfo(slot0, slot1)
	if slot1.row == nil or #slot2 <= 0 then
		return
	end

	slot0._maxRow = #slot2

	for slot6 = 1, #slot2 do
		if slot0._chessMo[slot6] == nil then
			slot0._chessMo[slot6] = {}
		end

		for slot11 = 1, #slot2[slot6].chess do
			slot0._maxCol = #slot7
			slot12 = slot7[slot11]

			if slot0._chessMo[slot6][slot11] == nil then
				slot0._chessMo[slot6][slot11] = EliminateChessMO.New()
			end

			slot13:setXY(slot6, slot11)
			slot13:setStartXY(slot6, slot11)
			slot13:setChessId(slot12.id)
			slot13:setChessBoardType(slot12.type)
		end
	end

	slot0:createInitMoveState()
end

function slot0.createInitMoveState(slot0)
	for slot4 = 1, #slot0._chessMo do
		for slot9 = 1, #slot0._chessMo[slot4] do
			slot5[slot9]:setStartXY(slot4, slot0._maxCol + 1)
		end
	end
end

function slot0.getMaxRowAndCol(slot0)
	return slot0._maxRow, slot0._maxCol
end

function slot0.posIsValid(slot0, slot1, slot2)
	return slot1 >= 1 and slot1 <= slot0._maxRow and slot2 >= 1 and slot2 <= slot0._maxCol
end

function slot0.updateMatch3Tips(slot0, slot1)
	if not slot0._tips then
		slot0._tips = EliminateTipMO.New()
	end

	slot0._tips:updateInfoByServer(slot1)
end

function slot0.getTipEliminateCount(slot0)
	return slot0._tips and slot0._tips:getEliminateCount() or 0
end

function slot0.updateMovePoint(slot0, slot1)
	slot0._movePoint = slot1 or 0
end

function slot0.getTipInfo(slot0)
	return slot0._tips
end

function slot0.getChessMo(slot0, slot1, slot2)
	return slot0._chessMo[slot1][slot2]
end

function slot0.updateChessMo(slot0, slot1, slot2, slot3)
	slot0._chessMo[slot1][slot2] = slot3
end

function slot0.getChessMoList(slot0)
	return slot0._chessMo
end

function slot0.getMovePoint(slot0)
	return slot0._movePoint
end

function slot0.setRecordCurNeedShowEffectAndXY(slot0, slot1, slot2, slot3)
	slot0._recordShowEffectX = slot1
	slot0._recordShowEffectY = slot2
	slot0._recordShowEffectType = slot3
end

function slot0.getRecordCurNeedShowEffectAndXYAndClear(slot0)
	slot0._recordShowEffectType = nil
	slot0._recordShowEffectX = nil
	slot0._recordShowEffectY = nil

	return slot0._recordShowEffectX, slot0._recordShowEffectY, slot0._recordShowEffectType
end

function slot0.addCurPlayAudioCount(slot0)
	slot0._playAudioCount = slot0._playAudioCount and slot0._playAudioCount + 1 or 1
end

function slot0.clearCurPlayAudioCount(slot0)
	slot0._playAudioCount = nil
end

function slot0.getCurPlayAudioCount(slot0)
	if slot0._playAudioCount == nil then
		slot0._playAudioCount = 1
	end

	return slot0._playAudioCount
end

function slot0.calEvaluateLevel(slot0)
	if slot0._eliminateTotalCount == nil then
		return nil
	end

	slot2 = nil

	if EliminateConfig.instance:getEvaluateGear() and #slot1 == 3 then
		slot2 = slot0._eliminateTotalCount < slot1[2] and (slot1[1] <= slot0._eliminateTotalCount and 1 or nil) or slot0._eliminateTotalCount < slot1[3] and 2 or 3
	end

	return slot2
end

function slot0.addTotalEliminateCount(slot0, slot1)
	if slot0._eliminateTotalCount == nil then
		slot0._eliminateTotalCount = 0
	end

	slot0._eliminateTotalCount = slot0._eliminateTotalCount + slot1
end

function slot0.clearTotalCount(slot0)
	slot0._eliminateTotalCount = nil
end

function slot0.getNeedResetData(slot0)
	return slot0._cacheData
end

function slot0.setNeedResetData(slot0, slot1)
	slot0._cacheData = slot1
end

function slot0.clear(slot0)
	slot0._chessMo = {}
	slot0._cacheData = nil
end

slot0.instance = slot0.New()

return slot0
