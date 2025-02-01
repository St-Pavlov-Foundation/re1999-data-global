module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameViewContainer", package.seeall)

slot0 = class("LanShouPaGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, LanShouPaGameView.New())
	table.insert(slot1, LanShouPaGameScene.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot2:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot2
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	ChessGameController.instance:release()
	slot0:closeThis()
end

function slot0._onEscape(slot0)
	slot0:_overrideCloseFunc()
end

function slot0.setRootSceneGo(slot0, slot1)
	slot0.sceneGo = slot1
end

function slot0.getRootSceneGo(slot0)
	return slot0.sceneGo
end

return slot0
