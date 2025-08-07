module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9FightSuccView", package.seeall)

local var_0_0 = class("VersionActivity2_9FightSuccView", FightSuccView)
local var_0_1 = 1
local var_0_2 = 0.37
local var_0_3 = 1
local var_0_4 = 0.39

function var_0_0.onOpen(arg_1_0)
	var_0_0.super.onOpen(arg_1_0)

	local var_1_0 = DungeonConfig.instance:getFirstEpisodeWinConditionText(nil, FightModel.instance:getBattleId())

	arg_1_0:_showPlatCondition(var_1_0, arg_1_0._goCondition, nil, DungeonEnum.StarType.Normal)
end

function var_0_0._showPlatCondition(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if string.nilorempty(arg_2_1) then
		gohelper.setActive(arg_2_2, false)
	else
		gohelper.setActive(arg_2_2, true)

		if arg_2_4 > (tonumber(FightResultModel.instance.star) or 0) then
			gohelper.findChildText(arg_2_2, "condition").text = gohelper.getRichColorText(arg_2_1, "#6C6C6B")

			ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(arg_2_2, "image_gou"), var_0_2)
			ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(arg_2_2, "star"), var_0_4)
			SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildImage(arg_2_2, "star"), "#FFFFFF")
		else
			gohelper.findChildText(arg_2_2, "condition").text = gohelper.getRichColorText(arg_2_1, "#C4C0BD")

			ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(arg_2_2, "image_gou"), var_0_1)
			ZProj.UGUIHelper.SetColorAlpha(gohelper.findChildImage(arg_2_2, "star"), var_0_3)
			SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildImage(arg_2_2, "star"), "#FFFFFF")
		end

		VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(arg_2_0._curEpisodeId, gohelper.findChildImage(arg_2_2, "star"))
	end
end

function var_0_0._addItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = gohelper.clone(arg_3_0._bonusItemGo, arg_3_0._bonusItemContainer, arg_3_1.id)
	local var_3_1 = gohelper.findChild(var_3_0, "container/itemIcon")
	local var_3_2 = IconMgr.instance:getCommonPropItemIcon(var_3_1)
	local var_3_3 = gohelper.findChild(var_3_0, "container/tag")
	local var_3_4 = gohelper.findChild(var_3_0, "container/tag/imgFirst")
	local var_3_5 = gohelper.findChild(var_3_0, "container/tag/imgFirstHard")
	local var_3_6 = gohelper.findChild(var_3_0, "container/tag/imgFirstSimple")
	local var_3_7 = gohelper.findChild(var_3_0, "container/tag/imgNormal")
	local var_3_8 = gohelper.findChild(var_3_0, "container/tag/imgAdvance")
	local var_3_9 = gohelper.findChild(var_3_0, "container/tag/imgEquipDaily")
	local var_3_10 = gohelper.findChild(var_3_0, "container/tag/limitfirstbg")
	local var_3_11 = gohelper.findChild(var_3_0, "container/tag/imgact")
	local var_3_12 = gohelper.findChild(var_3_0, "container")
	local var_3_13 = gohelper.findChild(var_3_0, "container/tag/#go_progress")
	local var_3_14 = gohelper.findChildImage(var_3_0, "container/tag/#go_progress/#image_icon")
	local var_3_15 = gohelper.findChildText(var_3_0, "container/tag/#go_progress/#txt_progress")

	gohelper.setActive(var_3_12, false)
	gohelper.setActive(var_3_3, arg_3_1.bonusTag)

	if arg_3_1.bonusTag then
		local var_3_16 = arg_3_1.bonusTag == FightEnum.FightBonusTag.AdvencedBonus or arg_3_1.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus

		gohelper.setActive(var_3_4, arg_3_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and arg_3_0._normalMode)
		gohelper.setActive(var_3_5, arg_3_1.bonusTag == FightEnum.FightBonusTag.FirstBonus and arg_3_0._hardMode)
		gohelper.setActive(var_3_7, false)
		gohelper.setActive(var_3_8, arg_3_1.bonusTag == FightEnum.FightBonusTag.AdvencedBonus and not var_3_16)
		gohelper.setActive(var_3_9, arg_3_1.bonusTag == FightEnum.FightBonusTag.EquipDailyFreeBonus)
		gohelper.setActive(var_3_10, arg_3_1.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus and not var_3_16)
		gohelper.setActive(var_3_11, arg_3_1.bonusTag == FightEnum.FightBonusTag.ActBonus)
		gohelper.setActive(var_3_6, arg_3_1.bonusTag == FightEnum.FightBonusTag.SimpleBouns or FightEnum.FightBonusTag.FirstBonus and arg_3_0._simpleMode)
		gohelper.setActive(var_3_13, var_3_16)

		if var_3_16 then
			VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(arg_3_0._curEpisodeId, var_3_14)

			local var_3_17 = arg_3_1.bonusTag == FightEnum.FightBonusTag.TimeFirstBonus and DungeonEnum.StarType.Normal or DungeonEnum.StarType.Advanced

			VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(arg_3_0._curEpisodeId, var_3_17, var_3_15)
		end
	end

	arg_3_1.isIcon = true

	var_3_2:onUpdateMO(arg_3_1)
	var_3_2:setCantJump(true)
	var_3_2:setCountFontSize(40)
	var_3_2:setAutoPlay(true)
	var_3_2:isShowEquipRefineLv(true)

	local var_3_18 = false

	if arg_3_1.bonusTag and arg_3_1.bonusTag == FightEnum.FightBonusTag.AdditionBonus then
		var_3_18 = true
	end

	var_3_2:isShowAddition(var_3_18)

	if arg_3_2 then
		arg_3_2(arg_3_0, var_3_2, arg_3_3)
	end

	gohelper.setActive(var_3_0, false)

	var_3_3:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0

	arg_3_0:applyBonusVfx(arg_3_1, var_3_0)

	return var_3_12, var_3_0
end

return var_0_0
