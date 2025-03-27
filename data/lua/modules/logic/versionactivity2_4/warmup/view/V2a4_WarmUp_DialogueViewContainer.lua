module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueViewContainer", package.seeall)

slot0 = class("V2a4_WarmUp_DialogueViewContainer", Activity125ViewBaseContainer)
slot1 = 1

function slot0.buildViews(slot0)
	return {
		V2a4_WarmUp_DialogueView.New(),
		TabViewGroup.New(uv0, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == uv0 then
		slot0._navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0._navigationView:setOverrideClose(slot0._overrideClose, slot0)

		return {
			slot0._navigationView
		}
	end
end

function slot0._overrideClose(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V2a4_WarmUp_DialogueView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, slot0._endYesCallback, nil, , slot0, nil, )
end

function slot0._endYesCallback(slot0)
	V2a4_WarmUpController.instance:abort()
end

function slot0.actId(slot0)
	return V2a4_WarmUpConfig.instance:actId()
end

function slot0.onContainerClose(slot0)
	V2a4_WarmUpController.instance:uploadToServer()
end

return slot0
