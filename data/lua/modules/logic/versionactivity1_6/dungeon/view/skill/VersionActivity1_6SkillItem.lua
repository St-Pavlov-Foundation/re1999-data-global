module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillItem", package.seeall)

local var_0_0 = class("VersionActivity1_6SkillItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._skillType = arg_1_2
	arg_1_0.btnLvUp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_LvUp/#btn_LvUpArea")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "image_Pic")
	arg_1_0._imageIconGold = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon_gold")
	arg_1_0._imageIconSliver = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon_sliver")
	arg_1_0._txtLvNum = gohelper.findChildText(arg_1_0.viewGO, "#txt_LvNum")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "Scroll View/Viewport/#txt_Descr")
	arg_1_0._goEffect = gohelper.findChild(arg_1_0.viewGO, "eff")

	arg_1_0:addEventListeners()
	arg_1_0:refreshItemUI()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.btnLvUp:AddClickListener(arg_2_0._btnLvUpClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.btnLvUp:RemoveClickListener()
end

function var_0_0.refreshItemUI(arg_4_0)
	local var_4_0 = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(arg_4_0._skillType)
	local var_4_1 = var_4_0 and var_4_0:getLevel() or 0
	local var_4_2 = Activity148Config.instance:getAct148CfgByTypeLv(arg_4_0._skillType, var_4_1)
	local var_4_3 = Activity148Config.instance:getAct148SkillTypeCfg(arg_4_0._skillType)
	local var_4_4

	if var_4_1 == 0 then
		var_4_4 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.SkillOriginIcon[arg_4_0._skillType])
	else
		var_4_4 = var_4_2.skillSmallIcon
	end

	local var_4_5 = tonumber(Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillLv))

	arg_4_0._txtLvNum.text = var_4_1 == var_4_5 and "MAX" or var_4_1
	arg_4_0._txtTitle.text = var_4_3.skillName
	arg_4_0._txtDesc.text = var_4_3.skillValueDesc

	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(arg_4_0._imageIcon, var_4_4)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(arg_4_0._imageIconGold, var_4_4)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(arg_4_0._imageIconSliver, var_4_4)

	local var_4_6 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.SilverEffectSkillLv)
	local var_4_7 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.GoldEffectSkillLv)
	local var_4_8 = var_4_1 >= tonumber(var_4_7)
	local var_4_9 = var_4_1 >= tonumber(var_4_6)

	if var_4_8 then
		gohelper.setActive(arg_4_0._imageIconSliver.gameObject, false)
		gohelper.setActive(arg_4_0._imageIconGold.gameObject, true)
	elseif var_4_9 then
		gohelper.setActive(arg_4_0._imageIconSliver.gameObject, true)
		gohelper.setActive(arg_4_0._imageIconGold.gameObject, false)
	else
		gohelper.setActive(arg_4_0._imageIconSliver.gameObject, false)
		gohelper.setActive(arg_4_0._imageIconGold.gameObject, false)
	end
end

function var_0_0.refreshResetEffect(arg_5_0)
	gohelper.setActive(arg_5_0._goEffect, false)
	gohelper.setActive(arg_5_0._goEffect, true)
end

function var_0_0.onDestroyItem(arg_6_0)
	arg_6_0:removeEventListeners()
end

function var_0_0._btnLvUpClick(arg_7_0)
	VersionActivity1_6DungeonController.instance:openSkillLvUpView(arg_7_0._skillType)
end

return var_0_0
