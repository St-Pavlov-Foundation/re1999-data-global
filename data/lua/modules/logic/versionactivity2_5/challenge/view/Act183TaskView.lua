module("modules.logic.versionactivity2_5.challenge.view.Act183TaskView", package.seeall)

slot0 = class("Act183TaskView", BaseView)
slot1 = {
	[Act183Enum.TaskType.Daily] = {
		"#D2D0D0",
		"v2a5_challenge_reward_btn1_1"
	},
	[Act183Enum.TaskType.NormalMain] = {
		"#D2D0D0",
		"v2a5_challenge_reward_btn2_1"
	},
	[Act183Enum.TaskType.HardMain] = {
		"#C14A3E",
		"v2a5_challenge_reward_btn3_1"
	}
}
slot2 = {
	[Act183Enum.TaskType.Daily] = {
		"#9B9899",
		"v2a5_challenge_reward_btn1_2"
	},
	[Act183Enum.TaskType.NormalMain] = {
		"#9B9899",
		"v2a5_challenge_reward_btn2_2"
	},
	[Act183Enum.TaskType.HardMain] = {
		"#873D30",
		"v2a5_challenge_reward_btn3_2"
	}
}
slot3 = 740
slot4 = 893
slot5 = -106
slot6 = -25

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._gocategorys = gohelper.findChild(slot0.viewGO, "root/left/#go_categorys")
	slot0._gocategoryitem = gohelper.findChild(slot0.viewGO, "root/left/#go_categorys/#go_categoryitem")
	slot0._scrolltask = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#scroll_task")
	slot0._goonekeypos = gohelper.findChild(slot0.viewGO, "root/right/#go_onekeypos")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._onFinishTask, slot0)

	slot0._taskTypes = {
		Act183Enum.TaskType.Daily,
		Act183Enum.TaskType.NormalMain,
		Act183Enum.TaskType.HardMain
	}
	slot0._defaultSelectTaskType = slot0._taskTypes[1]
	slot0._taskTitleMap = {
		[Act183Enum.TaskType.Daily] = luaLang("act183taskview_dailytask"),
		[Act183Enum.TaskType.NormalMain] = luaLang("act183taskview_normalmaintask"),
		[Act183Enum.TaskType.HardMain] = luaLang("act183taskview_hardmaintask")
	}
	slot0._categoryItemTab = slot0:getUserDataTb_()
	Act183TaskListModel.instance.startFrameCount = UnityEngine.Time.frameCount
end

function slot0._onFinishTask(slot0)
	Act183TaskListModel.instance:refresh()
	slot0:initOrRefreshOneKeyTaskItem()
	slot0:refreshAllCategoryItemReddot()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenTaskView)
	slot0:initInfo()
	slot0:refresh()
end

function slot0.refresh(slot0)
	Act183TaskListModel.instance:init(slot0._activityId, slot0._selectTaskType)
	slot0:_initCategorys()
	slot0:initOrRefreshOneKeyTaskItem()
end

function slot0.initInfo(slot0)
	if slot0.viewParam then
		slot0._selectGroupType = slot0.viewParam.selectGroupType
		slot0._selectGroupId = slot0.viewParam.selectGroupId

		if slot0._selectGroupType then
			slot0._selectTaskType = Act183Enum.GroupTypeToTaskType[slot0._selectGroupType]
		end
	end

	slot0._selectTaskType = slot0._selectTaskType or slot0._defaultSelectTaskType
	slot0._activityId = Act183Model.instance:getActivityId()
end

function slot0.initOrRefreshOneKeyTaskItem(slot0)
	slot2 = Act183TaskListModel.instance:getOneKeyTaskItem() ~= nil

	if slot0._oneKeyTaskItem then
		gohelper.setActive(slot0._oneKeyTaskItem.go, false)
	end

	recthelper.setHeight(slot0._scrolltask.transform, slot2 and uv0 or uv1)
	recthelper.setAnchorY(slot0._scrolltask.transform, slot2 and uv2 or uv3)

	if not slot2 then
		return
	end

	if not slot0._oneKeyTaskItem then
		slot0._oneKeyTaskItem = MonoHelper.addLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[3], slot0._goonekeypos), Act183TaskOneKeyItem)
		slot0._oneKeyTaskItem._index = 1
	end

	gohelper.setActive(slot0._oneKeyTaskItem.go, true)
	slot0._oneKeyTaskItem:onUpdateMO(slot1)
end

function slot0.onOpenFinish(slot0)
	slot0:focusTargetGroupTasks()
end

function slot0.focusTargetGroupTasks(slot0)
	if slot0._selectGroupType ~= Act183Enum.TaskType.Daily or not slot0._selectGroupId then
		return
	end

	slot1 = 0
	slot3 = false

	for slot7, slot8 in ipairs(Act183TaskListModel.instance:getList()) do
		slot9 = Act183Enum.TaskItemHeightMap[slot8.type] or 0
		slot10 = slot8.data and slot8.data.config

		if slot8.type == Act183Enum.TaskListItemType.Head and slot10 ~= nil and slot10.groupId == slot0._selectGroupId then
			slot3 = true

			break
		end

		slot1 = slot1 + slot9
	end

	slot0:setTaskVerticalScrollPixel(slot3 and slot1 or 0)
end

function slot0.setTaskVerticalScrollPixel(slot0, slot1)
	if slot0.viewContainer:getTaskScrollView() and slot2:getCsScroll() then
		slot3.VerticalScrollPixel = slot1
	end
end

function slot0._initCategorys(slot0)
	for slot4, slot5 in ipairs(slot0._taskTypes) do
		slot6 = slot0:_getOrCreateCategoryItem(slot4)
		slot6.txtselecttitle.text = slot0._taskTitleMap[slot5]
		slot6.txtunselecttitle.text = slot0._taskTitleMap[slot5]
		slot6.reddot = RedDotController.instance:addRedDot(slot6.goreddot, RedDotEnum.DotNode.V2a5_Act183Task, slot5, slot0._categoryReddotOverrideFunc, slot5)
		slot7 = slot5 == slot0._selectTaskType

		gohelper.setActive(slot6.goselect, slot7)
		gohelper.setActive(slot6.gounselect, not slot7)
		gohelper.setActive(slot6.viewGO, true)

		slot8 = uv0[slot5]
		slot9 = uv1[slot5]

		SLFramework.UGUI.GuiHelper.SetColor(slot6.txtselecttitle, slot8[1])
		SLFramework.UGUI.GuiHelper.SetColor(slot6.txtunselecttitle, slot9[1])
		UISpriteSetMgr.instance:setChallengeSprite(slot6.imageselectbg, slot8[2])
		UISpriteSetMgr.instance:setChallengeSprite(slot6.imageunselectbg, slot9[2])
		gohelper.setActive(slot6.goselect_normaleffect, slot7 and slot5 ~= Act183Enum.TaskType.HardMain)
		gohelper.setActive(slot6.goselect_hardeffect, slot7 and slot5 == Act183Enum.TaskType.HardMain)
	end
end

function slot0._categoryReddotOverrideFunc(slot0, slot1)
	slot2 = false

	if Act183TaskListModel.instance:getTaskMosByType(slot0) then
		for slot7, slot8 in ipairs(slot3) do
			if Act183Helper.isTaskCanGetReward(slot8.id) then
				slot2 = true

				break
			end
		end
	end

	slot1.show = slot2

	slot1:showRedDot(RedDotEnum.Style.Normal)
end

function slot0.refreshAllCategoryItemReddot(slot0)
	for slot4, slot5 in ipairs(slot0._taskTypes) do
		slot0:_getOrCreateCategoryItem(slot4).reddot:refreshDot()
	end
end

function slot0._getOrCreateCategoryItem(slot0, slot1)
	if not slot0._categoryItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._gocategoryitem, "categoryitem_" .. slot1)
		slot2.goselect = gohelper.findChild(slot2.viewGO, "go_select")
		slot2.gounselect = gohelper.findChild(slot2.viewGO, "go_unselect")
		slot2.imageselectbg = gohelper.findChildImage(slot2.viewGO, "go_select/bg")
		slot2.imageunselectbg = gohelper.findChildImage(slot2.viewGO, "go_unselect/bg")
		slot2.txtselecttitle = gohelper.findChildText(slot2.viewGO, "go_select/txt_title")
		slot2.txtunselecttitle = gohelper.findChildText(slot2.viewGO, "go_unselect/txt_title")
		slot2.goreddot = gohelper.findChild(slot2.viewGO, "go_reddot")
		slot2.goselect_normaleffect = gohelper.findChild(slot2.viewGO, "go_select/vx_normal")
		slot2.goselect_hardeffect = gohelper.findChild(slot2.viewGO, "go_select/vx_hard")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._onClickCategoryItem, slot0, slot1)

		slot0._categoryItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onClickCategoryItem(slot0, slot1)
	if not slot0._taskTypes[slot1] or slot0._selectTaskType == slot2 then
		return
	end

	slot0._selectTaskType = slot2

	slot0:setTaskVerticalScrollPixel(0)
	slot0:refresh()
end

function slot0.relreaseAllCategoryItems(slot0)
	if slot0._categoryItemTab then
		for slot4, slot5 in pairs(slot0._categoryItemTab) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.playTaskItmeAnimation(slot0)
	if not slot0.viewContainer:getTaskScrollView() then
		return
	end
end

function slot0.onClose(slot0)
	slot0:relreaseAllCategoryItems()
end

function slot0.onDestroyView(slot0)
end

return slot0
