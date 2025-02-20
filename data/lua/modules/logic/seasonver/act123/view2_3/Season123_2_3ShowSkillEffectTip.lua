module("modules.logic.seasonver.act123.view2_3.Season123_2_3ShowSkillEffectTip", package.seeall)

slot0 = class("Season123_2_3ShowSkillEffectTip", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._goBuffContainer = slot1
	slot0._btnclosebuff = gohelper.findChildButtonWithAudio(slot0._goBuffContainer, "buff_bg")
	slot0._goBuffContent = gohelper.findChild(slot0._goBuffContainer, "#go_buffContent")
	slot0._goBuffItem = gohelper.findChild(slot0._goBuffContainer, "#go_buffContent/#go_buffitem")
	slot0._buffTab = slot0:getUserDataTb_()

	slot0._btnclosebuff:AddClickListener(slot0._btnclosebuffOnClick, slot0)
	gohelper.setActive(slot0._goBuffContainer, false)
	gohelper.setActive(slot0._goBuffItem, false)
end

function slot0._btnclosebuffOnClick(slot0)
	slot4 = false

	gohelper.setActive(slot0._goBuffContainer, slot4)

	for slot4, slot5 in pairs(slot0._buffTab) do
		slot0._buffTab[slot4] = nil

		gohelper.destroy(slot5.go)
	end
end

function slot0.addHyperLinkClick(slot0, slot1)
	gohelper.onceAddComponent(slot1, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(slot0.onHyperLinkClick, slot0)
end

function slot0.onHyperLinkClick(slot0, slot1, slot2)
	slot0:createAndGetBufferItem(tonumber(slot1))
	gohelper.setActive(slot0._goBuffContainer, true)
	recthelper.setAnchorY(slot0._goBuffContent.transform, recthelper.screenPosToAnchorPos(slot2, slot0._goBuffContainer.transform).y)
end

function slot0.createAndGetBufferItem(slot0, slot1)
	if not slot0._buffTab[slot1] then
		slot2 = {
			go = gohelper.clone(slot0._goBuffItem, slot0._goBuffContent, "go_buffitem" .. slot1)
		}
		slot2.txtBuffName = gohelper.findChildText(slot2.go, "title/txt_name")
		slot2.goBuffTag = gohelper.findChild(slot2.go, "title/txt_name/go_tag")
		slot2.txtBuffTagName = gohelper.findChildText(slot2.go, "title/txt_name/go_tag/bg/txt_tagname")
		slot2.txtBuffDesc = gohelper.findChildText(slot2.go, "txt_desc")
		slot2.config = SkillConfig.instance:getSkillEffectDescCo(slot1)
		slot0._buffTab[slot1] = slot2
	end

	gohelper.setActive(slot2.go, true)

	slot3 = slot2.config.name
	slot2.txtBuffName.text = SkillConfig.instance:processSkillDesKeyWords(slot3)
	slot4 = FightConfig.instance:getBuffTag(slot3)

	gohelper.setActive(slot2.goBuffTag, not string.nilorempty(slot4))

	slot2.txtBuffTagName.text = slot4
	slot2.txtBuffDesc.text = SkillHelper.buildDesc(slot2.config.desc)

	slot0:addChildHyperLinkClick(slot2.txtBuffDesc, true)
end

function slot0.addChildHyperLinkClick(slot0, slot1)
	gohelper.onceAddComponent(slot1, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(slot0.onChildHyperLinkClick, slot0)
end

function slot0.onChildHyperLinkClick(slot0, slot1, slot2)
	slot0:createAndGetBufferItem(tonumber(slot1))
end

function slot0.onDestroy(slot0)
	slot0._btnclosebuff:RemoveClickListener()
end

return slot0
