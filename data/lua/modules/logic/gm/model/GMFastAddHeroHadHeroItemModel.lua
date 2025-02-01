module("modules.logic.gm.model.GMFastAddHeroHadHeroItemModel", package.seeall)

slot0 = class("GMFastAddHeroHadHeroItemModel", ListScrollModel)
slot0.ShowType = {
	Equip = 2,
	Hero = 1
}

function slot0.refreshList(slot0, slot1)
	table.sort(slot1, slot0._sortMo)
	slot0:setList(slot1)
end

function slot0._sortMo(slot0, slot1)
	if slot0.config.id ~= slot1.config.id then
		return slot0.config.id < slot1.config.id
	end

	return slot0.uid < slot1.uid
end

function slot0.setShowType(slot0, slot1)
	slot0.showType = slot1
end

function slot0.getShowType(slot0)
	return slot0.showType
end

function slot0.changeShowType(slot0)
	if slot0.showType == uv0.ShowType.Hero then
		slot0.showType = uv0.ShowType.Equip
	else
		slot0.showType = uv0.ShowType.Hero
	end
end

function slot0.setFastAddHeroView(slot0, slot1)
	slot0.fastAddHeroView = slot1
end

function slot0.changeSelectHeroItem(slot0, slot1)
	if slot0.fastAddHeroView then
		slot0.fastAddHeroView:changeSelectHeroItemMo(slot1)
	end
end

function slot0.setSelectMo(slot0, slot1)
	slot0.selectMo = slot1

	GMController.instance:dispatchEvent(GMController.Event.ChangeSelectHeroItem)
end

function slot0.getSelectMo(slot0)
	return slot0.selectMo
end

slot0.instance = slot0.New()

return slot0
