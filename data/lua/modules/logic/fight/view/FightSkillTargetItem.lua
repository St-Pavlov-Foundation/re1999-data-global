module("modules.logic.fight.view.FightSkillTargetItem", package.seeall)

slot0 = class("FightSkillTargetItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._cardIcon = gohelper.findChildSingleImage(slot1, "icon")
end

function slot0.onUpdateMO(slot0, slot1)
	slot2 = FightDataHelper.entityMgr:getById(slot1)

	slot0._cardIcon:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot2.skin).retangleIcon))

	if slot2:isMonster() and lua_monster.configDict[slot2.modelId] and slot4.heartVariantId ~= 0 then
		slot0._cardImage = gohelper.findChildImage(slot0.go, "icon")

		IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(slot4.heartVariantId), slot0._cardImage)
	end
end

function slot0.onDestroy(slot0)
	slot0._cardIcon:UnLoadImage()
end

return slot0
