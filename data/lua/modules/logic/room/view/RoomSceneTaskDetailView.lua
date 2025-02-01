module("modules.logic.room.view.RoomSceneTaskDetailView", package.seeall)

slot0 = class("RoomSceneTaskDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotask1 = gohelper.findChild(slot0.viewGO, "taskContent/#go_task1")
	slot0._gotask2 = gohelper.findChild(slot0.viewGO, "taskContent/#go_task2")
	slot0._gotask3 = gohelper.findChild(slot0.viewGO, "taskContent/#go_task3")
	slot0._gotask4 = gohelper.findChild(slot0.viewGO, "taskContent/#go_task4")
	slot0._gotask5 = gohelper.findChild(slot0.viewGO, "taskContent/#go_task5")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.PageShowNum = 5

function slot0._editableInitView(slot0)
	slot0._itemObjs = {}
	slot0._bgmask = gohelper.findChildSingleImage(slot0.viewGO, "#bg_mask")
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._itemObjs) do
		if not gohelper.isNil(slot5.btntouch) then
			slot5.btntouch:RemoveClickListener()
		end

		if not gohelper.isNil(slot5.simagebonus) then
			slot5.simagebonus:UnLoadImage()
		end

		if slot4 == 1 then
			slot5.btnEdit:RemoveClickListener()
			slot5.btnExpansion:RemoveClickListener()
		end
	end
end

function slot0.onOpen(slot0)
	slot0._curPage = 1

	slot0:addEventCb(RoomSceneTaskController.instance, RoomEvent.TaskUpdate, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	for slot4 = 1, uv0.PageShowNum do
		slot0:refreshItem(slot4)
	end
end

function slot0.onClickTask(slot0)
	if not RoomTaskModel.instance:getShowList()[slot0.index + (slot0.self._curPage - 1) * uv0.PageShowNum] then
		return
	end

	if RoomTaskModel.instance:tryGetTaskMO(slot5.id) and slot2 == 1 then
		slot1:showMaterialInfoByTaskConfig(slot5)
	elseif slot5 then
		if RoomSceneTaskController.isTaskOverUnlockLevel(slot5) then
			GameFacade.showToast(ToastEnum.RoomTaskUnlock)
		else
			GameFacade.showToast(ToastEnum.RoomSceneTaskOpen, slot5.name)
		end
	end
end

function slot0.onClickJump(slot0)
	if RoomTaskModel.instance:getShowList() and #slot1 > 0 and RoomTaskModel.instance:tryGetTaskMO(slot1[1].id) and not RoomSceneTaskDetailController.instance:goToTask(slot2) then
		slot0:closeThis()
	end
end

function slot0.showMaterialInfoByTaskConfig(slot0, slot1)
	if #string.split(slot1.bonus, "|") > 0 then
		slot3 = string.splitToNumber(slot2[1], "#")
		slot4 = tonumber(slot3[1])
		slot5 = tonumber(slot3[2])
		slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot4, slot5)

		MaterialTipController.instance:showMaterialInfo(slot4, slot5, false, nil, true)
	end
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0._itemObjs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = slot0["_gotask" .. tostring(slot1)]
		slot2.gofinish = gohelper.findChild(slot2.go, "go_finish")
		slot2.gounfinish = gohelper.findChild(slot2.go, "go_unfinish")
		slot2.golock = gohelper.findChild(slot2.go, "go_unfinish/go_lock")
		slot2.txtlock = gohelper.findChildText(slot2.go, "go_unfinish/go_lock/txt_lock")
		slot2.gorunning = gohelper.findChild(slot2.go, "go_running")
		slot2.goorderbg = gohelper.findChild(slot2.go, "go_lightbg")
		slot2.txtid = gohelper.findChildText(slot2.go, "txt_id")

		if slot1 == 1 then
			slot2.goJump = gohelper.findChild(slot2.go, "#go_jump")
			slot2.txtnum = gohelper.findChildText(slot2.goJump, "txt_rewardnum")
			slot2.txtdesc = gohelper.findChildText(slot2.goJump, "txt_taskdesc")
			slot2.txtRunningTips = gohelper.findChildText(slot2.goJump, "txt_rewardtip")
			slot2.simagebonus = gohelper.findChildSingleImage(slot2.goJump, "simage_reward")
			slot2.imagebonus = gohelper.findChildImage(slot2.goJump, "simage_reward")
			slot2.btnEdit = gohelper.findChildButtonWithAudio(slot2.goJump, "btn_edit")
			slot2.btnExpansion = gohelper.findChildButtonWithAudio(slot2.goJump, "btn_expansion")
			slot2.btntouch = gohelper.findChildButtonWithAudio(slot2.goJump, "btn_touch")

			slot2.btnEdit:AddClickListener(slot0.onClickJump, slot0)
			slot2.btnExpansion:AddClickListener(slot0.onClickJump, slot0)
			gohelper.setActive(gohelper.findChild(slot2.go, "btn_touch"), false)
		else
			slot2.txtnum = gohelper.findChildText(slot2.go, "go_unfinish/txt_num")
			slot2.txtdesc = gohelper.findChildText(slot2.go, "go_unfinish/txt_desc")
			slot2.simagebonus = gohelper.findChildSingleImage(slot2.go, "go_unfinish/simage_build")
			slot2.imagebonus = gohelper.findChildImage(slot2.go, "go_unfinish/simage_build")
			slot2.btntouch = gohelper.findChildButtonWithAudio(slot2.go, "btn_touch")
		end

		slot2.btntouch:AddClickListener(slot0.onClickTask, {
			self = slot0,
			index = slot1
		})

		slot0._itemObjs[slot1] = slot2
	end

	return slot2
end

slot1 = Color.New(0.090196, 0.08627451, 0.08627451, 1)
slot2 = Color.New(0.8980392, 0.8980392, 0.8980392, 0.5)
slot3 = Color.New(0.5372549, 0.5215687, 0.5176471, 1)
slot4 = Color.New(0.8980392, 0.8980392, 0.8980392, 1)

function slot0.refreshItem(slot0, slot1)
	slot2 = slot0:getOrCreateItem(slot1)
	slot6 = nil

	if RoomTaskModel.instance:getShowList()[slot1 + (slot0._curPage - 1) * uv0.PageShowNum] then
		slot6 = RoomTaskModel.instance:tryGetTaskMO(slot5.id)
	end

	slot7 = false

	if slot6 and slot1 == 1 then
		slot0:refreshWhenRunning(slot2, slot6, slot5)

		slot7 = true
	elseif not slot5 then
		slot0:refreshWhenFinish(slot2)
	else
		slot0:refreshWhenLock(slot2, slot5)
	end

	if not gohelper.isNil(slot2.gorunning) then
		gohelper.setActive(slot2.gorunning, slot7)
	end
end

function slot0.refreshWhenRunning(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.gofinish, false)
	gohelper.setActive(slot1.gounfinish, false)
	gohelper.setActive(slot1.goJump, true)
	gohelper.setActive(slot1.golock, false)
	gohelper.setActive(slot1.goorderbg, true)

	slot1.txtdesc.text = string.format(slot2.hasFinished == true and "%s(%s/%s)" or "%s(<color=#b26161>%s</color>/%s)", slot3.desc, slot2.progress, slot3.maxProgress)

	slot0:setRewardIcon(slot3, slot1, true)

	slot5 = false
	slot6 = false
	slot7 = slot3.tips or ""

	if slot3.listenerType == RoomSceneTaskEnum.ListenerType.EditResArea or slot3.listenerType == RoomSceneTaskEnum.ListenerType.EditHasResBlockCount then
		slot6 = true
	elseif slot3.listenerType == RoomSceneTaskEnum.ListenerType.RoomLevel then
		slot5 = true
		slot8 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, RoomSceneTaskEnum.RoomLevelUpItem)
		slot9 = tostring(slot8)

		if slot8 > 0 then
			slot9 = string.format("<color=#ffffff>%s</color>", slot8)
		end

		if not string.nilorempty(slot7) then
			slot7 = string.format(slot7, slot9)
		end
	end

	if not string.nilorempty(slot7) then
		slot1.txtRunningTips.text = slot7

		gohelper.setActive(slot1.txtRunningTips, true)
	else
		gohelper.setActive(slot1.txtRunningTips, false)
	end

	gohelper.setActive(slot1.btnExpansion, slot5)
	gohelper.setActive(slot1.btnEdit, slot6)

	slot1.imagebonus.color = Color.white
	slot1.txtdesc.color = Color.white
	slot1.txtid.color = uv0
	slot1.txtid.text = slot3.order
end

function slot0.refreshWhenFinish(slot0, slot1)
	gohelper.setActive(slot1.gofinish, true)
	gohelper.setActive(slot1.gounfinish, false)
	gohelper.setActive(slot1.goorderbg, false)

	if slot1.goJump then
		gohelper.setActive(slot1.goJump, false)
	end

	slot1.txtid.text = ""
end

function slot0.refreshWhenLock(slot0, slot1, slot2)
	gohelper.setActive(slot1.gofinish, false)
	gohelper.setActive(slot1.gounfinish, true)
	gohelper.setActive(slot1.golock, true)
	gohelper.setActive(slot1.goorderbg, false)

	if slot1.goJump then
		gohelper.setActive(slot1.goJump, false)
	end

	slot1.txtdesc.text = slot2.desc

	if not gohelper.isNil(slot1.txtlock) then
		if RoomSceneTaskController.isTaskOverUnlockLevel(slot2) then
			slot1.txtlock.text = luaLang("room_task_lock_by_task")
		else
			slot1.txtlock.text = string.format(luaLang("room_task_lock_by_level"), RoomSceneTaskController.getTaskUnlockLevel(slot2.openLimit))
		end
	end

	slot0:setRewardIcon(slot2, slot1, false)

	slot1.imagebonus.color = uv0
	slot1.txtdesc.color = uv1
	slot1.txtid.color = uv2
	slot1.txtid.text = slot2.order
end

function slot0.setRewardIcon(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = RoomSceneTaskController.getRewardConfigAndIcon(slot1)

	if not string.nilorempty(slot1.bonusIcon) then
		slot5 = ResUrl.getRoomTaskBonusIcon(slot1.bonusIcon)
	end

	if not string.nilorempty(slot5) then
		slot2.simagebonus:LoadImage(slot5)
	end

	if slot6 and slot3 then
		gohelper.setActive(slot2.txtnum.gameObject, true)

		slot2.txtnum.text = tostring(GameUtil.numberDisplay(slot6))
	else
		gohelper.setActive(slot2.txtnum.gameObject, false)
	end
end

function slot0.getMaxPage(slot0)
	return math.ceil(#RoomTaskModel.instance:getShowList() / uv0.PageShowNum)
end

return slot0
