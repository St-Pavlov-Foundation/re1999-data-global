module("modules.logic.room.view.layout.RoomLayoutItem", package.seeall)

slot0 = class("RoomLayoutItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnitem = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_item")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._simagecover = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/bg/mask/#simage_cover")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/bg/mask/#simage_mask")
	slot0._simagemaskcopy = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/bg/mask/#simage_mask_copy")
	slot0._btnlookinfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/Right/Btn/#btn_lookinfo")
	slot0._golookinfonormal = gohelper.findChild(slot0.viewGO, "#go_content/Right/Btn/#btn_lookinfo/#go_lookinfonormal")
	slot0._golookinfoselect = gohelper.findChild(slot0.viewGO, "#go_content/Right/Btn/#btn_lookinfo/#go_lookinfoselect")
	slot0._btnchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/Right/Btn/#btn_change")
	slot0._gochangenormal = gohelper.findChild(slot0.viewGO, "#go_content/Right/Btn/#btn_change/#go_changenormal")
	slot0._gochangeselect = gohelper.findChild(slot0.viewGO, "#go_content/Right/Btn/#btn_change/#go_changeselect")
	slot0._btndelete = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/Right/Btn/#btn_delete")
	slot0._godeletenormal = gohelper.findChild(slot0.viewGO, "#go_content/Right/Btn/#btn_delete/#go_deletenormal")
	slot0._godeletedisabled = gohelper.findChild(slot0.viewGO, "#go_content/Right/Btn/#btn_delete/#go_deletedisabled")
	slot0._txtshareCount = gohelper.findChildText(slot0.viewGO, "#go_content/Top/#txt_shareCount")
	slot0._txtdegree = gohelper.findChildText(slot0.viewGO, "#go_content/Top/#txt_degree")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_content/Top/#txt_num")
	slot0._gousing = gohelper.findChild(slot0.viewGO, "#go_content/#go_using")
	slot0._btnshare = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_share")
	slot0._gosharing = gohelper.findChild(slot0.viewGO, "#go_content/#btn_share/#go_sharing")
	slot0._gonotshare = gohelper.findChild(slot0.viewGO, "#go_content/#btn_share/#go_notshare")
	slot0._txtlayoutname = gohelper.findChildText(slot0.viewGO, "#go_content/RightBottom/#txt_layoutname")
	slot0._btneditname = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/RightBottom/#txt_layoutname/#btn_editname")
	slot0._gosharecode = gohelper.findChild(slot0.viewGO, "#go_content/RightBottom/#go_sharecode")
	slot0._txtsharecode = gohelper.findChildText(slot0.viewGO, "#go_content/RightBottom/#go_sharecode/#txt_sharecode")
	slot0._btncopysharecode = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/RightBottom/#go_sharecode/#btn_copysharecode")
	slot0._gosharetag = gohelper.findChild(slot0.viewGO, "#go_content/#go_sharetag")
	slot0._goadd = gohelper.findChild(slot0.viewGO, "#go_add")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_add/#btn_add")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnitem:AddClickListener(slot0._btnitemOnClick, slot0)
	slot0._btnlookinfo:AddClickListener(slot0._btnlookinfoOnClick, slot0)
	slot0._btnchange:AddClickListener(slot0._btnchangeOnClick, slot0)
	slot0._btndelete:AddClickListener(slot0._btndeleteOnClick, slot0)
	slot0._btnshare:AddClickListener(slot0._btnshareOnClick, slot0)
	slot0._btneditname:AddClickListener(slot0._btneditnameOnClick, slot0)
	slot0._btncopysharecode:AddClickListener(slot0._btncopysharecodeOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnitem:RemoveClickListener()
	slot0._btnlookinfo:RemoveClickListener()
	slot0._btnchange:RemoveClickListener()
	slot0._btndelete:RemoveClickListener()
	slot0._btnshare:RemoveClickListener()
	slot0._btneditname:RemoveClickListener()
	slot0._btncopysharecode:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
end

function slot0._btnshareOnClick(slot0)
	if not slot0._layoutMO or slot0._layoutMO:isEmpty() then
		return
	end

	if slot0._lastShareTime and slot0._lastShareTime < Time.time then
		return
	end

	if slot0._layoutMO:isSharing() then
		RoomRpc.instance:sendDeleteRoomShareRequest(slot0._layoutMO.id)
	else
		if RoomLayoutModel.instance:getCanShareCount() <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotNum)

			return
		end

		if slot2 <= CommonConfig.instance:getConstNum(ConstEnum.RoomPlanCanShareTipNum) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanShareCount, MsgBoxEnum.BoxType.Yes_No, slot0._sendShareRoomPlanRequest, nil, , slot0, nil, , slot2)
		else
			slot0:_sendShareRoomPlanRequest()
		end
	end
end

function slot0._sendShareRoomPlanRequest(slot0)
	if not slot0._layoutMO then
		return
	end

	if not slot0._layoutMO:haveEdited() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanShare)

		return
	end

	RoomRpc.instance:sendShareRoomPlanRequest(slot0._layoutMO.id)
end

function slot0._btncopysharecodeOnClick(slot0)
	if slot0._layoutMO then
		RoomLayoutController.instance:copyShareCodeTxt(slot0._layoutMO:getShareCode())
	end
end

function slot0._btnitemOnClick(slot0)
	slot0:_selectThis()
end

function slot0._btneditnameOnClick(slot0)
	slot0:_selectThis()

	if slot0._layoutMO then
		RoomLayoutController.instance:openRenameView(slot0._layoutMO.name, slot0._onRenameCallback, slot0)
	end
end

function slot0._btnlookinfoOnClick(slot0)
	slot0:_selectThis()

	if slot0._layoutMO then
		if not slot0._layoutMO.blockCount or slot0._layoutMO.blockCount < 1 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanMapNothing)

			return
		end

		slot1, slot2, slot3 = transformhelper.getPos(slot0._gocontentTrs)

		RoomLayoutController.instance:openTips(slot0._layoutMO.id, Vector3(slot1, slot2, slot3), slot0._halfWidth, slot0._halfHeight)
		slot0:_setLookinfoState(true)
	end
end

function slot0._btnchangeOnClick(slot0)
	slot0:_selectThis()

	if slot0._layoutMO then
		slot1, slot2, slot3 = transformhelper.getPos(slot0._gocontentTrs)

		RoomLayoutController.instance:openBgSelectView(Vector3(slot1, slot2, slot3), slot0._halfWidth, slot0._halfHeight)
		slot0:_setChangeState(true)
	end
end

function slot0._btndeleteOnClick(slot0)
	if not slot0._layoutMO then
		return
	end

	slot0:_selectThis()

	if slot0._layoutMO:isUse() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotDelete)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutDelete, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_sendDeleteRequest()
	end)
end

function slot0._sendDeleteRequest(slot0)
	if slot0._layoutMO then
		RoomRpc.instance:sendDeleteRoomPlanRequest(slot0._layoutMO.id)
	end
end

function slot0._onRenameCallback(slot0, slot1)
	if slot0._layoutMO and not string.nilorempty(slot1) and slot0._layoutMO.name ~= slot1 then
		if slot0._txtlayoutname then
			slot0._txtlayoutname.text = slot1
		end

		RoomLayoutController.instance:sendSetRoomPlanNameRpc(slot0._layoutMO.id, slot1)
	end
end

function slot0._btnaddOnClick(slot0)
	if slot0._layoutMO then
		slot0:_selectThis()
	end
end

function slot0._onCreateCallblck(slot0, slot1)
	if RoomController.instance:isVisitMode() then
		RoomLayoutController.instance:sendVisitCopyRpc(slot0._layoutMO, slot1)
		ViewMgr.instance:closeView(ViewName.RoomLayoutView)
	else
		RoomLayoutController.instance:sendCreateRpc(slot0._layoutMO, slot1)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goselect, false)
	gohelper.setActive(slot0._gousing, false)

	slot0._goRight = gohelper.findChild(slot0.viewGO, "#go_content/Right")
	slot0._goTop = gohelper.findChild(slot0.viewGO, "#go_content/Top")
	slot0._goTopTrs = slot0._goTop.transform
	slot0._topTrsPx, slot0._topTrsPy, slot0._topTrsPz = transformhelper.getLocalPos(slot0._goTopTrs)
	slot0._goRightWidth = recthelper.getWidth(slot0._goRight.transform)
	slot0._gocontentTrs = slot0._gocontent.transform
	slot0._halfWidth = recthelper.getWidth(slot0._gocontentTrs.transform) * 0.5 + 20
	slot0._halfHeight = recthelper.getHeight(slot0._gocontentTrs.transform) * 0.5

	if RoomController.instance:isVisitMode() then
		slot0:_setHideGoRight(true)
	end
end

function slot0._setHideGoRight(slot0, slot1)
	gohelper.setActive(slot0._goRight, not slot1)
	gohelper.setActive(slot0._btneditname, not slot1)
	transformhelper.setLocalPos(slot0._goTopTrs, slot0._topTrsPx + (slot1 and slot0._goRightWidth or 0), slot0._topTrsPy, slot0._topTrsPz)
end

function slot0._selectThis(slot0)
	if slot0._layoutMO then
		RoomLayoutListModel.instance:setSelect(slot0._layoutMO.id)
		RoomLayoutController.instance:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	end
end

function slot0._editableAddEvents(slot0)
	RoomLayoutController.instance:registerCallback(RoomEvent.UISelectLayoutPlanCoverItem, slot0._onUpdateCoverBg, slot0)
	RoomLayoutController.instance:registerCallback(RoomEvent.UICancelLayoutPlanItemTab, slot0._onCancelItemTab, slot0)
end

function slot0._editableRemoveEvents(slot0)
	RoomLayoutController.instance:unregisterCallback(RoomEvent.UISelectLayoutPlanCoverItem, slot0._onUpdateCoverBg, slot0)
	RoomLayoutController.instance:unregisterCallback(RoomEvent.UICancelLayoutPlanItemTab, slot0._onCancelItemTab, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._layoutMO = slot1

	if slot1 == nil then
		return
	end

	slot2 = slot1:isEmpty()

	gohelper.setActive(slot0._gocontent, not slot2)
	gohelper.setActive(slot0._goadd, slot2)

	if not slot2 then
		slot3 = slot1:isUse()

		gohelper.setActive(slot0._gousing, slot3)

		slot0._txtlayoutname.text = slot1:getName()
		slot0._txtdegree.text = slot1.buildingDegree
		slot0._txtnum.text = slot1.blockCount

		gohelper.setActive(slot0._godeletenormal, not slot3)
		gohelper.setActive(slot0._godeletedisabled, slot3)

		if not string.nilorempty(slot1:getCoverResPath()) then
			slot0._simagecover:LoadImage(slot4)
		else
			logError("can not find config. excel:X小屋.xlsx export_封面 coverId:%s", slot1:getCoverId())
		end

		slot5 = slot1:isSharing()

		gohelper.setActive(slot0._gonotshare, not slot5)
		gohelper.setActive(slot0._gosharing, slot5)
		gohelper.setActive(slot0._gosharecode, slot5)
		gohelper.setActive(slot0._txtshareCount, slot5)

		slot6 = RoomController.instance:isObMode()

		gohelper.setActive(slot0._btnshare, slot6)
		gohelper.setActive(slot0._gosharetag, not slot6 and slot5)

		if slot5 then
			slot0._txtsharecode.text = slot1:getShareCode()
			slot0._txtshareCount.text = slot1:getUseCount()
		end
	end
end

function slot0._setLookinfoState(slot0, slot1)
	gohelper.setActive(slot0._golookinfonormal, not slot1)
	gohelper.setActive(slot0._golookinfoselect, slot1)
end

function slot0._setChangeState(slot0, slot1)
	gohelper.setActive(slot0._gochangenormal, not slot1)
	gohelper.setActive(slot0._gochangeselect, slot1)
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1

	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simagecover:UnLoadImage()
end

function slot0._onUpdateCoverBg(slot0)
	if slot0._isSelect and RoomLayoutBgResListModel.instance:getSelectMO() then
		slot0._simagecover:LoadImage(slot1:getResPath())
	end
end

function slot0._onCancelItemTab(slot0)
	slot0:_setLookinfoState(false)
	slot0:_setChangeState(false)
end

slot0.prefabUrl = "ui/viewres/room/layout/roomlayoutitem.prefab"

return slot0
