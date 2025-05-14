module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnterView", package.seeall)

local var_0_0 = class("V1a6_CachotEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "right/#simage_rightbg/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "right/#simage_rightbg/#txt_desc")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "right/#txt_LimitTime")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/scroll_Reward")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "right/node/start")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "right/node/locked")
	arg_1_0._btnlocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/node/locked/#btn_locked")
	arg_1_0._gocontinue = gohelper.findChild(arg_1_0.viewGO, "right/node/continue")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "right/node/#go_reddot")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/node/start/#btn_start")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "right/node/locked/#txt_tips")
	arg_1_0._btncontinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/node/continue/#btn_continue")
	arg_1_0._btnabandon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/node/continue/#btn_abandon")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "right/node/continue/#go_progress")
	arg_1_0._simgeprogress = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/node/continue/#go_progress/icon")
	arg_1_0._txtprogress1 = gohelper.findChildText(arg_1_0.viewGO, "right/node/continue/#go_progress/#txt_progress1")
	arg_1_0._txtprogress2 = gohelper.findChildText(arg_1_0.viewGO, "right/node/continue/#go_progress/#txt_progress2")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "right/#go_reward")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "right/#go_reward/#txt_score")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_reward/#btn_reward")
	arg_1_0._gorewardreddot = gohelper.findChild(arg_1_0.viewGO, "right/#go_reward/#go_rewardreddot")
	arg_1_0._itemObjects = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, arg_2_0._refreshUI, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btncontinue:AddClickListener(arg_2_0._btncontinueOnClick, arg_2_0)
	arg_2_0._btnabandon:AddClickListener(arg_2_0._btnabandonOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, arg_3_0._refreshUI, arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnabandon:RemoveClickListener()
	arg_3_0._btncontinue:RemoveClickListener()
	arg_3_0._btnlocked:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
end

function var_0_0._btnabandonOnClick(arg_4_0)
	local function var_4_0()
		V1a6_CachotController.instance:abandonGame()
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox01, MsgBoxEnum.BoxType.Yes_No, var_4_0, nil, nil, arg_4_0)
end

function var_0_0._btnrewardOnClick(arg_6_0)
	V1a6_CachotController.instance:openV1a6_CachotProgressView()
end

function var_0_0._btnstartOnClick(arg_7_0)
	V1a6_CachotStatController.instance:statStart()
	V1a6_CachotController.instance:enterMap(false)
end

function var_0_0._btncontinueOnClick(arg_8_0)
	V1a6_CachotStatController.instance:statStart()
	V1a6_CachotController.instance:enterMap(false)
end

function var_0_0._editableInitView(arg_9_0)
	return
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	var_0_0.super.onOpen(arg_11_0)
	arg_11_0:_refreshUI()
	arg_11_0:_showLeftTime()
	RedDotController.instance:addRedDot(arg_11_0._goreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
	RedDotController.instance:addRedDot(arg_11_0._gorewardreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
end

function var_0_0._refreshUI(arg_12_0)
	local var_12_0 = ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId)

	arg_12_0.config = ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId)
	arg_12_0._txtdesc.text = arg_12_0.config.actDesc

	if var_12_0:isOpen() then
		local var_12_1 = ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId).openId
		local var_12_2 = var_12_1 and var_12_1 ~= 0 and OpenModel.instance:isFunctionUnlock(var_12_1)

		if var_12_2 then
			arg_12_0.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()

			local var_12_3 = arg_12_0.stateMo and arg_12_0.stateMo:isStart()

			if arg_12_0.stateMo and arg_12_0.stateMo.totalScore then
				arg_12_0._txtscore.text = arg_12_0.stateMo.totalScore
			end

			if var_12_3 then
				arg_12_0:refreshContinue()
			end

			gohelper.setActive(arg_12_0._gostart, not var_12_3)
			gohelper.setActive(arg_12_0._gocontinue, var_12_3)
			recthelper.setAnchorX(arg_12_0._goreward.transform, var_12_3 and 76 or 192)
		else
			local var_12_4 = OpenConfig.instance:getOpenCo(var_12_1).episodeId
			local var_12_5 = DungeonConfig.instance:getEpisodeDisplay(var_12_4)

			arg_12_0._txttips.text = formatLuaLang("dungeon_unlock_episode_mode", var_12_5)

			arg_12_0._btnlocked:AddClickListener(function()
				GameFacade.showToast(ToastEnum.DungeonMapLevel, var_12_5)
			end, arg_12_0)
			gohelper.setActive(arg_12_0._gostart, false)
			gohelper.setActive(arg_12_0._gocontinue, false)
		end

		gohelper.setActive(arg_12_0._golocked, not var_12_2)
		gohelper.setActive(arg_12_0._txttips.gameObject, not var_12_2)
		gohelper.setActive(arg_12_0._goreward, var_12_2)
	end

	arg_12_0:initRewards()

	arg_12_0._scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0.refreshContinue(arg_14_0)
	local var_14_0 = V1a6_CachotConfig.instance:getDifficultyConfig(arg_14_0.stateMo.difficulty)
	local var_14_1 = arg_14_0.stateMo.layer

	arg_14_0._simgeprogress:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_layerchange_level_" .. var_14_1))

	arg_14_0._txtprogress1.text = var_14_0.title
	arg_14_0._txtprogress2.text = V1a6_CachotRoomConfig.instance:getLayerName(arg_14_0.stateMo.layer, arg_14_0.stateMo.difficulty)
end

function var_0_0.initRewards(arg_15_0)
	local var_15_0 = GameUtil.splitString2(arg_15_0.config.activityBonus, true)

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_1 = arg_15_0._itemObjects[iter_15_0]

			if not var_15_1 then
				var_15_1 = IconMgr.instance:getCommonPropItemIcon(arg_15_0._gorewards)

				table.insert(arg_15_0._itemObjects, var_15_1)
			end

			var_15_1:setMOValue(iter_15_1[1], iter_15_1[2], 1)
			var_15_1:isShowCount(false)
		end
	end
end

function var_0_0._showLeftTime(arg_16_0)
	local var_16_0 = ActivityModel.instance:getRemainTimeSec(V1a6_CachotEnum.ActivityId)

	if var_16_0 then
		local var_16_1 = TimeUtil.SecondToActivityTimeFormat(var_16_0)

		arg_16_0._txtremaintime.text = var_16_1
	end
end

function var_0_0.everySecondCall(arg_17_0)
	arg_17_0:_showLeftTime()
end

function var_0_0.onClose(arg_18_0)
	var_0_0.super.onClose(arg_18_0)
	arg_18_0._simgeprogress:UnLoadImage()
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
