module("modules.logic.room.view.backpack.RoomBackpackViewContainer", package.seeall)

slot0 = class("RoomBackpackViewContainer", BaseViewContainer)
slot1 = {
	Navigate = 1,
	SubView = 2
}
slot0.SubViewTabId = {
	Critter = 1,
	Prop = 2
}
slot0.TabSettingList = {
	{
		namecn = "room_critter_backpack_cn",
		nameen = "room_critter_backpack_en"
	},
	{
		namecn = "room_prop_backpack_cn",
		nameen = "room_prop_backpack_en"
	}
}

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomBackpackView.New())
	table.insert(slot1, TabViewGroup.New(uv0.Navigate, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(uv0.SubView, "#go_container"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0.Navigate then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	elseif slot1 == uv0.SubView then
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "#scroll_critter"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromView
		slot2.prefabUrl = "#scroll_critter/viewport/content/#go_critterItem"
		slot2.cellClass = RoomBackpackCritterItem
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.lineCount = 8
		slot2.cellWidth = 152
		slot2.cellHeight = 152
		slot2.cellSpaceH = 30
		slot2.cellSpaceV = 30
		slot2.startSpace = 20
		slot2.minUpdateCountInFrame = 100
		slot4 = ListScrollParam.New()
		slot4.scrollGOPath = "#scroll_prop"
		slot4.prefabType = ScrollEnum.ScrollPrefabFromView
		slot4.prefabUrl = "#scroll_prop/viewport/content/#go_item"
		slot4.cellClass = RoomBackpackPropItem
		slot4.scrollDir = ScrollEnum.ScrollDirV
		slot4.lineCount = 7
		slot4.cellWidth = 220
		slot4.cellHeight = 220
		slot4.startSpace = 20
		slot4.endSpace = 10
		slot4.minUpdateCountInFrame = 100

		return {
			MultiView.New({
				RoomBackpackCritterView.New(),
				LuaListScrollView.New(RoomBackpackCritterListModel.instance, slot2)
			}),
			MultiView.New({
				RoomBackpackPropView.New(),
				LuaListScrollViewWithAnimator.New(RoomBackpackPropListModel.instance, slot4)
			})
		}
	end
end

function slot0.onContainerInit(slot0)
	if not slot0.viewParam then
		return
	end

	slot0.viewParam.defaultTabIds = {
		[uv0.SubView] = slot0:getDefaultSelectedTab()
	}
end

function slot0.getDefaultSelectedTab(slot0)
	slot1 = uv0.SubViewTabId.Critter

	if slot0:checkTabId(slot0.viewParam and slot0.viewParam.defaultTab) then
		slot1 = slot2
	end

	return slot1
end

function slot0.checkTabId(slot0, slot1)
	slot2 = false

	if slot1 then
		for slot6, slot7 in pairs(uv0.SubViewTabId) do
			if slot7 == slot1 then
				slot2 = true

				break
			end
		end
	end

	return slot2
end

function slot0.switchTab(slot0, slot1)
	if not slot0:checkTabId(slot1) then
		return
	end

	slot0:dispatchEvent(ViewEvent.ToSwitchTab, uv0.SubView, slot1)
end

function slot0.onContainerCloseFinish(slot0)
	RoomBackpackCritterListModel.instance:onInit()
end

return slot0
