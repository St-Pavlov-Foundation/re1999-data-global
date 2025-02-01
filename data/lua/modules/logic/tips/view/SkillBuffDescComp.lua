module("modules.logic.tips.view.SkillBuffDescComp", package.seeall)

slot0 = class("SkillBuffDescComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._goBuffContainer = slot1
	slot0._btnclosebuff = gohelper.findChildButtonWithAudio(slot1, "buff_bg")
	slot0._goBuffItem = gohelper.findChild(slot1, "#go_buffitem")
	slot0._txtBuffName = gohelper.findChildText(slot1, "#go_buffitem/title/txt_name")
	slot0._goBuffTag = gohelper.findChild(slot1, "#go_buffitem/title/txt_name/go_tag")
	slot0._txtBuffTagName = gohelper.findChildText(slot1, "#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	slot0._txtBuffDesc = gohelper.findChildText(slot1, "#go_buffitem/txt_desc")

	gohelper.setActive(slot1, false)
end

function slot0.addEventListeners(slot0)
	slot0._btnclosebuff:AddClickListener(slot0._closebuff, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclosebuff:RemoveClickListener()
end

function slot0._closebuff(slot0)
	gohelper.setActive(slot0._goBuffContainer, false)
end

function slot0.onShowBuff(slot0, slot1, slot2)
	gohelper.setActive(slot0._goBuffContainer, true)
	slot0:setBuffInfo(slot1)
	slot0:setBuffPos(slot2)
end

function slot0.setBuffInfo(slot0, slot1)
	slot0._txtBuffName.text = SkillConfig.instance:processSkillDesKeyWords(slot1)
	slot0._txtBuffDesc.text = HeroSkillModel.instance:skillDesToSpot(SkillConfig.instance:getSkillEffectDescCoByName(slot1).desc)
	slot3 = FightConfig.instance:getBuffTag(slot1)

	gohelper.setActive(slot0._goBuffTag, not string.nilorempty(slot3))

	slot0._txtBuffTagName.text = slot3
end

function slot0.setBuffPos(slot0, slot1)
	slot3 = slot1.y
	slot4 = slot0._goBuffItem.transform
	slot5 = slot0._goBuffContainer.transform

	ZProj.UGUIHelper.RebuildLayout(slot4)

	slot7 = recthelper.getHeight(slot4)
	slot9 = recthelper.getHeight(slot5)

	if -recthelper.getWidth(slot5) / 2 > slot1.x - 20 - recthelper.getWidth(slot4) - 10 then
		slot2 = -slot8 / 2 + slot6 + 10
	end

	if -slot9 / 2 > slot3 - slot7 / 2 - 10 then
		slot3 = -slot9 / 2 + slot7 / 2 + 10
	end

	recthelper.setAnchorY(slot4, slot3)
end

return slot0
