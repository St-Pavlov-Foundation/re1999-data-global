module("projbooter.hotupdate.optionpackage.OptionPackageHttpWorker", package.seeall)

slot0 = class("OptionPackageHttpWorker")

function slot0.ctor(slot0)
	slot0._httpGetterList = {}
	slot0._httpGetterFinishDict = {}
	slot0._httpResultDict = {}
end

function slot0.start(slot0, slot1, slot2, slot3)
	if not slot1 or #slot1 < 1 then
		slot0:_runCallBack(slot2, slot3)

		return
	end

	slot0._httpGetterList = {}

	tabletool.addValues(slot0._httpGetterList, slot1)
	slot0:_httpGetterStart(slot2, slot3)
end

function slot0.stop(slot0)
	for slot4, slot5 in pairs(slot0._httpGetterList) do
		if not slot0._httpGetterFinishDict[slot5:getHttpId()] then
			slot5:stop()
		end
	end
end

function slot0.checkWorkDone(slot0)
	return slot0:_checkHttpGetResult()
end

function slot0.againGetHttp(slot0, slot1, slot2)
	slot0._httpGetterOnFinshFunc = slot1
	slot0._httpGetterOnFinshObj = slot2

	for slot6, slot7 in pairs(slot0._httpGetterList) do
		if not slot0._httpGetterFinishDict[slot7:getHttpId()] then
			slot7:start(slot0._onHttpGetterFinish, slot0)
		end
	end
end

function slot0.getHttpResult(slot0)
	if not slot0._httpResultDict then
		slot0:_updateHttpResult()
	end

	return slot0._httpResultDict
end

function slot0.getPackInfo(slot0, slot1)
	if slot0:getHttpResult() then
		return slot2[slot1]
	end
end

function slot0.getDownloadUrl(slot0, slot1)
	if slot0:getPackInfo(slot1) then
		return slot2.download_url, slot2.download_url_bak
	end
end

function slot0.getPackSize(slot0, slot1)
	slot3 = 0

	if slot0:getPackInfo(slot1) and slot2.res then
		for slot7, slot8 in ipairs(slot2.res) do
			slot3 = slot3 + slot8.length
		end
	end

	return slot3
end

function slot0._httpGetterStart(slot0, slot1, slot2)
	slot0._httpGetterOnFinshFunc = slot1
	slot0._httpGetterOnFinshObj = slot2
	slot0._httpGetterFinishDict = {}
	slot0._httpResultDict = {}

	for slot6, slot7 in pairs(slot0._httpGetterList) do
		slot7:start(slot0._onHttpGetterFinish, slot0)
	end
end

function slot0._onHttpGetterFinish(slot0, slot1, slot2)
	slot0._httpGetterFinishDict[slot2:getHttpId()] = slot1

	if slot1 then
		slot0:_updateHttpResult()
	end

	slot3, slot4 = slot0:_checkHttpGetResult()

	if slot3 then
		slot0._httpGetterOnFinshFunc = nil
		slot0._httpGetterOnFinshObj = nil

		slot0:_runCallBack(slot0._httpGetterOnFinshFunc, slot0._httpGetterOnFinshObj, slot4)
	end
end

function slot0._runCallBack(slot0, slot1, slot2, slot3)
	if slot1 then
		if slot2 ~= nil then
			slot1(slot2, slot3)
		else
			slot1(slot3)
		end
	end
end

function slot0._updateHttpResult(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._httpGetterList) do
		if slot0._httpGetterFinishDict[slot6:getHttpId()] and slot6:getHttpResult() then
			for slot11, slot12 in pairs(slot7) do
				slot1[slot11] = slot12
			end
		end
	end

	slot0._httpResultDict = slot1
end

function slot0._checkHttpGetResult(slot0)
	slot1 = true
	slot2 = true

	for slot6, slot7 in pairs(slot0._httpGetterList) do
		if slot0._httpGetterFinishDict[slot7:getHttpId()] == nil then
			slot1 = false
			slot2 = false

			break
		elseif slot8 == false then
			slot2 = false
		end
	end

	return slot1, slot2
end

return slot0
