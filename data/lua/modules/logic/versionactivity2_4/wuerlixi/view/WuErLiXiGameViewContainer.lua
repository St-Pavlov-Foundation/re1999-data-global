module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameViewContainer", package.seeall)

slot0 = class("WuErLiXiGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		WuErLiXiGameView.New(),
		WuErLiXiGameMapView.New(),
		WuErLiXiGameOperView.New(),
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
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.WuErLiXiMapEscapeConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._onCloseGameView, nil, , slot0)
end

function slot0._onCloseGameView(slot0)
	slot0._mapId = WuErLiXiConfig.instance:getEpisodeCo(VersionActivity2_4Enum.ActivityId.WuErLiXi, slot0.viewParam.episodeId).mapId

	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(slot0._mapId),
		[StatEnum.EventProperties.OperationType] = "Escape",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnBackToLevel)
	slot0:closeThis()
end

return slot0
