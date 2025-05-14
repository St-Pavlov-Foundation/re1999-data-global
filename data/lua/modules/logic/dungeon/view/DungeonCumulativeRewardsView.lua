module("modules.logic.dungeon.view.DungeonCumulativeRewardsView", package.seeall)

local var_0_0 = class("DungeonCumulativeRewardsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txttipsinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_tipsinfo")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_reward")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_content")
	arg_1_0._gograyline = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_content/#go_grayline")
	arg_1_0._gonormalline = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_content/#go_normalline")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "#go_target")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "progresstip/#txt_progress")
	arg_1_0._simagetargetbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_target/#simage_targetbg")
	arg_1_0._simagerightfademask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightfademask")
	arg_1_0._simageleftfademask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftfademask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getDungeonIcon("full/guankajianlibiejing_038"))
	arg_5_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_5_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_5_0._simagetargetbg:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao"))
	arg_5_0._simagerightfademask:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao2"))
	arg_5_0._simageleftfademask:LoadImage(ResUrl.getDungeonIcon("bg_zhezhao1"))
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_main_eject)

	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0._scrollreward.gameObject)

	arg_5_0._drag:AddDragBeginListener(arg_5_0._onDragBeginHandler, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0._onDragEndHandler, arg_5_0)

	arg_5_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_5_0._scrollreward.gameObject, DungeonMapEpisodeAudio, arg_5_0._scrollreward)
	arg_5_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_5_0._scrollreward.gameObject)

	arg_5_0._touch:AddClickDownListener(arg_5_0._onClickDownHandler, arg_5_0)
end

function var_0_0._onDragBeginHandler(arg_6_0)
	arg_6_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_7_0)
	arg_7_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_8_0)
	arg_8_0._audioScroll:onClickDown()
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0._getPointRewardRequest(arg_10_0)
	local var_10_0 = DungeonMapModel.instance:canGetRewardsList(arg_10_0._maxChapterId)

	if var_10_0 and #var_10_0 > 0 then
		arg_10_0._getRewardLen = #var_10_0

		DungeonRpc.instance:sendGetPointRewardRequest(var_10_0)
	end
end

function var_0_0._onScrollChange(arg_11_0, arg_11_1)
	arg_11_0:_showTarget()
	gohelper.setActive(arg_11_0._simagerightfademask.gameObject, arg_11_0._isNormalMode and arg_11_0._scrollreward.horizontalNormalizedPosition < 1)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._maxChapterId = lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList].chapterId

	arg_12_0:addEventCb(DungeonController.instance, DungeonEvent.OnGetPointReward, arg_12_0._onGetPointReward, arg_12_0)
	arg_12_0:addEventCb(DungeonController.instance, DungeonEvent.OnGetPointRewardMaterials, arg_12_0._onGetPointRewardMaterials, arg_12_0)
	arg_12_0:addEventCb(DungeonController.instance, DungeonEvent.GuideGetPointReward, arg_12_0._getPointRewardRequest, arg_12_0)
	arg_12_0._scrollreward:AddOnValueChanged(arg_12_0._onScrollChange, arg_12_0)

	if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		TaskDispatcher.runDelay(arg_12_0._getPointRewardRequest, arg_12_0, 0.6)
	end

	arg_12_0:_showChapters()
	arg_12_0:_showProgress()
	arg_12_0:_moveCenter()
	arg_12_0:_showTarget()
	NavigateMgr.instance:addEscape(ViewName.DungeonCumulativeRewardsView, arg_12_0._btncloseOnClick, arg_12_0)
end

function var_0_0._onGetPointRewardMaterials(arg_13_0, arg_13_1)
	arg_13_0._rewardsMaterials = arg_13_1
end

function var_0_0._showMaterials(arg_14_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_14_0._rewardsMaterials)
end

function var_0_0._onGetPointReward(arg_15_0)
	if arg_15_0._getRewardLen == 1 then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
	else
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_multiple)
	end

	arg_15_0:_refreshItems()
	arg_15_0:_showProgress()
	arg_15_0:_showTarget()

	if arg_15_0._rewardsMaterials then
		TaskDispatcher.cancelTask(arg_15_0._showMaterials, arg_15_0)
		TaskDispatcher.runDelay(arg_15_0._showMaterials, arg_15_0, 0.8)
	end
end

function var_0_0._refreshItems(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._itemList) do
		iter_16_1:refreshRewardItems(true)
	end
end

function var_0_0._showChapters(arg_17_0)
	arg_17_0._firstPosX = 145
	arg_17_0._sliderBasePosx = 59.5
	arg_17_0._posX = 0
	arg_17_0._posY = -506.8
	arg_17_0._deltaPosX = 335
	arg_17_0._endNormalGap = 165
	arg_17_0._endTargetGap = 280
	arg_17_0._targetModeWidth = 1266
	arg_17_0._normalModeWidth = 1630
	arg_17_0._itemList = arg_17_0:getUserDataTb_()
	arg_17_0._itemMap = arg_17_0:getUserDataTb_()

	recthelper.setAnchor(arg_17_0._gograyline.transform, arg_17_0._sliderBasePosx, arg_17_0._posY)
	recthelper.setAnchor(arg_17_0._gonormalline.transform, arg_17_0._sliderBasePosx, arg_17_0._posY)

	arg_17_0._prevPointValue = 0

	for iter_17_0 = 101, arg_17_0._maxChapterId do
		arg_17_0:_showChapter(iter_17_0)
	end
end

function var_0_0._showChapter(arg_18_0, arg_18_1)
	local var_18_0 = DungeonConfig.instance:getChapterPointReward(arg_18_1)
	local var_18_1 = DungeonMapModel.instance:getRewardPointInfo()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_2 = arg_18_0.viewContainer:getSetting().otherRes[1]
		local var_18_3 = arg_18_0:getResInst(var_18_2, arg_18_0._gocontent, "item" .. iter_18_1.id)
		local var_18_4 = arg_18_0._posX
		local var_18_5 = arg_18_0._posX + (arg_18_0._posX == 0 and arg_18_0._firstPosX or arg_18_0._deltaPosX)

		arg_18_0._posX = var_18_5

		recthelper.setAnchor(var_18_3.transform, var_18_5, arg_18_0._posY)
		recthelper.setWidth(arg_18_0._gocontent.transform, arg_18_0._posX)

		local var_18_6 = arg_18_0._posX + arg_18_0._sliderBasePosx

		recthelper.setWidth(arg_18_0._gograyline.transform, var_18_6)

		local var_18_7 = MonoHelper.addLuaComOnceToGo(var_18_3, DungeonCumulativeRewardsItem, {
			arg_18_1,
			iter_18_1,
			false,
			var_18_4,
			var_18_5,
			arg_18_0._prevPointValue
		})

		table.insert(arg_18_0._itemList, var_18_7)

		arg_18_0._itemMap[iter_18_1.id] = var_18_7
		arg_18_0._prevPointValue = iter_18_1.rewardPointNum
	end
end

function var_0_0._showTarget(arg_19_0)
	local var_19_0 = recthelper.getAnchorX(arg_19_0._gocontent.transform)
	local var_19_1 = recthelper.getWidth(arg_19_0._scrollreward.transform)
	local var_19_2
	local var_19_3
	local var_19_4 = DungeonMapModel.instance:getRewardPointInfo()

	for iter_19_0 = 101, arg_19_0._maxChapterId do
		local var_19_5 = DungeonConfig.instance:getChapterPointReward(iter_19_0)

		for iter_19_1, iter_19_2 in ipairs(var_19_5) do
			if iter_19_2.display > 0 and var_19_4.rewardPoint < iter_19_2.rewardPointNum then
				var_19_3 = iter_19_2

				if var_19_1 < arg_19_0._itemMap[iter_19_2.id].curPosX + var_19_0 then
					var_19_2 = iter_19_2

					break
				end
			end
		end

		if var_19_2 then
			break
		end
	end

	var_19_2 = var_19_2 or var_19_3
	arg_19_0._isNormalMode = true

	if var_19_2 then
		arg_19_0._isNormalMode = false

		if arg_19_0._targetItem then
			if arg_19_0._targetItem.rewardId == var_19_2.id then
				return
			end

			arg_19_0:_playTargetItemQuitAmim()

			arg_19_0._targetItem = nil
		end

		recthelper.setWidth(arg_19_0._scrollreward.transform, arg_19_0._targetModeWidth)

		local var_19_6 = arg_19_0.viewContainer:getSetting().otherRes[1]
		local var_19_7 = arg_19_0:getResInst(var_19_6, arg_19_0._gotarget, "item" .. var_19_2.id)

		gohelper.setActive(var_19_7, not arg_19_0._unUseTargetItemGo)

		arg_19_0._targetItem = MonoHelper.addLuaComOnceToGo(var_19_7, DungeonCumulativeRewardsItem, {
			nil,
			var_19_2,
			true
		})

		TaskDispatcher.cancelTask(arg_19_0._showTargetItem, arg_19_0)
		TaskDispatcher.runDelay(arg_19_0._showTargetItem, arg_19_0, 0.1)
		gohelper.setActive(arg_19_0._gotarget, true)
		gohelper.setActive(arg_19_0._simagerightfademask.gameObject, false)
	else
		gohelper.setActive(arg_19_0._gotarget, false)
		recthelper.setWidth(arg_19_0._scrollreward.transform, arg_19_0._normalModeWidth)
	end

	local var_19_8 = arg_19_0._isNormalMode and arg_19_0._endNormalGap or arg_19_0._endTargetGap

	recthelper.setWidth(arg_19_0._gocontent.transform, arg_19_0._posX + var_19_8)
	gohelper.setActive(arg_19_0._simagerightfademask.gameObject, arg_19_0._isNormalMode and arg_19_0._scrollreward.horizontalNormalizedPosition < 1)
end

function var_0_0._playTargetItemQuitAmim(arg_20_0)
	if not arg_20_0._targetItem or not arg_20_0._targetItem.viewGO then
		return
	end

	arg_20_0._unUseTargetItemGo = arg_20_0._targetItem.viewGO

	arg_20_0._unUseTargetItemGo:GetComponent(typeof(UnityEngine.Animator)):Play("dungeoncumulativerewardsitem_switch_out")
	TaskDispatcher.cancelTask(arg_20_0._destroyUnUseTargetItem, arg_20_0)
	TaskDispatcher.runDelay(arg_20_0._destroyUnUseTargetItem, arg_20_0, 0.1)
end

function var_0_0._destroyUnUseTargetItem(arg_21_0)
	if not arg_21_0._unUseTargetItemGo then
		return
	end

	gohelper.destroy(arg_21_0._unUseTargetItemGo)

	arg_21_0._unUseTargetItemGo = nil
end

function var_0_0._showTargetItem(arg_22_0)
	if not arg_22_0._targetItem or not arg_22_0._targetItem.viewGO then
		return
	end

	gohelper.setActive(arg_22_0._targetItem.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_flip)
end

function var_0_0._showProgress(arg_23_0)
	local var_23_0 = DungeonMapModel.instance:getRewardPointInfo()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._itemList) do
		if iter_23_1.curPointValue <= var_23_0.rewardPoint then
			local var_23_1 = iter_23_1.curPosX - arg_23_0._sliderBasePosx

			recthelper.setWidth(arg_23_0._gonormalline.transform, var_23_1)
		elseif var_23_0.rewardPoint >= iter_23_1.prevPointValue then
			local var_23_2 = iter_23_1.curPointValue - iter_23_1.prevPointValue
			local var_23_3 = iter_23_0 == 1 and arg_23_0._sliderBasePosx or iter_23_1.prevPosX
			local var_23_4 = iter_23_1.curPosX - var_23_3
			local var_23_5 = var_23_3 + (var_23_0.rewardPoint - iter_23_1.prevPointValue) / var_23_2 * var_23_4 - arg_23_0._sliderBasePosx

			recthelper.setWidth(arg_23_0._gonormalline.transform, var_23_5)

			break
		end
	end

	local var_23_6 = arg_23_0._itemList and #arg_23_0._itemList or 0

	if var_23_6 > 0 and arg_23_0._itemList[var_23_6].curPointValue <= var_23_0.rewardPoint then
		local var_23_7 = recthelper.getWidth(arg_23_0._gograyline.transform)

		recthelper.setWidth(arg_23_0._gonormalline.transform, var_23_7)
	end

	arg_23_0._txtprogress.text = var_23_0.rewardPoint
end

function var_0_0._moveCenter(arg_24_0)
	local var_24_0 = DungeonMapModel.instance:getRewardPointInfo()
	local var_24_1

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._itemList) do
		if iter_24_1.curPointValue > var_24_0.rewardPoint then
			var_24_1 = iter_24_1

			break
		end
	end

	var_24_1 = var_24_1 or arg_24_0._itemList[#arg_24_0._itemList]

	local var_24_2 = recthelper.getWidth(arg_24_0._scrollreward.transform)

	recthelper.setAnchorX(arg_24_0._gocontent.transform, -var_24_1.curPosX + var_24_2 / 2)
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._getPointRewardRequest, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._destroyUnUseTargetItem, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._showTargetItem, arg_25_0)
	arg_25_0._scrollreward:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_25_0._showMaterials, arg_25_0)

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.DelayGetPointReward, nil)
		logError("DungeonCumulativeRewardsView clear flag:DelayGetPointReward")
	end
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0._simagebg:UnLoadImage()
	arg_26_0._simageleftbg:UnLoadImage()
	arg_26_0._simagerightbg:UnLoadImage()
	arg_26_0._simagetargetbg:UnLoadImage()
	arg_26_0._simageleftfademask:UnLoadImage()
	arg_26_0._simagerightfademask:UnLoadImage()

	if arg_26_0._drag then
		arg_26_0._drag:RemoveDragBeginListener()
		arg_26_0._drag:RemoveDragEndListener()

		arg_26_0._drag = nil
	end

	if arg_26_0._touch then
		arg_26_0._touch:RemoveClickDownListener()

		arg_26_0._touch = nil
	end
end

return var_0_0
