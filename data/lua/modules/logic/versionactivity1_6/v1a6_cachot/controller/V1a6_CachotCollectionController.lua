module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionController", package.seeall)

slot0 = class("V1a6_CachotCollectionController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2)
	V1a6_CachotCollectionListModel.instance:onInitData(slot1, slot2)
	slot0:selectFirstCollection()
	uv0.instance:dispatchEvent(V1a6_CachotEvent.OnSwitchCategory)
end

function slot0.onCloseView(slot0)
	if V1a6_CachotCollectionListModel.instance:getNewCollectionAndClickList() and #slot1 > 0 then
		RogueRpc.instance:sendRogueCollectionNewRequest(V1a6_CachotEnum.ActivityId, slot1)
	end

	V1a6_CachotCollectionListModel.instance:release()
end

function slot0.selectFirstCollection(slot0)
	slot0:onSelectCollection(V1a6_CachotCollectionListModel.instance:getCurCategoryFirstCollection())
end

function slot0.onSelectCollection(slot0, slot1)
	V1a6_CachotCollectionListModel.instance:markSelectCollecionId(slot1)
	uv0.instance:dispatchEvent(V1a6_CachotEvent.OnSelectCollectionItem)
end

function slot0.onSwitchCategory(slot0, slot1)
	if slot1 ~= V1a6_CachotCollectionListModel.instance:getCurCategory() then
		V1a6_CachotCollectionListModel.instance:resetCurPlayAnimCellIndex()
		V1a6_CachotCollectionListModel.instance:switchCategory(slot1)
		slot0:selectFirstCollection()
		uv0.instance:dispatchEvent(V1a6_CachotEvent.OnSwitchCategory)
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
