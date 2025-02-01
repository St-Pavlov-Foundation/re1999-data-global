module("modules.logic.versionactivity.view.VersionActivityExchangeItem", package.seeall)

slot0 = class("VersionActivityExchangeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtneed = gohelper.findChildText(slot0.go, "state/txt_need")
	slot0._gounfinishstate = gohelper.findChild(slot0.go, "state/go_unfinishstate")
	slot0._gofinishstate = gohelper.findChild(slot0.go, "state/go_finishstate")
	slot0._gorewardcontent = gohelper.findChild(slot0.go, "#go_rewardcontent")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.go, "btn_click")
	slot0._goget = gohelper.findChild(slot0.go, "go_get")
	slot0._golingqu = gohelper.findChild(slot0.go, "go_get/#lingqu")
	slot0._gofinish = gohelper.findChild(slot0.go, "go_finish")
	slot0._gounfinish = gohelper.findChild(slot0.go, "go_unfinish")
	slot0._goselected = gohelper.findChild(slot0.go, "go_selected")
	slot0._goselectedbg = gohelper.findChildSingleImage(slot0.go, "go_selected/bg")
	slot0._gorewarditem = gohelper.findChild(slot0.go, "#go_rewardcontent/anim/#go_rewarditem")
	slot0._imgiconbgunselect = gohelper.findChildImage(slot0.go, "hero/img_iconbgunselect")
	slot0._imgiconbgselect = gohelper.findChildImage(slot0.go, "hero/img_iconbgselect")
	slot0._imgheadicon = gohelper.findChildSingleImage(slot0.go, "hero/mask/img_headicon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._btnClickOnClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.updateLingqu, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.updateLingqu, slot0)
end

function slot0._btnClickOnClick(slot0)
	if slot0.state == -1 then
		-- Nothing
	elseif slot0.state == 1 then
		StoryController.instance:playStory(slot0.config.storyId, {
			mark = true
		})
	elseif slot0.needArr[3] <= ItemModel.instance:getItemQuantity(slot0.needArr[1], slot0.needArr[2]) then
		StoryController.instance:playStory(slot0.config.storyId, {
			mark = true
		}, slot0.sendExchange112Request, slot0)
	else
		ToastController.instance:showToast(3202, ItemModel.instance:getItemConfigAndIcon(slot0.needArr[1], slot0.needArr[2]) and slot2.name or slot0.needArr[2])
	end

	slot0:onClick()
end

function slot0.sendExchange112Request(slot0)
	if slot0.state == 0 then
		UIBlockMgr.instance:startBlock("VersionActivityExchangeItem")

		if slot0._animatorPlayer then
			slot0._animatorPlayer:Play(UIAnimationName.Close, slot0.sendRequest, slot0)
		else
			slot0:sendRequest()
		end
	end

	gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, false)
end

function slot0.sendRequest(slot0)
	UIBlockMgr.instance:endBlock("VersionActivityExchangeItem")
	Activity112Rpc.instance:sendExchange112Request(slot0.config.activityId, slot0.config.id)
end

function slot0.onClick(slot0)
	slot0.selectFunc(slot0.selectFuncObj, slot0.config)
end

function slot0._editableInitView(slot0)
	slot0.rewardItemList = {}
	slot0.click = gohelper.findChildClick(slot0.go, "")

	slot0.click:AddClickListener(slot0.onClick, slot0)
	slot0._goselectedbg:LoadImage(ResUrl.getVersionActivityExchangeIcon("img_bg_jiangjilan_xuanzhong"))

	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.go)
	slot0._gorewardcontentcg = gohelper.findChild(slot0._gorewardcontent, "anim"):GetComponent(typeof(UnityEngine.CanvasGroup))
end

function slot0.setSelectFunc(slot0, slot1, slot2)
	slot0.selectFunc = slot1
	slot0.selectFuncObj = slot2
end

function slot0.updateSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot0.config.id == slot1)
	gohelper.setActive(slot0._imgiconbgselect.gameObject, slot0.config.id == slot1)
	gohelper.setActive(slot0._imgiconbgunselect.gameObject, slot0.config.id ~= slot1)
end

slot0.DefaultHeadOffsetX = 2.4
slot0.DefaultHeadOffsetY = -70.9

function slot0.updateItem(slot0, slot1, slot2, slot3)
	slot0.config = slot1
	slot0.needArr = string.splitToNumber(slot1.items, "#")

	slot0._imgheadicon:LoadImage(slot1.head)
	recthelper.setAnchor(slot0._imgheadicon.transform, string.splitToNumber(slot1.chatheadsOffSet, "#")[1] or uv0.DefaultHeadOffsetX, slot4[2] or uv0.DefaultHeadOffsetY)

	slot0.state = -1
	slot0.state = VersionActivity112Model.instance:getRewardState(slot0.config.activityId, slot0.config.id)

	for slot9, slot10 in ipairs(GameUtil.splitString2(slot1.bonus, true)) do
		if slot0.rewardItemList[slot9] == nil then
			slot11 = {
				go = gohelper.cloneInPlace(slot0._gorewarditem, "item" .. slot9)
			}
			slot11.icon = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot11.go, "go_iconroot"))
			slot0.rewardItemList[slot9] = slot11
		end

		slot11.icon:setMOValue(slot10[1], slot10[2], slot10[3])
		slot11.icon:isShowCount(true)
		slot11.icon:setScale(0.5, 0.5, 0.5)
		slot11.icon:setCountFontSize(52)
		gohelper.setActive(slot11.go, true)
		gohelper.setActive(gohelper.findChild(slot11.go, "go_finish"), slot0.state == 1)
	end

	for slot9 = #slot5 + 1, #slot0.rewardItemList do
		gohelper.setActive(slot0.rewardItemList[slot9].go, false)
	end

	slot0._gorewardcontentcg.alpha = slot0.state == 1 and 0.45 or 1

	gohelper.setActive(slot0._gofinish, slot0.state == 1)

	slot0._txtneed.text = slot0.needArr[3]

	slot0:updateNeed()
	slot0:updateLingqu()

	slot0._animator.enabled = true

	if slot3 then
		slot0._animator:Play(UIAnimationName.Open, 0, 0)
		slot0._animator:Update(0)

		if slot0._animator:GetCurrentAnimatorStateInfo(0).length <= 0 then
			slot7 = 1
		end

		slot0._animator:Play(UIAnimationName.Open, 0, -0.066 * (slot2 - 1) / slot7)
		slot0._animator:Update(0)
	else
		slot0._animator:Play(UIAnimationName.Open, 0, 1)
		slot0._animator:Update(0)
	end
end

function slot0.updateNeed(slot0)
	gohelper.setActive(slot0._gounfinishstate, ItemModel.instance:getItemQuantity(slot0.needArr[1], slot0.needArr[2]) < slot0.needArr[3])
	gohelper.setActive(slot0._gofinishstate, slot0.needArr[3] <= slot1)
end

function slot0.updateLingqu(slot0)
	slot1 = ItemModel.instance:getItemQuantity(slot0.needArr[1], slot0.needArr[2])

	gohelper.setActive(slot0._golingqu, true)
	gohelper.setActive(slot0._goget, slot0.state == 0 and slot0.needArr[3] <= slot1)
	gohelper.setActive(slot0._gounfinish, slot0.state == 0 and slot1 < slot0.needArr[3])
end

function slot0.onDestroyView(slot0)
	slot0.rewardItemList = nil

	slot0.click:RemoveClickListener()
	slot0._goselectedbg:UnLoadImage()
end

return slot0
