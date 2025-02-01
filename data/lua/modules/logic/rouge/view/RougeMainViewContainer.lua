module("modules.logic.rouge.view.RougeMainViewContainer", package.seeall)

slot0 = class("RougeMainViewContainer", BaseViewContainer)
slot1 = 1

function slot0.buildViews(slot0)
	return {
		RougeMainView.New(),
		RougeBaseDLCViewComp.New(true),
		TabViewGroup.New(uv0, "#go_lefttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		slot2 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot2:setHelpId(HelpEnum.HelpId.RougeMainViewHelp)

		return {
			slot2
		}
	end
end

function slot0.onContainerClose(slot0)
	if not ViewMgr.instance:getContainer(ViewName.DungeonView) then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnShowStoryView)
end

return slot0
