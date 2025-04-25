module("modules.logic.room.entity.comp.RoomBuildingSummonComp", package.seeall)

slot0 = class("RoomBuildingSummonComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummonAnim, slot0._onStartSummonAnim, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, slot0._onDragEnd, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, slot0._onSummonSkip, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, slot0._onCloseGetCritter, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummonAnim, slot0._onStartSummonAnim, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onDragEnd, slot0._onDragEnd, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, slot0._onSummonSkip, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, slot0._onCloseGetCritter, slot0)
end

function slot0.onStart(slot0)
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

function slot0.getBuildingGOAnimatorPlayer(slot0)
	if not slot0._buildingGOAnimatorPlayer then
		slot0._buildingGOAnimatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.entity:getBuildingGO())
	end

	return slot0._buildingGOAnimatorPlayer
end

function slot0.getBuildingGOAnimator(slot0)
	if not slot0._buildingGOAnimator then
		slot0._buildingGOAnimator = slot0.entity:getBuildingGO():GetComponent(typeof(UnityEngine.Animator))
	end

	return slot0._buildingGOAnimator
end

function slot0._onStartSummonAnim(slot0, slot1)
	slot2 = slot1.mode
	slot0.mode = slot2
	slot3 = slot0:getBuildingGOAnimatorPlayer()

	function slot5()
		CritterSummonController.instance:onCanDrag()
	end

	if RoomSummonEnum.SummonMode[slot2].EntityAnimKey and slot3 then
		if slot2 == RoomSummonEnum.SummonType.Incubate then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan2)
		end

		slot3:Play(slot4.operatePre, slot5, slot0)
	else
		slot5()
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot3 = slot0:getBuildingGOAnimatorPlayer()

	function slot5()
		CritterSummonController.instance:onFinishSummonAnim(uv0)
	end

	if RoomSummonEnum.SummonMode[slot1].EntityAnimKey and slot3 then
		slot3:Play(slot4.operateEnd, function ()
			if uv0 then
				uv0:Play(uv1.rare[uv2], uv3, uv4)
			else
				uv3()
			end
		end, slot0)
	else
		slot5()
	end
end

function slot0._onSummonSkip(slot0)
	slot0:getBuildingGOAnimator():Play(RoomSummonEnum.SummonMode[slot0.mode].EntityAnimKey.operateEnd, 0, 1)
end

function slot0._onCloseGetCritter(slot0)
	if RoomSummonEnum.SummonType then
		for slot4, slot5 in pairs(RoomSummonEnum.SummonType) do
			if RoomSummonEnum.SummonMode[slot5] then
				slot0:_activeEggRoot(slot5, false)
			end
		end
	end
end

function slot0._activeEggRoot(slot0, slot1, slot2)
	if slot0:_getEggRoot(slot1) then
		gohelper.setActive(slot3, slot2)
	end
end

function slot0._getEggRoot(slot0, slot1)
	slot2 = RoomSummonEnum.SummonMode[slot1].EggRoot

	if not slot0._eggRoot then
		slot0._eggRoot = slot0:getUserDataTb_()
	end

	if slot2 then
		slot0._eggRoot[slot1] = gohelper.findChild(slot0.entity:getBuildingGO(), slot2)

		return slot0._eggRoot[slot1]
	end
end

return slot0
