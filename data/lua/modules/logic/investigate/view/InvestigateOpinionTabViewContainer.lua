module("modules.logic.investigate.view.InvestigateOpinionTabViewContainer", package.seeall)

slot0 = class("InvestigateOpinionTabViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, InvestigateOpinionTabView.New())
	table.insert(slot1, TabViewGroup.New(1, "root/#go_topleft"))

	slot0._tabViewGroupFit = TabViewGroupFit.New(2, "root/#go_container")

	slot0._tabViewGroupFit:keepCloseVisible(true)
	slot0._tabViewGroupFit:setTabCloseFinishCallback(slot0._onTabCloseFinish, slot0)
	slot0._tabViewGroupFit:setTabOpenFinishCallback(slot0._onTabOpenFinish, slot0)
	table.insert(slot1, slot0._tabViewGroupFit)

	return slot1
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

	if slot1 == 2 then
		slot0._commonView = InvestigateOpinionCommonView.New()
		slot0._commonExtendView = InvestigateOpinionCommonView.New()

		slot0._commonExtendView:setInExtendView(true)

		slot0._opinionView = InvestigateOpinionView.New()
		slot0._opinionExtendView = InvestigateOpinionExtendView.New()

		return {
			MultiView.New({
				slot0._commonView,
				slot0._opinionView
			}),
			MultiView.New({
				slot0._commonExtendView,
				slot0._opinionExtendView
			})
		}
	end
end

function slot0.getCurTabId(slot0)
	return slot0._tabViewGroupFit:getCurTabId()
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0._onTabCloseFinish(slot0, slot1, slot2)
	slot0._closeTabId = slot1

	slot0._tabViewGroupFit:setTabAlpha(slot1, 1)
end

function slot0._onTabOpenFinish(slot0, slot1, slot2, slot3)
	slot0._openTabId = slot1

	if slot0._closeTabId == slot0._openTabId then
		return
	end

	if slot1 == 1 then
		gohelper.setAsFirstSibling(slot2.viewGO)

		if slot0._closeTabId then
			slot0._opinionExtendView:playAnim("gone", slot0._onAnimDone, slot0)
		end
	else
		gohelper.setAsLastSibling(slot2.viewGO)
		slot0._opinionExtendView:playAnim("into", slot0._onAnimDone, slot0)
	end
end

function slot0._onAnimDone(slot0)
	if slot0._openTabId == 1 then
		slot0._tabViewGroupFit:setTabAlpha(2, 0)
	else
		slot0._tabViewGroupFit:setTabAlpha(1, 0)
	end
end

return slot0
