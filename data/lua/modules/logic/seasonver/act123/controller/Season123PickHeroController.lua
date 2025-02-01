module("modules.logic.seasonver.act123.controller.Season123PickHeroController", package.seeall)

slot0 = class("Season123PickHeroController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._finishCall = slot3
	slot0._finishCallObj = slot4

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroModel.instance:init(slot1, slot2, slot5, slot6)
end

function slot0.onCloseView(slot0)
	Season123PickHeroModel.instance:release()
	CharacterBackpackCardListModel.instance:clearCardList()
end

function slot0.setHeroSelect(slot0, slot1, slot2)
	if slot2 and Season123PickHeroModel.instance:getLimitCount() <= Season123PickHeroModel.instance:getSelectCount() then
		logNormal("max hero count!")

		return
	end

	Season123PickHeroModel.instance:setHeroSelect(slot1, slot2)
	slot0:notifyView()
end

function slot0.pickOver(slot0)
	if slot0._finishCall then
		slot0._finishCall(slot0._finishCallObj, Season123PickHeroModel.instance:getSelectMOList())
	end
end

function slot0.updateFilter(slot0)
	Season123PickHeroModel.instance:refreshList()
	Season123Controller.instance:dispatchEvent(Season123Event.PickViewRefresh)
end

function slot0.notifyView(slot0)
	Season123PickHeroModel.instance:onModelUpdate()
	Season123Controller.instance:dispatchEvent(Season123Event.PickViewRefresh)
end

slot0.instance = slot0.New()

return slot0
