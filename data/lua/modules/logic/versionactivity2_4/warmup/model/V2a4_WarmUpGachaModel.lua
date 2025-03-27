module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaModel", package.seeall)

slot0 = class("V2a4_WarmUpGachaModel", BaseModel)
slot1 = table.insert

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._waveList = {}
	slot0._s_RandomList = {}
end

function slot0.clean(slot0)
	slot0._waveList = {}
end

function slot0.curWaveIndex(slot0)
	return #slot0._waveList
end

function slot0.curWave(slot0)
	return slot0._waveList[slot0:curWaveIndex()]
end

function slot0.curRound(slot0)
	if not slot0:curWave() then
		return nil
	end

	return slot1:curRound()
end

function slot0.curRoundIndex(slot0)
	if not slot0:curRound() then
		return 0
	end

	return slot1:index()
end

function slot0.s_RdList(slot0, slot1)
	if slot0._s_RandomList[slot1] then
		return slot2
	end

	slot3 = V2a4_WarmUpController.instance:config()

	assert(#{
		[V2a4_WarmUpEnum.AskType.Text] = slot3:getTextItemListCO(slot1),
		[V2a4_WarmUpEnum.AskType.Photo] = slot3:getPhotoItemListCO(slot1)
	} == 2)

	slot0._s_RandomList[slot1] = slot2

	return slot2
end

function slot0.restart(slot0, slot1)
	slot0:clean()
	SimpleRandomModel.instance:clean(slot0:s_RdList(slot1))
end

function slot0.genWave(slot0, slot1)
	slot3 = slot0:s_RdList(slot1)
	slot4, slot5 = SimpleRandomModel.instance:getListIdxAndItemIdx(slot3)
	slot10 = V2a4_WarmUpGachaWaveMO.New(slot0:curWaveIndex() + 1, slot4)

	for slot14 = 1, V2a4_WarmUpController.instance:config():getLevelCO(slot1).askCount do
		slot10:genRound(slot3[slot4][slot5])
	end

	uv0(slot0._waveList, slot10)

	return slot10
end

slot0.instance = slot0.New()

return slot0
