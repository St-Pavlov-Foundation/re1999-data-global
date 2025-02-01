module("modules.logic.rouge.map.model.rpcmo.RougeStoreEventMO", package.seeall)

slot0 = class("RougeStoreEventMO", RougeBaseEventMO)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0.boughtPosList = slot0.jsonData.boughtGoodsPosSet

	if slot0.jsonData.posGoodMap then
		slot0.posGoodsList = {}

		for slot6, slot7 in pairs(slot0.jsonData.posGoodMap) do
			slot0.posGoodsList[tonumber(slot6)] = slot7
		end
	end

	slot0.refreshNum = slot0.jsonData.refreshNum
	slot0.refreshNeedCoin = slot0.jsonData.refreshNeedCoin
end

function slot0.update(slot0, slot1, slot2)
	uv0.super.update(slot0, slot1, slot2)

	slot0.boughtPosList = slot0.jsonData.boughtGoodsPosSet

	if slot0.jsonData.posGoodMap then
		slot0.posGoodsList = {}

		for slot6, slot7 in pairs(slot0.jsonData.posGoodMap) do
			slot0.posGoodsList[tonumber(slot6)] = slot7
		end
	end

	slot0.refreshNum = slot0.jsonData.refreshNum
	slot0.refreshNeedCoin = slot0.jsonData.refreshNeedCoin
end

function slot0.checkIsSellOut(slot0, slot1)
	return tabletool.indexOf(slot0.boughtPosList, slot1)
end

function slot0.__tostring(slot0)
	return uv0.super.__tostring(slot0)
end

return slot0
