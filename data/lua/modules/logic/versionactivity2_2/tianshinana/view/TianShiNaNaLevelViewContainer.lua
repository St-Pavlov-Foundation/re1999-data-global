module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelViewContainer", package.seeall)

slot0 = class("TianShiNaNaLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._mapViewScene = TianShiNaNaLevelScene.New()

	return {
		TianShiNaNaLevelView.New(),
		TianShiNaNaOperView.New(),
		slot0._mapViewScene,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot2:setOverrideClose(slot0.defaultOverrideCloseClick, slot0)

		return {
			slot2
		}
	end
end

function slot0.defaultOverrideCloseClick(slot0)
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.Act167Abort, MsgBoxEnum.BoxType.Yes_No, slot0.closeThis, nil, , slot0)
end

function slot0.setVisibleInternal(slot0, slot1)
	if slot0._mapViewScene then
		slot0._mapViewScene:setSceneVisible(slot1)
	end

	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
