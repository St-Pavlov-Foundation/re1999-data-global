module("modules.logic.versionactivity.view.VersionActivityMainView", package.seeall)

slot0 = class("VersionActivityMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnenter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_enter")
	slot0._gostamp = gohelper.findChild(slot0.viewGO, "leftcontent/#go_stamp")
	slot0._txtstampNum = gohelper.findChildText(slot0.viewGO, "leftcontent/#go_stamp/#txt_stampNum")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "leftcontent/#go_stamp/#go_reddot")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftcontent/#btn_store")
	slot0._txtendtime = gohelper.findChildText(slot0.viewGO, "leftcontent/#txt_endtime")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnenter:AddClickListener(slot0._btnenterOnClick, slot0)
	slot0._btnstore:AddClickListener(slot0._btnstoreOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnenter:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
end

function slot0._btnenterOnClick(slot0)
	VersionActivityDungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0._btnstoreOnClick(slot0)
	VersionActivityController.instance:openLeiMiTeBeiStoreView()
end

function slot0.enterTaskView(slot0)
	VersionActivityController.instance:openLeiMiTeBeiTaskView()
end

function slot0._editableInitView(slot0)
	slot0.taskClick = gohelper.getClick(slot0._gostamp)

	slot0.taskClick:AddClickListener(slot0.enterTaskView, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshTaskUI, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshTaskUI()
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.LeiMiTeBeiTask)

	if ActivityModel.instance:getActivityInfo()[VersionActivityEnum.ActivityId.Act113] then
		slot0._txtendtime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity_baozhi_time"), {
			slot1:getEndTimeStr(),
			slot1:getRemainTimeStr()
		})
	end
end

function slot0.refreshTaskUI(slot0)
	slot0._txtstampNum.text = string.format("%s/%s", slot0:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount())
end

function slot0.getFinishTaskCount(slot0)
	slot0.finishTaskCount = 0
	slot1 = nil

	for slot5, slot6 in ipairs(lua_activity113_task.configList) do
		if TaskModel.instance:getTaskById(slot6.id) and slot6.maxFinishCount <= slot1.finishCount then
			slot0.finishTaskCount = slot0.finishTaskCount + 1
		end
	end

	return slot0.finishTaskCount
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.taskClick:RemoveClickListener()
end

return slot0
