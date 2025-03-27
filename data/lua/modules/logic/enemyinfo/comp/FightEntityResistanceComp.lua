module("modules.logic.enemyinfo.comp.FightEntityResistanceComp", package.seeall)

slot0 = class("FightEntityResistanceComp", UserDataDispose)
slot0.FightResistancePath = "ui/viewres/fight/fightresistance.prefab"

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.goContainer = slot1
	slot0.viewContainer = slot2
end

slot0.ScreenPosIntervalX = 0

function slot0.onInitView(slot0)
	slot0.go = slot0.viewContainer:getResInst(uv0.FightResistancePath, slot0.goContainer)
	slot0.scroll = gohelper.findChild(slot0.go, "scroll_view"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.goResistanceItem = gohelper.findChild(slot0.go, "scroll_view/Viewport/Content/#go_resistanceitem")

	gohelper.setActive(slot0.goResistanceItem, false)

	slot0.click = gohelper.getClickWithDefaultAudio(slot0.go)

	slot0.click:AddClickListener(slot0.onClickResistance, slot0)

	slot0.resistanceItemList = {}
	slot0.rect = slot0.go:GetComponent(gohelper.Type_RectTransform)
end

function slot0.setParent(slot0, slot1)
	slot0.scroll.parentGameObject = slot1
end

function slot0.onClickResistance(slot0)
	if not slot0.resistanceDict then
		return
	end

	slot0.screenPos = recthelper.uiPosToScreenPos(slot0.rect)
	slot0.screenPos.x = slot0.screenPos.x - uv0.ScreenPosIntervalX

	FightResistanceTipController.instance:openFightResistanceTipView(slot0.resistanceDict, slot0.screenPos)
end

function slot0.refresh(slot0, slot1)
	slot0.resistanceDict = slot1

	if not slot1 then
		gohelper.setActive(slot0.goContainer, false)

		return
	end

	slot0.showResistanceList = slot0.showResistanceList or {}

	tabletool.clear(slot0.showResistanceList)

	for slot5, slot6 in pairs(FightEnum.Resistance) do
		if (slot0.resistanceDict[slot5] or 0) > 0 then
			table.insert(slot0.showResistanceList, {
				resistanceId = slot6,
				value = slot7
			})
		end
	end

	table.sort(slot0.showResistanceList, uv0.sortResistance)

	for slot5, slot6 in ipairs(slot0.showResistanceList) do
		gohelper.setActive((slot0.resistanceItemList[slot5] or slot0:createResistanceItem()).go, true)

		if lua_character_attribute.configDict[slot6.resistanceId] then
			UISpriteSetMgr.instance:setBuffSprite(slot7.icon, slot8.icon)
		end
	end

	if #slot0.showResistanceList > 0 then
		for slot6 = slot2 + 1, #slot0.resistanceItemList do
			gohelper.setActive(slot0.resistanceItemList[slot6].go, false)
		end

		slot0.scroll.horizontalNormalizedPosition = 0

		gohelper.setActive(slot0.goContainer, true)
	else
		gohelper.setActive(slot0.goContainer, false)
	end
end

function slot0.getResistanceValue(slot0, slot1)
	return FightHelper.getResistanceKeyById(slot1) and slot0.resistanceDict[slot2] or 0
end

function slot0.createResistanceItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0.goResistanceItem)
	slot1.icon = gohelper.findChildImage(slot1.go, "normal/#image_icon")

	table.insert(slot0.resistanceItemList, slot1)

	return slot1
end

function slot0.sortResistance(slot0, slot1)
	return lua_character_attribute.configDict[slot0.resistanceId].sortId < lua_character_attribute.configDict[slot1.resistanceId].sortId
end

function slot0.destroy(slot0)
	slot0.click:RemoveClickListener()

	slot0.click = nil
	slot0.resistanceItemList = nil

	slot0:__onDispose()
end

return slot0
