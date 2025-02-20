module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryReviewView", package.seeall)

slot0 = class("Activity165StoryReviewView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._goendingnode = gohelper.findChild(slot0.viewGO, "#go_endingnode")
	slot0._goend1 = gohelper.findChild(slot0.viewGO, "#go_endingnode/#go_end1")
	slot0._goend2 = gohelper.findChild(slot0.viewGO, "#go_endingnode/#go_end2")
	slot0._goend3 = gohelper.findChild(slot0.viewGO, "#go_endingnode/#go_end3")
	slot0._goend4 = gohelper.findChild(slot0.viewGO, "#go_endingnode/#go_end4")
	slot0._goend5 = gohelper.findChild(slot0.viewGO, "#go_endingnode/#go_end5")
	slot0._goend6 = gohelper.findChild(slot0.viewGO, "#go_endingnode/#go_end6")
	slot0._btnstory1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_story1")
	slot0._btnstory2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_story2")
	slot0._btnstory3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Btn/#btn_story3")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstory1:AddClickListener(slot0._btnstory1OnClick, slot0)
	slot0._btnstory2:AddClickListener(slot0._btnstory2OnClick, slot0)
	slot0._btnstory3:AddClickListener(slot0._btnstory3OnClick, slot0)
	slot0._animationEvent:AddEventListener(Activity165Enum.ReviewViewAnim.Switch, slot0.switchAnimCB, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstory1:RemoveClickListener()
	slot0._btnstory2:RemoveClickListener()
	slot0._btnstory3:RemoveClickListener()

	slot4 = Activity165Enum.ReviewViewAnim.Switch

	slot0._animationEvent:RemoveEventListener(slot4)

	for slot4, slot5 in pairs(slot0._endingItem) do
		slot5.btn:RemoveClickListener()
	end
end

function slot0._btnstory1OnClick(slot0)
	slot0:_switchAnim(1)
end

function slot0._btnstory2OnClick(slot0)
	slot0:_switchAnim(2)
end

function slot0._btnstory3OnClick(slot0)
	slot0:_switchAnim(3)
end

function slot0._editableInitView(slot0)
	slot0._btnState = slot0:getUserDataTb_()

	for slot5, slot6 in pairs(Activity165Model.instance:getAllActStory()) do
		slot7 = gohelper.findChild(slot0.viewGO, "Btn/#btn_story" .. slot5 .. "/selectbg")
		slot8 = gohelper.findChild(slot0.viewGO, "Btn/#btn_story" .. slot5 .. "/normalbg")
		slot0._btnState[slot5] = {
			select = slot7,
			normal = slot8
		}
		gohelper.findChildText(slot7, "txt_story").text = slot6:getStoryName()
		gohelper.findChildText(slot8, "txt_story").text = slot6:getStoryName()
	end

	slot0._endingItem = slot0:getUserDataTb_()

	for slot5 = 1, 6 do
		slot6 = gohelper.findChildImage(slot0.viewGO, "#go_endingnode/#go_end" .. slot5)
		slot0._endingItem[slot5] = {
			icon = slot6,
			unlock = gohelper.findChild(slot6.gameObject, "#unlock"),
			btn = gohelper.findChildButtonWithAudio(slot6.gameObject, "btn")
		}
	end

	slot0._viewAnim = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._animationEvent = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._actId = Activity165Model.instance:getActivityId()
	slot0._enterView = slot0.viewParam.view

	slot0:_onShowEnding(slot0.viewParam.storyId)
	slot0:_activeTagBtn()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._onShowEnding(slot0, slot1)
	slot0._pageIndex = slot1

	for slot5, slot6 in pairs(slot0._btnState) do
		gohelper.setActive(slot6.select, slot5 == slot1)
		gohelper.setActive(slot6.normal, slot5 ~= slot1)
	end

	slot6 = slot1
	slot0._mo = Activity165Model.instance:getStoryMo(slot0._actId, slot6)
	slot2 = 1

	for slot6, slot7 in pairs(slot0._mo.unlockEndings) do
		slot8 = slot0._endingItem[slot2]
		slot2 = slot2 + 1

		if not string.nilorempty(Activity165Config.instance:getEndingCo(slot0._actId, slot6).pic) then
			UISpriteSetMgr.instance:setV2a1Act165_2Sprite(slot8.icon, slot10)
		end

		slot8.btn:RemoveClickListener()
		slot8.btn:AddClickListener(function ()
			Activity165Controller.instance:openActivity165EditView(uv0, uv1)
		end, slot0)
		gohelper.setActive(slot8.icon.gameObject, true)

		slot12 = slot0:_isCanPlayUnlockAnim(slot6)

		gohelper.setActive(slot8.unlock.gameObject, slot12)

		if slot12 then
			AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_review)
		end
	end

	for slot8 = slot2, tabletool.len(Activity165Config.instance:getEndingCosByStoryId(slot0._actId, slot1)) do
		slot9 = slot0._endingItem[slot8]

		if not string.nilorempty("v2a1_strangetale_ending_locked") then
			UISpriteSetMgr.instance:setV2a1Act165_2Sprite(slot9.icon, slot10)
		end

		gohelper.setActive(slot9.icon.gameObject, true)
		slot9.btn:RemoveClickListener()
		slot9.btn:AddClickListener(function ()
			GameFacade.showToast(ToastEnum.Act165EndingLock)
		end, slot0)
	end

	for slot8 = slot4 + 1, #slot0._endingItem do
		gohelper.setActive(slot0._endingItem[slot8].icon.gameObject, false)
	end

	Activity165Model.instance:setEndingRedDot(slot1)

	if slot0._enterView then
		slot0._enterView:_checkRedDot()
	end
end

function slot0._isCanPlayUnlockAnim(slot0, slot1)
	if not slot0._mo or not slot1 then
		return false
	end

	if GameUtil.playerPrefsGetNumberByUserId(slot0:_playUnlockKey(slot1), 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(slot0:_playUnlockKey(slot1), 1)

		return true
	end
end

function slot0._activeTagBtn(slot0)
	slot2 = Activity165Model.instance
	slot4 = slot2

	for slot4 = 1, slot2.getStoryCount(slot4) do
		if slot0["_btnstory" .. slot4] then
			gohelper.setActive(slot7.gameObject, Activity165Model.instance:getStoryMo(slot0._actId, slot4) and slot5.isUnlock)
		end
	end
end

function slot0._playUnlockKey(slot0, slot1)
	return string.format("Activity165EndingItem_isUnlock_%s_%s_%s", slot0._actId, slot0._mo.storyId, slot1)
end

function slot0._switchAnim(slot0, slot1)
	if slot0._pageIndex == slot1 then
		return
	end

	slot0._pageIndex = slot1

	slot0._viewAnim:Play(Activity165Enum.ReviewViewAnim.Switch, nil, slot0)
end

function slot0.switchAnimCB(slot0)
	slot0:_onShowEnding(slot0._pageIndex)
end

return slot0
