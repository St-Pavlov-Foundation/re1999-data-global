module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateEffectViewContainer", package.seeall)

slot0 = class("EliminateEffectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, EliminateEffectView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.EliminateLevelClose, MsgBoxEnum.BoxType.Yes_No, slot0._closeLevel, nil, , slot0, nil, )
end

function slot0._closeLevel(slot0)
	EliminateLevelModel.instance:sendStatData(EliminateLevelEnum.resultStatUse.draw)
	EliminateLevelController.instance:closeLevel()
end

return slot0
