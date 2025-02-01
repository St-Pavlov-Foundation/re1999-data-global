module("modules.spine.roleeffect.CommonRoleEffect", package.seeall)

slot0 = class("CommonRoleEffect", BaseSpineRoleEffect)

function slot0.init(slot0, slot1)
	slot0._roleEffectConfig = slot1
	slot0._spineGo = slot0._spine._spineGo
	slot0._motionList = string.split(slot1.motion, "|")
	slot0._nodeList = GameUtil.splitString2(slot1.node, false, "|", "#")
end

function slot0.showBodyEffect(slot0, slot1, slot2, slot3)
	slot0._effectVisible = false

	slot0:_setNodeVisible(slot0._index, false)

	slot0._index = tabletool.indexOf(slot0._motionList, slot1)

	slot0:_setNodeVisible(slot0._index, true)

	if slot2 and slot3 then
		slot2(slot3, slot0._effectVisible)
	end
end

function slot0._setNodeVisible(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot7, slot8 in ipairs(slot0._nodeList[slot1]) do
		gohelper.setActive(gohelper.findChild(slot0._spineGo, slot8), slot2)

		if slot2 then
			slot0._effectVisible = true
		end
	end
end

function slot0.playBodyEffect(slot0, slot1, slot2, slot3)
end

function slot0.onDestroy(slot0)
	slot0._spineGo = nil
end

return slot0
