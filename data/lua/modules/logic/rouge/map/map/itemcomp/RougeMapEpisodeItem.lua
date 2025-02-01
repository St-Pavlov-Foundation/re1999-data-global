module("modules.logic.rouge.map.map.itemcomp.RougeMapEpisodeItem", package.seeall)

slot0 = class("RougeMapEpisodeItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.episodeMo = slot1
	slot0.map = slot2
	slot0.parentGo = slot0.map.goLayerNodeContainer
	slot0.index = slot1.id

	slot0:createGo()
	slot0:createNodeItemList()
end

function slot0.createGo(slot0)
	slot0.go = gohelper.create3d(slot0.parentGo, "episode" .. slot0.index)
	slot0.tr = slot0.go:GetComponent(gohelper.Type_Transform)

	transformhelper.setLocalPos(slot0.tr, RougeMapHelper.getEpisodePosX(slot0.index), 0, 0)
end

function slot0.createNodeItemList(slot0)
	slot0.nodeItemList = {}
	slot1 = slot0.episodeMo:getNodeMoList()
	slot0.posType = #slot1

	for slot5, slot6 in ipairs(slot1) do
		slot7 = RougeMapNodeItem.New()

		slot7:init(slot6, slot0.map, slot0)
		table.insert(slot0.nodeItemList, slot7)
	end
end

function slot0.getNodeItemList(slot0)
	return slot0.nodeItemList
end

function slot0.destroy(slot0)
	for slot4, slot5 in ipairs(slot0.nodeItemList) do
		slot5:destroy()
	end

	slot0:__onDispose()
end

return slot0
