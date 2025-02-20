module("modules.logic.versionactivity1_2.dreamtail.view.Activity119RewardItem", package.seeall)

slot0 = class("Activity119RewardItem")

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.taskId = nil
	slot0.bonusCount = 0
	slot0.bonusItems = {}

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.onInitView(slot0)
	slot0._rewards = {}

	for slot4 = 1, 3 do
		slot0._rewards[slot4] = {
			_goreward = gohelper.findChild(slot0.go, "reward" .. slot4)
		}
		slot0._rewards[slot4]._bg = gohelper.findChild(slot0._rewards[slot4]._goreward, "bg")
		slot0._rewards[slot4]._itemposContent = gohelper.findChild(slot0._rewards[slot4]._goreward, "itemposContent")
		slot0._rewards[slot4]._state = gohelper.findChild(slot0._rewards[slot4]._goreward, "state")
		slot8 = slot0._rewards[slot4]._goreward
		slot0._rewards[slot4]._lockbg = gohelper.findChild(slot8, "lockbg")

		for slot8 = 1, 3 do
			slot0._rewards[slot4]["_itempos" .. slot8] = gohelper.findChild(slot0._rewards[slot4]._itemposContent, "itempos" .. slot8)
		end

		slot0._rewards[slot4]._goclaimed = gohelper.findChild(slot0._rewards[slot4]._state, "go_claimed")
		slot0._rewards[slot4]._goclaim = gohelper.findChild(slot0._rewards[slot4]._state, "go_claim")
		slot0._rewards[slot4]._golocked = gohelper.findChild(slot0._rewards[slot4]._state, "go_locked")
		slot0._rewards[slot4]._btnclaim = gohelper.findChildButtonWithAudio(slot0._rewards[slot4]._state, "go_claim")
		slot0._rewards[slot4]._canvasGroup = gohelper.onceAddComponent(slot0._rewards[slot4]._itemposContent, typeof(UnityEngine.CanvasGroup))

		gohelper.setActive(slot0._rewards[slot4]._goreward, false)
	end
end

function slot0.addEvents(slot0)
	for slot4 = 1, 3 do
		slot0._rewards[slot4]._btnclaim:AddClickListener(slot0.onTaskFinish, slot0)
	end
end

function slot0.removeEvents(slot0)
	for slot4 = 1, 3 do
		slot0._rewards[slot4]._btnclaim:RemoveClickListener()
	end
end

function slot0.setBonus(slot0, slot1, slot2, slot3)
	slot0.taskId = slot2

	if slot0.bonusCount ~= #GameUtil.splitString2(slot1, true) then
		if slot0.bonusCount > 0 then
			gohelper.setActive(slot0._rewards[slot0.bonusCount]._goreward, false)
		end

		slot9 = true

		gohelper.setActive(slot0._rewards[slot5]._goreward, slot9)

		for slot9 = slot5 + 1, slot0.bonusCount do
			gohelper.setActive(slot0.bonusItems[slot9].go, false)
		end

		for slot9 = 1, slot5 do
			if not slot0.bonusItems[slot9] then
				slot0.bonusItems[slot9] = IconMgr.instance:getCommonPropItemIcon(slot0._rewards[slot5]["_itempos" .. slot9])
			else
				gohelper.setActive(slot0.bonusItems[slot9].go, true)
				slot0.bonusItems[slot9].go.transform:SetParent(slot0._rewards[slot5]["_itempos" .. slot9].transform, false)
			end
		end

		slot0.bonusCount = slot5
	end

	slot6 = slot0._rewards[slot0.bonusCount]
	slot3 = true

	gohelper.setActive(slot6._bg, slot3)
	gohelper.setActive(slot6._itemposContent, slot3)
	gohelper.setActive(slot6._state, slot3)
	gohelper.setActive(slot6._lockbg, not slot3)

	if slot3 then
		for slot10 = 1, slot5 do
			slot11 = slot4[slot10]

			slot0.bonusItems[slot10]:setMOValue(slot11[1], slot11[2], slot11[3], nil, true)
			slot0.bonusItems[slot10]:setCountFontSize(48)
			slot0.bonusItems[slot10]:SetCountBgHeight(32)
		end
	end
end

function slot0.updateTaskStatus(slot0, slot1)
	gohelper.setActive(slot0._rewards[slot0.bonusCount]._goclaimed, slot1 == 3)
	gohelper.setActive(slot2._goclaim, slot1 == 2)
	gohelper.setActive(slot2._golocked, slot1 == 1)

	slot2._canvasGroup.alpha = slot1 == 3 and 0.7 or 1

	for slot6 = 1, #slot0.bonusItems do
		slot0.bonusItems[slot6]:setAlpha(slot1 == 3 and 0.5 or 1)
	end
end

function slot0.onTaskFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	TaskRpc.instance:sendFinishTaskRequest(slot0.taskId)
end

function slot0.dispose(slot0)
	slot0:removeEvents()

	slot0.go = nil
	slot0.bonusCount = 0

	for slot4 = 1, #slot0.bonusItems do
		slot0.bonusItems[slot4]:onDestroy()
	end

	slot0.bonusItems = nil

	for slot4 = 1, 3 do
		for slot8, slot9 in pairs(slot0._rewards[slot4]) do
			slot0._rewards[slot4][slot8] = nil
		end
	end

	slot0._rewards = nil
	slot0.taskId = nil
end

return slot0
