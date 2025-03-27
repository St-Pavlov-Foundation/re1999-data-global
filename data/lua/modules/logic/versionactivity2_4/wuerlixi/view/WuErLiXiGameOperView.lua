module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameOperView", package.seeall)

slot0 = class("WuErLiXiGameOperView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "#go_Target")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_Right")
	slot0._goactunitroot = gohelper.findChild(slot0.viewGO, "#go_Right/ActUnits")
	slot0._goactunits = gohelper.findChild(slot0.viewGO, "#go_Right/ActUnits/#go_actunits")
	slot0._goactunititem = gohelper.findChild(slot0.viewGO, "#go_Right/ActUnits/#go_actunits/#go_actunititem")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_Right/Btns")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/Btns/#btn_reset")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/Btns/#btn_skip")
	slot0._btnunittips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/Btns/#btn_unittips")
	slot0._gounittipnew = gohelper.findChild(slot0.viewGO, "#go_Right/Btns/#btn_unittips/#go_new")
	slot0._godragitem = gohelper.findChild(slot0.viewGO, "#go_dragitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0._btnunittips:AddClickListener(slot0._btnunittipsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
	slot0._btnunittips:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.WuErLiXiResetConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._onChooseReset, nil, , slot0)
end

function slot0._onChooseReset(slot0)
	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(slot0._mapId),
		[StatEnum.EventProperties.OperationType] = "reset",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	WuErLiXiMapModel.instance:resetMap(slot0._mapId)
	WuErLiXiMapModel.instance:clearSelectUnit()
	slot0:_onMapReset()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.MapResetClicked)
end

function slot0._btnskipOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.WuErLiXiSkipConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._onChooseClose, nil, , slot0)
end

function slot0._onChooseClose(slot0)
	if slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj)
	end

	StatController.instance:track(StatEnum.EventName.WuErLiXiGameOperation, {
		[StatEnum.EventProperties.MapId] = tostring(slot0._mapId),
		[StatEnum.EventProperties.OperationType] = "skip",
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - WuErLiXiMapModel.instance:getMapStartTime(),
		[StatEnum.EventProperties.Result] = "unsuccess",
		[StatEnum.EventProperties.WuErLiXiMapInfo] = WuErLiXiMapModel.instance:getStatMapInfos(),
		[StatEnum.EventProperties.WuErLiXiOperationInfo] = WuErLiXiMapModel.instance:getStatOperationInfos()
	})
	slot0:closeThis()
end

function slot0._btnunittipsOnClick(slot0)
	WuErLiXiMapModel.instance:setReadNewElement()
	ViewMgr.instance:openView(ViewName.WuErLiXiUnitTipView)
	slot0:_refreshBtns()
end

function slot0._editableInitView(slot0)
	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaced, slot0._onNodeChange, slot0)
	slot0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaceBack, slot0._onNodeChange, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaced, slot0._onNodeChange, slot0)
	slot0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.NodeUnitPlaceBack, slot0._onNodeChange, slot0)
end

function slot0._onNodeChange(slot0)
	slot0:_refreshActUnits()
end

function slot0._onMapReset(slot0)
	slot0:_refreshActUnits()
end

function slot0.onOpen(slot0)
	slot0._actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	slot0._mapId = WuErLiXiConfig.instance:getEpisodeCo(slot0._actId, slot0.viewParam.episodeId).mapId
	slot0._mapMo = WuErLiXiMapModel.instance:getMap(slot0._mapId)
	slot0._actUnitItems = {}

	slot0:_refreshBtns()
	slot0:_refreshActUnits()
end

function slot0._refreshBtns(slot0)
	slot2 = WuErLiXiModel.instance:getEpisodeStatus(slot0.viewParam.episodeId)

	gohelper.setActive(slot0._btnskip.gameObject, WuErLiXiModel.instance:isEpisodePass(slot0.viewParam.episodeId) or slot2 == WuErLiXiEnum.EpisodeStatus.AfterStory or slot2 == WuErLiXiEnum.EpisodeStatus.Finished)
	gohelper.setActive(slot0._gounittipnew, WuErLiXiMapModel.instance:hasElementNew())
end

function slot0._refreshActUnits(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(WuErLiXiMapModel.instance:getMapLimitActUnits(slot0._mapId)) do
		if not slot0._actUnitItems[slot7.id] then
			slot0._actUnitItems[slot7.id] = WuErLiXiGameActUnitItem.New()

			slot0._actUnitItems[slot7.id]:init(gohelper.cloneInPlace(slot0._goactunititem), slot0._godragitem)
			slot0._actUnitItems[slot7.id]:setItem(slot7)
		else
			slot0._actUnitItems[slot7.id]:resetItem()
		end

		slot1[slot7.id] = true
	end

	for slot6, slot7 in pairs(slot0._actUnitItems) do
		if not slot1[slot6] then
			slot7:hide()
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()

	for slot4, slot5 in pairs(slot0._actUnitItems) do
		slot5:destroy()
	end
end

return slot0
