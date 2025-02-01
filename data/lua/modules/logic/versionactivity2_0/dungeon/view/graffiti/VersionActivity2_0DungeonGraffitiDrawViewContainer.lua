module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiDrawViewContainer", package.seeall)

slot0 = class("VersionActivity2_0DungeonGraffitiDrawViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity2_0DungeonGraffitiDrawView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0._navigateButtonView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	if Activity161Model.instance.graffitiInfoMap[slot0.viewParam.graffitiMO.id].state ~= Activity161Enum.graffitiState.IsFinished and slot0._isBeginDraw then
		GameFacade.showMessageBox(MessageBoxIdDefine.GraffitiUnFinishConfirm, MsgBoxEnum.BoxType.Yes_No, slot0.closeThis, nil, , slot0)
	else
		slot0:closeThis()
	end
end

function slot0.setIsBeginDrawState(slot0, slot1)
	slot0._isBeginDraw = slot1
end

return slot0
