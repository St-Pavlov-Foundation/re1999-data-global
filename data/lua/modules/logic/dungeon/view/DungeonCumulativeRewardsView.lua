module("modules.logic.dungeon.view.DungeonCumulativeRewardsView", package.seeall)

slot0 = class("DungeonCumulativeRewardsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightbg")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._txttipsinfo = gohelper.findChildText(slot0.viewGO, "#go_tips/#txt_tipsinfo")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_reward")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_content")
	slot0._gograyline = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_content/#go_grayline")
	slot0._gonormalline = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/#go_content/#go_normalline")
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "#go_target")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "progresstip/#txt_progress")
	slot0._simagetargetbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_target/#simage_targetbg")
	slot0._simagerightfademask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightfademask")
	slot0._simageleftfademask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftfademask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getDungeonIcon("full/guankajianlibiejing_038"))
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagetargetbg:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao"))
	slot0._simagerightfademask:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao2"))
	slot0._simageleftfademask:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao1"))
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollreward.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)

	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._scrollreward.gameObject, DungeonMapEpisodeAudio, slot0._scrollreward)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._scrollreward.gameObject)

	slot0._touch:AddClickDownListener(slot0._onClickDownHandler, slot0)
end

function slot0._onDragBeginHandler(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEndHandler(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onClickDownHandler(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0.onUpdateParam(slot0)
end

function slot0._getPointRewardRequest(slot0)
	if DungeonMapModel.instance:canGetRewardsList(slot0._maxChapterId) and #slot1 > 0 then
		slot0._getRewardLen = #slot1

		DungeonRpc.instance:sendGetPointRewardRequest(slot1)
	end
end

function slot0._onScrollChange(slot0, slot1)
	slot0:_showTarget()
	gohelper.setActive(slot0._simagerightfademask.gameObject, slot0._isNormalMode and slot0._scrollreward.horizontalNormalizedPosition < 1)
end

function slot0.onOpen(slot0)
	slot0._maxChapterId = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList].chapterId

	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnGetPointReward, slot0._onGetPointReward, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnGetPointRewardMaterials, slot0._onGetPointRewardMaterials, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.GuideGetPointReward, slot0._getPointRewardRequest, slot0)
	slot0._scrollreward:AddOnValueChanged(slot0._onScrollChange, slot0)

	if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		TaskDispatcher.runDelay(slot0._getPointRewardRequest, slot0, 0.6)
	end

	slot0:_showChapters()
	slot0:_showProgress()
	slot0:_moveCenter()
	slot0:_showTarget()
	NavigateMgr.instance:addEscape(ViewName.DungeonCumulativeRewardsView, slot0._btncloseOnClick, slot0)
end

function slot0._onGetPointRewardMaterials(slot0, slot1)
	slot0._rewardsMaterials = slot1
end

function slot0._showMaterials(slot0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot0._rewardsMaterials)
end

function slot0._onGetPointReward(slot0)
	if slot0._getRewardLen == 1 then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
	else
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_multiple)
	end

	slot0:_refreshItems()
	slot0:_showProgress()
	slot0:_showTarget()

	if slot0._rewardsMaterials then
		TaskDispatcher.cancelTask(slot0._showMaterials, slot0)
		TaskDispatcher.runDelay(slot0._showMaterials, slot0, 0.8)
	end
end

function slot0._refreshItems(slot0)
	for slot4, slot5 in ipairs(slot0._itemList) do
		slot5:refreshRewardItems(true)
	end
end

function slot0._showChapters(slot0)
	slot0._firstPosX = 145
	slot0._sliderBasePosx = 59.5
	slot0._posX = 0
	slot0._posY = -506.8
	slot0._deltaPosX = 335
	slot0._endNormalGap = 165
	slot0._endTargetGap = 280
	slot0._targetModeWidth = 1266
	slot0._normalModeWidth = 1630
	slot0._itemList = slot0:getUserDataTb_()
	slot0._itemMap = slot0:getUserDataTb_()

	recthelper.setAnchor(slot0._gograyline.transform, slot0._sliderBasePosx, slot0._posY)

	slot4 = slot0._posY

	recthelper.setAnchor(slot0._gonormalline.transform, slot0._sliderBasePosx, slot4)

	slot0._prevPointValue = 0

	for slot4 = 101, slot0._maxChapterId do
		slot0:_showChapter(slot4)
	end
end

function slot0._showChapter(slot0, slot1)
	slot3 = DungeonMapModel.instance:getRewardPointInfo()

	for slot7, slot8 in ipairs(DungeonConfig.instance:getChapterPointReward(slot1)) do
		slot10 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocontent, "item" .. slot8.id)
		slot12 = slot0._posX + (slot0._posX == 0 and slot0._firstPosX or slot0._deltaPosX)
		slot0._posX = slot12

		recthelper.setAnchor(slot10.transform, slot12, slot0._posY)
		recthelper.setWidth(slot0._gocontent.transform, slot0._posX)
		recthelper.setWidth(slot0._gograyline.transform, slot0._posX + slot0._sliderBasePosx)

		slot14 = MonoHelper.addLuaComOnceToGo(slot10, DungeonCumulativeRewardsItem, {
			slot1,
			slot8,
			false,
			slot0._posX,
			slot12,
			slot0._prevPointValue
		})

		table.insert(slot0._itemList, slot14)

		slot0._itemMap[slot8.id] = slot14
		slot0._prevPointValue = slot8.rewardPointNum
	end
end

function slot0._showTarget(slot0)
	slot1 = recthelper.getAnchorX(slot0._gocontent.transform)
	slot2 = recthelper.getWidth(slot0._scrollreward.transform)
	slot3, slot4 = nil
	slot5 = DungeonMapModel.instance:getRewardPointInfo()

	for slot9 = 101, slot0._maxChapterId do
		for slot14, slot15 in ipairs(DungeonConfig.instance:getChapterPointReward(slot9)) do
			if slot15.display > 0 and slot5.rewardPoint < slot15.rewardPointNum then
				slot4 = slot15

				if slot2 < slot0._itemMap[slot15.id].curPosX + slot1 then
					slot3 = slot15

					break
				end
			end
		end

		if slot3 then
			break
		end
	end

	slot0._isNormalMode = true

	if slot3 or slot4 then
		slot0._isNormalMode = false

		if slot0._targetItem then
			if slot0._targetItem.rewardId == slot3.id then
				return
			end

			slot0:_playTargetItemQuitAmim()

			slot0._targetItem = nil
		end

		recthelper.setWidth(slot0._scrollreward.transform, slot0._targetModeWidth)

		slot7 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gotarget, "item" .. slot3.id)

		gohelper.setActive(slot7, not slot0._unUseTargetItemGo)

		slot0._targetItem = MonoHelper.addLuaComOnceToGo(slot7, DungeonCumulativeRewardsItem, {
			nil,
			slot3,
			true
		})

		TaskDispatcher.cancelTask(slot0._showTargetItem, slot0)
		TaskDispatcher.runDelay(slot0._showTargetItem, slot0, 0.1)
		gohelper.setActive(slot0._gotarget, true)
		gohelper.setActive(slot0._simagerightfademask.gameObject, false)
	else
		gohelper.setActive(slot0._gotarget, false)
		recthelper.setWidth(slot0._scrollreward.transform, slot0._normalModeWidth)
	end

	recthelper.setWidth(slot0._gocontent.transform, slot0._posX + (slot0._isNormalMode and slot0._endNormalGap or slot0._endTargetGap))
	gohelper.setActive(slot0._simagerightfademask.gameObject, slot0._isNormalMode and slot0._scrollreward.horizontalNormalizedPosition < 1)
end

function slot0._playTargetItemQuitAmim(slot0)
	if not slot0._targetItem or not slot0._targetItem.viewGO then
		return
	end

	slot0._unUseTargetItemGo = slot0._targetItem.viewGO

	slot0._unUseTargetItemGo:GetComponent(typeof(UnityEngine.Animator)):Play("dungeoncumulativerewardsitem_switch_out")
	TaskDispatcher.cancelTask(slot0._destroyUnUseTargetItem, slot0)
	TaskDispatcher.runDelay(slot0._destroyUnUseTargetItem, slot0, 0.1)
end

function slot0._destroyUnUseTargetItem(slot0)
	if not slot0._unUseTargetItemGo then
		return
	end

	gohelper.destroy(slot0._unUseTargetItemGo)

	slot0._unUseTargetItemGo = nil
end

function slot0._showTargetItem(slot0)
	if not slot0._targetItem or not slot0._targetItem.viewGO then
		return
	end

	gohelper.setActive(slot0._targetItem.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_flip)
end

function slot0._showProgress(slot0)
	slot1 = DungeonMapModel.instance:getRewardPointInfo()

	for slot5, slot6 in ipairs(slot0._itemList) do
		if slot6.curPointValue <= slot1.rewardPoint then
			recthelper.setWidth(slot0._gonormalline.transform, slot6.curPosX - slot0._sliderBasePosx)
		elseif slot6.prevPointValue <= slot1.rewardPoint then
			slot8 = slot5 == 1 and slot0._sliderBasePosx or slot6.prevPosX

			recthelper.setWidth(slot0._gonormalline.transform, slot8 + (slot1.rewardPoint - slot6.prevPointValue) / (slot6.curPointValue - slot6.prevPointValue) * (slot6.curPosX - slot8) - slot0._sliderBasePosx)

			break
		end
	end

	if (slot0._itemList and #slot0._itemList or 0) > 0 and slot0._itemList[slot2].curPointValue <= slot1.rewardPoint then
		recthelper.setWidth(slot0._gonormalline.transform, recthelper.getWidth(slot0._gograyline.transform))
	end

	slot0._txtprogress.text = slot1.rewardPoint
end

function slot0._moveCenter(slot0)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0._itemList) do
		if DungeonMapModel.instance:getRewardPointInfo().rewardPoint < slot7.curPointValue then
			slot2 = slot7

			break
		end
	end

	recthelper.setAnchorX(slot0._gocontent.transform, -(slot2 or slot0._itemList[#slot0._itemList]).curPosX + recthelper.getWidth(slot0._scrollreward.transform) / 2)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._getPointRewardRequest, slot0)
	TaskDispatcher.cancelTask(slot0._destroyUnUseTargetItem, slot0)
	TaskDispatcher.cancelTask(slot0._showTargetItem, slot0)
	slot0._scrollreward:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(slot0._showMaterials, slot0)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.DelayGetPointReward, nil)
		logError("DungeonCumulativeRewardsView clear flag:DelayGetPointReward")
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simagetargetbg:UnLoadImage()
	slot0._simageleftfademask:UnLoadImage()
	slot0._simagerightfademask:UnLoadImage()

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()

		slot0._touch = nil
	end
end

return slot0
