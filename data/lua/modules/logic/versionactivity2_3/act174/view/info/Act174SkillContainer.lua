module("modules.logic.versionactivity2_3.act174.view.info.Act174SkillContainer", package.seeall)

slot0 = class("Act174SkillContainer", LuaCompBase)

function slot0.init(slot0, slot1)
	slot5 = "line/go_skills"
	slot0._goskills = gohelper.findChild(slot1, slot5)
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

function slot0.onUpdateMO(slot0, slot1)
	slot0._roleId = slot1.id
	slot0._heroId = slot1.heroId
	slot0._heroName = slot1.name

	slot0:_refreshSkillUI()
end

function slot0._refreshSkillUI(slot0)
	if slot0._roleId then
		slot5 = true

		for slot5, slot6 in pairs(Activity174Config.instance:getHeroSkillIdDic(slot0._roleId, slot5)) do
			if not lua_skill.configDict[slot6] then
				logError(string.format("heroID : %s, skillId not found : %s", slot0._roleId, slot6))
			end

			slot0._skillitems[slot5].icon:LoadImage(ResUrl.getSkillIcon(slot7.icon))
			slot0._skillitems[slot5].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot7.showTag))
			gohelper.setActive(slot0._skillitems[slot5].tag.gameObject, slot5 ~= 3)
		end
	end
end

function slot0._onSkillCardClick(slot0, slot1)
	if slot0._roleId then
		ViewMgr.instance:openView(ViewName.SkillTipView, {
			super = slot1 == 3,
			skillIdList = Activity174Config.instance:getHeroSkillIdDic(slot0._roleId)[slot1],
			isBalance = false,
			monsterName = slot0._heroName,
			heroId = slot0._heroId,
			skillIndex = slot1
		})
	end
end

return slot0
