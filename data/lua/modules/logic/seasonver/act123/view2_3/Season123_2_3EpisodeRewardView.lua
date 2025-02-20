module("modules.logic.seasonver.act123.view2_3.Season123_2_3EpisodeRewardView", package.seeall)

slot0 = class("Season123_2_3EpisodeRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._goRwards = gohelper.findChild(slot0.viewGO, "#go_rewards")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rewards/#btn_close")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "#go_rewards/#scroll_rewardview")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content")
	slot0._gofillbg = gohelper.findChild(slot0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_fillbg")
	slot0._gofill = gohelper.findChild(slot0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_fillbg/#go_fill")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_rewardContent")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "#go_rewards/#scroll_rewardview/Viewport/#go_Content/#go_rewardContent/#go_rewarditem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.OpenEpisodeRewardView, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshUI, slot0)
	slot0:removeEventCb(Season123Controller.instance, Season123Event.OpenEpisodeRewardView, slot0.refreshUI, slot0)
end

function slot0._btnCloseOnClick(slot0)
	slot0:resetView()
end

function slot0._editableInitView(slot0)
	slot0._rewardItems = slot0:getUserDataTb_()
	slot0._goContentHLayout = slot0._goContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.stage = slot0.viewParam.stage
	slot0.targetNumList = {}
end

function slot0.refreshUI(slot0)
	Season123EpisodeRewardModel.instance:init(slot0.actId, TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {})
	gohelper.setActive(slot0._goRwards, true)
	Season123EpisodeRewardModel.instance:setTaskInfoList(slot0.stage)

	slot0.itemList = Season123EpisodeRewardModel.instance:getList()

	slot0:initTargetNumList()

	slot2 = Season123Model.instance:getActInfo(slot0.actId):getStageMO(slot0.stage)
	slot0.stageMinRound = slot2.minRound
	slot0.stageIsPass = slot2.isPass
	slot0.defaultProgress = slot0.targetNumList[1] + 5
	slot0.curProgress = (slot0.stageMinRound == 0 or not slot0.stageIsPass) and slot0.defaultProgress or slot0.stageMinRound

	slot0:createAndRefreshRewardItem()
	slot0:refreshProgressBar()
	slot0:refreshScrollPos()
end

function slot0.createAndRefreshRewardItem(slot0)
	gohelper.CreateObjList(slot0, slot0.rewardItemShow, slot0.itemList, slot0._gorewardContent, slot0._gorewardItem)
end

function slot0.rewardItemShow(slot0, slot1, slot2, slot3)
	slot1.name = "rewardItem" .. slot3
	slot4 = gohelper.findChildTextMesh(slot1, "txt_score")
	slot7 = gohelper.findChild(slot1, "layout")

	gohelper.setActive(gohelper.findChild(slot1, "layout/go_reward"), false)

	slot9 = string.split(slot2.config.listenerParam, "#")
	slot4.text = slot9[2]

	SLFramework.UGUI.GuiHelper.SetColor(slot4, slot0.curProgress <= tonumber(slot9[2]) and "#E27F45" or "#9F9F9F")
	gohelper.setActive(gohelper.findChild(slot1, "darkpoint"), slot10 < slot0.curProgress)
	gohelper.setActive(gohelper.findChild(slot1, "lightpoint"), slot0.curProgress <= slot10)

	slot12 = GameUtil.splitString2(slot2.config.bonus, true, "|", "#")

	if not slot0._rewardItems[slot3] then
		slot11 = {
			[slot16] = slot18
		}

		for slot16, slot17 in ipairs(slot12) do
			slot18 = {
				itemGO = gohelper.cloneInPlace(slot8, "item" .. tostring(slot3))
			}
			slot18.goItemPos = gohelper.findChild(slot18.itemGO, "go_itempos")
			slot18.icon = IconMgr.instance:getCommonPropItemIcon(slot18.goItemPos)
			slot18.goHasGet = gohelper.findChild(slot18.itemGO, "go_hasget")
			slot18.goCanGet = gohelper.findChild(slot18.itemGO, "go_canget")
			slot18.btnCanGet = gohelper.findChildButtonWithAudio(slot18.itemGO, "go_canget")

			slot18.btnCanGet:AddClickListener(slot0.onItemGetClick, slot0)
			gohelper.setActive(slot18.itemGO, true)
			slot18.icon:setMOValue(slot17[1], slot17[2], slot17[3])
			slot18.icon:setHideLvAndBreakFlag(true)
			slot18.icon:hideEquipLvAndBreak(true)
			slot18.icon:setCountFontSize(51)
		end
	end

	slot0._rewardItems[slot3] = slot11

	for slot16, slot17 in pairs(slot11) do
		gohelper.setActive(slot17.goHasGet, slot2.config.maxFinishCount <= slot2.finishCount)
		gohelper.setActive(slot17.goCanGet, slot2.config.maxProgress <= slot2.progress and slot2.hasFinished)
	end
end

function slot0.onItemGetClick(slot0)
	if #Season123EpisodeRewardModel.instance:getCurStageCanGetReward() ~= 0 then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season123, 0, slot1, nil, , 0)
	end
end

function slot0.refreshProgressBar(slot0)
	slot1 = slot0._goContentHLayout.padding.left + 98
	slot2 = slot0._goContentHLayout.padding.right + 102 - 20
	slot3 = 40
	slot4 = 236
	slot5 = slot0.defaultProgress
	slot6 = 0
	slot7 = 0
	slot8 = 0
	slot9 = 0
	slot10 = 0

	for slot14, slot15 in ipairs(slot0.targetNumList) do
		if slot0.curProgress <= slot15 then
			slot6 = slot14
			slot7 = slot15
			slot8 = slot15
		elseif slot7 <= slot8 then
			slot8 = slot15
		end
	end

	if slot8 ~= slot7 then
		slot9 = (slot0.curProgress - slot7) / (slot8 - slot7)
	end

	slot10 = slot6 == 0 and (slot5 <= slot0.curProgress and slot1 / 2 or slot1 / 2 + (slot5 - slot0.curProgress) / (slot1 / 2)) or slot1 + slot6 * slot3 + (slot6 - 1) * slot4 + slot9 * slot4
	slot11 = #slot0.targetNumList
	slot0.totalWidth = math.max(1287, slot1 + (slot11 - 1) * slot4 + slot11 * slot3 + slot2)

	if slot6 == slot11 then
		slot10 = slot0.totalWidth
	end

	recthelper.setWidth(slot0._gofill.transform, slot10)
end

function slot0.initTargetNumList(slot0)
	if #slot0.targetNumList == 0 then
		for slot4, slot5 in pairs(slot0.itemList) do
			table.insert(slot0.targetNumList, tonumber(string.split(slot5.config.listenerParam, "#")[2]))
		end
	end
end

function slot0.refreshScrollPos(slot0)
	slot1 = 240
	slot2 = 36
	slot4 = recthelper.getWidth(slot0._scrollreward.transform)

	if slot0:getCurCanGetIndex() == nil or slot3 <= 0 then
		slot0._scrollreward.horizontalNormalizedPosition = 1
	else
		slot0._scrollreward.horizontalNormalizedPosition = Mathf.Clamp01(math.max(0, (slot3 - 0.5) * (slot1 + slot2)) / (slot0.totalWidth + 20 - slot4))
	end
end

function slot0.getCurCanGetIndex(slot0)
	for slot4, slot5 in pairs(slot0.itemList) do
		if slot5.config.maxProgress <= slot5.progress and slot5.hasFinished or slot5.finishCount < slot5.config.maxFinishCount then
			return slot4 - 1
		end
	end

	return nil
end

function slot0.resetView(slot0)
	gohelper.setActive(slot0._goRwards, false)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._rewardItems) do
		for slot9, slot10 in pairs(slot5) do
			slot10.btnCanGet:RemoveClickListener()
		end
	end
end

return slot0
