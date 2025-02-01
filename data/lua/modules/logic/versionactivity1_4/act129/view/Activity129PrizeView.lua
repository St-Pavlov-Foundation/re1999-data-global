module("modules.logic.versionactivity1_4.act129.view.Activity129PrizeView", package.seeall)

slot0 = class("Activity129PrizeView", BaseView)

function slot0.onInitView(slot0)
	slot0.goPrize = gohelper.findChild(slot0.viewGO, "#go_Prize")
	slot0.click = gohelper.findChildClick(slot0.goPrize, "click")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.goPrize, "#simage_ItemIcon")
	slot0.imageIcon = gohelper.findChildImage(slot0.goPrize, "#simage_ItemIcon")
	slot0.gonormal = gohelper.findChild(slot0.viewGO, "normal")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity129Controller.instance, Activity129Event.OnShowSpecialReward, slot0.showReward, slot0)
end

function slot0.removeEvents(slot0)
	slot0.click:RemoveClickListener()
	slot0:removeEventCb(Activity129Controller.instance, Activity129Event.OnShowSpecialReward, slot0.showReward, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
end

function slot0.showReward(slot0, slot1, slot2)
	slot0:clear()

	slot0.specialList = slot1
	slot0.list = slot2

	slot0:startShow()
end

function slot0.startShow(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_all)
	gohelper.setActive(slot0.gonormal, false)
	gohelper.setActive(slot0.gonormal, true)
	TaskDispatcher.cancelTask(slot0.continueShow, slot0)
	TaskDispatcher.runDelay(slot0.continueShow, slot0, 1.34)
end

function slot0.continueShow(slot0)
	gohelper.setActive(slot0.gonormal, false)

	if not slot0.specialList then
		slot0:onShowEnd()

		return
	end

	slot0:showItem()
end

function slot0.showItem(slot0)
	if not table.remove(slot0.specialList, 1) then
		slot0:onShowEnd()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_core)

	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot1[1], slot1[2], true)

	slot0.simageIcon:LoadImage(slot3)
	gohelper.setActive(slot0.goPrize, false)
	gohelper.setActive(slot0.goPrize, true)
	TaskDispatcher.cancelTask(slot0.showItem, slot0)
	TaskDispatcher.runDelay(slot0.showItem, slot0, 1.84)
end

function slot0.onShowEnd(slot0)
	slot0:clear()
	gohelper.setActive(slot0.goPrize, false)
	gohelper.setActive(slot0.gonormal, false)

	slot0.list = nil
	slot0.specialList = nil

	Activity129Controller.instance:dispatchEvent(Activity129Event.OnShowReward, slot0.list)
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0.showItem, slot0)
	TaskDispatcher.cancelTask(slot0.continueShow, slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.showItem, slot0)
	TaskDispatcher.cancelTask(slot0.continueShow, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
