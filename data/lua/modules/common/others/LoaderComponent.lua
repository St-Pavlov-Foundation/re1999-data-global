module("modules.common.others.LoaderComponent", package.seeall)

slot0 = class("LoaderComponent", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()

	slot0._urlDic = {}
	slot0._callback = {}
	slot0._assetDic = slot0:getUserDataTb_()
	slot0._failedDic = {}
	slot0._listLoadCallback = {}
end

function slot0.getAssetItem(slot0, slot1)
	return slot0._assetDic[slot1]
end

function slot0.loadAsset(slot0, slot1, slot2, slot3, slot4)
	if slot0.component_dead then
		return
	end

	if slot0._failedDic[slot1] then
		if slot4 then
			slot4(slot3, slot1)
		end

		return
	end

	if slot0._assetDic[slot1] then
		slot2(slot3, slot0._assetDic[slot1])

		return
	end

	if not slot0._callback[slot1] then
		slot0._callback[slot1] = {}
	end

	table.insert(slot0._callback[slot1], {
		call_back = slot2,
		handler = slot3,
		failedCallback = slot4
	})

	if not slot0._urlDic[slot1] then
		slot0._urlDic[slot1] = true

		loadAbAsset(slot1, false, slot0._onLoadCallback, slot0)
	end
end

function slot0.loadListAsset(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot0.component_dead then
		return
	end

	if slot3 then
		slot0._listLoadCallback[slot1] = {
			finishCallback = slot3,
			handler = slot4,
			listFailedCallback = slot6
		}
	end

	for slot10, slot11 in ipairs(slot1) do
		slot0:loadAsset(slot11, slot2, slot4, slot5)
	end

	slot0:_invokeUrlListCallback()
end

function slot0._invokeUrlListCallback(slot0)
	if not slot0._listLoadCallback then
		return
	end

	if slot0.component_dead then
		return
	end

	for slot4, slot5 in pairs(slot0._listLoadCallback) do
		slot7 = false

		for slot11, slot12 in ipairs(slot4) do
			if slot0._assetDic[slot12] then
				slot6 = 0 + 1
			end

			if slot0._failedDic[slot12] then
				slot6 = slot6 + 1
				slot7 = true
			end
		end

		if slot6 == #slot4 then
			if slot7 then
				if slot5.listFailedCallback then
					slot5.listFailedCallback(slot5.handler)
				end
			else
				slot5.finishCallback(slot5.handler)
			end

			slot0._listLoadCallback[slot4] = nil

			if slot0.component_dead then
				return
			end
		end
	end
end

function slot0._onLoadCallback(slot0, slot1)
	if slot0.component_dead then
		return
	end

	if slot1.IsLoadSuccess then
		slot0._assetDic[slot1.ResPath] = slot1

		slot1:Retain()
	else
		slot0._failedDic[slot2] = true

		logError("资源加载失败,URL:" .. slot2)
	end

	if slot0._callback[slot2] then
		for slot7, slot8 in ipairs(slot0._callback[slot2]) do
			if slot3 then
				slot8.call_back(slot8.handler, slot1)
			elseif slot8.failedCallback then
				slot8.failedCallback(slot8.handler, slot2)
			end

			if slot0.component_dead then
				return
			end
		end
	end

	slot0:_invokeUrlListCallback()

	slot0._callback[slot2] = nil
end

function slot0.releaseSelf(slot0)
	slot0.component_dead = true

	for slot4, slot5 in pairs(slot0._urlDic) do
		removeAssetLoadCb(slot4, slot0._onLoadCallback, slot0)
	end

	for slot4, slot5 in pairs(slot0._assetDic) do
		slot5:Release()
	end

	slot0._urlDic = nil
	slot0._callback = nil
	slot0._listLoadCallback = nil
	slot0._failedDic = nil

	slot0:__onDispose()
end

return slot0
