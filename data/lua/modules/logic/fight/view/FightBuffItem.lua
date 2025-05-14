module("modules.logic.fight.view.FightBuffItem", package.seeall)

local var_0_0 = class("FightBuffItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._imgIcon = gohelper.findChildImage(arg_1_1, "icon")
	arg_1_0._txtBadBuff = gohelper.findChildText(arg_1_1, "badText")
	arg_1_0._txtGoodBuff = gohelper.findChildText(arg_1_1, "goodText")
	arg_1_0._txtBadCount = gohelper.findChildText(arg_1_1, "badText_count")
	arg_1_0._txtGoodCount = gohelper.findChildText(arg_1_1, "goodText_count")
	arg_1_0._bgIcon = gohelper.findChildImage(arg_1_1, "bg")
	arg_1_0.bgeffect = gohelper.findChild(arg_1_1, "bgeffect")
	arg_1_0.buffquan = gohelper.findChild(arg_1_1, "buffquan")
	arg_1_0.bufffinish = gohelper.findChild(arg_1_1, "bufffinish")
	arg_1_0.buffdot = gohelper.findChild(arg_1_1, "buffdot")
	arg_1_0._animator = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._click = gohelper.getClick(arg_1_1)

	gohelper.addUIClickAudio(arg_1_1, AudioEnum.UI.UI_Common_Click)

	arg_1_0._tipsOffsetX = 0
	arg_1_0._tipsOffsetY = 0

	arg_1_0:closeAni()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.setClickCallback(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._callback = arg_4_1
	arg_4_0._callbackObj = arg_4_2
end

function var_0_0._onClick(arg_5_0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if arg_5_0._callback then
		arg_5_0._callback(arg_5_0._callbackObj, arg_5_0.buffMO.entityId)
	else
		FightController.instance:dispatchEvent(FightEvent.OnBuffClick, arg_5_0.buffMO.entityId, arg_5_0.tr, arg_5_0._tipsOffsetX, arg_5_0._tipsOffsetY)
	end
end

function var_0_0.setTipsOffset(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._tipsOffsetX = arg_6_1
	arg_6_0._tipsOffsetY = arg_6_2
end

function var_0_0.updateBuffMO(arg_7_0, arg_7_1)
	if arg_7_0.buffMO and arg_7_0.buffMO.buffId ~= arg_7_1.buffId and not FightHelper.shouUIPoisoningEffect(arg_7_1.buffId) then
		arg_7_0:_hidePoisoningEffect()
	end

	arg_7_0.buffMO = arg_7_1

	local var_7_0 = lua_skill_buff.configDict[arg_7_1.buffId]

	if var_7_0 then
		gohelper.onceAddComponent(arg_7_0.go, gohelper.Type_CanvasGroup).alpha = 1

		local var_7_1 = var_7_0.iconId

		if string.nilorempty(var_7_1) or var_7_1 == "0" then
			logError(string.format("try show buff icon, but buffId : %s, buffName : %s, buffIconId : %s", var_7_0.id, var_7_0.name, var_7_1))
		else
			UISpriteSetMgr.instance:setBuffSprite(arg_7_0._imgIcon, var_7_0.iconId)
		end

		arg_7_0:refreshTxt(arg_7_1, var_7_0)

		local var_7_2 = lua_skill_bufftype.configDict[var_7_0.typeId]

		if arg_7_0:isTimeBuff(var_7_0) then
			gohelper.setActive(arg_7_0._bgIcon.gameObject, true)
			UISpriteSetMgr.instance:setFightSprite(arg_7_0._bgIcon, "buff_jishiqi_" .. arg_7_0:calculateBuffType(var_7_2.type))
		elseif var_7_2.cannotRemove then
			UISpriteSetMgr.instance:setFightSprite(arg_7_0._bgIcon, "buff_bukechexiao_" .. arg_7_0:calculateBuffType(var_7_2.type))
			gohelper.setActive(arg_7_0._bgIcon.gameObject, true)
		else
			gohelper.setActive(arg_7_0._bgIcon.gameObject, false)
		end
	else
		logError("buff config not exist, id = " .. arg_7_1.buffId)
	end
end

function var_0_0.getBuffGoodText(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return ""
	end

	if FightBuffHelper.isCountContinueChanelBuff(arg_8_1) then
		return arg_8_1.exInfo
	end

	if arg_8_1.duration > 0 then
		return arg_8_1.duration
	end

	return ""
end

function var_0_0.refreshTxt(arg_9_0, arg_9_1, arg_9_2)
	if FightBuffHelper.isDeadlyPoisonBuff(arg_9_1) then
		arg_9_0:refreshDeadlyPoisonTxt(arg_9_1, arg_9_2)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(arg_9_1) then
		arg_9_0:refreshDuduBoneContinueChannelTxt(arg_9_1, arg_9_2)

		return
	end

	if arg_9_2.isGoodBuff == 1 then
		gohelper.setActive(arg_9_0._txtGoodBuff.gameObject, true)
		gohelper.setActive(arg_9_0._txtGoodCount.gameObject, true)
		gohelper.setActive(arg_9_0._txtBadBuff.gameObject, false)
		gohelper.setActive(arg_9_0._txtBadCount.gameObject, false)

		if FightSkillBuffMgr.instance:buffIsStackerBuff(arg_9_2) then
			arg_9_0._txtGoodBuff.text = ""
			arg_9_0._txtGoodCount.text = FightSkillBuffMgr.instance:getStackedCount(arg_9_1.entityId, arg_9_1)
		else
			arg_9_0._txtGoodBuff.text = arg_9_0:getBuffGoodText(arg_9_1)

			if arg_9_1.layer and arg_9_1.layer > 0 then
				arg_9_0._txtGoodCount.text = arg_9_1.layer
			else
				arg_9_0._txtGoodCount.text = arg_9_1.count > 0 and arg_9_1.count or ""
			end
		end
	else
		gohelper.setActive(arg_9_0._txtGoodBuff.gameObject, false)
		gohelper.setActive(arg_9_0._txtGoodCount.gameObject, false)
		gohelper.setActive(arg_9_0._txtBadBuff.gameObject, true)
		gohelper.setActive(arg_9_0._txtBadCount.gameObject, true)

		local var_9_0, var_9_1 = FightSkillBuffMgr.instance:buffIsStackerBuff(arg_9_2)

		if var_9_0 then
			arg_9_0._txtBadBuff.text = ""

			if var_9_1 == FightEnum.BuffIncludeTypes.Stacked12 then
				arg_9_0._txtBadBuff.text = arg_9_1.duration > 0 and arg_9_1.duration or ""
			end

			arg_9_0._txtBadCount.text = FightSkillBuffMgr.instance:getStackedCount(arg_9_1.entityId, arg_9_1)
		else
			arg_9_0._txtBadBuff.text = arg_9_1.duration > 0 and arg_9_1.duration or ""

			if arg_9_1.layer and arg_9_1.layer > 0 then
				arg_9_0._txtBadCount.text = arg_9_1.layer
			else
				arg_9_0._txtBadCount.text = arg_9_1.count > 0 and arg_9_1.count or ""
			end
		end
	end
end

function var_0_0.refreshDeadlyPoisonTxt(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_0._txtGoodBuff.gameObject, false)
	gohelper.setActive(arg_10_0._txtGoodCount.gameObject, false)
	gohelper.setActive(arg_10_0._txtBadBuff.gameObject, true)
	gohelper.setActive(arg_10_0._txtBadCount.gameObject, true)

	arg_10_0._txtBadBuff.text = arg_10_1.duration > 0 and arg_10_1.duration or ""
	arg_10_0._txtBadCount.text = FightSkillBuffMgr.instance:getStackedCount(arg_10_1.entityId, arg_10_1)
end

function var_0_0.refreshDuduBoneContinueChannelTxt(arg_11_0, arg_11_1, arg_11_2)
	gohelper.setActive(arg_11_0._txtGoodBuff.gameObject, true)
	gohelper.setActive(arg_11_0._txtGoodCount.gameObject, true)
	gohelper.setActive(arg_11_0._txtBadBuff.gameObject, false)
	gohelper.setActive(arg_11_0._txtBadCount.gameObject, false)

	arg_11_0._txtGoodBuff.text = arg_11_1.exInfo
	arg_11_0._txtGoodCount.text = ""
end

function var_0_0.calculateBuffType(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(FightEnum.BuffTypeList.GoodBuffList) do
		if arg_12_1 == iter_12_1 then
			return FightEnum.FightBuffType.GoodBuff
		end
	end

	for iter_12_2, iter_12_3 in ipairs(FightEnum.BuffTypeList.BadBuffList) do
		if arg_12_1 == iter_12_3 then
			return FightEnum.FightBuffType.BadBuff
		end
	end

	return FightEnum.FightBuffType.NormalBuff
end

function var_0_0.isTimeBuff(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.features

	if string.nilorempty(var_13_0) then
		return false
	end

	local var_13_1 = FightStrUtil.instance:getSplitCache(var_13_0, "|")
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_3 = FightStrUtil.instance:getSplitToNumberCache(iter_13_1, "#")

		if #var_13_3 >= 2 and var_13_3[1] == 702 and var_13_3[2] > 2 then
			return true
		end
	end

	return false
end

function var_0_0.showPoisoningEffect(arg_14_0)
	arg_14_0:playAni("buffeffect")
end

function var_0_0._hidePoisoningEffect(arg_15_0)
	arg_15_0:closeAni()
end

function var_0_0.playAni(arg_16_0, arg_16_1)
	local var_16_0 = FightModel.instance:getUISpeed()

	arg_16_0._animator.enabled = true
	arg_16_0._animator.speed = var_16_0

	arg_16_0._animator:Play(arg_16_1, 0, 0)

	local var_16_1 = arg_16_0._animator:GetCurrentAnimatorStateInfo(0).length / var_16_0

	TaskDispatcher.runDelay(arg_16_0.closeAni, arg_16_0, var_16_1)

	return var_16_1
end

function var_0_0.closeAni(arg_17_0)
	if not arg_17_0._animator then
		return
	end

	arg_17_0._animator.enabled = false

	ZProj.UGUIHelper.SetColorAlpha(arg_17_0._imgIcon, 1)

	gohelper.onceAddComponent(arg_17_0.go, gohelper.Type_CanvasGroup).alpha = 1

	gohelper.setActive(arg_17_0.bgeffect, false)
	gohelper.setActive(arg_17_0.buffquan, false)
	gohelper.setActive(arg_17_0.bufffinish, false)
	gohelper.setActive(arg_17_0.buffdot, false)
	transformhelper.setLocalScale(arg_17_0._txtBadBuff.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(arg_17_0._txtGoodBuff.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(arg_17_0._txtBadCount.transform, 0.4, 0.4, 1)
	transformhelper.setLocalScale(arg_17_0._txtGoodCount.transform, 0.4, 0.4, 1)
end

function var_0_0.onDestroy(arg_18_0)
	arg_18_0._imgIcon = nil
	arg_18_0._callback = nil
	arg_18_0._callbackObj = nil

	TaskDispatcher.cancelTask(arg_18_0._hidePoisoningEffect, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.closeAni, arg_18_0)
end

return var_0_0
