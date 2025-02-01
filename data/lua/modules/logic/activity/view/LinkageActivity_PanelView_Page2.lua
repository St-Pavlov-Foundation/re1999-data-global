module("modules.logic.activity.view.LinkageActivity_PanelView_Page2", package.seeall)

slot0 = class("LinkageActivity_PanelView_Page2", LinkageActivity_Page2)

function slot0.onInitView(slot0)
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "#txt_Descr")
	slot0._btnArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "Video/#btn_Arrow")
	slot0._simageIcon = gohelper.findChildSingleImage(slot0.viewGO, "Video/#simage_Icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnArrow:AddClickListener(slot0._btnArrowOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnArrow:RemoveClickListener()
end

slot1 = 2
slot2 = "switch"

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0._editableAddEvents(slot0)
	slot0._animEvent_video:AddEventListener(uv0, slot0._onSwitch, slot0)
	slot0._clickIcon:AddClickListener(slot0._onClickIcon, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._clickIcon:RemoveClickListener()
	slot0._animEvent_video:RemoveEventListener(uv0)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	for slot5, slot6 in ipairs(slot0:getDataList()) do
		slot0:addReward(slot5, gohelper.findChild(slot0.viewGO, "Reward/" .. slot5), LinkageActivity_Page2Reward)
	end

	slot2 = gohelper.findChild(slot0.viewGO, "Video")
	slot0._txtTips = gohelper.findChildText(slot2, "image_TipsBG/txt_Tips")

	slot0:addVideo(1, gohelper.findChild(slot2, "av/1"), LinkageActivity_Page2Video)
	slot0:addVideo(2, gohelper.findChild(slot2, "av/2"), LinkageActivity_Page2Video)

	slot0._clickIcon = gohelper.getClick(slot0._simageIcon.gameObject)
	slot0._anim_video = slot2:GetComponent(gohelper.Type_Animator)
	slot0._animEvent_video = gohelper.onceAddComponent(slot2, gohelper.Type_AnimationEventWrap)
	slot0._s_isReceiveGetian = ActivityType101Model.instance:isType101RewardGet(slot0:actId(), 1)

	slot0:setActive(false)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember_SImage(slot0, "_simageIcon")
	uv0.super.onDestroyView(slot0)
end

function slot0._btnArrowOnClick(slot0)
	slot0:selectedVideo(3 - slot0:_currentVideoIndex())
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
	slot0:selectedVideo(slot0:_currentVideoIndex())
end

function slot0.onSelectedVideo(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0._anim_video:Play(UIAnimationName.Idle, 0, 1)
		slot0:_refreshByIndex(slot1)

		return
	end

	slot0:_playAnim_switchTo(slot1)
end

function slot0._currentVideoIndex(slot0)
	return slot0:curVideoIndex() or uv0
end

function slot0._onClickIcon(slot0)
	slot2, slot3 = slot0:itemCo2TIQ(slot0:_getCurConfigIndex())

	MaterialTipController.instance:showMaterialInfo(slot2, slot3)
end

function slot0._playAnim_switchTo(slot0, slot1)
	slot0._anim_video:Play("switch" .. tostring(slot1), 0, 0)
end

function slot0._onSwitch(slot0)
	slot1 = slot0:_currentVideoIndex()

	slot0:getVideo(slot1):setAsLastSibling()
	slot0:_refreshByIndex(slot1)
end

function slot0._refreshByIndex(slot0, slot1)
	slot1 = slot0:_getCurConfigIndex(slot1)

	GameUtil.loadSImage(slot0._simageIcon, slot0:getItemIconResUrl(slot1))

	slot0._txtTips.text = slot0:getLinkageActivityCO_desc(slot1)
end

function slot0._onUpdateMO_videoList(slot0)
	assert(#slot0._videoItemList == 2)

	for slot5, slot6 in ipairs(slot0._videoItemList) do
		slot6:onUpdateMO({
			videoName = slot0:getLinkageActivityCO_res_video(slot0:_isReceiveGetian() and slot5 or 3 - slot5)
		})
	end
end

function slot0._isReceiveGetian(slot0)
	return slot0._s_isReceiveGetian
end

function slot0._selectedVideo_slient(slot0, slot1)
	slot0._curVideoIndex = slot1

	slot0:_onSwitch()
end

function slot0.onPostSelectedPage(slot0, slot1, slot2)
	if slot0 ~= slot1 then
		if slot0._s_isReceiveGetian and slot0._s_isReceiveGetian ~= ActivityType101Model.instance:isType101RewardGet(slot0:actId(), 1) then
			slot0._s_isReceiveGetian = slot3
		end

		slot0:_selectedVideo_slient(uv0)
	end

	uv1.super.onPostSelectedPage(slot0, slot1, slot2)
end

function slot0._getCurConfigIndex(slot0, slot1)
	slot1 = slot1 or slot0:_currentVideoIndex()

	return slot0:_isReceiveGetian() and slot1 or 3 - slot1
end

return slot0
