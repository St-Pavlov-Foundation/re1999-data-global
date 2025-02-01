module("modules.logic.seasonver.act166.view.Season166TeachViewContainer", package.seeall)

slot0 = class("Season166TeachViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166TeachView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0.navigateView:setOverrideClose(slot0.overrideClose, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.overrideClose(slot0)
	if Season166TeachModel.instance:checkIsAllTeachFinish(slot0.viewParam.actId) then
		slot0:closeThis()
	else
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.Season166CloseTeachTip, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.NotShow, slot0.onYesClick, nil, , slot0)
	end
end

function slot0.onYesClick(slot0)
	slot0:closeThis()
end

return slot0
