module("modules.logic.battlepass.view.BpViewContainer", package.seeall)

slot0 = class("BpViewContainer", BaseViewContainer)
slot1 = 1
slot2 = 2

function slot0.buildViews(slot0)
	BpModel.instance.isViewLoading = true

	return {
		BpBuyBtn.New(),
		TabViewGroup.New(uv0, "#go_btns"),
		BPTabViewGroup.New(uv1, "#go_container"),
		BpView.New(),
		ToggleListView.New(uv1, "right/toggleGroup")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == uv1 then
		return {
			BpBonusView.New(),
			BpTaskView.New()
		}
	end
end

function slot0.playOpenTransition(slot0)
	slot1 = "tarotopen"
	slot2 = 1

	if slot0.viewParam and slot0.viewParam.isSwitch then
		slot1 = "switch"
	end

	if TimeUtil.getDayFirstLoginRed("BpViewOpenAnim") then
		if not slot0.viewParam or slot0.viewParam.isPlayDayFirstAnim then
			AudioMgr.instance:trigger(AudioEnum2_6.BP.BpDayFirstAnim)
			UIBlockMgrExtend.setNeedCircleMv(false)

			slot1 = "tarotopen1"
			slot2 = 3

			TimeUtil.setDayFirstLoginRed("BpViewOpenAnim")
		else
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._checkPlayDayAnim, slot0)
		end
	end

	uv0.super.playOpenTransition(slot0, {
		anim = slot1,
		duration = slot2
	})
end

function slot0._checkPlayDayAnim(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.BpView) then
		return
	end

	if slot0.viewParam and not slot0.viewParam.isPlayDayFirstAnim then
		slot0.viewParam.isPlayDayFirstAnim = true
	end

	slot0:playOpenTransition()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._checkPlayDayAnim, slot0)
end

function slot0.onPlayOpenTransitionFinish(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	uv0.super.onPlayOpenTransitionFinish(slot0)
end

function slot0.playCloseTransition(slot0)
	slot0:onPlayCloseTransitionFinish()
end

function slot0.onContainerClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._checkPlayDayAnim, slot0)
	uv0.super.onContainerClose(slot0)
end

return slot0
