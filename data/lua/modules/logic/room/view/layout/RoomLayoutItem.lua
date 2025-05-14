module("modules.logic.room.view.layout.RoomLayoutItem", package.seeall)

local var_0_0 = class("RoomLayoutItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnitem = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_item")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._simagecover = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/bg/mask/#simage_cover")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/bg/mask/#simage_mask")
	arg_1_0._simagemaskcopy = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/bg/mask/#simage_mask_copy")
	arg_1_0._btnlookinfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_lookinfo")
	arg_1_0._golookinfonormal = gohelper.findChild(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_lookinfo/#go_lookinfonormal")
	arg_1_0._golookinfoselect = gohelper.findChild(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_lookinfo/#go_lookinfoselect")
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_change")
	arg_1_0._gochangenormal = gohelper.findChild(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_change/#go_changenormal")
	arg_1_0._gochangeselect = gohelper.findChild(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_change/#go_changeselect")
	arg_1_0._btndelete = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_delete")
	arg_1_0._godeletenormal = gohelper.findChild(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_delete/#go_deletenormal")
	arg_1_0._godeletedisabled = gohelper.findChild(arg_1_0.viewGO, "#go_content/Right/Btn/#btn_delete/#go_deletedisabled")
	arg_1_0._txtshareCount = gohelper.findChildText(arg_1_0.viewGO, "#go_content/Top/#txt_shareCount")
	arg_1_0._txtdegree = gohelper.findChildText(arg_1_0.viewGO, "#go_content/Top/#txt_degree")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_content/Top/#txt_num")
	arg_1_0._gousing = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_using")
	arg_1_0._btnshare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_share")
	arg_1_0._gosharing = gohelper.findChild(arg_1_0.viewGO, "#go_content/#btn_share/#go_sharing")
	arg_1_0._gonotshare = gohelper.findChild(arg_1_0.viewGO, "#go_content/#btn_share/#go_notshare")
	arg_1_0._txtlayoutname = gohelper.findChildText(arg_1_0.viewGO, "#go_content/RightBottom/#txt_layoutname")
	arg_1_0._btneditname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/RightBottom/#txt_layoutname/#btn_editname")
	arg_1_0._gosharecode = gohelper.findChild(arg_1_0.viewGO, "#go_content/RightBottom/#go_sharecode")
	arg_1_0._txtsharecode = gohelper.findChildText(arg_1_0.viewGO, "#go_content/RightBottom/#go_sharecode/#txt_sharecode")
	arg_1_0._btncopysharecode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/RightBottom/#go_sharecode/#btn_copysharecode")
	arg_1_0._gosharetag = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_sharetag")
	arg_1_0._goadd = gohelper.findChild(arg_1_0.viewGO, "#go_add")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_add/#btn_add")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._btnitemOnClick, arg_2_0)
	arg_2_0._btnlookinfo:AddClickListener(arg_2_0._btnlookinfoOnClick, arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btndelete:AddClickListener(arg_2_0._btndeleteOnClick, arg_2_0)
	arg_2_0._btnshare:AddClickListener(arg_2_0._btnshareOnClick, arg_2_0)
	arg_2_0._btneditname:AddClickListener(arg_2_0._btneditnameOnClick, arg_2_0)
	arg_2_0._btncopysharecode:AddClickListener(arg_2_0._btncopysharecodeOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnitem:RemoveClickListener()
	arg_3_0._btnlookinfo:RemoveClickListener()
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btndelete:RemoveClickListener()
	arg_3_0._btnshare:RemoveClickListener()
	arg_3_0._btneditname:RemoveClickListener()
	arg_3_0._btncopysharecode:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
end

function var_0_0._btnshareOnClick(arg_4_0)
	if not arg_4_0._layoutMO or arg_4_0._layoutMO:isEmpty() then
		return
	end

	local var_4_0 = Time.time

	if arg_4_0._lastShareTime and var_4_0 > arg_4_0._lastShareTime then
		return
	end

	if arg_4_0._layoutMO:isSharing() then
		RoomRpc.instance:sendDeleteRoomShareRequest(arg_4_0._layoutMO.id)
	else
		local var_4_1 = RoomLayoutModel.instance:getCanShareCount()

		if var_4_1 <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotNum)

			return
		end

		if var_4_1 <= CommonConfig.instance:getConstNum(ConstEnum.RoomPlanCanShareTipNum) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanShareCount, MsgBoxEnum.BoxType.Yes_No, arg_4_0._sendShareRoomPlanRequest, nil, nil, arg_4_0, nil, nil, var_4_1)
		else
			arg_4_0:_sendShareRoomPlanRequest()
		end
	end
end

function var_0_0._sendShareRoomPlanRequest(arg_5_0)
	if not arg_5_0._layoutMO then
		return
	end

	if not arg_5_0._layoutMO:haveEdited() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanShare)

		return
	end

	RoomRpc.instance:sendShareRoomPlanRequest(arg_5_0._layoutMO.id)
end

function var_0_0._btncopysharecodeOnClick(arg_6_0)
	if arg_6_0._layoutMO then
		RoomLayoutController.instance:copyShareCodeTxt(arg_6_0._layoutMO:getShareCode())
	end
end

function var_0_0._btnitemOnClick(arg_7_0)
	arg_7_0:_selectThis()
end

function var_0_0._btneditnameOnClick(arg_8_0)
	arg_8_0:_selectThis()

	if arg_8_0._layoutMO then
		RoomLayoutController.instance:openRenameView(arg_8_0._layoutMO.name, arg_8_0._onRenameCallback, arg_8_0)
	end
end

function var_0_0._btnlookinfoOnClick(arg_9_0)
	arg_9_0:_selectThis()

	if arg_9_0._layoutMO then
		if not arg_9_0._layoutMO.blockCount or arg_9_0._layoutMO.blockCount < 1 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanMapNothing)

			return
		end

		local var_9_0, var_9_1, var_9_2 = transformhelper.getPos(arg_9_0._gocontentTrs)

		RoomLayoutController.instance:openTips(arg_9_0._layoutMO.id, Vector3(var_9_0, var_9_1, var_9_2), arg_9_0._halfWidth, arg_9_0._halfHeight)
		arg_9_0:_setLookinfoState(true)
	end
end

function var_0_0._btnchangeOnClick(arg_10_0)
	arg_10_0:_selectThis()

	if arg_10_0._layoutMO then
		local var_10_0, var_10_1, var_10_2 = transformhelper.getPos(arg_10_0._gocontentTrs)

		RoomLayoutController.instance:openBgSelectView(Vector3(var_10_0, var_10_1, var_10_2), arg_10_0._halfWidth, arg_10_0._halfHeight)
		arg_10_0:_setChangeState(true)
	end
end

function var_0_0._btndeleteOnClick(arg_11_0)
	if not arg_11_0._layoutMO then
		return
	end

	arg_11_0:_selectThis()

	if arg_11_0._layoutMO:isUse() then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotDelete)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutDelete, MsgBoxEnum.BoxType.Yes_No, function()
		arg_11_0:_sendDeleteRequest()
	end)
end

function var_0_0._sendDeleteRequest(arg_13_0)
	if arg_13_0._layoutMO then
		RoomRpc.instance:sendDeleteRoomPlanRequest(arg_13_0._layoutMO.id)
	end
end

function var_0_0._onRenameCallback(arg_14_0, arg_14_1)
	if arg_14_0._layoutMO and not string.nilorempty(arg_14_1) and arg_14_0._layoutMO.name ~= arg_14_1 then
		if arg_14_0._txtlayoutname then
			arg_14_0._txtlayoutname.text = arg_14_1
		end

		RoomLayoutController.instance:sendSetRoomPlanNameRpc(arg_14_0._layoutMO.id, arg_14_1)
	end
end

function var_0_0._btnaddOnClick(arg_15_0)
	if arg_15_0._layoutMO then
		arg_15_0:_selectThis()
	end
end

function var_0_0._onCreateCallblck(arg_16_0, arg_16_1)
	if RoomController.instance:isVisitMode() then
		RoomLayoutController.instance:sendVisitCopyRpc(arg_16_0._layoutMO, arg_16_1)
		ViewMgr.instance:closeView(ViewName.RoomLayoutView)
	else
		RoomLayoutController.instance:sendCreateRpc(arg_16_0._layoutMO, arg_16_1)
	end
end

function var_0_0._editableInitView(arg_17_0)
	gohelper.setActive(arg_17_0._goselect, false)
	gohelper.setActive(arg_17_0._gousing, false)

	arg_17_0._goRight = gohelper.findChild(arg_17_0.viewGO, "#go_content/Right")
	arg_17_0._goTop = gohelper.findChild(arg_17_0.viewGO, "#go_content/Top")
	arg_17_0._goTopTrs = arg_17_0._goTop.transform
	arg_17_0._topTrsPx, arg_17_0._topTrsPy, arg_17_0._topTrsPz = transformhelper.getLocalPos(arg_17_0._goTopTrs)
	arg_17_0._goRightWidth = recthelper.getWidth(arg_17_0._goRight.transform)
	arg_17_0._gocontentTrs = arg_17_0._gocontent.transform
	arg_17_0._halfWidth = recthelper.getWidth(arg_17_0._gocontentTrs.transform) * 0.5 + 20
	arg_17_0._halfHeight = recthelper.getHeight(arg_17_0._gocontentTrs.transform) * 0.5

	if RoomController.instance:isVisitMode() then
		arg_17_0:_setHideGoRight(true)
	end
end

function var_0_0._setHideGoRight(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0._goRight, not arg_18_1)
	gohelper.setActive(arg_18_0._btneditname, not arg_18_1)

	local var_18_0 = arg_18_1 and arg_18_0._goRightWidth or 0

	transformhelper.setLocalPos(arg_18_0._goTopTrs, arg_18_0._topTrsPx + var_18_0, arg_18_0._topTrsPy, arg_18_0._topTrsPz)
end

function var_0_0._selectThis(arg_19_0)
	if arg_19_0._layoutMO then
		RoomLayoutListModel.instance:setSelect(arg_19_0._layoutMO.id)
		RoomLayoutController.instance:dispatchEvent(RoomEvent.UISelectLayoutPlanItem)
	end
end

function var_0_0._editableAddEvents(arg_20_0)
	RoomLayoutController.instance:registerCallback(RoomEvent.UISelectLayoutPlanCoverItem, arg_20_0._onUpdateCoverBg, arg_20_0)
	RoomLayoutController.instance:registerCallback(RoomEvent.UICancelLayoutPlanItemTab, arg_20_0._onCancelItemTab, arg_20_0)
end

function var_0_0._editableRemoveEvents(arg_21_0)
	RoomLayoutController.instance:unregisterCallback(RoomEvent.UISelectLayoutPlanCoverItem, arg_21_0._onUpdateCoverBg, arg_21_0)
	RoomLayoutController.instance:unregisterCallback(RoomEvent.UICancelLayoutPlanItemTab, arg_21_0._onCancelItemTab, arg_21_0)
end

function var_0_0.onUpdateMO(arg_22_0, arg_22_1)
	arg_22_0._layoutMO = arg_22_1

	if arg_22_1 == nil then
		return
	end

	local var_22_0 = arg_22_1:isEmpty()

	gohelper.setActive(arg_22_0._gocontent, not var_22_0)
	gohelper.setActive(arg_22_0._goadd, var_22_0)

	if not var_22_0 then
		local var_22_1 = arg_22_1:isUse()

		gohelper.setActive(arg_22_0._gousing, var_22_1)

		arg_22_0._txtlayoutname.text = arg_22_1:getName()
		arg_22_0._txtdegree.text = arg_22_1.buildingDegree
		arg_22_0._txtnum.text = arg_22_1.blockCount

		gohelper.setActive(arg_22_0._godeletenormal, not var_22_1)
		gohelper.setActive(arg_22_0._godeletedisabled, var_22_1)

		local var_22_2 = arg_22_1:getCoverResPath()

		if not string.nilorempty(var_22_2) then
			arg_22_0._simagecover:LoadImage(var_22_2)
		else
			logError("can not find config. excel:X小屋.xlsx export_封面 coverId:%s", arg_22_1:getCoverId())
		end

		local var_22_3 = arg_22_1:isSharing()

		gohelper.setActive(arg_22_0._gonotshare, not var_22_3)
		gohelper.setActive(arg_22_0._gosharing, var_22_3)
		gohelper.setActive(arg_22_0._gosharecode, var_22_3)
		gohelper.setActive(arg_22_0._txtshareCount, var_22_3)

		local var_22_4 = RoomController.instance:isObMode()

		gohelper.setActive(arg_22_0._btnshare, var_22_4)
		gohelper.setActive(arg_22_0._gosharetag, not var_22_4 and var_22_3)

		if var_22_3 then
			arg_22_0._txtsharecode.text = arg_22_1:getShareCode()
			arg_22_0._txtshareCount.text = arg_22_1:getUseCount()
		end
	end
end

function var_0_0._setLookinfoState(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._golookinfonormal, not arg_23_1)
	gohelper.setActive(arg_23_0._golookinfoselect, arg_23_1)
end

function var_0_0._setChangeState(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._gochangenormal, not arg_24_1)
	gohelper.setActive(arg_24_0._gochangeselect, arg_24_1)
end

function var_0_0.onSelect(arg_25_0, arg_25_1)
	arg_25_0._isSelect = arg_25_1

	gohelper.setActive(arg_25_0._goselect, arg_25_1)
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0._simagecover:UnLoadImage()
end

function var_0_0._onUpdateCoverBg(arg_27_0)
	if arg_27_0._isSelect then
		local var_27_0 = RoomLayoutBgResListModel.instance:getSelectMO()

		if var_27_0 then
			arg_27_0._simagecover:LoadImage(var_27_0:getResPath())
		end
	end
end

function var_0_0._onCancelItemTab(arg_28_0)
	arg_28_0:_setLookinfoState(false)
	arg_28_0:_setChangeState(false)
end

var_0_0.prefabUrl = "ui/viewres/room/layout/roomlayoutitem.prefab"

return var_0_0
