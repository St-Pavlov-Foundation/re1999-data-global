module("modules.logic.rouge.view.RougeRewardNoticeView", package.seeall)

slot0 = class("RougeRewardNoticeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_ItemList")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_ItemList/Viewport/Content")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "#scroll_ItemList/Viewport/Content/#go_Item")
	slot0._itemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0._initView(slot0)
	slot0._season = RougeOutsideModel.instance:season()

	for slot5, slot6 in pairs(RougeRewardConfig.instance:getBigRewardToStage()) do
		slot7 = slot6[1]

		if slot0._itemList[slot5] == nil then
			slot8 = slot0:getUserDataTb_()
			slot9 = gohelper.cloneInPlace(slot0._goItem, "rewarditem" .. slot5)
			slot8.go = slot9
			slot8.co = slot7
			slot8.index = slot5
			slot8.txtNum = gohelper.findChildText(slot9, "#txt_Num")
			slot8.txtItem = gohelper.findChildText(slot9, "#txt_Item")
			slot8.goGet = gohelper.findChild(slot9, "#go_Get")
			slot8.goUnGetBg = gohelper.findChild(slot9, "image_ItemIconBG2")
			slot8.goLockMask = gohelper.findChild(slot9, "#go_LockMask")
			slot8.goUnlockItem = gohelper.findChild(slot9, "#go_UnlockItem")
			slot8.imageItemIcon = gohelper.findChildImage(slot9, "#image_ItemIcon")
			slot8.goNextUnlock = gohelper.findChild(slot9, "#go_nextUnlock")
			slot8.btn = gohelper.findChildButton(slot9, "btn")

			slot8.btn:AddClickListener(slot0._btnclickOnClick, slot0, slot8)

			slot8.animator = slot9:GetComponent(typeof(UnityEngine.Animator))
			slot8.layoutindex = math.ceil(slot8.index / 3)

			table.insert(slot0._itemList, slot8)
		end

		if math.floor(slot7.bigRewardId / 10) > 0 then
			slot8.txtNum.text = slot7.bigRewardId
		else
			slot8.txtNum.text = string.format("0%d", slot7.bigRewardId)
		end

		slot8.txtItem.text = slot7.name

		if not string.nilorempty(slot7.icon) then
			UISpriteSetMgr.instance:setRouge5Sprite(slot8.imageItemIcon, slot7.icon)
		end

		slot9 = RougeRewardModel.instance:checShowBigRewardGot(slot7.bigRewardId)

		gohelper.setActive(slot8.goGet, slot9)
		gohelper.setActive(slot8.goUnGetBg, not slot9)

		slot10 = RougeRewardModel.instance:isStageOpen(slot7.stage)

		gohelper.setActive(slot8.goLockMask, not slot10)
		gohelper.setActive(slot8.goUnlockItem, not slot10)
		gohelper.setActive(slot8.imageItemIcon.gameObject, slot10)
		gohelper.setActive(slot8.btn, slot10)

		slot8.txtItem.text = slot10 and slot7.name or slot7.lockName

		gohelper.setActive(slot8.goNextUnlock, RougeRewardModel.instance:isShowNextStageTag(slot7.stage))
	end
end

function slot0._btnclickOnClick(slot0, slot1)
	slot0:_jumpToTargetReward(slot1.index)
end

function slot0._jumpToTargetReward(slot0, slot1)
	slot0:closeThis()
	RougeController.instance:dispatchEvent(RougeEvent.OnClickBigReward, slot1)
end

function slot0.onOpen(slot0)
	RougeRewardModel.instance:setNextUnlockStage()
	slot0:_initView()
	slot0:_openAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardNoticeView)
end

function slot0._openAnim(slot0)
	function slot0._playAnim()
		if not uv0.viewContainer or not uv0.viewContainer._isVisible then
			return
		end

		TaskDispatcher.cancelTask(uv0._playAnim, uv0)

		function uv0.playfunc(slot0)
			if not uv0.viewContainer or not uv0.viewContainer._isVisible then
				return
			end

			TaskDispatcher.cancelTask(uv0.playfunc, slot0)
			gohelper.setActive(slot0.go, true)
			slot0.animator:Update(0)
			slot0.animator:Play("in", 0, 0)
		end

		for slot3, slot4 in pairs(uv0._itemList) do
			TaskDispatcher.runDelay(uv0.playfunc, slot4, slot4.layoutindex * 0.06)
		end
	end

	TaskDispatcher.runDelay(slot0._playAnim, slot0, 0.1)
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._itemList) do
		slot5.btn:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
