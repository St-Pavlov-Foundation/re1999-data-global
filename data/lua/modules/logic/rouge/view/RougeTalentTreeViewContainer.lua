module("modules.logic.rouge.view.RougeTalentTreeViewContainer", package.seeall)

slot0 = class("RougeTalentTreeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._treeview = RougeTalentTreeView.New()
	slot0._poolview = RougeTalentTreeBranchPool.New(slot0._viewSetting.otherRes.branchitem)
	slot0._tabview = TabViewGroup.New(2, "#go_talenttree")

	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, slot0._tabview)
	table.insert(slot1, slot0._treeview)
	table.insert(slot1, slot0._poolview)

	return slot1
end

function slot0.getPoolView(slot0)
	return slot0._poolview
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0._navigateButtonView:setCloseCheck(slot0.defaultOverrideCloseCheck, slot0)

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		slot2 = {}

		for slot8 = 1, RougeTalentConfig.instance:getTalentNum(RougeConfig1.instance:season()) do
			table.insert(slot2, RougeTalentTreeBranchView.New())
		end

		return slot2
	end
end

function slot0.getTabView(slot0)
	return slot0._tabview
end

function slot0.defaultOverrideCloseCheck(slot0)
	RougeController.instance:dispatchEvent(RougeEvent.exitTalentView)

	function slot0._closeCallback()
		uv0._navigateButtonView:_reallyClose()
		RougeController.instance:dispatchEvent(RougeEvent.reallyExitTalentView)
	end

	TaskDispatcher.runDelay(slot0._closeCallback, slot0, 0.5)
end

return slot0
