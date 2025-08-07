module("modules.logic.fight.view.FightAiJiAoQteSelectView", package.seeall)

local var_0_0 = class("FightAiJiAoQteSelectView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.root = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0.itemRoot = gohelper.findChild(arg_1_0.viewGO, "root/selectTarget/#scroll_enemy/viewport/content")
	arg_1_0.objItem = gohelper.findChild(arg_1_0.viewGO, "root/selectTarget/#scroll_enemy/viewport/content/go_enemyItem")
	arg_1_0.roleImg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/BG/simage_role/loop/simage_role")
	arg_1_0.confirmClick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/#btn_confirm/clickarea")
	arg_1_0.exSkillIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/selectTarget/lv4/imgIcon")
	arg_1_0.txtWave = gohelper.findChildText(arg_1_0.viewGO, "root/topLeftContent/imgRound/txtWave")
	arg_1_0.txtRound = gohelper.findChildText(arg_1_0.viewGO, "root/topLeftContent/imgRound/txtRound")
	arg_1_0.btnInfo = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/topLeftContent/enemyinfo/#btn_enemyinfo/clickarea")
	arg_1_0.go_skillTips = gohelper.findChild(arg_1_0.viewGO, "root/selectTarget/#go_skilltip")
	arg_1_0.skillNameText = gohelper.findChildText(arg_1_0.viewGO, "root/selectTarget/#go_skilltip/skillbg/container/#txt_skillname")
	arg_1_0.skillDescText = gohelper.findChildText(arg_1_0.viewGO, "root/selectTarget/#go_skilltip/skillbg/#txt_skilldesc")
	arg_1_0.btnSkillTips = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "root/selectTarget/btn_skillClick")
	arg_1_0.skillTipsMaskClick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "tipsMask")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.confirmClick, arg_2_0.onConfirmClick)
	arg_2_0:com_registClick(arg_2_0.btnInfo, arg_2_0.onBtnInfoClick)
	arg_2_0:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView)
	arg_2_0:com_registEvent(ViewMgr.instance, ViewEvent.DestroyViewFinish, arg_2_0.onDestroyViewFinish)
	arg_2_0:com_registClick(arg_2_0.btnSkillTips, arg_2_0.onBtnSkillTipsClick)
	arg_2_0:com_registClick(arg_2_0.skillTipsMaskClick, arg_2_0.onSkillTipsMaskClick)
end

function var_0_0.onBtnSkillTipsClick(arg_3_0)
	gohelper.setActive(arg_3_0.go_skillTips, true)
	gohelper.setActive(arg_3_0.skillTipsMaskClick.gameObject, true)
end

function var_0_0.onSkillTipsMaskClick(arg_4_0)
	gohelper.setActive(arg_4_0.go_skillTips, false)
	gohelper.setActive(arg_4_0.skillTipsMaskClick.gameObject, false)
end

function var_0_0.onOpenView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.FightFocusView then
		gohelper.setActive(arg_5_0.viewGO, false)
	end
end

function var_0_0.onDestroyViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.FightFocusView then
		gohelper.setActive(arg_6_0.viewGO, true)
	end
end

function var_0_0.onBtnInfoClick(arg_7_0)
	FightViewContainer.openFightFocusView()
end

function var_0_0.onConfirmClick(arg_8_0)
	if not arg_8_0.selectId then
		return
	end

	if arg_8_0.clicked then
		return
	end

	arg_8_0.clicked = true

	AudioMgr.instance:trigger(20305034)

	local var_8_0 = arg_8_0:com_registFlowSequence()

	var_8_0:registWork(FightWorkPlayAnimator, arg_8_0.viewGO, "close")
	var_8_0:registWork(FightWorkFunction, arg_8_0.afterCloseAni, arg_8_0)
	var_8_0:start()
end

function var_0_0.afterCloseAni(arg_9_0)
	FightDataHelper.tempMgr.aiJiAoSelectTargetView = nil

	arg_9_0.callback(arg_9_0.handle, arg_9_0.selectId)
	arg_9_0:closeThis()
end

function var_0_0.onConstructor(arg_10_0)
	return
end

function var_0_0._onBtnEsc(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	FightDataHelper.tempMgr.aiJiAoSelectTargetView = true
	FightDataHelper.tempMgr.hideNameUIByTimeline = true

	local var_12_0 = FightHelper.getAllEntitys()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1.nameUI then
			iter_12_1.nameUI:setActive(false)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)
	NavigateMgr.instance:addEscape(arg_12_0.viewContainer.viewName, arg_12_0._onBtnEsc, arg_12_0)

	arg_12_0.callback = arg_12_0.viewParam.callback
	arg_12_0.handle = arg_12_0.viewParam.handle

	local var_12_1 = arg_12_0.viewParam.fromId
	local var_12_2 = FightDataHelper.entityMgr:getById(var_12_1)
	local var_12_3 = arg_12_0.viewParam.skillId
	local var_12_4 = arg_12_0.viewParam.targetLimit

	arg_12_0.itemList = {}

	for iter_12_2, iter_12_3 in ipairs(var_12_4) do
		local var_12_5 = gohelper.cloneInPlace(arg_12_0.objItem)

		table.insert(arg_12_0.itemList, arg_12_0:com_openSubView(FightAiJiAoQteSelectItemView, var_12_5, nil, var_12_1, iter_12_3))
	end

	arg_12_0.selectId = var_12_4[1]

	gohelper.setActive(arg_12_0.objItem, false)

	local var_12_6 = lua_skill.configDict[var_12_2.exSkill]

	if var_12_6 then
		local var_12_7 = ResUrl.getSkillIcon(var_12_6.icon)

		arg_12_0.exSkillIcon:LoadImage(var_12_7)
	end

	local var_12_8 = FightModel.instance.maxWave
	local var_12_9 = FightModel.instance:getCurWaveId()
	local var_12_10 = math.min(var_12_9, var_12_8)

	arg_12_0.txtWave.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_wave_lang"), var_12_10, var_12_8)

	local var_12_11 = FightModel.instance:getMaxRound()
	local var_12_12 = FightModel.instance:getCurRoundId()
	local var_12_13 = math.min(var_12_12, var_12_11)

	arg_12_0.txtRound.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("fight_round_lang"), var_12_13, var_12_11)

	local var_12_14 = var_12_2.skin == 312301 and "singlebg/fight/azio/fight_azio_role_1.png" or "singlebg/fight/azio/fight_azio_role_2.png"

	arg_12_0.roleImg:LoadImage(var_12_14)

	local var_12_15 = arg_12_0:com_registFlowSequence()

	var_12_15:registWork(FightWorkPlayAnimator, arg_12_0.viewGO, "open")
	var_12_15:registWork(FightWorkFunction, arg_12_0.onOpenAnimatorFinish, arg_12_0, var_12_4)
	var_12_15:start()

	arg_12_0.skillNameText.text = var_12_6.name
	arg_12_0.skillDescText.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getSkillEffectDesc(nil, var_12_6))
end

function var_0_0.onOpenAnimatorFinish(arg_13_0, arg_13_1)
	if arg_13_0.selected then
		return
	end

	local var_13_0 = FightDataHelper.operationDataMgr.curSelectEntityId

	var_13_0 = (not var_13_0 or var_13_0 ~= 0) and var_13_0

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if iter_13_1 == var_13_0 then
			arg_13_0.itemList[iter_13_0]:onClick()

			break
		end
	end

	if not var_13_0 then
		local var_13_1 = arg_13_1[1]

		arg_13_0.itemList[1]:onClick()
	end
end

function var_0_0.getTargetLimit(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, arg_14_0, arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = FightDataHelper.entityMgr:getById(iter_14_1)

		if var_14_2.entityType == 3 then
			-- block empty
		elseif var_14_2:hasBuffFeature(FightEnum.BuffType_CantSelect) or var_14_2:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
			-- block empty
		elseif DungeonModel.instance.curSendChapterId ~= DungeonEnum.ChapterId.RoleDuDuGu or var_14_2.originSkin ~= CharacterEnum.DefaultSkinId.DuDuGu then
			table.insert(var_14_0, iter_14_1)
		end
	end

	table.sort(var_14_0, var_0_0.sortByPosX)

	return var_14_0
end

function var_0_0.onSelectItem(arg_15_0, arg_15_1)
	AudioMgr.instance:trigger(20305033)

	arg_15_0.selected = true
	arg_15_0.selectId = arg_15_1

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.itemList) do
		iter_15_1:showSelect(arg_15_1)
	end
end

function var_0_0.sortByPosX(arg_16_0, arg_16_1)
	local var_16_0 = FightHelper.getEntity(arg_16_0)
	local var_16_1 = var_16_0 and var_16_0.go
	local var_16_2 = FightHelper.getEntity(arg_16_1)
	local var_16_3 = var_16_2 and var_16_2.go

	if var_16_1 and var_16_3 then
		return transformhelper.getLocalPos(var_16_1.transform) < transformhelper.getLocalPos(var_16_3.transform)
	else
		return false
	end
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
