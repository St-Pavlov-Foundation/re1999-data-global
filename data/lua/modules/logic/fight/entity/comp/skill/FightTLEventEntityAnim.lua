module("modules.logic.fight.entity.comp.skill.FightTLEventEntityAnim", package.seeall)

slot0 = class("FightTLEventEntityAnim")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._targetEntitys = nil

	if slot3[1] == "1" then
		slot0._targetEntitys = {}

		table.insert(slot0._targetEntitys, FightHelper.getEntity(slot1.fromId))
	elseif slot4 == "2" then
		slot0._targetEntitys = FightHelper.getSkillTargetEntitys(slot1)
	elseif slot4 == "3" then
		slot0._targetEntitys = {}

		table.insert(slot0._targetEntitys, FightHelper.getEntity(slot1.toId))
	elseif slot4 == "4" then
		slot0._targetEntitys = FightHelper.getSkillTargetEntitys(slot1)

		tabletool.removeValue(slot0._targetEntitys, FightHelper.getEntity(slot1.fromId))
	elseif not string.nilorempty(slot4) then
		if GameSceneMgr.instance:getCurScene().entityMgr:getUnit(SceneTag.UnitNpc, slot1.stepUid .. "_" .. slot4) then
			slot0._targetEntitys = {}

			table.insert(slot0._targetEntitys, slot7)
		else
			logError("找不到实体, id: " .. tostring(slot6))

			return
		end
	end

	slot0.setAnimEntityList = {}
	slot0._ani_path = nil
	slot0._leftPath = nil
	slot0._rightPath = nil
	slot0._loader = MultiAbLoader.New()
	slot0._revertSpinePosAndColor = slot3[5] == "1"

	if not string.nilorempty(slot3[2]) then
		slot0._ani_path = slot5

		slot0._loader:addPath(FightHelper.getEntityAniPath(slot5))
	end

	if not string.nilorempty(slot3[3]) then
		slot0._leftPath = slot5

		slot0._loader:addPath(FightHelper.getEntityAniPath(slot5))
	end

	if not string.nilorempty(slot3[4]) then
		slot0._rightPath = slot5

		slot0._loader:addPath(FightHelper.getEntityAniPath(slot5))
	end

	if #slot0._loader._pathList > 0 then
		slot0._loader:startLoad(slot0._onLoaded, slot0)
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_onFinish()
end

function slot0._onLoaded(slot0, slot1)
	if not slot0._targetEntitys then
		return
	end

	slot2 = {
		[FightEnum.EntitySide.EnemySide] = slot5
	}
	slot3 = {
		[FightEnum.EntitySide.EnemySide] = slot0._leftPath
	}

	if slot0._leftPath and slot0._loader:getAssetItem(FightHelper.getEntityAniPath(slot0._leftPath)) and slot4:GetResource(ResUrl.getEntityAnim(slot0._leftPath)) then
		slot5.legacy = true
	end

	if slot0._rightPath and slot0._loader:getAssetItem(FightHelper.getEntityAniPath(slot0._rightPath)) and slot4:GetResource(ResUrl.getEntityAnim(slot0._rightPath)) then
		slot2[FightEnum.EntitySide.MySide] = slot5
		slot3[FightEnum.EntitySide.MySide] = slot0._rightPath
		slot5.legacy = true
	end

	slot4 = nil

	if slot0._ani_path and slot0._loader:getAssetItem(FightHelper.getEntityAniPath(slot0._ani_path)) and slot5:GetResource(ResUrl.getEntityAnim(slot0._ani_path)) then
		slot4.legacy = true
	end

	slot0._animStateName = {}
	slot0._animCompList = {}

	for slot8, slot9 in ipairs(slot0._targetEntitys) do
		if not tabletool.indexOf(slot0.setAnimEntityList, slot9.id) and slot9.spine then
			if slot9.spine:getSpineGO() then
				slot12 = slot3[slot9:getSide()] or slot0._ani_path

				if slot2[slot9:getSide()] or slot4 then
					slot13 = gohelper.onceAddComponent(slot10, typeof(UnityEngine.Animation))

					table.insert(slot0._animCompList, slot13)
					table.insert(slot0._animStateName, slot12)

					slot13.enabled = true
					slot13.clip = slot11

					slot13:AddClip(slot11, slot12)

					if slot13.this:get(slot12) then
						slot14.speed = FightModel.instance:getSpeed()
					end

					slot13:Play()
					table.insert(slot0.setAnimEntityList, slot9.id)
					FightController.instance:dispatchEvent(FightEvent.TimelinePlayEntityAni, slot9.id, true)
				end
			else
				slot0.waitSpineList = slot0.waitSpineList or {}

				table.insert(slot0.waitSpineList, slot9.spine)
				FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0.onSpineLoaded, slot0)
			end
		end
	end

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
end

function slot0.onSpineLoaded(slot0, slot1)
	if not slot0.waitSpineList then
		return
	end

	for slot5, slot6 in ipairs(slot0.waitSpineList) do
		if slot6 == slot1 then
			slot0:_onLoaded()
			table.remove(slot0.waitSpineList, slot5)

			break
		end
	end

	if #slot0.waitSpineList < 1 then
		slot0:clearWaitSpine()
	end
end

function slot0._onUpdateSpeed(slot0)
	for slot4, slot5 in ipairs(slot0._animCompList) do
		if slot5.this:get(slot0._animStateName[slot4]) then
			slot6.speed = FightModel.instance:getSpeed()
		end
	end
end

function slot0._onFinish(slot0)
	slot0:dispose()
end

function slot0.reset(slot0)
	slot0:dispose()
end

function slot0.dispose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
	slot0:_clearLoader()
	slot0:_clearAnim()
	slot0:_resetEntitys()
	slot0:clearWaitSpine()
end

function slot0._clearAnim(slot0)
	if slot0._animCompList then
		for slot4, slot5 in ipairs(slot0._animCompList) do
			if not gohelper.isNil(slot5) then
				if slot5:GetClip(slot0._animStateName[slot4]) then
					slot5:RemoveClip(slot6)
				end

				if slot5.clip and slot5.clip.name == slot6 then
					slot5.clip = nil
				end

				slot5.enabled = false
			end
		end

		tabletool.clear(slot0._animCompList)

		slot0._animCompList = nil
	end
end

function slot0._resetEntitys(slot0)
	if slot0._targetEntitys then
		for slot4, slot5 in ipairs(slot0._targetEntitys) do
			ZProj.CharacterSetVariantHelper.Disable(slot5.spine and slot5.spine:getSpineGO())
			FightController.instance:dispatchEvent(FightEvent.TimelinePlayEntityAni, slot5.id, false)

			if slot0._revertSpinePosAndColor then
				transformhelper.setLocalPos(slot6.transform, 0, 0, 0)
			end
		end
	end

	slot0._targetEntitys = nil
end

function slot0._clearLoader(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0.clearWaitSpine(slot0)
	slot0.waitSpineList = nil

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0.onSpineLoaded, slot0)
end

return slot0
