module("modules.logic.room.view.transport.RoomTransportPathFailTips", package.seeall)

slot0 = class("RoomTransportPathFailTips", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btntips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_tips")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/expand/#btn_close")
	slot0._scrolldec = gohelper.findChildScrollRect(slot0.viewGO, "#go_content/expand/bg/#scroll_dec")
	slot0._godecitem = gohelper.findChild(slot0.viewGO, "#go_content/expand/bg/#scroll_dec/viewport/content/#go_decitem")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#go_content/expand/bg/#scroll_dec/viewport/content/#go_decitem/#txt_dec")
	slot0._txtfailcount = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_failcount")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntips:AddClickListener(slot0._btntipsOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntips:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btntipsOnClick(slot0)
	slot0._isShow = true

	gohelper.setActive(slot0._goexpand, true)
	gohelper.setActive(slot0._btntips, false)
	slot0._animatorPlayer:Play(UIAnimationName.Open, slot0._animDone, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0._isShow = false

	slot0._animatorPlayer:Play(UIAnimationName.Close, slot0._animDone, slot0)
end

function slot0._editableInitView(slot0)
	slot0._goexpand = gohelper.findChild(slot0.viewGO, "#go_content/expand")

	gohelper.setActive(slot0._goexpand, false)

	slot0._isShow = false
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0._goexpand)
	slot0._slotDataList = {
		{
			slotType = RoomBuildingEnum.BuildingType.Collect
		},
		{
			slotType = RoomBuildingEnum.BuildingType.Process
		},
		{
			slotType = RoomBuildingEnum.BuildingType.Manufacture
		}
	}
	slot4 = slot0._godecitem
	slot0._tbItemList = {
		slot0:_createTB(slot4)
	}

	for slot4 = 1, #slot0._slotDataList do
		if slot0._tbItemList[slot4] == nil then
			table.insert(slot0._tbItemList, slot0:_createTB(gohelper.cloneInPlace(slot0._godecitem)))
		end

		slot5.dataMO = slot0._slotDataList[slot4]
		slot5._txtdec.text = luaLang(RoomTransportPathEnum.TipLang[slot5.dataMO.slotType])
	end
end

function slot0._animDone(slot0)
	if not slot0._isShow then
		gohelper.setActive(slot0._goexpand, false)
		gohelper.setActive(slot0._btntips, true)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathLineChanged, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	if slot0._lastFailCount ~= RoomMapTransportPathModel.instance:getLinkFailCount() then
		slot0._lastFailCount = slot2

		gohelper.setActive(slot0._gocontent, slot2 > 0)

		slot0._txtfailcount.text = slot2
	end

	if slot2 > 0 then
		slot0:_refreshItemTbList()
	end
end

function slot0._refreshItemTbList(slot0)
	for slot5 = 1, #slot0._tbItemList do
		slot7, slot8 = RoomTransportHelper.getSiteFromToByType(slot0._tbItemList[slot5].dataMO.slotType)
		slot10 = true

		if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot7, slot8) and slot9:isLinkFinish() then
			slot10 = false
		end

		gohelper.setActive(slot6.go, slot10)
	end
end

function slot0._createTB(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2._txtdec = gohelper.findChildText(slot1, "#txt_dec")

	return slot2
end

slot0.prefabPath = "ui/viewres/room/transport/roomtransportpathfailtips.prefab"

return slot0
