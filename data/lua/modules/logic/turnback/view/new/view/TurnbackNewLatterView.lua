module("modules.logic.turnback.view.new.view.TurnbackNewLatterView", package.seeall)

local var_0_0 = class("TurnbackNewLatterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gofirst = gohelper.findChild(arg_1_0.viewGO, "first")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "normal")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.day = arg_7_0.viewParam and arg_7_0.viewParam.day or 1
	arg_7_0._isNormal = arg_7_0.viewParam and arg_7_0.viewParam.isNormal or false
	arg_7_0.notfirst = arg_7_0.viewParam and arg_7_0.viewParam.notfirst or false

	gohelper.setActive(arg_7_0._gonormal, arg_7_0._isNormal)
	gohelper.setActive(arg_7_0._gofirst, not arg_7_0._isNormal)

	arg_7_0.turnbackId = TurnbackModel.instance:getCurTurnbackId()
	arg_7_0.config = TurnbackConfig.instance:getTurnbackSignInDayCo(arg_7_0.turnbackId, arg_7_0.day)

	arg_7_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_letter_expansion)
end

function var_0_0.refreshUI(arg_8_0)
	if arg_8_0._isNormal then
		arg_8_0:refreshNoraml()
	else
		arg_8_0:refreshFirst()
	end
end

function var_0_0.refreshNoraml(arg_9_0)
	arg_9_0._simagerole = gohelper.findChildSingleImage(arg_9_0.viewGO, "normal/simage_page2/#simage_role")
	arg_9_0._txtdec = gohelper.findChildText(arg_9_0.viewGO, "normal/simage_page2/#scroll_desc/Viewport/#txt_dec")
	arg_9_0._txtname = gohelper.findChildText(arg_9_0.viewGO, "normal/simage_page2/#scroll_desc/Viewport/#txt_dec/#txt_name")
	arg_9_0._simagesign = gohelper.findChildSingleImage(arg_9_0.viewGO, "normal/simage_page2/#simage_sign")

	arg_9_0._simagerole:LoadImage(ResUrl.getTurnbackIcon("new/letter/turnback_new_letter_role" .. arg_9_0.day))

	arg_9_0._txtdec.text = arg_9_0.config.content
	arg_9_0._txtname.text = arg_9_0.config.name

	local var_9_0 = "characterget/" .. tostring(arg_9_0.config.characterId)

	arg_9_0._simagesign:LoadImage(ResUrl.getSignature(var_9_0))
end

function var_0_0.refreshFirst(arg_10_0)
	local var_10_0 = TurnbackConfig.instance:getTurnbackCo(arg_10_0.turnbackId)

	arg_10_0._simagerole = gohelper.findChildSingleImage(arg_10_0.viewGO, "first/simage_page2/#simage_role")
	arg_10_0._scrolldesc = gohelper.findChildScrollRect(arg_10_0.viewGO, "first/simage_page2/#scroll_desc")
	arg_10_0._txtdec = gohelper.findChildText(arg_10_0.viewGO, "first/simage_page2/#scroll_desc/Viewport/#txt_dec")
	arg_10_0._gorewardicon = gohelper.findChild(arg_10_0.viewGO, "first/simage_page2/go_reward/rewardicon")
	arg_10_0._goallrewardicon = gohelper.findChild(arg_10_0.viewGO, "first/simage_page3/#scroll_reward/Viewport/Content/rewardicon")
	arg_10_0._btngoto = gohelper.findChildButton(arg_10_0.viewGO, "first/simage_page3/#btn_goto")

	arg_10_0._simagerole:LoadImage(ResUrl.getTurnbackIcon("new/letter/turnback_new_letter_role" .. arg_10_0.day))

	arg_10_0._txtdec.text = arg_10_0.config.content

	arg_10_0._btngoto:AddClickListener(arg_10_0._btngotoOnClick, arg_10_0)
	gohelper.setActive(arg_10_0._btngoto.gameObject, not arg_10_0.notfirst)

	arg_10_0.toprewardList = {}

	local var_10_1 = GameUtil.splitString2(var_10_0.onceBonus, true)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = arg_10_0:getUserDataTb_()

		var_10_2.goicon = gohelper.cloneInPlace(arg_10_0._gorewardicon, "reward" .. iter_10_0)
		var_10_2.gorewardicon = gohelper.findChild(var_10_2.goicon, "icon")
		var_10_2.goreceive = gohelper.findChild(var_10_2.goicon, "go_receive")

		gohelper.setActive(var_10_2.goicon, true)

		if not var_10_2.itemIcon then
			var_10_2.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_10_2.gorewardicon)
		end

		var_10_2.itemIcon:setMOValue(iter_10_1[1], iter_10_1[2], iter_10_1[3], nil, true)
		var_10_2.itemIcon:setScale(0.5)
		var_10_2.itemIcon:setCountFontSize(48)
		table.insert(arg_10_0.toprewardList, var_10_2)
	end

	arg_10_0:setRewardReceiveState()

	arg_10_0.rewardList = {}

	local var_10_3 = var_10_0.bonusList

	if var_10_3 then
		local var_10_4 = GameUtil.splitString2(var_10_3, true)

		for iter_10_2, iter_10_3 in ipairs(var_10_4) do
			local var_10_5 = arg_10_0:getUserDataTb_()

			var_10_5.goicon = gohelper.cloneInPlace(arg_10_0._goallrewardicon, "reward" .. iter_10_2)

			gohelper.setActive(var_10_5.goicon, true)

			if not var_10_5.itemIcon then
				var_10_5.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_10_5.goicon)
			end

			var_10_5.itemIcon:setMOValue(iter_10_3[1], iter_10_3[2], iter_10_3[3], nil, true)
			var_10_5.itemIcon:setScale(0.5)
			var_10_5.itemIcon:setCountFontSize(48)
			table.insert(arg_10_0.rewardList, var_10_5)
		end
	end

	if TurnbackModel.instance:haveOnceBonusReward() then
		TaskDispatcher.runDelay(arg_10_0.afterAnim, arg_10_0, 1)
	end
end

function var_0_0.afterAnim(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.afterAnim, arg_11_0)

	local var_11_0 = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendTurnbackOnceBonusRequest(var_11_0)
end

function var_0_0._btngotoOnClick(arg_12_0)
	local var_12_0 = TurnbackModel.instance:getCurTurnbackId()
	local var_12_1 = {
		turnbackId = var_12_0
	}

	TurnbackController.instance:openTurnbackBeginnerView(var_12_1)
	arg_12_0:closeThis()
end

function var_0_0.onClose(arg_13_0)
	if not arg_13_0._isNormal then
		arg_13_0._btngoto:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_13_0.afterAnim, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.checkScrollEnd, arg_13_0)
end

function var_0_0._onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.CommonPropView and not arg_14_0._isNormal and not arg_14_0.notfirst then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.toprewardList) do
			gohelper.setActive(iter_14_1.goreceive, true)
		end
	end
end

function var_0_0.setRewardReceiveState(arg_15_0)
	if not arg_15_0._isNormal and arg_15_0.notfirst then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.toprewardList) do
			gohelper.setActive(iter_15_1.goreceive, true)
		end
	end
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
