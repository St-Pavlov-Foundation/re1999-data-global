module("modules.logic.mail.view.MailCategoryListItem", package.seeall)

local var_0_0 = class("MailCategoryListItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goselectedBg = gohelper.findChild(arg_1_1, "#go_cg/bg/#go_selectedBg")
	arg_1_0._gounselectedBg = gohelper.findChild(arg_1_1, "#go_cg/bg/#go_unselectedBg")
	arg_1_0._gohasReadBg = gohelper.findChild(arg_1_1, "#go_cg/bg/#go_hasReadBg")
	arg_1_0._gomailSelectIcon = gohelper.findChild(arg_1_1, "#go_cg/icon/#go_mailSelectIcon")
	arg_1_0._gomailUnselectIcon = gohelper.findChild(arg_1_1, "#go_cg/icon/#go_mailUnselectIcon")
	arg_1_0._gogiftSelectIcon = gohelper.findChild(arg_1_1, "#go_cg/icon/#go_giftSelectIcon")
	arg_1_0._gogiftUnselectIcon = gohelper.findChild(arg_1_1, "#go_cg/icon/#go_giftUnselectIcon")
	arg_1_0._gogiftHasReceiveIcon = gohelper.findChild(arg_1_1, "#go_cg/icon/#go_giftHasReceiveIcon")
	arg_1_0._gomailHasReceiveIcon = gohelper.findChild(arg_1_1, "#go_cg/icon/#go_mailHasReceiveIcon")
	arg_1_0._txtmailTitleSelect = gohelper.findChildText(arg_1_1, "#go_cg/#txt_mailTitleSelect")
	arg_1_0._txtmailTitleUnSelect = gohelper.findChildText(arg_1_1, "#go_cg/#txt_mailTitleUnSelect")
	arg_1_0._txtmailTimeSelect = gohelper.findChildText(arg_1_1, "#go_cg/#txt_mailTimeSelect")
	arg_1_0._txtmailTimeUnSelect = gohelper.findChildText(arg_1_1, "#go_cg/#txt_mailTimeUnSelect")
	arg_1_0._goreceivedIcon = gohelper.findChild(arg_1_1, "#go_cg/#go_receivedIcon")
	arg_1_0._goredTip = gohelper.findChild(arg_1_1, "#go_cg/#go_redTip")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_click")
	arg_1_0._gocg = gohelper.findChildComponent(arg_1_1, "#go_cg", typeof(UnityEngine.CanvasGroup))
	arg_1_0._goAnim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(arg_1_0._btnclick.gameObject, AudioEnum.UI.UI_Mail_switch)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnclick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnclick(arg_4_0)
	if arg_4_0._select then
		return
	end

	arg_4_0._view:selectCell(arg_4_0._index, true)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0:_refreshInfo()
	arg_5_0:_refreshTips()
	arg_5_0:_refreshBg()
	arg_5_0:_refreshIcon()
end

function var_0_0._refreshInfo(arg_6_0)
	gohelper.setActive(arg_6_0._txtmailTitleSelect.gameObject, arg_6_0._select)
	gohelper.setActive(arg_6_0._txtmailTitleUnSelect.gameObject, not arg_6_0._select)

	if arg_6_0._select then
		arg_6_0._txtmailTitleSelect.text = GameUtil.getBriefNameByWidth(arg_6_0._mo:getLangTitle(), arg_6_0._txtmailTitleSelect)
	else
		arg_6_0._txtmailTitleUnSelect.text = GameUtil.getBriefNameByWidth(arg_6_0._mo:getLangTitle(), arg_6_0._txtmailTitleUnSelect)
	end

	gohelper.setActive(arg_6_0._txtmailTimeSelect.gameObject, arg_6_0._select)
	gohelper.setActive(arg_6_0._txtmailTimeUnSelect.gameObject, not arg_6_0._select)

	local var_6_0 = TimeUtil.langTimestampToString3(arg_6_0._mo.createTime / 1000)

	if arg_6_0._select then
		arg_6_0._txtmailTimeSelect.text = var_6_0
	else
		arg_6_0._txtmailTimeUnSelect.text = var_6_0
	end
end

function var_0_0._refreshTips(arg_7_0)
	if arg_7_0._mo:haveBonus() then
		if arg_7_0._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(arg_7_0._goredTip, false)
			gohelper.setActive(arg_7_0._goreceivedIcon, true)
		else
			gohelper.setActive(arg_7_0._goredTip, true)
			gohelper.setActive(arg_7_0._goreceivedIcon, false)
		end
	elseif arg_7_0._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(arg_7_0._goredTip, false)
		gohelper.setActive(arg_7_0._goreceivedIcon, true)
	else
		gohelper.setActive(arg_7_0._goredTip, true)
		gohelper.setActive(arg_7_0._goreceivedIcon, false)
	end

	arg_7_0:setRead(arg_7_0._mo.state == MailEnum.ReadStatus.Read)
end

function var_0_0._refreshBg(arg_8_0)
	gohelper.setActive(arg_8_0._goselectedBg, false)
	gohelper.setActive(arg_8_0._gounselectedBg, false)
	gohelper.setActive(arg_8_0._gohasReadBg, false)

	if arg_8_0._select then
		gohelper.setActive(arg_8_0._goselectedBg, true)
		gohelper.setActive(arg_8_0._goreceivedIcon, false)
	elseif arg_8_0._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(arg_8_0._gohasReadBg, true)
		gohelper.setActive(arg_8_0._gounselectedBg, true)
	else
		gohelper.setActive(arg_8_0._gounselectedBg, true)

		if arg_8_0._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(arg_8_0._goreceivedIcon, true)
		end
	end
end

function var_0_0._refreshIcon(arg_9_0)
	gohelper.setActive(arg_9_0._gomailSelectIcon, false)
	gohelper.setActive(arg_9_0._gomailUnselectIcon, false)
	gohelper.setActive(arg_9_0._gogiftSelectIcon, false)
	gohelper.setActive(arg_9_0._gogiftUnselectIcon, false)
	gohelper.setActive(arg_9_0._gogiftHasReceiveIcon, false)
	gohelper.setActive(arg_9_0._gomailHasReceiveIcon, false)

	if arg_9_0._mo:haveBonus() then
		if arg_9_0._select then
			gohelper.setActive(arg_9_0._gogiftSelectIcon, true)
		elseif arg_9_0._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(arg_9_0._gogiftHasReceiveIcon, true)
		else
			gohelper.setActive(arg_9_0._gogiftUnselectIcon, true)
		end
	elseif arg_9_0._select then
		gohelper.setActive(arg_9_0._gomailSelectIcon, true)
	elseif arg_9_0._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(arg_9_0._gomailHasReceiveIcon, true)
	else
		gohelper.setActive(arg_9_0._gomailUnselectIcon, true)
	end
end

function var_0_0.getAnimator(arg_10_0)
	return arg_10_0._goAnim
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	if not arg_11_0._select and arg_11_1 then
		MailController.instance:dispatchEvent(MailEvent.UpdateSelectMail, arg_11_0._mo)
	end

	arg_11_0._select = arg_11_1

	arg_11_0:_refreshInfo()
	arg_11_0:_refreshTips()
	arg_11_0:_refreshBg()
	arg_11_0:_refreshIcon()
end

function var_0_0.setRead(arg_12_0, arg_12_1)
	local var_12_0 = 1

	if arg_12_1 and not arg_12_0._select then
		var_12_0 = 0.7
	end

	arg_12_0._gocg.alpha = var_12_0
end

function var_0_0.onDestroy(arg_13_0)
	return
end

return var_0_0
