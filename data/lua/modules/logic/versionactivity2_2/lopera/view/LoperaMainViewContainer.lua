module("modules.logic.versionactivity2_2.lopera.view.LoperaMainViewContainer", package.seeall)

slot0 = class("LoperaMainViewContainer", BaseViewContainer)
slot1 = 0.35

function slot0.buildViews(slot0)
	slot0._mainView = LoperaMainView.New()

	return {
		slot0._mainView,
		TabViewGroup.New(1, "#go_left")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot2:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot2
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_2Enum.ActivityId.Lopera)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_2Enum.ActivityId.Lopera
	})
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)

	if not slot0.viewGO then
		return
	end

	if not slot0._anim then
		slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if slot1 then
		slot0._anim:Play(UIAnimationName.Open, 0, 0)
		slot0._mainView:tryShowFinishUnlockView()
	end
end

function slot0._overrideCloseFunc(slot0)
	if not slot0._anim then
		slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._anim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, uv0)
end

function slot0.onContainerClose(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0
