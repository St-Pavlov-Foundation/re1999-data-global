module("modules.logic.rouge.view.RougeDLCSelectViewContainer", package.seeall)

slot0 = class("RougeDLCSelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = MixScrollParam.New()
	slot1.scrollGOPath = "#go_root/#scroll_dlcs"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#go_root/#scroll_dlcs/Viewport/Content/#go_dlcitem"
	slot1.cellClass = RougeDLCSelectListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.startSpace = 0
	slot1.endSpace = 0
	slot2 = {}

	table.insert(slot2, RougeDLCSelectView.New())
	table.insert(slot2, TabViewGroup.New(1, "#go_root/#go_topleft"))
	table.insert(slot2, LuaMixScrollView.New(RougeDLCSelectListModel.instance, slot1))

	return slot2
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
