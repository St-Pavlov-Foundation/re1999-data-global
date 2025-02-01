module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillItem", package.seeall)

slot0 = class("VersionActivity1_6SkillItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0.viewGO = slot1
	slot0._skillType = slot2
	slot0.btnLvUp = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_LvUp/#btn_LvUpArea")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#txt_Title")
	slot0._imageIcon = gohelper.findChildImage(slot0.viewGO, "image_Pic")
	slot0._imageIconGold = gohelper.findChildImage(slot0.viewGO, "#image_Icon_gold")
	slot0._imageIconSliver = gohelper.findChildImage(slot0.viewGO, "#image_Icon_sliver")
	slot0._txtLvNum = gohelper.findChildText(slot0.viewGO, "#txt_LvNum")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "Scroll View/Viewport/#txt_Descr")
	slot0._goEffect = gohelper.findChild(slot0.viewGO, "eff")

	slot0:addEventListeners()
	slot0:refreshItemUI()
end

function slot0.addEventListeners(slot0)
	slot0.btnLvUp:AddClickListener(slot0._btnLvUpClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnLvUp:RemoveClickListener()
end

function slot0.refreshItemUI(slot0)
	slot2 = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(slot0._skillType) and slot1:getLevel() or 0
	slot4 = Activity148Config.instance:getAct148SkillTypeCfg(slot0._skillType)
	slot5 = nil
	slot5 = (slot2 ~= 0 or Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.SkillOriginIcon[slot0._skillType])) and Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillType, slot2).skillSmallIcon
	slot0._txtLvNum.text = slot2 == tonumber(Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillLv)) and "MAX" or slot2
	slot0._txtTitle.text = slot4.skillName
	slot0._txtDesc.text = slot4.skillValueDesc

	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(slot0._imageIcon, slot5)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(slot0._imageIconGold, slot5)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(slot0._imageIconSliver, slot5)

	slot10 = tonumber(Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.SilverEffectSkillLv)) <= slot2

	if tonumber(Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.GoldEffectSkillLv)) <= slot2 then
		gohelper.setActive(slot0._imageIconSliver.gameObject, false)
		gohelper.setActive(slot0._imageIconGold.gameObject, true)
	elseif slot10 then
		gohelper.setActive(slot0._imageIconSliver.gameObject, true)
		gohelper.setActive(slot0._imageIconGold.gameObject, false)
	else
		gohelper.setActive(slot0._imageIconSliver.gameObject, false)
		gohelper.setActive(slot0._imageIconGold.gameObject, false)
	end
end

function slot0.refreshResetEffect(slot0)
	gohelper.setActive(slot0._goEffect, false)
	gohelper.setActive(slot0._goEffect, true)
end

function slot0.onDestroyItem(slot0)
	slot0:removeEventListeners()
end

function slot0._btnLvUpClick(slot0)
	VersionActivity1_6DungeonController.instance:openSkillLvUpView(slot0._skillType)
end

return slot0
