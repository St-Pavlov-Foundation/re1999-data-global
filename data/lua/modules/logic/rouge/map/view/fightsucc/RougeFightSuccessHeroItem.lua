module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessHeroItem", package.seeall)

slot0 = class("RougeFightSuccessHeroItem", RougeLuaCompBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.go = slot1
	slot0.slider = gohelper.findChildSlider(slot1, "#slider_hp")
	slot0.simageRole = gohelper.findChildSingleImage(slot1, "hero/#simage_rolehead")
	slot0.goDead = gohelper.findChild(slot1, "#go_dead")
end

function slot0.refreshHero(slot0, slot1)
	if (slot1 and slot1.heroId) ~= 0 then
		gohelper.setActive(slot0.go, true)
		slot0.simageRole:LoadImage(ResUrl.getRoomHeadIcon(slot0:getHeroHeadIcon(slot2)))

		if (RougeModel.instance:getFightResultInfo() and slot4:getLife(slot2)) <= 0 then
			slot0.slider:SetValue(0)
			gohelper.setActive(slot0.goDead, true)
		else
			slot0.slider:SetValue(slot5 / 1000)
			gohelper.setActive(slot0.goDead, false)
		end

		slot0:tickUpdateDLCs(slot1)
	end
end

function slot0.getHeroHeadIcon(slot0, slot1)
	slot4 = nil
	slot4 = (not (RougeModel.instance:getTeamInfo() and slot2:isAssistHero(slot1)) or slot2:getAssistHeroMo()) and HeroModel.instance:getByHeroId(slot1)
	slot5 = slot4 and slot4.skin
	slot6 = slot5 and lua_skin.configDict[slot5]

	return slot6 and slot6.headIcon or slot1 .. "01"
end

function slot0.onDestroyView(slot0)
	slot0.simageRole:UnLoadImage()
end

return slot0
