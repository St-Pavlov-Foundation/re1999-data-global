module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandItem", package.seeall)

slot0 = class("VersionActivity1_3FairyLandItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagecard = gohelper.findChildImage(slot0.viewGO, "root/#image_card")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "root/image_namebg/#txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/desc/Viewport/Content/#txt_desc")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "root/#go_selected")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	slot0._landView:landItemClick(slot0)
end

function slot0.ctor(slot0, slot1)
	slot0._landView = slot1[1]
	slot0.config = slot1[2]
end

function slot0._editableInitView(slot0)
	slot1 = slot0.config.skillId
	slot0._txtdesc.text = FightConfig.instance:getSkillEffectDesc(nil, lua_skill_effect.configDict[slot1])
	slot0._txtname.text = lua_skill.configDict[slot1] and slot3.name

	UISpriteSetMgr.instance:setV1a3FairyLandCardSprite(slot0._imagecard, "v1a3_fairylandcard_" .. slot0.config.id - 2130000)
	slot0:setSelected(false)
end

function slot0.setSelected(slot0, slot1)
	slot0._isSelected = slot1

	gohelper.setActive(slot0._goselected, slot0._isSelected)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
