module("modules.logic.bossrush.view.V1a4_BossRush_HeroGroupItemBase", package.seeall)

slot0 = class("V1a4_BossRush_HeroGroupItemBase", LuaCompBase)

function slot0._initGoList(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot5 = slot0[slot1 .. tostring(1)]

	while not gohelper.isNil(slot5) do
		slot2[slot3] = slot5
		slot5 = slot0[slot1 .. tostring(slot3 + 1)]
	end

	return slot2
end

function slot0.setData(slot0, slot1, slot2)
	slot0._heroMo = slot1
	slot0._equipMo = slot2

	slot0:onSetData()
end

function slot0.refreshShowLevel(slot0, slot1)
	if not slot1 then
		return
	end

	slot4, slot5 = HeroConfig.instance:getShowLevel(slot0._heroMo and slot2.level or 0)
	slot1.text = tostring(slot4)
end

function slot0.refreshLevelList(slot0, slot1)
	if not slot1 then
		return
	end

	slot4, slot5 = HeroConfig.instance:getShowLevel(slot0._heroMo and slot2.level or 0)

	for slot9, slot10 in ipairs(slot1) do
		gohelper.setActive(slot10, slot9 == slot5 - 1)
	end
end

function slot0.refreshStarList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot8, slot9 in ipairs(slot1) do
		gohelper.setActive(slot9, slot8 <= (slot2 and (slot0._heroMo and slot2.config).rare or -1) + 1)
	end
end

function slot0.getHeadIconMiddleResUrl(slot0)
	if not slot0._heroMo then
		return
	end

	return ResUrl.getHeadIconMiddle(FightConfig.instance:getSkinCO(slot1.skin).retangleIcon)
end

function slot0.getCareerSpriteName(slot0)
	if not slot0._heroMo then
		return
	end

	return "lssx_" .. tostring(slot1.config.career)
end

function slot0.getEquipIconSpriteName(slot0)
	if not slot0._equipMo then
		return
	end

	return slot1.config.icon
end

function slot0.getEquipRareSprite(slot0)
	if not slot0._equipMo then
		return
	end

	return "bianduixingxian_" .. tostring(slot1.config.rare)
end

function slot0.onDestroyView(slot0)
	slot0:onDestroy()
end

function slot0._refreshHeroByDefault(slot0)
	if not slot0._heroMo then
		gohelper.setActive(slot0._gohero, false)

		return
	end

	slot0._simageheroicon:LoadImage(slot0:getHeadIconMiddleResUrl())
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, slot0:getCareerSpriteName())
end

function slot0.onSetData(slot0)
	assert(false, "please override this function")
end

function slot0.onDestroy(slot0)
end

return slot0
