module("modules.spine.rolefaceeffect.CommonRoleFaceEffect", package.seeall)

slot0 = class("CommonRoleFaceEffect", BaseSpineRoleFaceEffect)

function slot0.init(slot0, slot1)
	slot0._config = slot1
	slot0._spineGo = slot0._spine._spineGo
	slot0._faceList = string.split(slot1.face, "|")
	slot0._nodeList = GameUtil.splitString2(slot1.node, false, "|", "#")
end

function slot0.showFaceEffect(slot0, slot1)
	slot0:_setNodeVisible(slot0._index, false)

	slot0._index = tabletool.indexOf(slot0._faceList, slot1)

	slot0:_setNodeVisible(slot0._index, true)
end

function slot0._setNodeVisible(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot7, slot8 in ipairs(slot0._nodeList[slot1]) do
		gohelper.setActive(gohelper.findChild(slot0._spineGo, slot8), slot2)
	end
end

function slot0.onDestroy(slot0)
	slot0._spineGo = nil
end

return slot0
