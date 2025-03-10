module("modules.logic.activity.view.ActivityNorSignItem", package.seeall)

slot0 = class("ActivityNorSignItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._gobg = gohelper.findChild(slot1, "normalbg")
	slot0._todaybg = gohelper.findChild(slot1, "todaybg")
	slot0._txtdate = gohelper.findChildText(slot1, "datecn")
	slot0._txtdateEn = gohelper.findChildText(slot1, "dateen")
	slot0._goreward = gohelper.findChild(slot1, "#go_reward")
	slot0._gotomorrowtag = gohelper.findChild(slot1, "go_tomorrowtag")
	slot0._goget = gohelper.findChild(slot1, "get")
	slot0._gomask = gohelper.findChild(slot1, "mask")
	slot0._itemClick = gohelper.getClickWithAudio(slot0._gobg)
	slot0._txtname = gohelper.findChildText(slot1, "#go_reward/#txt_name")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._anim.enabled = false
	slot0._go = slot1

	gohelper.setActive(slot1, false)
end

function slot0.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._itemClick:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	slot2 = ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NorSign)

	if ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NorSign, slot0._index) then
		Activity101Rpc.instance:sendGet101BonusRequest(ActivityEnum.Activity.NorSign, slot0._index)
	end

	if slot2 < slot0._index then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()
	TaskDispatcher.runDelay(slot0._playAnimation, slot0, slot0._index * 0.03)
end

function slot0._refreshItem(slot0)
	ActivityType101Model.instance:setCurIndex(slot0._index)

	slot1 = string.splitToNumber(ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.NorSign, slot0._index).bonus, "#")
	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot1[1], slot1[2])

	if not slot0._item then
		slot0._item = IconMgr.instance:getCommonPropItemIcon(slot0._goreward)
	end

	slot0._item:setMOValue(slot1[1], slot1[2], slot1[3], nil, true)
	slot0._item:setScale(0.8)
	slot0._item:showName(slot0._txtname)

	slot0._txtname.text = slot2.name

	slot0._item:setNameType("<color=#3A3836><size=38>%s</size></color>")
	slot0._item:setCountFontSize(35)

	slot0._txtdate.text = "0" .. slot0._index
	slot0._txtdateEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(slot0._index))
	slot4 = ActivityType101Model.instance:isType101RewardGet(ActivityEnum.Activity.NorSign, slot0._index)
	slot6 = ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NorSign)

	gohelper.setActive(slot0._goget, slot4)
	gohelper.setActive(slot0._gomask, slot4 or slot6 < slot0._index)
	gohelper.setActive(slot0._todaybg, ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NorSign, slot0._index))
	gohelper.setActive(slot0._gotomorrowtag, slot0._index == slot6 + 1)

	if slot4 then
		ZProj.UGUIHelper.SetColorAlpha(slot0._gomask:GetComponent("Image"), 0.68)
	else
		ZProj.UGUIHelper.SetColorAlpha(slot0._gomask:GetComponent("Image"), 0)
	end

	if not slot4 and slot5 then
		slot0._item:customOnClickCallback(slot0._onItemClick, slot0)
	else
		slot0._item:customOnClickCallback(nil)
	end
end

function slot0._playAnimation(slot0)
	gohelper.setActive(slot0._go, true)

	slot0._anim.enabled = true
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._playAnimation, slot0)
end

return slot0
