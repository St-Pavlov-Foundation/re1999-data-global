module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelViewContainer", package.seeall)

slot0 = class("LoperaLevelViewContainer", BaseViewContainer)
slot1 = 0.35

function slot0.buildViews(slot0)
	return {
		LoperaLevelView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot2:setOverrideClose(slot0._overrideCloseAction, slot0)
		slot2:setOverrideHome(slot0._overrideClickHome, slot0)

		return {
			slot2
		}
	end
end

function slot0._overrideCloseAction(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, slot0._playAniAndClose, nil, , slot0)
end

function slot0._overrideClickHome(slot0)
	LoperaController.instance:sendStatOnHomeClick()
	NavigateButtonsView.homeClick()
end

function slot0._playAniAndClose(slot0)
	if not slot0._anim then
		slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._anim:Play("out", 0, 0)
	LoperaController.instance:abortEpisode()
	TaskDispatcher.runDelay(slot0.closeThis, slot0, uv0)
end

function slot0.defaultOverrideCloseCheck(slot0, slot1, slot2)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, function ()
		LoperaController.instance:abortEpisode()
		uv0(uv1)
	end)

	return false
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
