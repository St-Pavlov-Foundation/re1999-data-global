module("modules.logic.turnback.view.new.view.TurnbackNewLatterView", package.seeall)

slot0 = class("TurnbackNewLatterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gofirst = gohelper.findChild(slot0.viewGO, "first")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "normal")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.day = slot0.viewParam and slot0.viewParam.day or 1
	slot0._isNormal = slot0.viewParam and slot0.viewParam.isNormal or false
	slot0.notfirst = slot0.viewParam and slot0.viewParam.notfirst or false

	gohelper.setActive(slot0._gonormal, slot0._isNormal)
	gohelper.setActive(slot0._gofirst, not slot0._isNormal)

	slot0.turnbackId = TurnbackModel.instance:getCurTurnbackId()
	slot0.config = TurnbackConfig.instance:getTurnbackSignInDayCo(slot0.turnbackId, slot0.day)

	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_letter_expansion)
end

function slot0.refreshUI(slot0)
	if slot0._isNormal then
		slot0:refreshNoraml()
	else
		slot0:refreshFirst()
	end
end

function slot0.refreshNoraml(slot0)
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "normal/simage_page2/#simage_role")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "normal/simage_page2/#scroll_desc/Viewport/#txt_dec")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "normal/simage_page2/#scroll_desc/Viewport/#txt_dec/#txt_name")
	slot0._simagesign = gohelper.findChildSingleImage(slot0.viewGO, "normal/simage_page2/#simage_sign")

	slot0._simagerole:LoadImage(ResUrl.getTurnbackIcon("new/letter/turnback_new_letter_role" .. slot0.day))

	slot0._txtdec.text = slot0.config.content
	slot0._txtname.text = slot0.config.name

	slot0._simagesign:LoadImage(ResUrl.getSignature("characterget/" .. tostring(slot0.config.characterId)))
end

function slot0.refreshFirst(slot0)
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "first/simage_page2/#simage_role")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "first/simage_page2/#scroll_desc")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "first/simage_page2/#scroll_desc/Viewport/#txt_dec")
	slot0._gorewardicon = gohelper.findChild(slot0.viewGO, "first/simage_page2/go_reward/rewardicon")
	slot0._goallrewardicon = gohelper.findChild(slot0.viewGO, "first/simage_page3/#scroll_reward/Viewport/Content/rewardicon")
	slot0._btngoto = gohelper.findChildButton(slot0.viewGO, "first/simage_page3/#btn_goto")
	slot6 = slot0.day

	slot0._simagerole:LoadImage(ResUrl.getTurnbackIcon("new/letter/turnback_new_letter_role" .. slot6))

	slot0._txtdec.text = slot0.config.content

	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	gohelper.setActive(slot0._btngoto.gameObject, not slot0.notfirst)

	slot0.toprewardList = {}

	for slot6, slot7 in ipairs(GameUtil.splitString2(TurnbackConfig.instance:getTurnbackCo(slot0.turnbackId).onceBonus, true)) do
		slot8 = slot0:getUserDataTb_()
		slot8.goicon = gohelper.cloneInPlace(slot0._gorewardicon, "reward" .. slot6)
		slot8.gorewardicon = gohelper.findChild(slot8.goicon, "icon")
		slot8.goreceive = gohelper.findChild(slot8.goicon, "go_receive")

		gohelper.setActive(slot8.goicon, true)

		if not slot8.itemIcon then
			slot8.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot8.gorewardicon)
		end

		slot8.itemIcon:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
		slot8.itemIcon:setScale(0.5)
		slot8.itemIcon:setCountFontSize(48)
		table.insert(slot0.toprewardList, slot8)
	end

	slot0:setRewardReceiveState()

	slot0.rewardList = {}

	if slot1.bonusList then
		for slot8, slot9 in ipairs(GameUtil.splitString2(slot3, true)) do
			slot10 = slot0:getUserDataTb_()
			slot10.goicon = gohelper.cloneInPlace(slot0._goallrewardicon, "reward" .. slot8)

			gohelper.setActive(slot10.goicon, true)

			if not slot10.itemIcon then
				slot10.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot10.goicon)
			end

			slot10.itemIcon:setMOValue(slot9[1], slot9[2], slot9[3], nil, true)
			slot10.itemIcon:setScale(0.5)
			slot10.itemIcon:setCountFontSize(48)
			table.insert(slot0.rewardList, slot10)
		end
	end

	if TurnbackModel.instance:haveOnceBonusReward() then
		TaskDispatcher.runDelay(slot0.afterAnim, slot0, 1)
	end
end

function slot0.afterAnim(slot0)
	TaskDispatcher.cancelTask(slot0.afterAnim, slot0)
	TurnbackRpc.instance:sendTurnbackOnceBonusRequest(TurnbackModel.instance:getCurTurnbackId())
end

function slot0._btngotoOnClick(slot0)
	TurnbackController.instance:openTurnbackBeginnerView({
		turnbackId = TurnbackModel.instance:getCurTurnbackId()
	})
	slot0:closeThis()
end

function slot0.onClose(slot0)
	if not slot0._isNormal then
		slot0._btngoto:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(slot0.afterAnim, slot0)
	TaskDispatcher.cancelTask(slot0.checkScrollEnd, slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView and not slot0._isNormal and not slot0.notfirst then
		for slot5, slot6 in ipairs(slot0.toprewardList) do
			gohelper.setActive(slot6.goreceive, true)
		end
	end
end

function slot0.setRewardReceiveState(slot0)
	if not slot0._isNormal and slot0.notfirst then
		for slot4, slot5 in ipairs(slot0.toprewardList) do
			gohelper.setActive(slot5.goreceive, true)
		end
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
