module("modules.spine.roleeffect.RoleEffect307904_6", package.seeall)

slot0 = class("RoleEffect307904_6", CommonRoleEffect)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._idleIndex = tabletool.indexOf(slot0._motionList, "b_idle")
	slot0._lightBodyList = {
		"b_idle",
		"b_diantou",
		"b_yaotou",
		"b_taishou"
	}
end

function slot0.showBodyEffect(slot0, slot1, slot2, slot3)
	slot0._effectVisible = false

	if slot0._index == slot0._idleIndex then
		if not tabletool.indexOf(slot0._lightBodyList, slot1) then
			slot0:_setNodeVisible(slot0._index, false)
		end
	else
		slot0:_setNodeVisible(slot0._index, false)
	end

	slot0._index = tabletool.indexOf(slot0._motionList, slot1)

	slot0:_setNodeVisible(slot0._index, true)

	if tabletool.indexOf(slot0._lightBodyList, slot1) then
		slot0:_setNodeVisible(slot0._idleIndex, true)
	end

	if not slot0._firstShow then
		slot0._firstShow = true

		slot0:showEverNodes(false)
		TaskDispatcher.cancelTask(slot0._delayShowEverNodes, slot0)
		TaskDispatcher.runDelay(slot0._delayShowEverNodes, slot0, 0.3)
	end

	if slot2 and slot3 then
		slot2(slot3, slot0._effectVisible or slot0._showEverEffect)
	end
end

return slot0
