module("modules.logic.seasonver.act166.view.Season166HeroGroupFightLayoutView", package.seeall)

slot0 = class("Season166HeroGroupFightLayoutView", BaseView)

function slot0.onInitView(slot0)
	slot0.heroContainer = gohelper.findChild(slot0.viewGO, "herogroupcontain/area")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.MoveOffsetX = 125

function slot0._editableInitView(slot0)
	slot0.isSeason166Episode = Season166HeroGroupModel.instance:isSeason166Episode()

	if not slot0.isSeason166Episode then
		return
	end

	slot0.goHeroGroupContain = gohelper.findChild(slot0.viewGO, "herogroupcontain")
	slot0.heroGroupContainRectTr = slot0.goHeroGroupContain:GetComponent(gohelper.Type_RectTransform)
	slot0.maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()

	slot0:initItemName()

	slot0.heroItemList = {}

	for slot4 = 1, slot0.maxHeroCount do
		slot5 = slot0:getUserDataTb_()
		slot5.bgRectTr = gohelper.findChildComponent(slot0.viewGO, "herogroupcontain/hero/bg" .. slot4, gohelper.Type_RectTransform)
		slot5.posGoTr = gohelper.findChildComponent(slot0.viewGO, "herogroupcontain/area/pos" .. slot4, gohelper.Type_RectTransform)
		slot5.bgX = recthelper.getAnchorX(slot5.bgRectTr)
		slot5.posX = recthelper.getAnchorX(slot5.posGoTr)

		table.insert(slot0.heroItemList, slot5)
	end

	slot0.mainFrameBgTr = gohelper.findChildComponent(slot0.viewGO, "frame/#go_mainFrameBg", gohelper.Type_RectTransform)
	slot0.mainFrameBgWidth = recthelper.getWidth(slot0.mainFrameBgTr)
	slot0.mainFrameBgX = recthelper.getAnchorX(slot0.mainFrameBgTr)
	slot0.helpFrameBgTr = gohelper.findChildComponent(slot0.viewGO, "frame/#go_helpFrameBg", gohelper.Type_RectTransform)
	slot0.helpFrameBgWidth = recthelper.getWidth(slot0.helpFrameBgTr)
	slot0.helpFrameBgX = recthelper.getAnchorX(slot0.helpFrameBgTr)

	slot0:addEventCb(Season166HeroGroupController.instance, Season166Event.OnCreateHeroItemDone, slot0.onCreateHeroItemDone, slot0)
end

function slot0.initItemName(slot0)
	if slot0.maxHeroCount == Season166Enum.MaxHeroCount then
		return
	end

	slot1 = slot0.maxHeroCount / 2 + 1

	for slot5 = 1, Season166Enum.MaxHeroCount do
		gohelper.setActive(gohelper.findChild(slot0.heroContainer, "pos" .. slot5), slot5 % slot1 ~= 0)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/bg" .. slot5), slot5 % slot1 ~= 0)

		if slot5 % slot1 == 0 then
			slot6.name = string.format("pos_%d_1", slot5)
			slot7.name = string.format("bg_%d_1", slot5)
		end

		if slot1 <= slot5 and slot5 % slot1 ~= 0 then
			slot8 = slot5 - math.floor(slot5 / slot1)
			slot6.name = "pos" .. slot8
			slot7.name = "bg" .. slot8
		end
	end
end

function slot0.onCreateHeroItemDone(slot0)
	for slot4 = 1, slot0.maxHeroCount do
		slot0.heroItemList[slot4].heroItemRectTr = gohelper.findChildComponent(slot0.goHeroGroupContain, "hero/item" .. slot4, gohelper.Type_RectTransform)
	end

	slot0:setUIPos()
end

function slot0.setUIPos(slot0)
	slot1 = slot0.maxHeroCount == Season166Enum.MaxHeroCount and 0 or uv0.MoveOffsetX

	for slot5 = 1, slot0.maxHeroCount do
		slot6 = slot0.heroItemList[slot5]

		recthelper.setAnchorX(slot6.bgRectTr, slot6.bgX + slot1)
		recthelper.setAnchorX(slot6.posGoTr, slot6.posX + slot1)

		if not gohelper.isNil(slot6.heroItemRectTr) then
			slot8 = recthelper.rectToRelativeAnchorPos(slot6.posGoTr.position, slot0.heroGroupContainRectTr)

			recthelper.setAnchor(slot7, slot8.x, slot8.y)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
