module("modules.logic.versionactivity1_4.act133.view.Activity133ListItem", package.seeall)

local var_0_0 = class("Activity133ListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageitem = gohelper.findChildImage(arg_1_0.viewGO, "#image_item")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#image_item/lockbg")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/Content")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/Content/#go_item")
	arg_1_0._btnfix = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_fix")
	arg_1_0._goFixIcon = gohelper.findChild(arg_1_0.viewGO, "bottom/#btn_fix/icon")
	arg_1_0._goCanFix = gohelper.findChild(arg_1_0.viewGO, "bottom/#btn_fix/icon1")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_check")
	arg_1_0._btnchecking = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg_checking/#btn_checking")
	arg_1_0._imgcost = gohelper.findChildImage(arg_1_0.viewGO, "bottom/cost/txt/#simage_icon")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "bottom/cost/txt")
	arg_1_0._gochecking = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_checking")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "bottom/cost")
	arg_1_0._gobuyed = gohelper.findChild(arg_1_0.viewGO, "bottom/buyed")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "bottom/buyed/#txt_title")
	arg_1_0._gocheckbg = gohelper.findChild(arg_1_0.viewGO, "bg_checking")
	arg_1_0._golockbg = gohelper.findChild(arg_1_0.viewGO, "bg_lockedmask")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "bottom/#btn_fix/icon/#go_reddot")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._unlockAniTime = 1

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfix:AddClickListener(arg_2_0._btnfixOnClick, arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btnchecking:AddClickListener(arg_2_0._btncheckingOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity133Controller.instance, Activity133Event.OnUpdateInfo, arg_2_0._refreshStatus, arg_2_0)
	arg_2_0:addEventCb(Activity133Controller.instance, Activity133Event.OnGetBonus, arg_2_0._refreshStatus, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfix:RemoveClickListener()
	arg_3_0._btncheck:RemoveClickListener()
	arg_3_0._btnchecking:RemoveClickListener()
	arg_3_0:removeEventCb(Activity133Controller.instance, Activity133Event.OnUpdateInfo, arg_3_0._refreshStatus, arg_3_0)
	arg_3_0:removeEventCb(Activity133Controller.instance, Activity133Event.OnGetBonus, arg_3_0._refreshStatus, arg_3_0)
end

function var_0_0._btnfixOnClick(arg_4_0)
	if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity >= tonumber(arg_4_0.targetNum) then
		arg_4_0._animator.speed = 1

		UIBlockMgr.instance:startBlock("Activity133ListItem")
		arg_4_0._animator:Play(UIAnimationName.Unlock, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_list_maintain)
		arg_4_0._animator:Update(0)
		TaskDispatcher.runDelay(arg_4_0._onItemFixAniFinish, arg_4_0, arg_4_0._unlockAniTime)
	else
		GameFacade.showToast(ToastEnum.DiamondBuy, arg_4_0.costName)
	end
end

function var_0_0._onItemFixAniFinish(arg_5_0)
	UIBlockMgr.instance:endBlock("Activity133ListItem")
	Activity133Rpc.instance:sendAct133BonusRequest(arg_5_0.actId, arg_5_0.id)
end

function var_0_0._btncheckOnClick(arg_6_0)
	arg_6_0._view:selectCell(arg_6_0._index, true)
end

function var_0_0._btncheckingOnClick(arg_7_0)
	arg_7_0._view:selectCell(arg_7_0._index, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	Activity133Controller.instance:dispatchEvent(Activity133Event.OnSelectCheckNote)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._itemList = {}
	arg_8_0._isfix = false
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0.mo = arg_9_1

	arg_9_0:_refreshUI()
	arg_9_0:_checkRedDot()
end

function var_0_0._checkRedDot(arg_10_0)
	if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act133).quantity >= tonumber(arg_10_0.targetNum) then
		arg_10_0._canGet = true
	else
		arg_10_0._canGet = false
	end

	gohelper.setActive(arg_10_0._goFixIcon, not arg_10_0._canGet)
	gohelper.setActive(arg_10_0._goCanFix, arg_10_0._canGet)
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = arg_11_0.mo.config

	arg_11_0.actId = var_11_0.activityId
	arg_11_0.id = var_11_0.id
	arg_11_0.iconid = var_11_0.icon

	UISpriteSetMgr.instance:setV1a4ShiprepairSprite(arg_11_0._imageitem, tostring(var_11_0.icon))

	local var_11_1 = string.splitToNumber(var_11_0.needTokens, "#")
	local var_11_2 = var_11_1[1]
	local var_11_3 = var_11_1[2]
	local var_11_4

	arg_11_0.targetNum, var_11_4 = var_11_1[3], ItemModel.instance:getItemConfig(var_11_2, var_11_3)
	arg_11_0.costName = var_11_4 and var_11_4.name or ""

	local var_11_5, var_11_6 = ItemModel.instance:getItemConfigAndIcon(var_11_2, var_11_3)
	local var_11_7 = var_11_5.icon
	local var_11_8 = string.format("%s_1", var_11_7)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_11_0._imgcost, var_11_8)

	arg_11_0._txtcost.text = arg_11_0.targetNum
	arg_11_0._txttitle.text = var_11_0.title

	local var_11_9 = GameUtil.splitString2(var_11_0.bonus, true)

	for iter_11_0, iter_11_1 in ipairs(var_11_9) do
		local var_11_10 = arg_11_0._itemList[iter_11_0]

		if not var_11_10 then
			var_11_10 = arg_11_0:getUserDataTb_()
			var_11_10.go = gohelper.cloneInPlace(arg_11_0._goitem)

			gohelper.setActive(var_11_10.go, true)

			var_11_10.icon = IconMgr.instance:getCommonPropItemIcon(var_11_10.go)
			var_11_10.goget = gohelper.findChild(var_11_10.go, "get")

			gohelper.setAsLastSibling(var_11_10.goget)
			gohelper.setActive(var_11_10.goget, false)
			table.insert(arg_11_0._itemList, var_11_10)
		end

		var_11_10.icon:setMOValue(iter_11_1[1], iter_11_1[2], iter_11_1[3], nil, true)
		var_11_10.icon:SetCountLocalY(45)
		var_11_10.icon:SetCountBgHeight(30)
		var_11_10.icon:setCountFontSize(36)
	end

	arg_11_0:_refreshStatus()
end

function var_0_0._refreshStatus(arg_12_0)
	local var_12_0 = Activity133Model.instance:checkBonusReceived(arg_12_0.mo.id)

	gohelper.setActive(arg_12_0._btnfix.gameObject, not var_12_0)
	gohelper.setActive(arg_12_0._btncheck.gameObject, var_12_0)
	gohelper.setActive(arg_12_0._golock, not var_12_0)
	gohelper.setActive(arg_12_0._golockbg, not var_12_0)
	gohelper.setActive(arg_12_0._gocost, not var_12_0)
	gohelper.setActive(arg_12_0._gobuyed, var_12_0)

	for iter_12_0, iter_12_1 in pairs(arg_12_0._itemList) do
		gohelper.setActive(iter_12_1.goget, var_12_0)

		if var_12_0 then
			iter_12_1.icon:setAlpha(0.45, 0.8)
		else
			iter_12_1.icon:setAlpha(1, 1)
		end
	end
end

function var_0_0.getAnimator(arg_13_0)
	return arg_13_0._animator
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._btncheck.gameObject, not arg_14_1)
	gohelper.setActive(arg_14_0._gochecking, arg_14_1)
	gohelper.setActive(arg_14_0._gocheckbg, arg_14_1)

	if arg_14_1 then
		Activity133Controller.instance:dispatchEvent(Activity133Event.OnSelectCheckNote, arg_14_0.mo)
	end
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
