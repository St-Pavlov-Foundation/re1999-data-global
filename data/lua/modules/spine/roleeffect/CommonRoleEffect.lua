module("modules.spine.roleeffect.CommonRoleEffect", package.seeall)

slot0 = class("CommonRoleEffect", BaseSpineRoleEffect)

function slot0.init(slot0, slot1)
	slot0._roleEffectConfig = slot1
	slot0._spineGo = slot0._spine._spineGo
	slot0._motionList = string.split(slot1.motion, "|")
	slot0._nodeList = GameUtil.splitString2(slot1.node, false, "|", "#")
	slot0._firstShow = false
	slot0._showEverEffect = false
	slot0._effectVisible = false
end

function slot0.isShowEverEffect(slot0)
	return slot0._showEverEffect
end

function slot0.showBodyEffect(slot0, slot1, slot2, slot3)
	slot0._effectVisible = false

	slot0:_setNodeVisible(slot0._index, false)

	slot0._index = tabletool.indexOf(slot0._motionList, slot1)

	slot0:_setNodeVisible(slot0._index, true)

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

function slot0._delayShowEverNodes(slot0)
	slot0:showEverNodes(true)
end

function slot0.showEverNodes(slot0, slot1)
	if string.nilorempty(slot0._roleEffectConfig.everNode) or not slot0._spineGo then
		return
	end

	if slot0._spine._resPath and not string.find(slot2, slot0._roleEffectConfig.heroResName .. ".prefab") then
		return
	end

	for slot7, slot8 in ipairs(string.split(slot0._roleEffectConfig.everNode, "#")) do
		slot9 = gohelper.findChild(slot0._spineGo, slot8)

		gohelper.setActive(slot9, slot1)

		slot0._showEverEffect = true

		if not slot9 and SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("%s找不到特效节点：%s,请检查路径", slot2, slot8))
		end
	end
end

function slot0._setNodeVisible(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot7, slot8 in ipairs(slot0._nodeList[slot1]) do
		slot9 = gohelper.findChild(slot0._spineGo, slot8)

		gohelper.setActive(slot9, slot2)

		if not slot9 and SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("%s找不到特效节点：%s,请检查路径", slot0._spine._resPath, slot8))
		end

		if slot2 then
			slot0._effectVisible = true
		end
	end
end

function slot0.playBodyEffect(slot0, slot1, slot2, slot3)
end

function slot0.onDestroy(slot0)
	slot0._spineGo = nil

	TaskDispatcher.cancelTask(slot0._delayShowEverNodes, slot0)
end

return slot0
