module("modules.logic.explore.view.ExploreRewardView", package.seeall)

slot0 = class("ExploreRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._btnbox = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_box")
	slot0._txtprogress0 = gohelper.findChildTextMesh(slot0.viewGO, "#btn_box/#txt_progress")
	slot0._txtprogress1 = gohelper.findChildTextMesh(slot0.viewGO, "Top/title1/#txt_progress")
	slot0._txtprogress2 = gohelper.findChildTextMesh(slot0.viewGO, "Top/title2/#txt_progress")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbox:AddClickListener(slot0.openBoxView, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, slot0._onUpdateTaskList, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbox:RemoveClickListener()
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, slot0._onUpdateTaskList, slot0)
end

function slot0.openBoxView(slot0)
	ViewMgr.instance:openView(ViewName.ExploreBonusRewardView, slot0.viewParam)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	slot2, slot3, slot4, slot5, slot6, slot7 = ExploreSimpleModel.instance:getChapterCoinCount(slot0.viewParam.id)
	slot8 = slot2 == slot5
	slot9 = slot3 == slot6
	slot10 = slot4 == slot7
	slot0._txtprogress0.text = string.format("%d/%d", slot2, slot5)
	slot0._txtprogress1.text = string.format("%d/%d", slot4, slot7)
	slot0._txtprogress2.text = string.format("%d/%d", slot3, slot6)
	slot11 = {}

	for slot15 = 1, 2 do
		slot16 = ExploreTaskModel.instance:getTaskList(3 - slot15)

		for slot21, slot22 in pairs(ExploreConfig.instance:getTaskList(slot1.id, slot15)) do
			if TaskModel.instance:getTaskById(slot22.id) and slot22.maxProgress <= slot23.progress and slot23.finishCount == 0 then
				table.insert(slot11, slot22.id)
			end
		end

		slot16:setList(slot17)
	end

	if #slot11 > 0 then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Explore, nil, slot11)
	end
end

function slot0._onUpdateTaskList(slot0)
end

function slot0._setitem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildImage(slot1, "bottom/image_progresssilder")
	slot6 = gohelper.findChildImage(slot1, "bottom/bg")
	slot7 = gohelper.findChild(slot1, "icons")
	slot8 = gohelper.findChildButtonWithAudio(slot1, "btn_click")
	slot9 = GameUtil.splitString2(slot2.bonus, true)
	gohelper.findChildTextMesh(slot1, "bottom/txt_point").text = slot2.maxProgress
	slot12 = slot10 and slot10.finishCount > 0 or false
	slot13 = 1

	if slot2.maxProgress <= (TaskModel.instance:getTaskById(slot2.id) and slot10.progress or 0) then
		if slot3 == #slot0._taskList then
			slot13 = 1
		else
			if TaskModel.instance:getTaskById(slot0._taskList[slot3 + 1].id) then
				slot11 = slot15.progress or slot11
			end

			slot13 = Mathf.Clamp((slot11 - slot2.maxProgress) / (slot0._taskList[slot3 + 1].maxProgress - slot2.maxProgress), 0, 0.5) + 0.5
		end
	else
		slot13 = slot3 == 1 and slot11 / slot2.maxProgress * 0.5 or Mathf.Clamp((slot11 - slot0._taskList[slot3 - 1].maxProgress) / (slot2.maxProgress - slot0._taskList[slot3 - 1].maxProgress), 0.5, 1) - 0.5
	end

	slot4.fillAmount = slot13

	ZProj.UGUIHelper.SetColorAlpha(slot6, slot14 and 1 or 0.15)
	SLFramework.UGUI.GuiHelper.SetColor(slot5, slot14 and "#000000" or "#d2c197")
	slot0:addClickCb(slot8, slot0._getReward, slot0, slot2)
	gohelper.setActive(slot8, not slot12 and slot14)

	slot0._isGet = slot12

	gohelper.CreateObjList(slot0, slot0._setRewardItem, slot9, slot7, slot0._gorewarditemicon)
end

function slot0._setRewardItem(slot0, slot1, slot2, slot3)
	slot6 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot1, "go_icon"))

	slot6:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
	slot6:setCountFontSize(46)
	slot6:SetCountBgHeight(31)
	gohelper.setActive(gohelper.findChild(slot1, "go_receive"), slot0._isGet)
end

function slot0._getReward(slot0, slot1)
	TaskRpc.instance:sendFinishTaskRequest(slot1.id)
end

return slot0
