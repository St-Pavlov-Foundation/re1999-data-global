module("modules.logic.fight.view.FightSuccessCachotHeroView", package.seeall)

slot0 = class("FightSuccessCachotHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_cachot_herogroup")
	slot0._heroItemParent = gohelper.findChild(slot0._goroot, "layout")
	slot0._heroItem = gohelper.findChild(slot0._goroot, "layout/heroitem")
	slot0._txtLv = gohelper.findChild(slot0.viewGO, "goalcontent/txtLv")
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._txtLv, false)
	gohelper.setActive(slot0._goroot, true)

	slot1 = {}

	if not V1a6_CachotModel.instance:getTeamInfo() then
		return
	end

	if slot2:getCurGroupInfo() then
		for slot7, slot8 in ipairs(slot3.heroList) do
			if HeroModel.instance:getById(slot8) then
				slot10 = slot2:getHeroHp(slot9.heroId)

				if slot9.skin == 0 then
					slot11 = lua_character.configDict[slot9.heroId].skinId
				end

				table.insert(slot1, {
					skinId = slot9.skin,
					nowHp = slot10.life / 1000,
					heroId = slot9.heroId
				})
			end
		end
	end

	gohelper.CreateObjList(slot0, slot0._onHeroItemCreate, slot1, slot0._heroItemParent, slot0._heroItem)
end

function slot0._onHeroItemCreate(slot0, slot1, slot2, slot3)
	slot5 = gohelper.findChildSingleImage(slot1, "hero/#simage_rolehead")

	gohelper.findChildSlider(slot1, "#slider_hp"):SetValue(slot2.nowHp)
	gohelper.setActive(gohelper.findChild(slot1, "#dead"), slot2.nowHp <= 0)
	slot5:LoadImage(ResUrl.getHeadIconSmall(lua_skin.configDict[slot2.skinId].headIcon))
	ZProj.UGUIHelper.SetGrayscale(slot5.gameObject, slot2.nowHp <= 0)
end

function slot0.onClose(slot0)
end

return slot0
