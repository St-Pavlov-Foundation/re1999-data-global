module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameOperView", package.seeall)

local var_0_0 = class("WuErLiXiGameOperView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "#go_Target")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_Right")
	arg_1_0._goactunitroot = gohelper.findChild(arg_1_0.viewGO, "#go_Right/ActUnits")
	arg_1_0._goactunits = gohelper.findChild(arg_1_0.viewGO, "#go_Right/ActUnits/#go_actunits")
	arg_1_0._goactunititem = gohelper.findChild(arg_1_0.viewGO, "#go_Right/ActUnits/#go_actunits/#go_actunititem")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_Right/Btns")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/Btns/#btn_reset")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/Btns/#btn_skip")
	arg_1_0._btnunittips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/Btns/#btn_unittips")
	arg_1_0._gounittipnew = gohelper.findChild(arg_1_0.viewGO, "#go_Right/Btns/#btn_unittips/#go_new")
	arg_1_0._godragitem = gohelper.findChild(arg_1_0.viewGO, "#go_dragitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0._btnunittips:AddClickListener(arg_2_0._btnunittipsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0._btnunittips:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.WuErLiXiResetConfirm, MsgBoxEnum.BoxType.Yes_No, arg_4_0._onChooseReset, nil, nil, arg_4_0)
end

function var_0_0._onChooseReset(arg_5_0)
	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(arg_5_0._mapId),
		[StatEnum.EventProperties.OperationType] = "reset",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	WuErLiXiMapModel.instance:resetMap(arg_5_0._mapId)
	WuErLiXiMapModel.instance:clearSelectUnit()
	arg_5_0:_onMapReset()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.MapResetClicked)
end

function var_0_0._btnskipOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.WuErLiXiSkipConfirm, MsgBoxEnum.BoxType.Yes_No, arg_6_0._onChooseClose, nil, nil, arg_6_0)
end

function var_0_0._onChooseClose(arg_7_0)
	if arg_7_0.viewParam.callback then
		arg_7_0.viewParam.callback(arg_7_0.viewParam.callbackObj)
	end

	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(arg_7_0._mapId),
		[StatEnum.EventProperties.OperationType] = "skip",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	arg_7_0:closeThis()
end

function var_0_0._btnunittipsOnClick(arg_8_0)
	WuErLiXiMapModel.instance:setReadNewElement()
	ViewMgr.instance:openView(ViewName.WuErLiXiUnitTipView)
	arg_8_0:_refreshBtns()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0:_addEvents()
end

function var_0_0._addEvents(arg_10_0)
	arg_10_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaced, arg_10_0._onNodeChange, arg_10_0)
	arg_10_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaceBack, arg_10_0._onNodeChange, arg_10_0)
end

function var_0_0._removeEvents(arg_11_0)
	arg_11_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaced, arg_11_0._onNodeChange, arg_11_0)
	arg_11_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaceBack, arg_11_0._onNodeChange, arg_11_0)
end

function var_0_0._onNodeChange(arg_12_0)
	arg_12_0:_refreshActUnits()
end

function var_0_0._onMapReset(arg_13_0)
	arg_13_0:_refreshActUnits()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	arg_14_0._mapId = WuErLiXiConfig.instance:getEpisodeCo(arg_14_0._actId, arg_14_0.viewParam.episodeId).mapId
	arg_14_0._mapMo = WuErLiXiMapModel.instance:getMap(arg_14_0._mapId)
	arg_14_0._actUnitItems = {}

	arg_14_0:_refreshBtns()
	arg_14_0:_refreshActUnits()
end

function var_0_0._refreshBtns(arg_15_0)
	local var_15_0 = WuErLiXiModel.instance:isEpisodePass(arg_15_0.viewParam.episodeId)
	local var_15_1 = WuErLiXiModel.instance:getEpisodeStatus(arg_15_0.viewParam.episodeId)
	local var_15_2 = var_15_0 or var_15_1 == WuErLiXiEnum.EpisodeStatus.AfterStory or var_15_1 == WuErLiXiEnum.EpisodeStatus.Finished

	gohelper.setActive(arg_15_0._btnskip.gameObject, var_15_2)

	local var_15_3 = WuErLiXiMapModel.instance:hasElementNew()

	gohelper.setActive(arg_15_0._gounittipnew, var_15_3)
end

function var_0_0._refreshActUnits(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = WuErLiXiMapModel.instance:getMapLimitActUnits(arg_16_0._mapId)

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if not arg_16_0._actUnitItems[iter_16_1.id] then
			local var_16_2 = gohelper.cloneInPlace(arg_16_0._goactunititem)

			arg_16_0._actUnitItems[iter_16_1.id] = WuErLiXiGameActUnitItem.New()

			arg_16_0._actUnitItems[iter_16_1.id]:init(var_16_2, arg_16_0._godragitem)
			arg_16_0._actUnitItems[iter_16_1.id]:setItem(iter_16_1)
		else
			arg_16_0._actUnitItems[iter_16_1.id]:resetItem()
		end

		var_16_0[iter_16_1.id] = true
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0._actUnitItems) do
		if not var_16_0[iter_16_2] then
			iter_16_3:hide()
		end
	end
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0:_removeEvents()

	for iter_18_0, iter_18_1 in pairs(arg_18_0._actUnitItems) do
		iter_18_1:destroy()
	end
end

return var_0_0
