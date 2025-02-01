module("modules.logic.versionactivity1_2.jiexika.view.Activity114TaskItem", package.seeall)

slot0 = class("Activity114TaskItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._simagebg = gohelper.findChildSingleImage(slot0.go, "#simage_bg")
	slot0._txtTaskDesc = gohelper.findChildText(slot0.go, "#txt_taskdes")
	slot0._txtTaskTotal = gohelper.findChildText(slot0.go, "#txt_total")
	slot0._txtTaskComplete = gohelper.findChildText(slot0.go, "#txt_complete")
	slot0._goNotFinish = gohelper.findChildButtonWithAudio(slot0.go, "#go_notget/#btn_notfinishbg")
	slot0._goGetBonus = gohelper.findChild(slot0.go, "#go_notget/#btn_finishbg")
	slot0._goFinishBg = gohelper.findChildButtonWithAudio(slot0.go, "#go_notget/#go_getbonus")
	slot0._scrollreward = gohelper.findChild(slot0.go, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._gorewards = gohelper.findChild(slot0.go, "scroll_reward/Viewport/#go_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.go, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")

	slot0._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("task/bg_renwulan.png"))

	slot0._rewardItems = {}
	slot0._anim = slot0.go:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0._goFinishBg:AddClickListener(slot0._goFinishBgOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._goFinishBg:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0._txtTaskDesc.text = slot0.mo.config.desc
	slot0._txtTaskTotal.text = slot0.mo.config.maxProgress
	slot0._txtTaskComplete.text = slot0.mo.progress

	gohelper.setActive(slot0._goNotFinish.gameObject, slot0.mo.finishStatus == Activity114Enum.TaskStatu.NoFinish)
	gohelper.setActive(slot0._goFinishBg.gameObject, slot0.mo.finishStatus == Activity114Enum.TaskStatu.Finish)
	gohelper.setActive(slot0._goGetBonus, slot0.mo.finishStatus == Activity114Enum.TaskStatu.GetBonus)

	slot0._scrollreward.parentGameObject = slot0._view._csListScroll.gameObject

	if not slot0.bonusItems then
		slot0.bonusItems = {}
	end

	for slot5, slot6 in pairs(slot0._rewardItems) do
		gohelper.destroy(slot6.itemIcon.go)
		gohelper.destroy(slot6.parentGo)
		slot6.itemIcon:onDestroy()
	end

	slot0._rewardItems = {}
	slot0._gorewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #string.split(slot1.config.bonus, "|") > 2

	for slot6 = 1, #slot2 do
		slot7 = {
			parentGo = gohelper.cloneInPlace(slot0._gorewarditem)
		}

		gohelper.setActive(slot7.parentGo, true)

		slot8 = string.splitToNumber(slot2[slot6], "#")
		slot7.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot7.parentGo)

		slot7.itemIcon:setMOValue(slot8[1], slot8[2], slot8[3], nil, true)
		slot7.itemIcon:isShowCount(slot8[1] ~= MaterialEnum.MaterialType.Hero)
		slot7.itemIcon:setCountFontSize(40)
		slot7.itemIcon:showStackableNum2()
		slot7.itemIcon:setHideLvAndBreakFlag(true)
		slot7.itemIcon:hideEquipLvAndBreak(true)
		table.insert(slot0._rewardItems, slot7)
	end
end

function slot0._goFinishBgOnClick(slot0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:receiveTaskReward(Activity114Model.instance.id, slot0.mo.id)
end

function slot0.getAnimator(slot0)
	return slot0._anim
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	for slot4, slot5 in pairs(slot0._rewardItems) do
		gohelper.destroy(slot5.itemIcon.go)
		gohelper.destroy(slot5.parentGo)
		slot5.itemIcon:onDestroy()
	end

	slot0._rewardItems = nil
end

return slot0
