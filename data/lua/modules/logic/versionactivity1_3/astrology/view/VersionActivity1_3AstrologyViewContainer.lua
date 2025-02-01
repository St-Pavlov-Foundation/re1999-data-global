module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyViewContainer", package.seeall)

slot0 = class("VersionActivity1_3AstrologyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.astrologyView = VersionActivity1_3AstrologyView.New()

	return {
		slot0.astrologyView,
		TabViewGroup.New(1, "#go_BackBtns"),
		TabViewGroup.New(2, "#go_plate"),
		TabViewGroup.New(3, "#go_Right")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.VersionActivity1_3Astrology)

		slot0._navigateButtonView:setHomeCheck(slot0._closeCheckFunc, slot0)
		slot0._navigateButtonView:setOverrideClose(slot0.overrideClose, slot0)

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		return {
			VersionActivity1_3AstrologyPlateView.New()
		}
	elseif slot1 == 3 then
		return {
			VersionActivity1_3AstrologySelectView.New(),
			VersionActivity1_3AstrologyResultView.New()
		}
	end
end

function slot0._closeCheckFunc(slot0)
	if not VersionActivity1_3AstrologyModel.instance:isEffectiveAdjust() then
		return true
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg2, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:sendUpdateProgressRequest()
	end, function ()
		uv0._navigateButtonView:_reallyHome()
	end)

	return false
end

function slot0.overrideClose(slot0)
	if not VersionActivity1_3AstrologyModel.instance:isEffectiveAdjust() then
		slot0:closeThis()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg2, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:sendUpdateProgressRequest()
	end, function ()
		uv0:closeThis()
	end)
end

function slot0.sendUpdateProgressRequest(slot0)
	slot3, slot0._sendPlanetList = VersionActivity1_3AstrologyModel.instance:generateStarProgressCost()

	Activity126Rpc.instance:sendUpdateProgressRequest(VersionActivity1_3Enum.ActivityId.Act310, VersionActivity1_3AstrologyModel.instance:generateStarProgressStr(), slot3)
end

function slot0.getSendPlanetList(slot0)
	return slot0._sendPlanetList
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 3, slot1)
end

return slot0
