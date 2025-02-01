module("modules.logic.rouge.view.RougeTalentTreeView", package.seeall)

slot0 = class("RougeTalentTreeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gotalenttree = gohelper.findChild(slot0.viewGO, "#go_talenttree")
	slot0._gotalentdec = gohelper.findChild(slot0.viewGO, "#go_talentdec")
	slot0._txttalentname = gohelper.findChildText(slot0.viewGO, "#go_talentdec/bg/#txt_talentname")
	slot0._txttalentdec = gohelper.findChildText(slot0.viewGO, "#go_talentdec/#txt_talentdec")
	slot0._gopoint = gohelper.findChild(slot0.viewGO, "#go_point")
	slot0._gopointitem = gohelper.findChild(slot0.viewGO, "#go_point/point")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")
	slot0._btnarrowright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_arrow/#btn_arrowright")
	slot0._btnarrowleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_arrow/#btn_arrowleft")
	slot0._btnoverview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_overview")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "#go_detail")
	slot0._txtdetailname = gohelper.findChildText(slot0.viewGO, "#go_detail/#txt_talentname")
	slot0._txtdetaildec = gohelper.findChildText(slot0.viewGO, "#go_detail/#scroll_desc/Viewport/#txt_talentdec")
	slot0._btnlocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_detail/#btn_locked")
	slot0._txtlocked = gohelper.findChildText(slot0.viewGO, "#go_detail/#btn_locked/#txt_locked")
	slot0._txtlocked2 = gohelper.findChildText(slot0.viewGO, "#go_detail/#btn_locked/#txt_locked2")
	slot0._btnlack = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_detail/#btn_lack")
	slot0._txtlack = gohelper.findChildText(slot0.viewGO, "#go_detail/#btn_lack/#txt_lack")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_detail/#btn_cancel")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._gotoprighttips = gohelper.findChild(slot0.viewGO, "#go_topright/tips")
	slot0._txttoprighttips = gohelper.findChildText(slot0.viewGO, "#go_topright/tips/#txt_tips")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_topright/#txt_num")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_click")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._detailAnimator = slot0._godetail:GetComponent(typeof(UnityEngine.Animator))
	slot0._currentSelectId = nil
	slot0._isopentips = false
	slot0._animtime = 0.2
	slot0._pointList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnarrowright:AddClickListener(slot0._btnarrowrightOnClick, slot0)
	slot0._btnarrowleft:AddClickListener(slot0._btnarrowleftOnClick, slot0)
	slot0._btnoverview:AddClickListener(slot0._btnoverviewOnClick, slot0)
	slot0._btnlack:AddClickListener(slot0._btnlackOnClick, slot0)
	slot0._btnlocked:AddClickListener(slot0._btnlockOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.onSwitchTab, slot0._onSwitchTab, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickTreeNode, slot0._onClickTreeBranchItem, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickEmpty, slot0.clickEmpty, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, slot0._refreshUI, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.exitTalentView, slot0.exitTalentView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnarrowright:RemoveClickListener()
	slot0._btnarrowleft:RemoveClickListener()
	slot0._btnoverview:RemoveClickListener()
	slot0._btnlack:RemoveClickListener()
	slot0._btnlocked:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(RougeController.instance, RougeEvent.onSwitchTab, slot0._onSwitchTab, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnClickTreeNode, slot0._onClickTreeBranchItem, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnClickEmpty, slot0.clickEmpty, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, slot0._refreshUI, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.exitTalentView, slot0.exitTalentView, slot0)
end

function slot0._btnlackOnClick(slot0)
	if not slot0._currentconfig then
		return
	end

	if RougeTalentModel.instance:checkBigNodeLock(slot0._currentconfig.talent) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBigTalentLock)

		return
	end

	if RougeTalentModel.instance:checkBeforeNodeLock(slot0._currentconfig.id) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBeforeTalentLock)

		return
	end

	if RougeTalentModel.instance:getTalentPoint() < slot0._currentconfig.cost then
		GameFacade.showToast(ToastEnum.RougeTalentTreeNoPoint)

		return
	end

	if RougeModel.instance:inRouge() then
		GameFacade.showToast(ToastEnum.InRouge)

		return
	end

	if not RougeTalentModel.instance:checkNodeLight(slot0._currentSelectId) then
		RougeOutsideRpc.instance:sendRougeActiveGeniusRequest(slot0._season, slot0._currentSelectId)
	end
end

function slot0._btnlockOnClick(slot0)
	if not slot0._currentconfig then
		return
	end

	if RougeTalentModel.instance:checkBigNodeLock(slot0._currentconfig.talent) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBigTalentLock)

		return
	end

	if RougeTalentModel.instance:checkBeforeNodeLock(slot0._currentconfig.id) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBeforeTalentLock)

		return
	end
end

function slot0._btncancelOnClick(slot0)
	slot0._isOpenDetail = false

	gohelper.setActive(slot0._godetail, slot0._isOpenDetail)
	gohelper.setActive(slot0._gopoint, not slot0._isOpenDetail)
	gohelper.setActive(slot0._btnoverview.gameObject, not slot0._isOpenDetail)
	RougeController.instance:dispatchEvent(RougeEvent.OnCancelTreeNode, slot0._currentSelectId)
end

function slot0._btnarrowrightOnClick(slot0)
	if slot0._tabIndex < RougeTalentConfig.instance:getTalentNum(slot0._season) then
		slot0._tabIndex = slot0._tabIndex + 1

		slot0._animator:Update(0)
		slot0._animator:Play("switch_right", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.SwtichTalentTreeView)
		TaskDispatcher.runDelay(slot0._switchfunc, slot0, slot0._animtime)
	end

	slot0:_btncancelOnClick()
	slot0:_refreshView()
end

function slot0._btnarrowleftOnClick(slot0)
	if slot0._tabIndex > 1 then
		slot0._tabIndex = slot0._tabIndex - 1

		slot0._animator:Update(0)
		slot0._animator:Play("switch_left", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.SwtichTalentTreeView)
		TaskDispatcher.runDelay(slot0._switchfunc, slot0, slot0._animtime)
	end

	slot0:_btncancelOnClick()
	slot0:_refreshView()
end

function slot0._onSwitchTab(slot0)
	RougeTalentModel.instance:setCurrentSelectIndex(slot0._tabIndex)
	slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot0._tabIndex)
end

function slot0._btnoverviewOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RougeTalentTreeOverview)
end

function slot0._btnclickOnClick(slot0)
	slot0._isopentips = not slot0._isopentips

	gohelper.setActive(slot0._gotoprighttips, slot0._isopentips)
end

function slot0.clickEmpty(slot0)
	if slot0._isopentips then
		slot0._isopentips = false

		gohelper.setActive(slot0._gotoprighttips, slot0._isopentips)
	end

	if slot0._isOpenDetail then
		slot0:_btncancelOnClick()
	end
end

function slot0._onClickTreeBranchItem(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._currentSelectId ~= slot1.id and slot0._currentSelectId ~= nil then
		if not slot0._isOpenDetail then
			slot0._isOpenDetail = not slot0._isOpenDetail

			gohelper.setActive(slot0._godetail, slot0._isOpenDetail)
			gohelper.setActive(slot0._gopoint, not slot0._isOpenDetail)
			gohelper.setActive(slot0._btnoverview.gameObject, not slot0._isOpenDetail)
			slot0:_refreshDetail(slot1)
		else
			slot0._detailAnimator:Update(0)
			slot0._detailAnimator:Play("close", 0, 0)

			function slot0._onDetailCloseEnd()
				TaskDispatcher.cancelTask(uv0._onDetailCloseEnd, uv0)
				uv0:_refreshDetail(uv1)
				uv0._detailAnimator:Update(0)
				uv0._detailAnimator:Play("open", 0, 0)
			end

			TaskDispatcher.runDelay(slot0._onDetailCloseEnd, slot0, 0.2)
		end
	elseif not slot0._isOpenDetail then
		slot0._isOpenDetail = not slot0._isOpenDetail

		gohelper.setActive(slot0._godetail, slot0._isOpenDetail)
		gohelper.setActive(slot0._gopoint, not slot0._isOpenDetail)
		gohelper.setActive(slot0._btnoverview.gameObject, not slot0._isOpenDetail)
		slot0:_refreshDetail(slot1)
	end
end

function slot0._onDetailOpenEnd(slot0)
end

function slot0._refreshDetail(slot0, slot1, slot2)
	slot0._currentconfig = slot1

	if not slot0._currentSelectId then
		slot0._currentSelectId = slot1.id
	elseif slot0._currentSelectId ~= slot1.id then
		slot0._currentSelectId = slot1.id
		slot0._showDetailAnim = true
	end

	slot0._txtdetailname.text = slot1.name
	slot0._txtdetaildec.text = slot1.desc
	slot0._txtlack.text = slot1.cost
	slot3 = true

	if not ((slot1.isOrigin ~= 1 or (slot1.id ~= RougeEnum.OutsideConst.StartNode or false) and RougeTalentModel.instance:checkBigNodeLock(slot1.talent)) and RougeTalentModel.instance:checkNodeLock(slot1)) then
		slot4 = RougeTalentModel.instance:checkNodeLight(slot1.id)

		gohelper.setActive(slot0._btnlocked.gameObject, false)
		gohelper.setActive(slot0._btnlack.gameObject, not slot4)
		gohelper.setActive(slot0._btncancel.gameObject, not slot4)

		if RougeTalentModel.instance:getTalentPoint() < slot1.cost then
			slot0._txtlack.color = GameUtil.parseColor("#9F342C")
		else
			slot0._txtlack.color = GameUtil.parseColor("#E99B56")
		end
	else
		gohelper.setActive(slot0._btnlocked.gameObject, slot3)
		gohelper.setActive(slot0._btnlack.gameObject, not slot3)

		slot4 = slot1.isOrigin == 1

		gohelper.setActive(slot0._txtlocked.gameObject, not slot4)
		gohelper.setActive(slot0._txtlocked2.gameObject, slot4)

		if slot4 then
			slot0._txtlocked2.text = string.format(luaLang("rouge_kehua_lock_tip"), RougeTalentModel.instance:getHadConsumeTalentPoint(), RougeTalentConfig.instance:getConfigByTalent(slot0._season, slot1.talent).cost)
		else
			slot0._txtlocked.text = luaLang("rouge_talenttree_normal")
		end
	end

	if slot2 then
		slot0._detailAnimator:Update(0)
		slot0._detailAnimator:Play("close", 0, 0)

		slot0._isOpenDetail = false

		gohelper.setActive(slot0._godetail, slot0._isOpenDetail)
		gohelper.setActive(slot0._gopoint, not slot0._isOpenDetail)
		gohelper.setActive(slot0._btnoverview.gameObject, not slot0._isOpenDetail)
	end
end

function slot0._editableInitView(slot0)
	function slot0._switchfunc()
		TaskDispatcher.cancelTask(uv0._switchfunc, uv0)
		RougeController.instance:dispatchEvent(RougeEvent.onSwitchTab, uv0._tabIndex)
	end
end

function slot0._refreshUI(slot0, slot1)
	slot2 = slot0._configList[slot0._tabIndex]
	slot0._txttalentname.text = slot2.name
	slot0._txttalentdec.text = slot2.desc

	if slot0._tabIndex == 1 then
		gohelper.setActive(slot0._btnarrowleft.gameObject, false)
	else
		gohelper.setActive(slot0._btnarrowleft.gameObject, true)
	end

	if slot0._tabIndex == #slot0._configList then
		gohelper.setActive(slot0._btnarrowright.gameObject, false)
	else
		gohelper.setActive(slot0._btnarrowright.gameObject, true)
	end

	slot0._txtnum.text = RougeTalentModel.instance:getTalentPoint()
	slot0._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_talenttree_remaintalent"), {
		RougeTalentModel.instance:getHadAllTalentPoint(),
		RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit)
	})

	if slot1 then
		slot0:_refreshDetail(RougeTalentConfig.instance:getBranchConfigByID(slot0._season, slot1), slot1)
	end
end

function slot0._refreshView(slot0)
	for slot4, slot5 in ipairs(slot0._pointList) do
		if slot0._tabIndex ~= slot4 then
			gohelper.setActive(slot5.light, false)
		else
			gohelper.setActive(slot5.light, true)
		end
	end

	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0._season = RougeOutsideModel.instance:season()

	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentTreeView)

	slot0._isOpenDetail = false

	gohelper.setActive(slot0._godetail, slot0._isOpenDetail)

	slot0._tabIndex = nil

	if slot0.viewParam then
		slot0._tabIndex = slot0.viewParam

		slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot0._tabIndex)
	end

	slot0._configList = RougeTalentConfig.instance:getRougeTalentDict(slot0._season)

	for slot4, slot5 in ipairs(slot0._configList) do
		if not slot0._pointList[slot4] then
			slot6 = slot0:getUserDataTb_()
			slot7 = gohelper.cloneInPlace(slot0._gopointitem, "talent" .. slot4)
			slot6.go = slot7
			slot6.light = gohelper.findChild(slot7, "point_light")

			gohelper.setActive(slot7, true)
			table.insert(slot0._pointList, slot6)
		end

		if slot0._tabIndex ~= slot4 then
			gohelper.setActive(slot6.light, false)
		else
			gohelper.setActive(slot6.light, true)
		end
	end

	slot0._animator:Update(0)
	slot0._animator:Play("open", 0, 0)
	slot0:_refreshUI()
end

function slot0.exitTalentView(slot0)
	slot0._animator:Update(0)
	slot0._animator:Play("close", 0, 0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
