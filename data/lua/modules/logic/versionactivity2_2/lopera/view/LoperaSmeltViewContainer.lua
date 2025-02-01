module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltViewContainer", package.seeall)

slot0 = class("LoperaSmeltViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LoperaSmeltView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot2:setCloseCheck(slot0.defaultOverrideCloseCheck, slot0)
		slot2:setOverrideHome(slot0._overrideClickHome, slot0)

		return {
			slot2
		}
	end
end

function slot0.defaultOverrideCloseCheck(slot0)
	slot0:closeThis()
end

function slot0._overrideClickHome(slot0)
	LoperaController.instance:sendStatOnHomeClick()
	NavigateButtonsView.homeClick()
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
