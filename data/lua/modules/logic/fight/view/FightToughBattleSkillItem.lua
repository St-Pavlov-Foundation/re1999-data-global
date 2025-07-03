module("modules.logic.fight.view.FightToughBattleSkillItem", package.seeall)

local var_0_0 = class("FightToughBattleSkillItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_1 = gohelper.findChild(arg_1_1, "anchoroffset")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "#go_Selected")
	arg_1_0._btn = gohelper.getClickWithDefaultAudio(arg_1_1, "btn")
	arg_1_0._gonum = gohelper.findChild(arg_1_1, "#go_Num")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_1, "#go_Num/#txt_Num")
	arg_1_0._simagechar = gohelper.findChildSingleImage(arg_1_1, "#simage_Char")
	arg_1_0._iconImage = gohelper.findChildImage(arg_1_1, "#simage_Char")
	arg_1_0._goDetails = gohelper.findChild(arg_1_1, "#go_details")
	arg_1_0._txtDetailTitle = gohelper.findChildTextMesh(arg_1_0._goDetails, "details/#scroll_details/Viewport/Content/#txt_title")
	arg_1_0._txtDetailContent = gohelper.findChildTextMesh(arg_1_0._goDetails, "details/#scroll_details/Viewport/Content/#txt_details")
	arg_1_0._ani = gohelper.onceAddComponent(arg_1_1, typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0.clickIcon, arg_2_0)

	arg_2_0._long = SLFramework.UGUI.UILongPressListener.Get(arg_2_0._btn.gameObject)

	arg_2_0._long:SetLongPressTime({
		0.5,
		99999
	})
	arg_2_0._long:AddLongPressListener(arg_2_0._onLongPress, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_2_0.updateSkillRound, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnEntityDead, arg_2_0.checkHeroIsDead, arg_2_0)
	FightController.instance:registerCallback(FightEvent.TouchFightViewScreen, arg_2_0._onTouchFightViewScreen, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0.updateSkillRound, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
	arg_3_0._long:RemoveLongPressListener()
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_3_0.updateSkillRound, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnEntityDead, arg_3_0.checkHeroIsDead, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.TouchFightViewScreen, arg_3_0._onTouchFightViewScreen, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_3_0.updateSkillRound, arg_3_0)
end

function var_0_0.setCo(arg_4_0, arg_4_1)
	arg_4_0._co = arg_4_1

	arg_4_0:refreshView()
end

function var_0_0.refreshView(arg_5_0)
	if not arg_5_0._co then
		return
	end

	gohelper.setActive(arg_5_0._gonum, false)
	arg_5_0._simagechar:LoadImage(ResUrl.getHandbookheroIcon(arg_5_0._co.icon))

	if arg_5_0._co.type == ToughBattleEnum.HeroType.Hero then
		arg_5_0._trialId = tonumber(arg_5_0._co.param) or 0

		arg_5_0:checkHeroIsDead()
	elseif arg_5_0._co.type == ToughBattleEnum.HeroType.Rule then
		arg_5_0._ani:Play("passive", 0, 0)
	elseif arg_5_0._co.type == ToughBattleEnum.HeroType.Skill then
		arg_5_0._skillId = string.splitToNumber(arg_5_0._co.param, "#")[1] or 0

		arg_5_0:updateSkillRound()
	end

	arg_5_0._txtDetailTitle.text = arg_5_0._co.name
	arg_5_0._txtDetailContent.text = HeroSkillModel.instance:skillDesToSpot(arg_5_0._co.desc)
end

function var_0_0.checkHeroIsDead(arg_6_0)
	if not arg_6_0._co or arg_6_0._co.type ~= ToughBattleEnum.HeroType.Hero then
		return
	end

	local var_6_0 = FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)
	local var_6_1

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1.trialId == arg_6_0._trialId then
			var_6_1 = iter_6_1

			break
		end
	end

	local var_6_2 = var_6_1 and "#FFFFFF" or "#c8c8c8"

	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._simagechar.gameObject:GetComponent(gohelper.Type_Image), var_6_2)

	if var_6_1 then
		arg_6_0._ani:Play("passive", 0, 0)
	elseif arg_6_0.go.activeInHierarchy then
		arg_6_0._ani:Play("die", 0, 0)
		TaskDispatcher.runDelay(arg_6_0._destoryThis, arg_6_0, 0.667)
	else
		arg_6_0._isDeaded = true
	end
end

function var_0_0.onEnable(arg_7_0)
	if arg_7_0._isDeaded and arg_7_0._ani then
		arg_7_0._ani:Play("die", 0, 0)
		TaskDispatcher.runDelay(arg_7_0._destoryThis, arg_7_0, 0.667)
	end
end

function var_0_0._destoryThis(arg_8_0)
	gohelper.destroy(arg_8_0.go)
end

function var_0_0.onDestroy(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._destoryThis, arg_9_0)
end

function var_0_0.updateSkillRound(arg_10_0)
	if not arg_10_0._co or arg_10_0._co.type ~= ToughBattleEnum.HeroType.Skill then
		return
	end

	local var_10_0 = arg_10_0:getCd()

	if var_10_0 > 0 then
		gohelper.setActive(arg_10_0._gonum, true)

		arg_10_0._txtnum.text = var_10_0
	else
		gohelper.setActive(arg_10_0._gonum, false)
	end

	local var_10_1 = var_10_0 <= 0 and "#FFFFFF" or "#808080"

	SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._simagechar.gameObject:GetComponent(gohelper.Type_Image), var_10_1)

	if var_10_0 <= 0 then
		arg_10_0._ani:Play("active", 0, 0)
	else
		arg_10_0._ani:Play("cooling", 0, 0)
	end
end

function var_0_0.getCd(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = FightModel.instance:getClothSkillList()

	if var_11_1 and #var_11_1 > 0 then
		for iter_11_0, iter_11_1 in pairs(var_11_1) do
			if iter_11_1.skillId == arg_11_0._skillId then
				var_11_0 = iter_11_1.cd

				break
			end
		end
	end

	return var_11_0
end

function var_0_0.clickIcon(arg_12_0)
	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if not arg_12_0._co or arg_12_0._co.type ~= ToughBattleEnum.HeroType.Skill then
		return
	end

	if arg_12_0:getCd() > 0 then
		return
	end

	if #FightDataHelper.operationDataMgr:getOpList() > 0 then
		FightRpc.instance:sendResetRoundRequest()
	end

	FightRpc.instance:sendUseClothSkillRequest(arg_12_0._skillId, nil, nil, FightEnum.ClothSkillType.ClothSkill)
end

function var_0_0._onLongPress(arg_13_0)
	gohelper.setActive(arg_13_0._goDetails, true)
end

function var_0_0._onTouchFightViewScreen(arg_14_0)
	gohelper.setActive(arg_14_0._goDetails, false)
end

return var_0_0
