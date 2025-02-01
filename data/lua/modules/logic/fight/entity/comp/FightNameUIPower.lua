module("modules.logic.fight.entity.comp.FightNameUIPower", package.seeall)

slot0 = class("FightNameUIPower", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._parentView = slot1
	slot0._entity = slot0._parentView.entity
	slot0._powerId = slot2
	slot0._objList = slot0:getUserDataTb_()
	slot0._cloneComp = UICloneComponent.New()
	slot0._point_ani_sequence = {}
end

function slot0.onOpen(slot0)
	slot0._energyRoot = gohelper.findChild(slot0._parentView:getUIGO(), "layout/energy")
	slot0._eneryItem = gohelper.findChild(slot0._parentView:getUIGO(), "layout/energy/energyitem")

	slot0:_correctObjCount()
	slot0:_refreshUI()
	slot0:addEventCb(FightController.instance, FightEvent.PowerMaxChange, slot0._onPowerMaxChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PowerChange, slot0._onPowerChange, slot0)
end

function slot0._getPowerData(slot0)
	if slot0._entity:getMO() then
		return slot1:getPowerInfo(slot0._powerId)
	end
end

function slot0._refreshUI(slot0)
	if slot0:_getPowerData() then
		for slot5, slot6 in ipairs(slot0._objList) do
			gohelper.setActive(gohelper.findChild(slot6, "light"), slot5 <= slot1.num)
		end
	end
end

function slot0._onPowerMaxChange(slot0, slot1, slot2)
	if slot0._entity.id == slot1 and slot0._powerId == slot2 then
		slot0:_correctObjCount()
		slot0:_refreshUI()
	end
end

function slot0._onPowerChange(slot0, slot1, slot2, slot3, slot4)
	if slot0._entity.id == slot1 and slot0._powerId == slot2 and slot3 ~= slot4 then
		table.insert(slot0._point_ani_sequence, {
			slot3,
			slot4
		})

		if slot0._pointPlayType == 1 and slot3 < slot4 then
			slot0._change_ani_playing = nil
		elseif slot0._pointPlayType == 2 and slot4 < slot3 then
			slot0._change_ani_playing = nil
		end

		if not slot0._change_ani_playing then
			slot0:_playPointChangeAni()
		end
	end
end

slot1 = "open"
slot2 = "close"

function slot0._playPointChangeAni(slot0)
	if table.remove(slot0._point_ani_sequence, 1) then
		slot2 = slot1[1]
		slot3 = slot1[2]

		if slot0._entity and slot0._entity.id then
			if slot2 < slot3 then
				slot0._pointPlayType = 1

				slot0:_playAni(uv0, slot2, slot3)
			elseif slot3 < slot2 then
				slot0._pointPlayType = 2

				slot0:_playAni(uv1, slot2, slot3)
			end
		end
	else
		slot0._change_ani_playing = false
		slot0._pointPlayType = nil

		if slot0._entity and slot0._entity:getMO() then
			slot0:_refreshUI()
		end
	end
end

slot3 = {
	open = "energyitem_open",
	close = "energyitem_close"
}

function slot0._playAni(slot0, slot1, slot2, slot3)
	slot4 = nil

	for slot10 = math.min(slot2, slot3) + 1, math.max(slot2, slot3) do
		if slot0._objList[slot10] then
			gohelper.setActive(gohelper.findChild(slot11, "light"), true)

			slot13 = gohelper.onceAddComponent(slot11, typeof(UnityEngine.Animator))

			slot13:Play(slot1, 0, 0)

			slot13.speed = FightModel.instance:getSpeed()
			slot0._change_ani_playing = true
			slot4 = slot13
		end
	end

	TaskDispatcher.runDelay(slot0._playPointChangeAni, slot0, GameUtil.getMotionDuration(slot4, uv0[slot1]))
end

function slot0._correctObjCount(slot0)
	if slot0:_getPowerData() then
		gohelper.setActive(slot0._energyRoot, true)
		slot0._cloneComp:createObjList(slot0, slot0._onItemShow, slot1.max or 0, slot0._energyRoot, slot0._eneryItem)
	else
		gohelper.setActive(slot0._energyRoot, false)
	end
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator)):Play("idle", 0, 0)

	slot0._objList[slot3] = slot0._objList[slot3] or slot1
end

function slot0.releaseSelf(slot0)
	slot0._cloneComp:releaseSelf()
	slot0:__onDispose()
end

return slot0
