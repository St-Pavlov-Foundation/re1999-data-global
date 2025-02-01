module("modules.logic.mail.view.MailCategoryListItem", package.seeall)

slot0 = class("MailCategoryListItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._goselectedBg = gohelper.findChild(slot1, "#go_cg/bg/#go_selectedBg")
	slot0._gounselectedBg = gohelper.findChild(slot1, "#go_cg/bg/#go_unselectedBg")
	slot0._gohasReadBg = gohelper.findChild(slot1, "#go_cg/bg/#go_hasReadBg")
	slot0._gomailSelectIcon = gohelper.findChild(slot1, "#go_cg/icon/#go_mailSelectIcon")
	slot0._gomailUnselectIcon = gohelper.findChild(slot1, "#go_cg/icon/#go_mailUnselectIcon")
	slot0._gogiftSelectIcon = gohelper.findChild(slot1, "#go_cg/icon/#go_giftSelectIcon")
	slot0._gogiftUnselectIcon = gohelper.findChild(slot1, "#go_cg/icon/#go_giftUnselectIcon")
	slot0._gogiftHasReceiveIcon = gohelper.findChild(slot1, "#go_cg/icon/#go_giftHasReceiveIcon")
	slot0._gomailHasReceiveIcon = gohelper.findChild(slot1, "#go_cg/icon/#go_mailHasReceiveIcon")
	slot0._txtmailTitleSelect = gohelper.findChildText(slot1, "#go_cg/#txt_mailTitleSelect")
	slot0._txtmailTitleUnSelect = gohelper.findChildText(slot1, "#go_cg/#txt_mailTitleUnSelect")
	slot0._txtmailTimeSelect = gohelper.findChildText(slot1, "#go_cg/#txt_mailTimeSelect")
	slot0._txtmailTimeUnSelect = gohelper.findChildText(slot1, "#go_cg/#txt_mailTimeUnSelect")
	slot0._goreceivedIcon = gohelper.findChild(slot1, "#go_cg/#go_receivedIcon")
	slot0._goredTip = gohelper.findChild(slot1, "#go_cg/#go_redTip")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot1, "#btn_click")
	slot0._gocg = gohelper.findChildComponent(slot1, "#go_cg", typeof(UnityEngine.CanvasGroup))
	slot0._goAnim = slot1:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(slot0._btnclick.gameObject, AudioEnum.UI.UI_Mail_switch)
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnclick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnclick(slot0)
	if slot0._select then
		return
	end

	slot0._view:selectCell(slot0._index, true)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshInfo()
	slot0:_refreshTips()
	slot0:_refreshBg()
	slot0:_refreshIcon()
end

function slot0._refreshInfo(slot0)
	gohelper.setActive(slot0._txtmailTitleSelect.gameObject, slot0._select)
	gohelper.setActive(slot0._txtmailTitleUnSelect.gameObject, not slot0._select)

	if slot0._select then
		slot0._txtmailTitleSelect.text = GameUtil.getBriefNameByWidth(slot0._mo:getLangTitle(), slot0._txtmailTitleSelect)
	else
		slot0._txtmailTitleUnSelect.text = GameUtil.getBriefNameByWidth(slot0._mo:getLangTitle(), slot0._txtmailTitleUnSelect)
	end

	gohelper.setActive(slot0._txtmailTimeSelect.gameObject, slot0._select)
	gohelper.setActive(slot0._txtmailTimeUnSelect.gameObject, not slot0._select)

	if slot0._select then
		slot0._txtmailTimeSelect.text = TimeUtil.langTimestampToString3(slot0._mo.createTime / 1000)
	else
		slot0._txtmailTimeUnSelect.text = slot1
	end
end

function slot0._refreshTips(slot0)
	if slot0._mo:haveBonus() then
		if slot0._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(slot0._goredTip, false)
			gohelper.setActive(slot0._goreceivedIcon, true)
		else
			gohelper.setActive(slot0._goredTip, true)
			gohelper.setActive(slot0._goreceivedIcon, false)
		end
	elseif slot0._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(slot0._goredTip, false)
		gohelper.setActive(slot0._goreceivedIcon, true)
	else
		gohelper.setActive(slot0._goredTip, true)
		gohelper.setActive(slot0._goreceivedIcon, false)
	end

	slot0:setRead(slot0._mo.state == MailEnum.ReadStatus.Read)
end

function slot0._refreshBg(slot0)
	gohelper.setActive(slot0._goselectedBg, false)
	gohelper.setActive(slot0._gounselectedBg, false)
	gohelper.setActive(slot0._gohasReadBg, false)

	if slot0._select then
		gohelper.setActive(slot0._goselectedBg, true)
		gohelper.setActive(slot0._goreceivedIcon, false)
	elseif slot0._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(slot0._gohasReadBg, true)
		gohelper.setActive(slot0._gounselectedBg, true)
	else
		gohelper.setActive(slot0._gounselectedBg, true)

		if slot0._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(slot0._goreceivedIcon, true)
		end
	end
end

function slot0._refreshIcon(slot0)
	gohelper.setActive(slot0._gomailSelectIcon, false)
	gohelper.setActive(slot0._gomailUnselectIcon, false)
	gohelper.setActive(slot0._gogiftSelectIcon, false)
	gohelper.setActive(slot0._gogiftUnselectIcon, false)
	gohelper.setActive(slot0._gogiftHasReceiveIcon, false)
	gohelper.setActive(slot0._gomailHasReceiveIcon, false)

	if slot0._mo:haveBonus() then
		if slot0._select then
			gohelper.setActive(slot0._gogiftSelectIcon, true)
		elseif slot0._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(slot0._gogiftHasReceiveIcon, true)
		else
			gohelper.setActive(slot0._gogiftUnselectIcon, true)
		end
	elseif slot0._select then
		gohelper.setActive(slot0._gomailSelectIcon, true)
	elseif slot0._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(slot0._gomailHasReceiveIcon, true)
	else
		gohelper.setActive(slot0._gomailUnselectIcon, true)
	end
end

function slot0.getAnimator(slot0)
	return slot0._goAnim
end

function slot0.onSelect(slot0, slot1)
	if not slot0._select and slot1 then
		MailController.instance:dispatchEvent(MailEvent.UpdateSelectMail, slot0._mo)
	end

	slot0._select = slot1

	slot0:_refreshInfo()
	slot0:_refreshTips()
	slot0:_refreshBg()
	slot0:_refreshIcon()
end

function slot0.setRead(slot0, slot1)
	slot2 = 1

	if slot1 and not slot0._select then
		slot2 = 0.7
	end

	slot0._gocg.alpha = slot2
end

function slot0.onDestroy(slot0)
end

return slot0
