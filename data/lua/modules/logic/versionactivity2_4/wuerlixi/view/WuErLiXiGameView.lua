module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameView", package.seeall)

local var_0_0 = class("WuErLiXiGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._goimgbg1 = gohelper.findChild(arg_1_0.viewGO, "#simage_FullBG1")
	arg_1_0._bgClick = gohelper.getClick(arg_1_0._goimgbg1)
	arg_1_0._goimgbg2 = gohelper.findChild(arg_1_0.viewGO, "#simage_FullBG2")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "#go_Target")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_Right")
	arg_1_0._gosuccessright = gohelper.findChild(arg_1_0.viewGO, "#go_SuccessRight")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_SuccessRight/Click")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_Success")
	arg_1_0._closeClick = gohelper.getClick(arg_1_0._goclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._bgClick:AddClickListener(arg_2_0._onBgClick, arg_2_0)
	arg_2_0._closeClick:AddClickListener(arg_2_0._onCloseClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._bgClick:RemoveClickListener()
	arg_3_0._closeClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:_addEvents()
end

function var_0_0._onBgClick(arg_5_0)
	WuErLiXiMapModel.instance:clearSelectUnit()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeClicked)
end

function var_0_0._onCloseClick(arg_6_0)
	if arg_6_0._gameSuccess then
		if arg_6_0.viewParam.callback then
			arg_6_0.viewParam.callback(arg_6_0.viewParam.callbackObj)
		end

		WuErLiXiMapModel.instance:resetMap(arg_6_0._mapId)
	end

	TaskDispatcher.runDelay(arg_6_0.closeThis, arg_6_0, 0.5)
end

function var_0_0._addEvents(arg_7_0)
	arg_7_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapConnectSuccess, arg_7_0._onGameSuccess, arg_7_0)
	arg_7_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, arg_7_0._onMapReset, arg_7_0)
end

function var_0_0._removeEvents(arg_8_0)
	arg_8_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapConnectSuccess, arg_8_0._onGameSuccess, arg_8_0)
	arg_8_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, arg_8_0._onMapReset, arg_8_0)
end

function var_0_0._onGameSuccess(arg_9_0)
	arg_9_0._gameSuccess = true

	gohelper.setActive(arg_9_0._gotopleft, false)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_success)
	arg_9_0._anim:Play("success", 0, 0)
	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(arg_9_0._mapId),
		[StatEnum.EventProperties.OperationType] = "success",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "success",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
end

function var_0_0._onMapReset(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)
	arg_10_0._anim:Play("reset", 0, 0)
end

function var_0_0.onOpen(arg_11_0)
	WuErLiXiMapModel.instance:setMapStartTime()
	WuErLiXiMapModel.instance:clearOperations()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)

	arg_11_0._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	arg_11_0._mapId = WuErLiXiConfig.instance:getEpisodeCo(arg_11_0._actId, arg_11_0.viewParam.episodeId).mapId

	WuErLiXiMapModel.instance:setCurMapId(arg_11_0._mapId)

	arg_11_0._mapMo = WuErLiXiMapModel.instance:getMap(arg_11_0._mapId)
end

function var_0_0.onClose(arg_12_0)
	WuErLiXiMapModel.instance:clearSelectUnit()
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._successShowEnd, arg_13_0)
	arg_13_0:_removeEvents()
end

return var_0_0
