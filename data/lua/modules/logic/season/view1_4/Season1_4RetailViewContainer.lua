module("modules.logic.season.view1_4.Season1_4RetailViewContainer", package.seeall)

slot0 = class("Season1_4RetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season1_4RetailView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, slot0._closeCallback, slot0._homeCallback, nil, slot0)

	return {
		slot0._navigateButtonView
	}
end

function slot0._closeCallback(slot0)
	slot0:closeThis()
end

function slot0._homeCallback(slot0)
	slot0:closeThis()
end

function slot0.setVisibleInternal(slot0, slot1)
	if slot1 then
		slot0:_setVisible(true)
		slot0:playAnim(UIAnimationName.Open)
	elseif ViewMgr.instance:isOpen(ViewName.Season1_4MainView) then
		slot0:playAnim(UIAnimationName.Close)
	else
		slot0:_setVisible(false)
	end
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	if not slot0._anim and slot0.viewGO then
		slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if slot0._anim then
		if slot2 and slot3 then
			slot0._anim:Play(slot1, slot2, slot3)
		else
			slot0._anim:Play(slot1)
		end
	end
end

return slot0
