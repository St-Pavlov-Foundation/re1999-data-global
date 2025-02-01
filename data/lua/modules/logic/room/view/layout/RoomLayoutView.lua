module("modules.logic.room.view.layout.RoomLayoutView", package.seeall)

slot0 = class("RoomLayoutView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "go_normalroot/#simage_maskbg")
	slot0._gotitleLayout = gohelper.findChild(slot0.viewGO, "go_normalroot/#go_titleLayout")
	slot0._gotitleCopy = gohelper.findChild(slot0.viewGO, "go_normalroot/#go_titleCopy")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "go_normalroot/#scroll_ItemList")
	slot0._gotipsusing = gohelper.findChild(slot0.viewGO, "go_normalroot/#go_tips_using")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/Btn/#btn_cancel")
	slot0._btncover = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/Btn/#btn_cover")
	slot0._btnchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/Btn/#btn_change")
	slot0._btnnew = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/Btn/#btn_new")
	slot0._btnvisitcover = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/Btn/#btn_visitcover")
	slot0._btnsave = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/Btn/#btn_save")
	slot0._btnsharecode = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/#btn_sharecode")
	slot0._txtshareCount = gohelper.findChildText(slot0.viewGO, "go_normalroot/rightTop/#txt_shareCount")
	slot0._btnshareCount = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/rightTop/#txt_shareCount/#btn_shareCount")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btncover:AddClickListener(slot0._btncoverOnClick, slot0)
	slot0._btnchange:AddClickListener(slot0._btnchangeOnClick, slot0)
	slot0._btnnew:AddClickListener(slot0._btnnewOnClick, slot0)
	slot0._btnvisitcover:AddClickListener(slot0._btnvisitcoverOnClick, slot0)
	slot0._btnsave:AddClickListener(slot0._btnsaveOnClick, slot0)
	slot0._btnsharecode:AddClickListener(slot0._btnsharecodeOnClick, slot0)
	slot0._btnshareCount:AddClickListener(slot0._btnshareCountOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btncover:RemoveClickListener()
	slot0._btnchange:RemoveClickListener()
	slot0._btnnew:RemoveClickListener()
	slot0._btnvisitcover:RemoveClickListener()
	slot0._btnsave:RemoveClickListener()
	slot0._btnsharecode:RemoveClickListener()
	slot0._btnshareCount:RemoveClickListener()
end

function slot0._btnsaveOnClick(slot0)
	slot0:_onOpenCreateTipsView()
end

function slot0._btnshareCountOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.PlanShare,
		shareCount = RoomLayoutModel.instance:getUseCount()
	})
end

function slot0._btnsharecodeOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoomLayoutFindShareView)
end

function slot0._btnvisitcoverOnClick(slot0)
	slot0:_onOpenCreateTipsView(slot0:_getCoverTitleStr())
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncoverOnClick(slot0)
	slot0:_onOpenCreateTipsView(slot0:_getCoverTitleStr())
end

function slot0._btnchangeOnClick(slot0)
	if not RoomLayoutListModel.instance:getSelectMO() then
		return
	end

	if (RoomCharacterModel.instance:getConfirmCharacterCount() or 0) - (RoomCharacterModel.instance:getMaxCharacterCount(slot1.buildingDegree) or 0) > 0 then
		ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
			needRemoveCount = slot4,
			sureCallback = slot0._confirmSwitchPlanCallback,
			callbackObj = slot0,
			callbackParam = {
				switchPlanId = slot1.id
			}
		})
	else
		slot0:_sendSwitchRoomPlan(slot5)
	end
end

function slot0._btnnewOnClick(slot0)
	slot0:_onOpenCreateTipsView()
end

function slot0._confirmSwitchPlanCallback(slot0, slot1)
	slot0:_sendSwitchRoomPlan(slot1.switchPlanId)
end

function slot0._sendSwitchRoomPlan(slot0, slot1)
	RoomLayoutController.instance:sendSwitchRoomPlanRequest(slot1)
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	slot0._gorightTop = gohelper.findChild(slot0.viewGO, "go_normalroot/rightTop")
end

function slot0.onUpdateParam(slot0)
end

function slot0._getCoverTitleStr(slot0)
	if RoomLayoutListModel.instance:getSelectMO() and slot1:isSharing() then
		return luaLang("room_layoutplan_cover_sharecode_tips")
	end

	return luaLang("room_layoutplan_cover_tips")
end

function slot0._onOpenCreateTipsView(slot0, slot1)
	if RoomLayoutListModel.instance:getSelectMO() then
		RoomLayoutController.instance:openCreateTipsView(slot1, false, slot2.id ~= RoomEnum.LayoutUsedPlanId and RoomController.instance:isVisitMode(), slot0._onCreateCallblck, slot0)
	end
end

function slot0._onCreateCallblck(slot0, slot1)
	if not RoomController.instance:isVisitMode() then
		RoomLayoutController.instance:sendCreateRpc(RoomLayoutListModel.instance:getSelectMO(), slot1)

		return
	end

	slot0._isVisitCopyRpcSelect = slot1

	if RoomController.instance:isVisitShareMode() then
		if RoomLayoutModel.instance:getCanUseShareCount() <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanUseShareCodeNotNum)

			return
		end

		if slot3 <= CommonConfig.instance:getConstNum(ConstEnum.RoomPlanCanUseShareTipNum) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanUseShareCount, MsgBoxEnum.BoxType.Yes_No, slot0._checkVisitCharacterPlaceCount, nil, , slot0, nil, , slot3)

			return
		end
	end

	slot0:_checkVisitCharacterPlaceCount()
end

function slot0._checkVisitCharacterPlaceCount(slot0)
	slot1 = RoomLayoutListModel.instance:getSelectMO()

	if slot0._isVisitCopyRpcSelect or slot1 and slot1.id == RoomEnum.LayoutUsedPlanId then
		slot3, slot4 = RoomLayoutHelper.findHasBlockBuildingInfos(RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode()) and slot2.infos, slot2 and slot2.buildingInfos)
		slot5, slot6 = RoomLayoutHelper.sunDegreeInfos(slot3, slot4)
		slot9 = RoomModel.instance:getObInfo()

		if #RoomModel.instance:getCharacterList() - (RoomCharacterModel.instance:getMaxCharacterCount(slot5, RoomModel.instance:getRoomLevel()) or 0) > 0 then
			ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
				notUpdateMapModel = true,
				needRemoveCount = slot11,
				sureCallback = slot0._sendVisitCopyRpc,
				callbackObj = slot0,
				roomCharacterMOList = slot10
			})

			return
		end
	end

	slot0:_sendVisitCopyRpc()
end

function slot0._sendVisitCopyRpc(slot0)
	RoomLayoutController.instance:sendVisitCopyRpc(RoomLayoutListModel.instance:getSelectMO(), slot0._isVisitCopyRpcSelect)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomLayoutController.instance, RoomEvent.UISelectLayoutPlanItem, slot0._onUISelectLayoutPlan, slot0)
	RoomLayoutListModel.instance:initScelect(RoomController.instance:isVisitMode())
	slot0:_onUISelectLayoutPlan()
	slot0.viewContainer:movetoSelect()
end

function slot0.onClose(slot0)
end

function slot0._onUISelectLayoutPlan(slot0)
	slot0:_showButUI()
end

function slot0._showButUI(slot0)
	slot0._isObMode = RoomController.instance:isObMode()
	slot0._isVisitMode = RoomController.instance:isVisitMode()
	slot2 = true
	slot0._isEmpty = true

	if RoomLayoutListModel.instance:getSelectMO() == nil or slot1:isUse() and slot0._isObMode then
		slot2 = false
	else
		slot0._isEmpty = slot1:isEmpty()
	end

	gohelper.setActive(slot0._gotitleLayout, slot0._isObMode)
	gohelper.setActive(slot0._gotitleCopy, slot0._isVisitMode)
	gohelper.setActive(slot0._gorightTop, slot0._isObMode)

	slot0._isLastShowBtn = slot2

	if slot0._isLastShowBtn ~= slot2 and slot0._isLastShowBtn ~= nil then
		if slot2 then
			slot0:_onShowButUI()
		end

		gohelper.setActive(slot0._gotipsusing, true)
		slot0._animator:Play(slot2 and "switch_btn" or "switch_tips")
		TaskDispatcher.cancelTask(slot0._onShowButUI, slot0)
		TaskDispatcher.runDelay(slot0._onShowButUI, slot0, 0.5)
	else
		slot0:_onShowButUI()
	end

	slot0._txtshareCount.text = RoomLayoutModel.instance:getUseCount()
end

function slot0._onShowButUI(slot0)
	slot1 = RoomController.instance:isObMode()
	slot2 = RoomController.instance:isVisitMode()
	slot4 = slot0._isEmpty

	gohelper.setActive(slot0._btncancel, slot0._isLastShowBtn and slot2)
	gohelper.setActive(slot0._btncover, slot3 and slot1 and not slot4)
	gohelper.setActive(slot0._btnvisitcover, slot3 and slot2 and not slot4)
	gohelper.setActive(slot0._btnnew, slot3 and slot1 and slot4)
	gohelper.setActive(slot0._btnsave, slot3 and slot2 and slot4)
	gohelper.setActive(slot0._btnchange, slot3 and slot1 and not slot4)
	gohelper.setActive(slot0._gotipsusing, not slot3)
	gohelper.setActive(slot0._btnsharecode, slot1)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onShowButUI, slot0)
	RoomMapController.instance:dispatchEvent(RoomEvent.ResumeAtmosphereEffect)
end

return slot0
