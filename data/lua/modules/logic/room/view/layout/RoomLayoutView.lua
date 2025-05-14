module("modules.logic.room.view.layout.RoomLayoutView", package.seeall)

local var_0_0 = class("RoomLayoutView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_normalroot/#simage_maskbg")
	arg_1_0._gotitleLayout = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_titleLayout")
	arg_1_0._gotitleCopy = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_titleCopy")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "go_normalroot/#scroll_ItemList")
	arg_1_0._gotipsusing = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/#go_tips_using")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Btn/#btn_cancel")
	arg_1_0._btncover = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Btn/#btn_cover")
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Btn/#btn_change")
	arg_1_0._btnnew = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Btn/#btn_new")
	arg_1_0._btnvisitcover = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Btn/#btn_visitcover")
	arg_1_0._btnsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/Btn/#btn_save")
	arg_1_0._btnsharecode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/#btn_sharecode")
	arg_1_0._txtshareCount = gohelper.findChildText(arg_1_0.viewGO, "go_normalroot/rightTop/#txt_shareCount")
	arg_1_0._btnshareCount = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_normalroot/rightTop/#txt_shareCount/#btn_shareCount")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btncover:AddClickListener(arg_2_0._btncoverOnClick, arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btnnew:AddClickListener(arg_2_0._btnnewOnClick, arg_2_0)
	arg_2_0._btnvisitcover:AddClickListener(arg_2_0._btnvisitcoverOnClick, arg_2_0)
	arg_2_0._btnsave:AddClickListener(arg_2_0._btnsaveOnClick, arg_2_0)
	arg_2_0._btnsharecode:AddClickListener(arg_2_0._btnsharecodeOnClick, arg_2_0)
	arg_2_0._btnshareCount:AddClickListener(arg_2_0._btnshareCountOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btncover:RemoveClickListener()
	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btnnew:RemoveClickListener()
	arg_3_0._btnvisitcover:RemoveClickListener()
	arg_3_0._btnsave:RemoveClickListener()
	arg_3_0._btnsharecode:RemoveClickListener()
	arg_3_0._btnshareCount:RemoveClickListener()
end

function var_0_0._btnsaveOnClick(arg_4_0)
	arg_4_0:_onOpenCreateTipsView()
end

function var_0_0._btnshareCountOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.PlanShare,
		shareCount = RoomLayoutModel.instance:getUseCount()
	})
end

function var_0_0._btnsharecodeOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.RoomLayoutFindShareView)
end

function var_0_0._btnvisitcoverOnClick(arg_7_0)
	local var_7_0 = arg_7_0:_getCoverTitleStr()

	arg_7_0:_onOpenCreateTipsView(var_7_0)
end

function var_0_0._btncancelOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btncoverOnClick(arg_9_0)
	local var_9_0 = arg_9_0:_getCoverTitleStr()

	arg_9_0:_onOpenCreateTipsView(var_9_0)
end

function var_0_0._btnchangeOnClick(arg_10_0)
	local var_10_0 = RoomLayoutListModel.instance:getSelectMO()

	if not var_10_0 then
		return
	end

	local var_10_1 = RoomCharacterModel.instance:getMaxCharacterCount(var_10_0.buildingDegree) or 0
	local var_10_2 = (RoomCharacterModel.instance:getConfirmCharacterCount() or 0) - var_10_1
	local var_10_3 = var_10_0.id

	if var_10_2 > 0 then
		ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
			needRemoveCount = var_10_2,
			sureCallback = arg_10_0._confirmSwitchPlanCallback,
			callbackObj = arg_10_0,
			callbackParam = {
				switchPlanId = var_10_3
			}
		})
	else
		arg_10_0:_sendSwitchRoomPlan(var_10_3)
	end
end

function var_0_0._btnnewOnClick(arg_11_0)
	arg_11_0:_onOpenCreateTipsView()
end

function var_0_0._confirmSwitchPlanCallback(arg_12_0, arg_12_1)
	arg_12_0:_sendSwitchRoomPlan(arg_12_1.switchPlanId)
end

function var_0_0._sendSwitchRoomPlan(arg_13_0, arg_13_1)
	RoomLayoutController.instance:sendSwitchRoomPlanRequest(arg_13_1)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._animator = arg_14_0.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	arg_14_0._gorightTop = gohelper.findChild(arg_14_0.viewGO, "go_normalroot/rightTop")
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0._getCoverTitleStr(arg_16_0)
	local var_16_0 = RoomLayoutListModel.instance:getSelectMO()

	if var_16_0 and var_16_0:isSharing() then
		return luaLang("room_layoutplan_cover_sharecode_tips")
	end

	return luaLang("room_layoutplan_cover_tips")
end

function var_0_0._onOpenCreateTipsView(arg_17_0, arg_17_1)
	local var_17_0 = RoomLayoutListModel.instance:getSelectMO()

	if var_17_0 then
		local var_17_1 = var_17_0.id ~= RoomEnum.LayoutUsedPlanId and RoomController.instance:isVisitMode()

		RoomLayoutController.instance:openCreateTipsView(arg_17_1, false, var_17_1, arg_17_0._onCreateCallblck, arg_17_0)
	end
end

function var_0_0._onCreateCallblck(arg_18_0, arg_18_1)
	local var_18_0 = RoomLayoutListModel.instance:getSelectMO()

	if not RoomController.instance:isVisitMode() then
		RoomLayoutController.instance:sendCreateRpc(var_18_0, arg_18_1)

		return
	end

	arg_18_0._isVisitCopyRpcSelect = arg_18_1

	if RoomController.instance:isVisitShareMode() then
		local var_18_1 = RoomLayoutModel.instance:getCanUseShareCount()

		if var_18_1 <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanUseShareCodeNotNum)

			return
		end

		if var_18_1 <= CommonConfig.instance:getConstNum(ConstEnum.RoomPlanCanUseShareTipNum) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanUseShareCount, MsgBoxEnum.BoxType.Yes_No, arg_18_0._checkVisitCharacterPlaceCount, nil, nil, arg_18_0, nil, nil, var_18_1)

			return
		end
	end

	arg_18_0:_checkVisitCharacterPlaceCount()
end

function var_0_0._checkVisitCharacterPlaceCount(arg_19_0)
	local var_19_0 = RoomLayoutListModel.instance:getSelectMO()

	if arg_19_0._isVisitCopyRpcSelect or var_19_0 and var_19_0.id == RoomEnum.LayoutUsedPlanId then
		local var_19_1 = RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode())
		local var_19_2, var_19_3 = RoomLayoutHelper.findHasBlockBuildingInfos(var_19_1 and var_19_1.infos, var_19_1 and var_19_1.buildingInfos)
		local var_19_4, var_19_5 = RoomLayoutHelper.sunDegreeInfos(var_19_2, var_19_3)
		local var_19_6 = RoomModel.instance:getRoomLevel()
		local var_19_7 = RoomCharacterModel.instance:getMaxCharacterCount(var_19_4, var_19_6) or 0
		local var_19_8 = RoomModel.instance:getObInfo()
		local var_19_9 = RoomModel.instance:getCharacterList()
		local var_19_10 = #var_19_9 - var_19_7

		if var_19_10 > 0 then
			ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
				notUpdateMapModel = true,
				needRemoveCount = var_19_10,
				sureCallback = arg_19_0._sendVisitCopyRpc,
				callbackObj = arg_19_0,
				roomCharacterMOList = var_19_9
			})

			return
		end
	end

	arg_19_0:_sendVisitCopyRpc()
end

function var_0_0._sendVisitCopyRpc(arg_20_0)
	local var_20_0 = RoomLayoutListModel.instance:getSelectMO()

	RoomLayoutController.instance:sendVisitCopyRpc(var_20_0, arg_20_0._isVisitCopyRpcSelect)
	arg_20_0:closeThis()
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:addEventCb(RoomLayoutController.instance, RoomEvent.UISelectLayoutPlanItem, arg_21_0._onUISelectLayoutPlan, arg_21_0)
	RoomLayoutListModel.instance:initScelect(RoomController.instance:isVisitMode())
	arg_21_0:_onUISelectLayoutPlan()
	arg_21_0.viewContainer:movetoSelect()
end

function var_0_0.onClose(arg_22_0)
	return
end

function var_0_0._onUISelectLayoutPlan(arg_23_0)
	arg_23_0:_showButUI()
end

function var_0_0._showButUI(arg_24_0)
	arg_24_0._isObMode = RoomController.instance:isObMode()
	arg_24_0._isVisitMode = RoomController.instance:isVisitMode()

	local var_24_0 = RoomLayoutListModel.instance:getSelectMO()
	local var_24_1 = true

	arg_24_0._isEmpty = true

	if var_24_0 == nil or var_24_0:isUse() and arg_24_0._isObMode then
		var_24_1 = false
	else
		arg_24_0._isEmpty = var_24_0:isEmpty()
	end

	gohelper.setActive(arg_24_0._gotitleLayout, arg_24_0._isObMode)
	gohelper.setActive(arg_24_0._gotitleCopy, arg_24_0._isVisitMode)
	gohelper.setActive(arg_24_0._gorightTop, arg_24_0._isObMode)

	local var_24_2 = arg_24_0._isLastShowBtn ~= var_24_1 and arg_24_0._isLastShowBtn ~= nil

	arg_24_0._isLastShowBtn = var_24_1

	if var_24_2 then
		if var_24_1 then
			arg_24_0:_onShowButUI()
		end

		gohelper.setActive(arg_24_0._gotipsusing, true)
		arg_24_0._animator:Play(var_24_1 and "switch_btn" or "switch_tips")
		TaskDispatcher.cancelTask(arg_24_0._onShowButUI, arg_24_0)
		TaskDispatcher.runDelay(arg_24_0._onShowButUI, arg_24_0, 0.5)
	else
		arg_24_0:_onShowButUI()
	end

	arg_24_0._txtshareCount.text = RoomLayoutModel.instance:getUseCount()
end

function var_0_0._onShowButUI(arg_25_0)
	local var_25_0 = RoomController.instance:isObMode()
	local var_25_1 = RoomController.instance:isVisitMode()
	local var_25_2 = arg_25_0._isLastShowBtn
	local var_25_3 = arg_25_0._isEmpty

	gohelper.setActive(arg_25_0._btncancel, var_25_2 and var_25_1)
	gohelper.setActive(arg_25_0._btncover, var_25_2 and var_25_0 and not var_25_3)
	gohelper.setActive(arg_25_0._btnvisitcover, var_25_2 and var_25_1 and not var_25_3)
	gohelper.setActive(arg_25_0._btnnew, var_25_2 and var_25_0 and var_25_3)
	gohelper.setActive(arg_25_0._btnsave, var_25_2 and var_25_1 and var_25_3)
	gohelper.setActive(arg_25_0._btnchange, var_25_2 and var_25_0 and not var_25_3)
	gohelper.setActive(arg_25_0._gotipsusing, not var_25_2)
	gohelper.setActive(arg_25_0._btnsharecode, var_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._onShowButUI, arg_26_0)
	RoomMapController.instance:dispatchEvent(RoomEvent.ResumeAtmosphereEffect)
end

return var_0_0
