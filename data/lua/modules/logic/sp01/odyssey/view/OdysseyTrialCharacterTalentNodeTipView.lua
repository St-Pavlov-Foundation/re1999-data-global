module("modules.logic.sp01.odyssey.view.OdysseyTrialCharacterTalentNodeTipView", package.seeall)

local var_0_0 = class("OdysseyTrialCharacterTalentNodeTipView", CharacterSkillTalentNodeTipView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onClickTalentTreeNode, arg_2_0._onClickTalentTreeNode, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, arg_2_0._closeTip, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, arg_2_0._closeTip, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onClickTalentTreeNode, arg_3_0._onClickTalentTreeNode, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, arg_3_0._closeTip, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, arg_3_0._closeTip, arg_3_0)
end

function var_0_0._btnyesOnClick(arg_4_0)
	if not arg_4_0.skillTalentMo then
		return
	end

	if arg_4_0.skillTalentMo:isNullTalentPonit(arg_4_0.heroMo) then
		return
	end

	if arg_4_0._nodeMo:isLight() then
		return
	end

	if arg_4_0.isActTrialHero then
		OdysseyRpc.instance:sendOdysseyTalentCassandraTreeChoiceRequest(arg_4_0._sub, arg_4_0._level)
	end
end

function var_0_0._btnnoOnClick(arg_5_0)
	if not arg_5_0.skillTalentMo then
		return
	end

	if not arg_5_0._nodeMo:isLight() then
		return
	end

	if arg_5_0.isActTrialHero then
		OdysseyRpc.instance:sendOdysseyTalentCassandraTreeCancelRequest(arg_5_0._sub, arg_5_0._level)
	end
end

function var_0_0._onClickTalentTreeNode(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:_openNodeTip(arg_6_1, arg_6_2)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.heroMo = arg_7_0.viewParam

	local var_7_0 = arg_7_0.heroMo.extraMo
	local var_7_1 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local var_7_2 = tonumber(var_7_1.value)

	arg_7_0.isActTrialHero = arg_7_0.heroMo.trialCo and arg_7_0.heroMo.trialCo.id == var_7_2
	arg_7_0.skillTalentMo = var_7_0 and arg_7_0.heroMo.trialCo and arg_7_0.isActTrialHero and OdysseyTalentModel.instance:getTrialCassandraTreeInfo() or var_7_0:getSkillTalentMo()
	arg_7_0._isShowTip = false

	gohelper.setActive(arg_7_0._gotip, false)
	gohelper.setActive(arg_7_0._btnclose.gameObject, false)
end

function var_0_0._openNodeTip(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.heroMo.exSkillLevel

	recthelper.setAnchorX(arg_8_0._gotip.transform, arg_8_1 == 2 and 500 or 0)

	local var_8_1 = arg_8_0.skillTalentMo:getTreeNodeMoBySubLevel(arg_8_1, arg_8_2)

	arg_8_0._sub = arg_8_1
	arg_8_0._level = arg_8_2
	arg_8_0._txtname.text = var_8_1.co.name

	local var_8_2 = var_8_1:getDesc(var_8_0)
	local var_8_3 = var_8_1:getFieldActivateDesc(var_8_0)

	arg_8_0._skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._txtdesc.gameObject, SkillDescComp)

	arg_8_0._skillDesc:updateInfo(arg_8_0._txtdesc, var_8_2, arg_8_0.heroMo.heroId)
	UISpriteSetMgr.instance:setUiCharacterSprite(arg_8_0._imageTag, arg_8_0.skillTalentMo:getSmallSubIconPath(arg_8_1))

	arg_8_0._treeMo = arg_8_0.skillTalentMo:getTreeMosBySub(arg_8_1)
	arg_8_0._nodeMo = arg_8_0.skillTalentMo:getTreeNodeMoBySubLevel(arg_8_1, arg_8_2)

	local var_8_4 = #arg_8_0.skillTalentMo:getLightOrCancelNodes(arg_8_1, arg_8_2)

	if arg_8_0._nodeMo:isLight() then
		arg_8_0._txtnonum.text = "+" .. var_8_4
		arg_8_0._txtlocknum.text = "+" .. var_8_4
	elseif arg_8_0._nodeMo:isLock() then
		arg_8_0._txtlocknum.text = "+" .. var_8_4
	else
		arg_8_0._txtyesnum.text = "-" .. var_8_4
	end

	arg_8_0._fieldDesc = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._txtfield.gameObject, SkillDescComp)

	arg_8_0._fieldDesc:updateInfo(arg_8_0._txtfield, var_8_3, arg_8_0.heroMo.heroId)

	local var_8_5 = arg_8_0._treeMo:isAllLight()
	local var_8_6 = arg_8_0._nodeMo:isLock()
	local var_8_7 = arg_8_0._nodeMo:isLight()
	local var_8_8 = arg_8_0._nodeMo:isNormal()
	local var_8_9 = arg_8_0.skillTalentMo:getExtraCount()
	local var_8_10 = ""
	local var_8_11 = ""
	local var_8_12 = var_8_4 > arg_8_0.skillTalentMo:getTalentpoint()

	if var_8_12 then
		var_8_10 = luaLang("characterskilltalent_warning_3")
	end

	local var_8_13 = arg_8_0.skillTalentMo:getMainFieldMo()

	if var_8_13 then
		local var_8_14 = var_8_13.co and var_8_13.co.sub

		if var_8_14 and var_8_14 ~= arg_8_1 then
			if not var_8_12 then
				var_8_10 = luaLang("characterskilltalent_warning_2")
			end

			local var_8_15 = luaLang("characterskilltalent_warning_1")
			local var_8_16 = luaLang("characterskilltalent_sub_" .. var_8_14)
			local var_8_17 = luaLang("characterskilltalent_sub_" .. arg_8_1)

			var_8_11 = GameUtil.getSubPlaceholderLuaLangTwoParam(var_8_15, var_8_16, var_8_17)
		end
	end

	local var_8_18 = var_8_5 and var_8_9 == 2

	arg_8_0._txtWarning.text = var_8_11
	arg_8_0._txtTips.text = var_8_10

	local var_8_19 = var_8_6 and not string.nilorempty(var_8_10)
	local var_8_20 = not string.nilorempty(var_8_11)
	local var_8_21 = not string.nilorempty(var_8_3)

	gohelper.setActive(arg_8_0._gofieldbg.gameObject, arg_8_0.isActTrialHero and (var_8_20 or var_8_21))
	gohelper.setActive(arg_8_0._golichang.gameObject, arg_8_0.isActTrialHero and var_8_21)
	gohelper.setActive(arg_8_0._txtTips.gameObject, arg_8_0.isActTrialHero and var_8_19)
	gohelper.setActive(arg_8_0._txtWarning.gameObject, arg_8_0.isActTrialHero and var_8_20)
	gohelper.setActive(arg_8_0._btnyes.gameObject, arg_8_0.isActTrialHero and not var_8_18 and var_8_8)
	gohelper.setActive(arg_8_0._btnno.gameObject, arg_8_0.isActTrialHero and not var_8_18 and var_8_7)
	gohelper.setActive(arg_8_0._btnLocked.gameObject, arg_8_0.isActTrialHero and (var_8_18 or var_8_19))
	gohelper.setActive(arg_8_0._goWarning.gameObject, arg_8_0.isActTrialHero and not var_8_5 and var_8_20)
	arg_8_0:_activeTip(true)
end

return var_0_0
