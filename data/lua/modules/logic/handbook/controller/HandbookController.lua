module("modules.logic.handbook.controller.HandbookController", package.seeall)

slot0 = class("HandbookController", BaseController)
slot0.EventName = {
	PlayCharacterSwitchCloseAnim = 3,
	PlayCharacterSwitchOpenAnim = 2,
	OnShowSubCharacterView = 1
}
slot0.OpenViewNameEnum = {
	HandbookCharacterView = 1,
	HandbookStoryView = 3,
	HandbookEquipView = 2
}

function slot0.onInit(slot0)
	slot0._openViewName = 0
end

function slot0.reInit(slot0)
	slot0._openViewName = 0
end

function slot0.addConstEvents(slot0)
end

function slot0.jumpView(slot0, slot1)
	slot0:openView()

	if #slot1 <= 1 then
		return {}
	end

	if tonumber(slot1[2]) == JumpEnum.HandbookType.Character then
		slot0:openCharacterView()
		table.insert(slot2, ViewName.HandBookCharacterSwitchView)
	elseif slot3 == JumpEnum.HandbookType.Equip then
		slot0:openEquipView()
		table.insert(slot2, HandbookEquipView)
	elseif slot3 == JumpEnum.HandbookType.Story then
		slot0:openStoryView()
		table.insert(slot2, HandbookStoryView)
	elseif slot3 == JumpEnum.HandbookType.CG then
		slot0:openCGView()
		table.insert(slot2, HandbookCGView)
	end

	return slot2
end

function slot0.openView(slot0, slot1)
	slot0:markNotFirstHandbook()
	ViewMgr.instance:openView(ViewName.HandbookView, slot1)
end

function slot0.openCharacterView(slot0, slot1)
	slot0._openViewParam = slot1
	slot0._openViewName = uv0.OpenViewNameEnum.HandbookCharacterView

	HandbookRpc.instance:sendGetHandbookInfoRequest(slot0._getHandbookInfoReply, slot0)
end

function slot0.openEquipView(slot0, slot1)
	slot0._openViewParam = slot1
	slot0._openViewName = uv0.OpenViewNameEnum.HandbookEquipView

	HandbookRpc.instance:sendGetHandbookInfoRequest(slot0._getHandbookInfoReply, slot0)
end

function slot0.openStoryView(slot0, slot1)
	slot0._openViewParam = slot1
	slot0._openViewName = uv0.OpenViewNameEnum.HandbookStoryView

	HandbookRpc.instance:sendGetHandbookInfoRequest(slot0._getHandbookInfoReply, slot0)
end

function slot0._getHandbookInfoReply(slot0)
	if not slot0.viewNameDict then
		slot0.viewNameDict = {
			[uv0.OpenViewNameEnum.HandbookCharacterView] = ViewName.HandBookCharacterSwitchView,
			[uv0.OpenViewNameEnum.HandbookEquipView] = ViewName.HandbookEquipView,
			[uv0.OpenViewNameEnum.HandbookStoryView] = ViewName.HandbookStoryView
		}
	end

	ViewMgr.instance:openView(slot0.viewNameDict[slot0._openViewName], slot0._openViewParam)

	slot0._openViewParam = nil
end

function slot0.openCGView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.HandbookCGView, slot1)
end

function slot0.openCGDetailView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.HandbookCGDetailView, slot1)
end

function slot0.markNotFirstHandbook(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FirstHandbook .. tostring(PlayerModel.instance:getMyUserId()), 1)
end

function slot0.isFirstHandbook(slot0)
	return PlayerPrefsHelper.getNumber(PlayerPrefsKey.FirstHandbook .. tostring(PlayerModel.instance:getMyUserId()), 0) <= 0
end

function slot0.openHandbookWeekWalkMapView(slot0, slot1)
	slot0._openViewParam = slot1

	WeekwalkRpc.instance:sendGetWeekwalkEndRequest(slot0._getWeekWalkEndReply, slot0)
end

function slot0._getWeekWalkEndReply(slot0)
	ViewMgr.instance:openView(ViewName.HandbookWeekWalkMapView, slot0._openViewParam)

	slot0._openViewParam = nil
end

slot0.instance = slot0.New()

return slot0
