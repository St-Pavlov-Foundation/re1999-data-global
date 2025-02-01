module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryItem", package.seeall)

slot0 = class("Activity165StoryItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._simagepic = gohelper.findChildImage(slot0.viewGO, "#simage_pic")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._gostoryname = gohelper.findChild(slot0.viewGO, "#go_storyname")
	slot0._txtstoryname = gohelper.findChildText(slot0.viewGO, "#go_storyname/#txt_storyname")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "#go_reward")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_reward/#txt_num")
	slot0._btnreword = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_reward/#btn_reword")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnreword:AddClickListener(slot0._btnrewordOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnreword:RemoveClickListener()
end

function slot0._btnrewordOnClick(slot0)
	Activity165Controller.instance:dispatchEvent(Activity165Event.onClickOpenStoryRewardBtn, slot0._mo.storyId)
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0._btnclickOnClick(slot0)
	if slot0._mo and slot0._mo.isUnlock then
		Activity165Controller.instance:openActivity165EditView(slot0._mo.storyId)
	else
		GameFacade.showToast(ToastEnum.Act165StoryLock)
	end
end

function slot0._editableInitView(slot0)
	slot0._rewardCanClaim = gohelper.findChild(slot0.viewGO, "#go_reward/claim")
	slot0._rewardfinish = gohelper.findChild(slot0.viewGO, "#go_reward/finish")
	slot0._rewardReddot = gohelper.findChild(slot0.viewGO, "#go_reward/claim/go_reddot")
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.actId = Activity165Model.instance:getActivityId()

	slot0:onInitView()
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0._mo = slot1
	slot4 = slot1 and slot1:getAllEndingRewardCo()
	slot0.allRewordCount = slot4 and tabletool.len(slot4) or 0
	slot0._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act126_story_reword_count"), math.min(slot1 and slot1:getUnlockEndingCount() or 0, slot0.allRewordCount), slot0.allRewordCount)
	slot7 = slot1 and slot1:isFinish()

	if not (slot1 and slot1.isUnlock) then
		slot8 = (slot1 and slot1.storyCo and slot1.storyCo.pic or "v2a1_strangetale_pic" .. slot2) .. "_locked"
	end

	UISpriteSetMgr.instance:setV2a1Act165_2Sprite(slot0._simagepic, slot8, true)
	gohelper.setActive(slot0._gofinish.gameObject, false)
	slot0:refreshRewardState()

	slot0._txtstoryname.text = slot1 and slot1:getStoryName(63) or 0

	slot0:_playUnlock()
	RedDotController.instance:addRedDot(slot0._rewardReddot, RedDotEnum.DotNode.Act165HasReward, slot2)
end

function slot0.refreshRewardState(slot0)
	slot2 = slot0._mo and slot0._mo:getclaimRewardCount() or 0
	slot3 = slot0.allRewordCount <= slot2

	gohelper.setActive(slot0._rewardCanClaim.gameObject, slot2 < (slot0._mo and slot0._mo:getUnlockEndingCount() or 0) and not slot3)
	gohelper.setActive(slot0._rewardfinish.gameObject, slot3)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._playUnlock(slot0)
	if not slot0._mo then
		return
	end

	if slot0._mo.isUnlock and slot0._mo:isNewUnlock() then
		slot0._viewAnim:Play(Activity165Enum.StoryItemAnim.Unlock, 0, 0)
		slot0._mo:cancelNewUnlockStory()
	end
end

function slot0._checkUnlock(slot0)
	slot1 = slot0._mo and slot0._mo.isUnlock

	gohelper.setActive(slot0._goreward.gameObject, slot1)
	gohelper.setActive(slot0._gostoryname.gameObject, slot1)
end

return slot0
