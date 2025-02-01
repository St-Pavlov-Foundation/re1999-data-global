module("modules.logic.skin.model.SkinOffsetAdjustModel", package.seeall)

slot0 = class("SkinOffsetAdjustModel", BaseModel)

function slot0.onInit(slot0)
	slot0._offsetList = {}
	slot0._saveList = {}
end

function slot0.getOffset(slot0, slot1, slot2, slot3, slot4)
	slot0._offsetList[slot1.id] = slot0._offsetList[slot1.id] or {}

	if slot0._offsetList[slot1.id][slot2] then
		slot5 = slot0._offsetList[slot1.id][slot2]

		return tonumber(slot5[1]), tonumber(slot5[2]), tonumber(slot5[3])
	end

	if slot0._saveList[slot1.id] and slot0._saveList[slot1.id][slot2] then
		slot5 = slot0._saveList[slot1.id][slot2]

		return tonumber(slot5[1]), tonumber(slot5[2]), tonumber(slot5[3])
	end

	if not slot1[slot2] then
		logError("skin offset key error:", slot2)
	end

	slot6, slot7 = SkinConfig.instance:getSkinOffset(slot5)

	if slot7 and not string.nilorempty(slot3) then
		if not slot1[slot3] then
			logError("skin offset key error:", slot3)
		end

		slot6, slot7 = SkinConfig.instance:getSkinOffset(slot5)

		if slot4 ~= -1 then
			slot8 = SkinConfig.instance:getSkinOffset(CommonConfig.instance:getConstStr(slot4))
			slot6[1] = slot6[1] + slot8[1]
			slot6[2] = slot6[2] + slot8[2]
			slot6[3] = slot6[3] + slot8[3]
		end
	end

	slot8 = slot6[1]
	slot9 = slot6[2]
	slot10 = slot6[3]
	slot0._offsetList[slot1.id][slot2] = {
		slot8,
		slot9,
		slot10
	}

	return slot8, slot9, slot10, slot7
end

function slot0.resetTempOffset(slot0, slot1, slot2)
	slot0._offsetList[slot1.id] = slot0._offsetList[slot1.id] or {}
	slot0._offsetList[slot1.id][slot2] = nil
end

function slot0.setTempOffset(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._offsetList[slot1.id] = slot0._offsetList[slot1.id] or {}
	slot0._offsetList[slot1.id][slot2] = {
		slot3,
		slot4,
		slot5
	}
end

function slot0.setOffset(slot0, slot1, slot2, slot3, slot4, slot5)
	slot3 = tonumber(slot3) == 0 and 0 or tonumber(0)
	slot4 = tonumber(slot4) == 0 and 0 or tonumber(0)
	slot5 = tonumber(slot5) == 0 and 0 or tonumber(0)
	slot0._offsetList[slot1.id] = slot0._offsetList[slot1.id] or {}
	slot0._offsetList[slot1.id][slot2] = {
		slot3,
		slot4,
		slot5
	}
	slot0._saveList[slot1.id] = slot0._saveList[slot1.id] or {}
	slot0._saveList[slot1.id][slot2] = {
		slot3,
		slot4,
		slot5
	}

	slot0:saveConfig()
end

function slot0.saveCameraSize(slot0, slot1, slot2)
	slot0._saveList[slot1.id] = slot0._saveList[slot1.id] or {}
	slot0._saveList[slot1.id].fullScreenCameraSize = slot2
end

function slot0.getCameraSize(slot0, slot1)
	return slot0._saveList[slot1] and slot0._saveList[slot1].fullScreenCameraSize
end

function slot0.getTrigger(slot0, slot1, slot2)
	slot0._offsetList[slot1.id] = slot0._offsetList[slot1.id] or {}

	if slot0._offsetList[slot1.id][slot2] then
		return slot0._offsetList[slot1.id][slot2]
	end

	slot3 = {}

	for slot9, slot10 in ipairs(string.split(slot1[slot2], "_")) do
		if #string.split(slot10, "|") == 2 then
			slot12 = string.split(slot11[1], "#")
			slot13 = string.split(slot11[2], "#")

			table.insert(slot3, {
				tonumber(slot12[1]),
				tonumber(slot12[2]),
				tonumber(slot13[1]),
				tonumber(slot13[2])
			})
		end
	end

	return slot3
end

function slot0.setTrigger(slot0, slot1, slot2, slot3)
	slot0._offsetList[slot1.id] = slot0._offsetList[slot1.id] or {}
	slot0._offsetList[slot1.id][slot2] = slot3
	slot0._saveList[slot1.id] = slot0._saveList[slot1.id] or {}
	slot0._saveList[slot1.id][slot2] = slot3

	slot0:saveConfig()
end

function slot0.saveConfig(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._saveList) do
		table.insert(slot1, {
			slot5,
			slot6
		})
	end

	SLFramework.FileHelper.WriteTextToPath(string.format("%s/../skinOffsetAdjust.json", UnityEngine.Application.dataPath), cjson.encode(slot1))
	GameFacade.showToast(ToastEnum.SkinOffsetAdjustSaveConfig)
end

slot0.instance = slot0.New()

return slot0
