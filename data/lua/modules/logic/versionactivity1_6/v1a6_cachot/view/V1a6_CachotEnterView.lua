module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnterView", package.seeall)

slot0 = class("V1a6_CachotEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "right/#simage_rightbg/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "right/#simage_rightbg/#txt_desc")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "right/#txt_LimitTime")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "right/scroll_Reward")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "right/scroll_Reward/Viewport/#go_rewards")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "right/node/start")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "right/node/locked")
	slot0._btnlocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/node/locked/#btn_locked")
	slot0._gocontinue = gohelper.findChild(slot0.viewGO, "right/node/continue")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "right/node/#go_reddot")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/node/start/#btn_start")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "right/node/locked/#txt_tips")
	slot0._btncontinue = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/node/continue/#btn_continue")
	slot0._btnabandon = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/node/continue/#btn_abandon")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "right/node/continue/#go_progress")
	slot0._simgeprogress = gohelper.findChildSingleImage(slot0.viewGO, "right/node/continue/#go_progress/icon")
	slot0._txtprogress1 = gohelper.findChildText(slot0.viewGO, "right/node/continue/#go_progress/#txt_progress1")
	slot0._txtprogress2 = gohelper.findChildText(slot0.viewGO, "right/node/continue/#go_progress/#txt_progress2")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "right/#go_reward")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "right/#go_reward/#txt_score")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_reward/#btn_reward")
	slot0._gorewardreddot = gohelper.findChild(slot0.viewGO, "right/#go_reward/#go_rewardreddot")
	slot0._itemObjects = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, slot0._refreshUI, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btncontinue:AddClickListener(slot0._btncontinueOnClick, slot0)
	slot0._btnabandon:AddClickListener(slot0._btnabandonOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, slot0._refreshUI, slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btnabandon:RemoveClickListener()
	slot0._btncontinue:RemoveClickListener()
	slot0._btnlocked:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
end

function slot0._btnabandonOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox01, MsgBoxEnum.BoxType.Yes_No, function ()
		V1a6_CachotController.instance:abandonGame()
	end, nil, , slot0)
end

function slot0._btnrewardOnClick(slot0)
	V1a6_CachotController.instance:openV1a6_CachotProgressView()
end

function slot0._btnstartOnClick(slot0)
	V1a6_CachotStatController.instance:statStart()
	V1a6_CachotController.instance:enterMap(false)
end

function slot0._btncontinueOnClick(slot0)
	V1a6_CachotStatController.instance:statStart()
	V1a6_CachotController.instance:enterMap(false)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:_refreshUI()
	slot0:_showLeftTime()
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
	RedDotController.instance:addRedDot(slot0._gorewardreddot, RedDotEnum.DotNode.V1a6RogueRewardEnter)
end

function slot0._refreshUI(slot0)
	slot0.config = ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId)
	slot0._txtdesc.text = slot0.config.actDesc

	if ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId):isOpen() then
		if ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId).openId and slot4 ~= 0 and OpenModel.instance:isFunctionUnlock(slot4) then
			slot0.stateMo = V1a6_CachotModel.instance:getRogueStateInfo()
			slot6 = slot0.stateMo and slot0.stateMo:isStart()

			if slot0.stateMo and slot0.stateMo.totalScore then
				slot0._txtscore.text = slot0.stateMo.totalScore
			end

			if slot6 then
				slot0:refreshContinue()
			end

			gohelper.setActive(slot0._gostart, not slot6)
			gohelper.setActive(slot0._gocontinue, slot6)
			recthelper.setAnchorX(slot0._goreward.transform, slot6 and 76 or 192)
		else
			slot0._txttips.text = formatLuaLang("dungeon_unlock_episode_mode", DungeonConfig.instance:getEpisodeDisplay(OpenConfig.instance:getOpenCo(slot4).episodeId))

			slot0._btnlocked:AddClickListener(function ()
				GameFacade.showToast(ToastEnum.DungeonMapLevel, uv0)
			end, slot0)
			gohelper.setActive(slot0._gostart, false)
			gohelper.setActive(slot0._gocontinue, false)
		end

		gohelper.setActive(slot0._golocked, not slot5)
		gohelper.setActive(slot0._txttips.gameObject, not slot5)
		gohelper.setActive(slot0._goreward, slot5)
	end

	slot0:initRewards()

	slot0._scrollReward.horizontalNormalizedPosition = 0
end

function slot0.refreshContinue(slot0)
	slot0._simgeprogress:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_layerchange_level_" .. slot0.stateMo.layer))

	slot0._txtprogress1.text = V1a6_CachotConfig.instance:getDifficultyConfig(slot0.stateMo.difficulty).title
	slot0._txtprogress2.text = V1a6_CachotRoomConfig.instance:getLayerName(slot0.stateMo.layer, slot0.stateMo.difficulty)
end

function slot0.initRewards(slot0)
	if GameUtil.splitString2(slot0.config.activityBonus, true) then
		for slot5, slot6 in ipairs(slot1) do
			if not slot0._itemObjects[slot5] then
				table.insert(slot0._itemObjects, IconMgr.instance:getCommonPropItemIcon(slot0._gorewards))
			end

			slot7:setMOValue(slot6[1], slot6[2], 1)
			slot7:isShowCount(false)
		end
	end
end

function slot0._showLeftTime(slot0)
	if ActivityModel.instance:getRemainTimeSec(V1a6_CachotEnum.ActivityId) then
		slot0._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(slot1)
	end
end

function slot0.everySecondCall(slot0)
	slot0:_showLeftTime()
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
	slot0._simgeprogress:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
