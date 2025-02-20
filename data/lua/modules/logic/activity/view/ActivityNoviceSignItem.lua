module("modules.logic.activity.view.ActivityNoviceSignItem", package.seeall)

slot0 = class("ActivityNoviceSignItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._gobg = gohelper.findChild(slot1, "#go_normalday/normalbg")
	slot0._gotomorrowtag = gohelper.findChild(slot1, "#go_tomorrowtag")
	slot0._gotodaynormalbg = gohelper.findChild(slot1, "#go_todaynormalbg")
	slot0._txtdate = gohelper.findChildText(slot1, "date/datecn")
	slot0._gonormalday = gohelper.findChild(slot1, "#go_normalday")
	slot0._gonormalget = gohelper.findChild(slot1, "#go_normalget")
	slot0._finalget = gohelper.findChild(slot1, "#go_finalget")
	slot0._itemClick = gohelper.getClickWithAudio(slot0._gotodaynormalbg)
	slot0._gofinalbg = gohelper.findChild(slot1, "#go_finalday/finalbg")
	slot0._finalitemClick = gohelper.getClickWithAudio(slot0._gofinalbg)
	slot0._siamgefinalrewardicon = gohelper.findChildSingleImage(slot1, "#go_finalday/#siamge_finalrewardicon")
	slot0._gofinalday = gohelper.findChild(slot1, "#go_finalday")
	slot0._goicon1 = gohelper.findChild(slot1, "#go_normalday/content/#go_icon1")
	slot0._goicon2 = gohelper.findChild(slot1, "#go_normalday/content/#go_icon2")
	slot0._canvascontent = gohelper.findChild(slot1, "#go_normalday/content"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._canvasdate = gohelper.findChild(slot1, "date"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._anim.enabled = false

	gohelper.setActive(slot1, false)

	slot0._rewardTab = {}
end

slot0.finalday = 8

function slot0.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
	slot0._finalitemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._itemClick:RemoveClickListener()
	slot0._finalitemClick:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	slot2 = ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NoviceSign)

	if ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NoviceSign, slot0._index) then
		Activity101Rpc.instance:sendGet101BonusRequest(ActivityEnum.Activity.NoviceSign, slot0._index)
	end

	if slot0._index == uv0.finalday and not slot1 then
		MaterialTipController.instance:showMaterialInfo(tonumber(slot0._prop[1]), tonumber(slot0._prop[2]))
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()
	TaskDispatcher.runDelay(slot0._playAnimation, slot0, slot0._index * 0.03)
end

function slot0._refreshItem(slot0)
	ActivityType101Model.instance:setCurIndex(slot0._index)

	if slot0._index ~= uv0.finalday then
		slot3 = ActivityConfig.instance
		slot5 = slot3

		for slot5 = 1, #string.split(slot3.getNorSignActivityCo(slot5, ActivityEnum.Activity.NoviceSign, slot0._index).bonus, "|") do
			slot6 = string.splitToNumber(slot1[slot5], "#")

			if not slot0._rewardTab[slot5] then
				table.insert(slot0._rewardTab, IconMgr.instance:getCommonPropItemIcon(slot0["_goicon" .. slot5]))
			end

			slot7:setMOValue(slot6[1], slot6[2], slot6[3])
			slot7:setCountFontSize(46)
			slot7:setHideLvAndBreakFlag(true)
			slot7:hideEquipLvAndBreak(true)
		end

		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtdate, "#ADA697")
	else
		slot0._prop = string.splitToNumber(ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.NoviceSign, slot0._index).bonus, "#")
		slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(slot0._prop[1], slot0._prop[2], true)

		slot0._siamgefinalrewardicon:LoadImage(slot2)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtdate, "#B57F50")
	end

	gohelper.setActive(slot0._gofinalday, tonumber(slot0._index) == uv0.finalday)
	gohelper.setActive(slot0._gonormalday, tonumber(slot0._index) ~= uv0.finalday)

	slot0._txtdate.text = string.format("%02d", slot0._index)

	gohelper.setActive(slot0._gonormalget, ActivityType101Model.instance:isType101RewardGet(ActivityEnum.Activity.NoviceSign, slot0._index) and slot0._index ~= uv0.finalday)
	gohelper.setActive(slot0._finalget, slot1 and slot0._index == uv0.finalday)
	gohelper.setActive(slot0._gotodaynormalbg, ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NoviceSign, slot0._index))
	gohelper.setActive(slot0._gotomorrowtag, slot0._index == ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NoviceSign) + 1)

	slot0._canvascontent.alpha = slot1 and 0.8 or 1
	slot0._canvasdate.alpha = slot1 and 0.8 or 1

	ZProj.UGUIHelper.SetColorAlpha(slot0._siamgefinalrewardicon:GetComponent(gohelper.Type_Image), slot1 and 0.8 or 1)
end

function slot0._playAnimation(slot0)
	gohelper.setActive(slot0._go, true)

	slot0._anim.enabled = true
end

function slot0.onDestroy(slot0)
	if slot0._index and tonumber(slot0._index) == 8 then
		slot0._siamgefinalrewardicon:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0._playAnimation, slot0)
end

return slot0
