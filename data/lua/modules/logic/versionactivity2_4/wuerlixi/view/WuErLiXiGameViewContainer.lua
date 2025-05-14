module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameViewContainer", package.seeall)

local var_0_0 = class("WuErLiXiGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		WuErLiXiGameView.New(),
		WuErLiXiGameMapView.New(),
		WuErLiXiGameOperView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		var_2_0:setOverrideClose(arg_2_0.defaultOverrideCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.defaultOverrideCloseClick(arg_3_0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.WuErLiXiMapEscapeConfirm, MsgBoxEnum.BoxType.Yes_No, arg_3_0._onCloseGameView, nil, nil, arg_3_0)
end

function var_0_0._onCloseGameView(arg_4_0)
	arg_4_0._mapId = WuErLiXiConfig.instance:getEpisodeCo(VersionActivity2_4Enum.ActivityId.WuErLiXi, arg_4_0.viewParam.episodeId).mapId

	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(arg_4_0._mapId),
		[StatEnum.EventProperties.OperationType] = "Escape",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnBackToLevel)
	arg_4_0:closeThis()
end

return var_0_0
