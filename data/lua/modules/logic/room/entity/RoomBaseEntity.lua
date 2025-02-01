module("modules.logic.room.entity.RoomBaseEntity", package.seeall)

slot0 = class("RoomBaseEntity", BaseUnitSpawn)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)
	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.luaMono = slot1:GetComponent(RoomEnum.ComponentType.LuaMonobehavier)
	slot0.__hasTaskOnEnabled = true

	TaskDispatcher.runDelay(slot0._onEnabledLuaMono, slot0, 0.01)
end

function slot0._onEnabledLuaMono(slot0)
	slot0.__hasTaskOnEnabled = false
	slot0.luaMono.enabled = false
end

function slot0.getCharacterMeshRendererList(slot0)
end

function slot0.getGameObjectListByName(slot0, slot1)
end

function slot0.playAudio(slot0, slot1)
	logNormal("当前接口未实现,需子类实现")
end

function slot0.getMainEffectKey(slot0)
	return RoomEnum.EffectKey.BuildingGOKey
end

function slot0.addComp(slot0, slot1, slot2)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.go, slot2, slot0)
	slot0[slot1] = slot3

	table.insert(slot0._compList, slot3)
end

function slot0.beforeDestroy(slot0)
	if slot0.__hasTaskOnEnabled then
		slot0.__hasTaskOnEnabled = false

		TaskDispatcher.cancelTask(slot0._onEnabledLuaMono, slot0)
	end

	if slot0:getCompList() then
		for slot5, slot6 in ipairs(slot1) do
			if slot6.beforeDestroy then
				slot6:beforeDestroy()
			end
		end
	end
end

return slot0
