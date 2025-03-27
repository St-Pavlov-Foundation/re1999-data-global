module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameView", package.seeall)

slot0 = class("WuErLiXiGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0._goimgbg1 = gohelper.findChild(slot0.viewGO, "#simage_FullBG1")
	slot0._bgClick = gohelper.getClick(slot0._goimgbg1)
	slot0._goimgbg2 = gohelper.findChild(slot0.viewGO, "#simage_FullBG2")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "#go_Target")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_Right")
	slot0._gosuccessright = gohelper.findChild(slot0.viewGO, "#go_SuccessRight")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_SuccessRight/Click")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_Success")
	slot0._closeClick = gohelper.getClick(slot0._goclick)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._bgClick:AddClickListener(slot0._onBgClick, slot0)
	slot0._closeClick:AddClickListener(slot0._onCloseClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._bgClick:RemoveClickListener()
	slot0._closeClick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0:_addEvents()
end

function slot0._onBgClick(slot0)
	WuErLiXiMapModel.instance:clearSelectUnit()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeClicked)
end

function slot0._onCloseClick(slot0)
	if slot0._gameSuccess then
		if slot0.viewParam.callback then
			slot0.viewParam.callback(slot0.viewParam.callbackObj)
		end

		WuErLiXiMapModel.instance:resetMap(slot0._mapId)
	end

	TaskDispatcher.runDelay(slot0.closeThis, slot0, 0.5)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapConnectSuccess, slot0._onGameSuccess, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, slot0._onMapReset, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapConnectSuccess, slot0._onGameSuccess, slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.MapResetClicked, slot0._onMapReset, slot0)
end

function slot0._onGameSuccess(slot0)
	slot0._gameSuccess = true

	gohelper.setActive(slot0._gotopleft, false)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_success)
	slot0._anim:Play("success", 0, 0)
	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(slot0._mapId),
		[StatEnum.EventProperties.OperationType] = "success",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "success",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
end

function slot0._onMapReset(slot0)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)
	slot0._anim:Play("reset", 0, 0)
end

function slot0.onOpen(slot0)
	WuErLiXiMapModel.instance:setMapStartTime()
	WuErLiXiMapModel.instance:clearOperations()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)

	slot0._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	slot0._mapId = WuErLiXiConfig.instance:getEpisodeCo(slot0._actId, slot0.viewParam.episodeId).mapId

	WuErLiXiMapModel.instance:setCurMapId(slot0._mapId)

	slot0._mapMo = WuErLiXiMapModel.instance:getMap(slot0._mapId)
end

function slot0.onClose(slot0)
	WuErLiXiMapModel.instance:clearSelectUnit()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._successShowEnd, slot0)
	slot0:_removeEvents()
end

return slot0
