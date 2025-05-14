module("modules.logic.rouge.view.RougeTalentTreeView", package.seeall)

local var_0_0 = class("RougeTalentTreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gotalenttree = gohelper.findChild(arg_1_0.viewGO, "#go_talenttree")
	arg_1_0._gotalentdec = gohelper.findChild(arg_1_0.viewGO, "#go_talentdec")
	arg_1_0._txttalentname = gohelper.findChildText(arg_1_0.viewGO, "#go_talentdec/bg/#txt_talentname")
	arg_1_0._txttalentdec = gohelper.findChildText(arg_1_0.viewGO, "#go_talentdec/#txt_talentdec")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "#go_point")
	arg_1_0._gopointitem = gohelper.findChild(arg_1_0.viewGO, "#go_point/point")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")
	arg_1_0._btnarrowright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_arrow/#btn_arrowright")
	arg_1_0._btnarrowleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_arrow/#btn_arrowleft")
	arg_1_0._btnoverview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_overview")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_detail")
	arg_1_0._txtdetailname = gohelper.findChildText(arg_1_0.viewGO, "#go_detail/#txt_talentname")
	arg_1_0._txtdetaildec = gohelper.findChildText(arg_1_0.viewGO, "#go_detail/#scroll_desc/Viewport/#txt_talentdec")
	arg_1_0._btnlocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_detail/#btn_locked")
	arg_1_0._txtlocked = gohelper.findChildText(arg_1_0.viewGO, "#go_detail/#btn_locked/#txt_locked")
	arg_1_0._txtlocked2 = gohelper.findChildText(arg_1_0.viewGO, "#go_detail/#btn_locked/#txt_locked2")
	arg_1_0._btnlack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_detail/#btn_lack")
	arg_1_0._txtlack = gohelper.findChildText(arg_1_0.viewGO, "#go_detail/#btn_lack/#txt_lack")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_detail/#btn_cancel")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._gotoprighttips = gohelper.findChild(arg_1_0.viewGO, "#go_topright/tips")
	arg_1_0._txttoprighttips = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/tips/#txt_tips")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#txt_num")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_click")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._detailAnimator = arg_1_0._godetail:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._currentSelectId = nil
	arg_1_0._isopentips = false
	arg_1_0._animtime = 0.2
	arg_1_0._pointList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnarrowright:AddClickListener(arg_2_0._btnarrowrightOnClick, arg_2_0)
	arg_2_0._btnarrowleft:AddClickListener(arg_2_0._btnarrowleftOnClick, arg_2_0)
	arg_2_0._btnoverview:AddClickListener(arg_2_0._btnoverviewOnClick, arg_2_0)
	arg_2_0._btnlack:AddClickListener(arg_2_0._btnlackOnClick, arg_2_0)
	arg_2_0._btnlocked:AddClickListener(arg_2_0._btnlockOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.onSwitchTab, arg_2_0._onSwitchTab, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnClickTreeNode, arg_2_0._onClickTreeBranchItem, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnClickEmpty, arg_2_0.clickEmpty, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, arg_2_0._refreshUI, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.exitTalentView, arg_2_0.exitTalentView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnarrowright:RemoveClickListener()
	arg_3_0._btnarrowleft:RemoveClickListener()
	arg_3_0._btnoverview:RemoveClickListener()
	arg_3_0._btnlack:RemoveClickListener()
	arg_3_0._btnlocked:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.onSwitchTab, arg_3_0._onSwitchTab, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnClickTreeNode, arg_3_0._onClickTreeBranchItem, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnClickEmpty, arg_3_0.clickEmpty, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, arg_3_0._refreshUI, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.exitTalentView, arg_3_0.exitTalentView, arg_3_0)
end

function var_0_0._btnlackOnClick(arg_4_0)
	if not arg_4_0._currentconfig then
		return
	end

	local var_4_0 = arg_4_0._currentconfig.talent

	if RougeTalentModel.instance:checkBigNodeLock(var_4_0) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBigTalentLock)

		return
	end

	if RougeTalentModel.instance:checkBeforeNodeLock(arg_4_0._currentconfig.id) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBeforeTalentLock)

		return
	end

	if RougeTalentModel.instance:getTalentPoint() < arg_4_0._currentconfig.cost then
		GameFacade.showToast(ToastEnum.RougeTalentTreeNoPoint)

		return
	end

	if RougeModel.instance:inRouge() then
		GameFacade.showToast(ToastEnum.InRouge)

		return
	end

	if not RougeTalentModel.instance:checkNodeLight(arg_4_0._currentSelectId) then
		RougeOutsideRpc.instance:sendRougeActiveGeniusRequest(arg_4_0._season, arg_4_0._currentSelectId)
	end
end

function var_0_0._btnlockOnClick(arg_5_0)
	if not arg_5_0._currentconfig then
		return
	end

	local var_5_0 = arg_5_0._currentconfig.talent

	if RougeTalentModel.instance:checkBigNodeLock(var_5_0) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBigTalentLock)

		return
	end

	if RougeTalentModel.instance:checkBeforeNodeLock(arg_5_0._currentconfig.id) then
		GameFacade.showToast(ToastEnum.RougeTalentTreeBeforeTalentLock)

		return
	end
end

function var_0_0._btncancelOnClick(arg_6_0)
	arg_6_0._isOpenDetail = false

	gohelper.setActive(arg_6_0._godetail, arg_6_0._isOpenDetail)
	gohelper.setActive(arg_6_0._gopoint, not arg_6_0._isOpenDetail)
	gohelper.setActive(arg_6_0._btnoverview.gameObject, not arg_6_0._isOpenDetail)
	RougeController.instance:dispatchEvent(RougeEvent.OnCancelTreeNode, arg_6_0._currentSelectId)
end

function var_0_0._btnarrowrightOnClick(arg_7_0)
	if RougeTalentConfig.instance:getTalentNum(arg_7_0._season) > arg_7_0._tabIndex then
		arg_7_0._tabIndex = arg_7_0._tabIndex + 1

		arg_7_0._animator:Update(0)
		arg_7_0._animator:Play("switch_right", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.SwtichTalentTreeView)
		TaskDispatcher.runDelay(arg_7_0._switchfunc, arg_7_0, arg_7_0._animtime)
	end

	arg_7_0:_btncancelOnClick()
	arg_7_0:_refreshView()
end

function var_0_0._btnarrowleftOnClick(arg_8_0)
	if arg_8_0._tabIndex > 1 then
		arg_8_0._tabIndex = arg_8_0._tabIndex - 1

		arg_8_0._animator:Update(0)
		arg_8_0._animator:Play("switch_left", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.SwtichTalentTreeView)
		TaskDispatcher.runDelay(arg_8_0._switchfunc, arg_8_0, arg_8_0._animtime)
	end

	arg_8_0:_btncancelOnClick()
	arg_8_0:_refreshView()
end

function var_0_0._onSwitchTab(arg_9_0)
	RougeTalentModel.instance:setCurrentSelectIndex(arg_9_0._tabIndex)
	arg_9_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_9_0._tabIndex)
end

function var_0_0._btnoverviewOnClick(arg_10_0)
	ViewMgr.instance:openView(ViewName.RougeTalentTreeOverview)
end

function var_0_0._btnclickOnClick(arg_11_0)
	arg_11_0._isopentips = not arg_11_0._isopentips

	gohelper.setActive(arg_11_0._gotoprighttips, arg_11_0._isopentips)
end

function var_0_0.clickEmpty(arg_12_0)
	if arg_12_0._isopentips then
		arg_12_0._isopentips = false

		gohelper.setActive(arg_12_0._gotoprighttips, arg_12_0._isopentips)
	end

	if arg_12_0._isOpenDetail then
		arg_12_0:_btncancelOnClick()
	end
end

function var_0_0._onClickTreeBranchItem(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	if arg_13_0._currentSelectId ~= arg_13_1.id and arg_13_0._currentSelectId ~= nil then
		if not arg_13_0._isOpenDetail then
			arg_13_0._isOpenDetail = not arg_13_0._isOpenDetail

			gohelper.setActive(arg_13_0._godetail, arg_13_0._isOpenDetail)
			gohelper.setActive(arg_13_0._gopoint, not arg_13_0._isOpenDetail)
			gohelper.setActive(arg_13_0._btnoverview.gameObject, not arg_13_0._isOpenDetail)
			arg_13_0:_refreshDetail(arg_13_1)
		else
			arg_13_0._detailAnimator:Update(0)
			arg_13_0._detailAnimator:Play("close", 0, 0)

			function arg_13_0._onDetailCloseEnd()
				TaskDispatcher.cancelTask(arg_13_0._onDetailCloseEnd, arg_13_0)
				arg_13_0:_refreshDetail(arg_13_1)
				arg_13_0._detailAnimator:Update(0)
				arg_13_0._detailAnimator:Play("open", 0, 0)
			end

			local var_13_0 = 0.2

			TaskDispatcher.runDelay(arg_13_0._onDetailCloseEnd, arg_13_0, var_13_0)
		end
	elseif not arg_13_0._isOpenDetail then
		arg_13_0._isOpenDetail = not arg_13_0._isOpenDetail

		gohelper.setActive(arg_13_0._godetail, arg_13_0._isOpenDetail)
		gohelper.setActive(arg_13_0._gopoint, not arg_13_0._isOpenDetail)
		gohelper.setActive(arg_13_0._btnoverview.gameObject, not arg_13_0._isOpenDetail)
		arg_13_0:_refreshDetail(arg_13_1)
	end
end

function var_0_0._onDetailOpenEnd(arg_15_0)
	return
end

function var_0_0._refreshDetail(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._currentconfig = arg_16_1

	if not arg_16_0._currentSelectId then
		arg_16_0._currentSelectId = arg_16_1.id
	elseif arg_16_0._currentSelectId ~= arg_16_1.id then
		arg_16_0._currentSelectId = arg_16_1.id
		arg_16_0._showDetailAnim = true
	end

	arg_16_0._txtdetailname.text = arg_16_1.name
	arg_16_0._txtdetaildec.text = arg_16_1.desc
	arg_16_0._txtlack.text = arg_16_1.cost

	local var_16_0 = true

	if arg_16_1.isOrigin == 1 then
		if arg_16_1.id == RougeEnum.OutsideConst.StartNode then
			var_16_0 = false
		else
			var_16_0 = RougeTalentModel.instance:checkBigNodeLock(arg_16_1.talent)
		end
	else
		var_16_0 = RougeTalentModel.instance:checkNodeLock(arg_16_1)
	end

	if not var_16_0 then
		local var_16_1 = RougeTalentModel.instance:checkNodeLight(arg_16_1.id)

		gohelper.setActive(arg_16_0._btnlocked.gameObject, false)
		gohelper.setActive(arg_16_0._btnlack.gameObject, not var_16_1)
		gohelper.setActive(arg_16_0._btncancel.gameObject, not var_16_1)

		if RougeTalentModel.instance:getTalentPoint() < arg_16_1.cost then
			arg_16_0._txtlack.color = GameUtil.parseColor("#9F342C")
		else
			arg_16_0._txtlack.color = GameUtil.parseColor("#E99B56")
		end
	else
		gohelper.setActive(arg_16_0._btnlocked.gameObject, var_16_0)
		gohelper.setActive(arg_16_0._btnlack.gameObject, not var_16_0)

		local var_16_2 = arg_16_1.isOrigin == 1

		gohelper.setActive(arg_16_0._txtlocked.gameObject, not var_16_2)
		gohelper.setActive(arg_16_0._txtlocked2.gameObject, var_16_2)

		if var_16_2 then
			local var_16_3 = RougeTalentConfig.instance:getConfigByTalent(arg_16_0._season, arg_16_1.talent)
			local var_16_4 = RougeTalentModel.instance:getHadConsumeTalentPoint()

			arg_16_0._txtlocked2.text = string.format(luaLang("rouge_kehua_lock_tip"), var_16_4, var_16_3.cost)
		else
			arg_16_0._txtlocked.text = luaLang("rouge_talenttree_normal")
		end
	end

	if arg_16_2 then
		arg_16_0._detailAnimator:Update(0)
		arg_16_0._detailAnimator:Play("close", 0, 0)

		arg_16_0._isOpenDetail = false

		gohelper.setActive(arg_16_0._godetail, arg_16_0._isOpenDetail)
		gohelper.setActive(arg_16_0._gopoint, not arg_16_0._isOpenDetail)
		gohelper.setActive(arg_16_0._btnoverview.gameObject, not arg_16_0._isOpenDetail)
	end
end

function var_0_0._editableInitView(arg_17_0)
	function arg_17_0._switchfunc()
		TaskDispatcher.cancelTask(arg_17_0._switchfunc, arg_17_0)
		RougeController.instance:dispatchEvent(RougeEvent.onSwitchTab, arg_17_0._tabIndex)
	end
end

function var_0_0._refreshUI(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._configList[arg_19_0._tabIndex]

	arg_19_0._txttalentname.text = var_19_0.name
	arg_19_0._txttalentdec.text = var_19_0.desc

	if arg_19_0._tabIndex == 1 then
		gohelper.setActive(arg_19_0._btnarrowleft.gameObject, false)
	else
		gohelper.setActive(arg_19_0._btnarrowleft.gameObject, true)
	end

	if arg_19_0._tabIndex == #arg_19_0._configList then
		gohelper.setActive(arg_19_0._btnarrowright.gameObject, false)
	else
		gohelper.setActive(arg_19_0._btnarrowright.gameObject, true)
	end

	arg_19_0._txtnum.text = RougeTalentModel.instance:getTalentPoint()

	local var_19_1 = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit)
	local var_19_2 = RougeTalentModel.instance:getHadAllTalentPoint()
	local var_19_3 = {
		var_19_2,
		var_19_1
	}

	arg_19_0._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_talenttree_remaintalent"), var_19_3)

	if arg_19_1 then
		local var_19_4 = RougeTalentConfig.instance:getBranchConfigByID(arg_19_0._season, arg_19_1)

		arg_19_0:_refreshDetail(var_19_4, arg_19_1)
	end
end

function var_0_0._refreshView(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._pointList) do
		if arg_20_0._tabIndex ~= iter_20_0 then
			gohelper.setActive(iter_20_1.light, false)
		else
			gohelper.setActive(iter_20_1.light, true)
		end
	end

	arg_20_0:_refreshUI()
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0._season = RougeOutsideModel.instance:season()

	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentTreeView)

	arg_21_0._isOpenDetail = false

	gohelper.setActive(arg_21_0._godetail, arg_21_0._isOpenDetail)

	arg_21_0._tabIndex = nil

	if arg_21_0.viewParam then
		arg_21_0._tabIndex = arg_21_0.viewParam

		arg_21_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_21_0._tabIndex)
	end

	arg_21_0._configList = RougeTalentConfig.instance:getRougeTalentDict(arg_21_0._season)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._configList) do
		local var_21_0 = arg_21_0._pointList[iter_21_0]

		if not var_21_0 then
			var_21_0 = arg_21_0:getUserDataTb_()

			local var_21_1 = gohelper.cloneInPlace(arg_21_0._gopointitem, "talent" .. iter_21_0)

			var_21_0.light, var_21_0.go = gohelper.findChild(var_21_1, "point_light"), var_21_1

			gohelper.setActive(var_21_1, true)
			table.insert(arg_21_0._pointList, var_21_0)
		end

		if arg_21_0._tabIndex ~= iter_21_0 then
			gohelper.setActive(var_21_0.light, false)
		else
			gohelper.setActive(var_21_0.light, true)
		end
	end

	arg_21_0._animator:Update(0)
	arg_21_0._animator:Play("open", 0, 0)
	arg_21_0:_refreshUI()
end

function var_0_0.exitTalentView(arg_22_0)
	arg_22_0._animator:Update(0)
	arg_22_0._animator:Play("close", 0, 0)
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
