module("modules.logic.herogroup.view.CharacterSkillContainer", package.seeall)

slot0 = class("CharacterSkillContainer", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._goskills = gohelper.findChild(slot1, "line/go_skills")
	slot0._skillitems = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		slot6 = gohelper.findChild(slot0._goskills, "skillicon" .. tostring(slot5))
		slot7 = {
			icon = gohelper.findChildSingleImage(slot6, "imgIcon"),
			tag = gohelper.findChildSingleImage(slot6, "tag/tagIcon"),
			btn = gohelper.findChildButtonWithAudio(slot6, "bg", AudioEnum.UI.Play_ui_role_description),
			index = slot5
		}

		slot7.btn:AddClickListener(slot0._onSkillCardClick, slot0, slot7.index)

		slot0._skillitems[slot5] = slot7
	end
end

function slot0.onDestroy(slot0)
	for slot4 = 1, 3 do
		slot0._skillitems[slot4].btn:RemoveClickListener()
		slot0._skillitems[slot4].icon:UnLoadImage()
		slot0._skillitems[slot4].tag:UnLoadImage()
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3, slot4)
	slot0._heroId = slot1
	slot0._heroName = HeroConfig.instance:getHeroCO(slot0._heroId).name
	slot0._heroMo = slot3
	slot0._isBalance = slot4
	slot0._showAttributeOption = slot2 or CharacterEnum.showAttributeOption.ShowCurrent

	slot0:_refreshSkillUI()
end

function slot0._refreshSkillUI(slot0)
	if slot0._heroId then
		slot5 = slot0._heroMo

		for slot5, slot6 in pairs(SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(slot0._heroId, slot0._showAttributeOption, slot5)) do
			if not lua_skill.configDict[slot6] then
				logError(string.format("heroID : %s, skillId not found : %s", slot0._heroId, slot6))
			end

			slot0._skillitems[slot5].icon:LoadImage(ResUrl.getSkillIcon(slot7.icon))
			slot0._skillitems[slot5].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot7.showTag))
			gohelper.setActive(slot0._skillitems[slot5].tag.gameObject, slot5 ~= 3)
		end
	end
end

function slot0._onSkillCardClick(slot0, slot1)
	if slot0._heroId then
		ViewMgr.instance:openView(ViewName.SkillTipView, {
			super = slot1 == 3,
			skillIdList = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(slot0._heroId, slot0._showAttributeOption, slot0._heroMo)[slot1],
			isBalance = slot0._isBalance,
			monsterName = slot0._heroName,
			heroId = slot0._heroId,
			heroMo = slot0._heroMo,
			skillIndex = slot1
		})
	end
end

return slot0
