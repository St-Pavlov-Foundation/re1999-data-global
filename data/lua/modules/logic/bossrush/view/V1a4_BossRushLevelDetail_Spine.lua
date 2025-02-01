module("modules.logic.bossrush.view.V1a4_BossRushLevelDetail_Spine", package.seeall)

slot0 = class("V1a4_BossRushLevelDetail_Spine", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._gospine = gohelper.findChild(slot1, "#go_spine")
	slot0._gospineTran = slot0._gospine.transform
	slot0._gospineX, slot0._gospineY = recthelper.getAnchor(slot0._gospineTran)
	slot0._uiSpine = GuiSpine.Create(slot0._gospine, false)
end

function slot0.setData(slot0, slot1)
	if FightConfig.instance:getSkinCO(slot1) then
		slot0._uiSpine:showModel()
		slot0._uiSpine:setResPath(ResUrl.getSpineUIPrefab(slot2.spine), slot0._onSpineLoaded, slot0, true)
	else
		slot0._uiSpine:hideModel()
	end
end

function slot0.setOffsetXY(slot0, slot1, slot2)
	recthelper.setAnchor(slot0._gospineTran, slot0._gospineX + (slot1 or 0), slot0._gospineY + (slot2 or 0))
end

function slot0.setScale(slot0, slot1)
	if not slot1 then
		return
	end

	transformhelper.setLocalScale(slot0._gospineTran, slot1, slot1, slot1)
end

function slot0.onDestroy(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:doClear()
	end

	slot0._uiSpine = nil
end

function slot0.onDestroyView(slot0)
	slot0:onDestroy()
end

return slot0
