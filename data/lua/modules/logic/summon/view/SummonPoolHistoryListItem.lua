module("modules.logic.summon.view.SummonPoolHistoryListItem", package.seeall)

slot0 = class("SummonPoolHistoryListItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._name = gohelper.findChildText(slot1, "main/name/#txt_name")
	slot0._pooltype = gohelper.findChildText(slot1, "main/type/#txt_type")
	slot0._time = gohelper.findChildText(slot1, "main/time/#txt_time")
	slot0._imgstar = gohelper.findChildImage(slot1, "main/name/#txt_name/img_star")
	slot0._gomain = gohelper.findChild(slot1, "main")
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	if slot0._mo then
		slot1, slot2 = nil

		if not slot0._mo.isLuckyBag then
			slot1, slot2 = slot0:getNameAndRare(slot0._mo.gainId)
		else
			slot1, slot2 = slot0:getLuckyBagNameAndRare(slot0._mo.gainId, slot0._mo.poolId)
		end

		slot0._name.text = slot0:getStarName(slot1, slot2)
		slot0._pooltype.text = SummonConfig.instance:getSummonPool(slot0._mo.poolId) and slot4.nameCn or slot0._mo.poolName
		slot0._time.text = slot0._mo.createTime

		gohelper.setActive(slot0._imgstar.gameObject, slot2 >= 4)

		if slot0._colorStr ~= (SummonEnum.HistoryColor[slot2 or 1] or SummonEnum.HistoryColor[1]) then
			slot0._colorStr = slot6

			SLFramework.UGUI.GuiHelper.SetColor(slot0._name, slot6)

			if slot2 >= 4 then
				SLFramework.UGUI.GuiHelper.SetColor(slot0._imgstar, slot6)
			end
		end
	end

	gohelper.setActive(slot0._gomain, slot0._mo and true or false)
end

function slot0.getStarName(slot0, slot1, slot2)
	if SummonEnum.HistoryNameStarFormat[slot2] then
		return string.format(slot3, slot1)
	end

	return slot1
end

function slot0.getNameAndRare(slot0, slot1)
	if HeroConfig.instance:getHeroCO(slot1) then
		return slot2.name, slot2.rare
	end

	if EquipConfig.instance:getEquipCo(slot1) then
		return slot3.name, slot3.rare
	end

	return slot1 .. "", 1
end

function slot0.getLuckyBagNameAndRare(slot0, slot1, slot2)
	if SummonConfig.instance:getLuckyBag(slot2, slot1) then
		return slot3.name, SummonEnum.LuckyBagRare
	else
		return tostring(slot1), SummonEnum.LuckyBagRare
	end
end

function slot0.onDestroy(slot0)
end

return slot0
