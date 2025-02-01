module("modules.logic.versionactivity.view.VersionActivityExchangeTaskItem", package.seeall)

slot0 = class("VersionActivityExchangeTaskItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.viewGO = slot1
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "simage_bg")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._txtcurcount = gohelper.findChildText(slot0.viewGO, "#txt_curcount")
	slot0._txttotalcount = gohelper.findChildText(slot0.viewGO, "#txt_totalcount")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_rewards")
	slot0._btnreceive = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_receive")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._goblackmask = gohelper.findChild(slot0.viewGO, "#go_mask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnreceive:AddClickListener(slot0._btnreceiveOnClick, slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnreceive:RemoveClickListener()
	slot0._btnjump:RemoveClickListener()
end

function slot0._btnreceiveOnClick(slot0)
	slot0._animator:Play("finish")
	UIBlockMgr.instance:startBlock("VersionActivityExchangeTaskItem")
	TaskDispatcher.runDelay(slot0.sendRewardRequest, slot0, 0.6)
end

function slot0._btnjumpOnClick(slot0)
	GameFacade.jump(slot0.mo.config.jumpId)
end

function slot0._editableInitView(slot0)
	slot0.icon = IconMgr.instance:getCommonItemIcon(slot0._gorewards)

	slot0.icon:setCountFontSize(36)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityExchangeIcon("bg_rwdi"))

	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.sendRewardRequest(slot0)
	UIBlockMgr.instance:endBlock("VersionActivityExchangeTaskItem")
	Activity112Rpc.instance:sendReceiveAct112TaskRewardRequest(slot0.mo.actId, slot0.mo.id)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0.mo = slot1
	slot0._txtdesc.text = slot1.config.desc
	slot0._txtcurcount.text = slot1.progress
	slot0._txttotalcount.text = slot1.config.maxProgress

	slot0:_setCurCountFontSize()

	slot4 = GameUtil.splitString2(slot1.config.bonus, true)[1]

	slot0.icon:setMOValue(slot4[1], slot4[2], slot4[3])
	slot0.icon:isShowCount(true)
	gohelper.setActive(slot0._btnjump.gameObject, slot1.progress < slot1.config.maxProgress and slot1.hasGetBonus == false)
	gohelper.setActive(slot0._btnreceive.gameObject, slot1.config.maxProgress <= slot1.progress and slot1.hasGetBonus == false)
	gohelper.setActive(slot0._gofinish, slot1.hasGetBonus)
	gohelper.setActive(slot0._goblackmask, slot1.hasGetBonus)

	if slot3 then
		slot0._animator:Play(UIAnimationName.Open, 0, 0)
		slot0._animator:Update(0)

		if slot0._animator:GetCurrentAnimatorStateInfo(0).length <= 0 then
			slot6 = 1
		end

		slot0._animator:Play(UIAnimationName.Open, 0, -0.06 * (slot2 - 1) / slot6)
		slot0._animator:Update(0)
	else
		slot0._animator:Play(UIAnimationName.Open, 0, 1)
		slot0._animator:Update(0)
	end
end

function slot0._setCurCountFontSize(slot0)
	slot3 = 0.7

	if #slot0._txtcurcount.text > 3 then
		slot3 = slot2 - (slot2 - 0.35) / (6 - slot6) * (slot5 - slot6)
	end

	transformhelper.setLocalScale(slot0._txtcurcount.transform, slot3, slot3, 1)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
