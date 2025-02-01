module("modules.logic.season.view1_2.Season1_2FightRuleView", package.seeall)

slot0 = class("Season1_2FightRuleView", BaseView)

function slot0.onInitView(slot0)
	slot0._content = gohelper.findChild(slot0.viewGO, "mask/Scroll View/Viewport/Content")
	slot0._simagedecorate = gohelper.findChildSingleImage(slot0.viewGO, "mask/#simage_decorate")
	slot0._goItem = gohelper.findChild(slot0._content, "#go_ruleitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goItem, false)
end

function slot0.onOpen(slot0)
	slot0:refreshRule()
end

function slot0.refreshRule(slot0)
	slot1 = uv0.getRuleList() or {}

	if not slot0.itemList then
		slot0.itemList = slot0:getUserDataTb_()
	end

	slot5 = #slot1

	for slot5 = 1, math.max(#slot0.itemList, slot5) do
		slot0:updateItem(slot0.itemList[slot5] or slot0:createItem(slot5), slot1[slot5])
	end

	slot0:setDecorateVisible(#slot1 <= 1)
end

function slot0.createItem(slot0, slot1)
	slot2 = {
		go = slot3,
		txtEffectDesc = gohelper.findChildTextMesh(slot3, "txt_effectdesc"),
		imgTag = gohelper.findChildImage(slot3, "rulecontain/image_tag"),
		imgIcon = gohelper.findChildImage(slot3, "rulecontain/image_icon")
	}
	slot3 = gohelper.clone(slot0._goItem, slot0._content, string.format("item%s", slot1))
	slot0.itemList[slot1] = slot2

	return slot2
end

function slot0.updateItem(slot0, slot1, slot2)
	if not slot2 or string.nilorempty(slot2[2]) then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot3 = lua_rule.configDict[slot2[2]]
	slot4 = slot2[1]
	slot5 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	slot1.txtEffectDesc.text = string.format("<color=%s>[%s]</color>%s%s", slot5[slot4], luaLang("dungeon_add_rule_target_" .. slot4), string.gsub(slot3.desc, "%【(.-)%】", "<color=#6680bd>[%1]</color>"), "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(slot3.desc, slot5[1]))

	UISpriteSetMgr.instance:setCommonSprite(slot1.imgTag, "wz_" .. slot2[1])
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(slot1.imgIcon, slot3.icon)
end

function slot0.destroyItem(slot0, slot1)
end

function slot0.getRuleList()
	if not FightModel.instance:getFightParam() then
		return
	end

	if not lua_battle.configDict[slot0.battleId] then
		return
	end

	return SeasonConfig.instance:filterRule(GameUtil.splitString2(slot1.additionRule, true, "|", "#"))
end

function slot0.setDecorateVisible(slot0, slot1)
	gohelper.setActive(slot0._simagedecorate.gameObject, slot1)

	if slot1 then
		slot0._simagedecorate:LoadImage(ResUrl.getSeasonIcon("img_zs2.png"))
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.itemList then
		for slot4, slot5 in pairs(slot0.itemList) do
			slot0:destroyItem(slot5)
		end

		slot0.itemList = nil
	end
end

return slot0
