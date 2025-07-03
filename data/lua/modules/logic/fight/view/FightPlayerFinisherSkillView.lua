module("modules.logic.fight.view.FightPlayerFinisherSkillView", package.seeall)

local var_0_0 = class("FightPlayerFinisherSkillView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "skill/btn_skill")
	arg_1_0._longPress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._click.gameObject)
	arg_1_0._used = gohelper.findChild(arg_1_0.viewGO, "used")
	arg_1_0._power = gohelper.findChild(arg_1_0.viewGO, "power")
	arg_1_0._noPower = gohelper.findChild(arg_1_0.viewGO, "noPower")
	arg_1_0._powerList = {}
	arg_1_0._aniList = {}

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "skill/go_energy").transform

	for iter_1_0 = 0, 4 do
		local var_1_1 = var_1_0:GetChild(iter_1_0).gameObject

		table.insert(arg_1_0._powerList, var_1_1)

		local var_1_2 = gohelper.onceAddComponent(var_1_1, typeof(UnityEngine.Animator))

		table.insert(arg_1_0._aniList, var_1_2)
	end

	arg_1_0._tips = gohelper.findChild(arg_1_0.viewGO, "skill/#go_skilltip")
	arg_1_0._btnClose = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "skill/#go_skilltip/#btn_close")
	arg_1_0._title = gohelper.findChildText(arg_1_0.viewGO, "skill/#go_skilltip/bg/#txt_title")
	arg_1_0._desc = gohelper.findChildText(arg_1_0.viewGO, "skill/#go_skilltip/bg/#txt_dec")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registMsg(FightMsgId.RefreshPlayerFinisherSkill, arg_2_0._onRefreshPlayerFinisherSkill)
	arg_2_0:com_registFightEvent(FightEvent.PowerChange, arg_2_0._onPowerChange)
	arg_2_0:com_registFightEvent(FightEvent.PowerInfoChange, arg_2_0._onPowerInfoChange)
	arg_2_0:com_registFightEvent(FightEvent.StageChanged, arg_2_0._onStageChanged)
	arg_2_0:com_registFightEvent(FightEvent.CancelOperation, arg_2_0._onCancelOperation)
	arg_2_0:com_registFightEvent(FightEvent.TouchFightViewScreen, arg_2_0._onTouchFightViewScreen)
	arg_2_0:com_registClick(arg_2_0._click, arg_2_0._onClick)
	arg_2_0:com_registLongPress(arg_2_0._longPress, arg_2_0._onLongPress)
	arg_2_0:com_registClick(arg_2_0._btnClose, arg_2_0._onBtnClose)
end

function var_0_0._onTouchFightViewScreen(arg_3_0)
	gohelper.setActive(arg_3_0._tips, false)
end

function var_0_0._onBtnClose(arg_4_0)
	gohelper.setActive(arg_4_0._tips, false)
end

function var_0_0._onLongPress(arg_5_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	gohelper.setActive(arg_5_0._tips, true)
end

function var_0_0._onCancelOperation(arg_6_0)
	arg_6_0:_refreshPower()
end

function var_0_0._onStageChanged(arg_7_0)
	arg_7_0:_refreshPower()
end

function var_0_0._canUse(arg_8_0)
	local var_8_0 = arg_8_0:_getSkillData()

	if var_8_0 then
		local var_8_1 = FightDataHelper.entityMgr:getById(FightEntityScene.MySideId)

		if not var_8_1 then
			return
		end

		local var_8_2 = var_8_1:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill)

		if not var_8_2 then
			return
		end

		arg_8_0._curSkillId = var_8_0.skillId

		local var_8_3 = FightDataHelper.operationDataMgr.playerFinisherSkillUsedCount or 0

		if var_8_3 >= FightDataHelper.fieldMgr.playerFinisherInfo.roundUseLimit then
			return
		end

		local var_8_4 = var_8_0.needPower

		if var_8_4 > var_8_2.num - var_8_3 * var_8_4 then
			return
		end

		return true, var_8_0
	end

	return false
end

function var_0_0._onClick(arg_9_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	local var_9_0, var_9_1 = arg_9_0:_canUse()

	if var_9_0 then
		local var_9_2 = var_9_1.skillId

		arg_9_0._curSkillId = var_9_2

		local var_9_3 = lua_skill.configDict[var_9_2]
		local var_9_4 = FightDataHelper.entityMgr:getMyNormalList()
		local var_9_5 = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
		local var_9_6 = #var_9_4 + #var_9_5

		if var_9_3 and FightEnum.ShowLogicTargetView[var_9_3.logicTarget] and var_9_3.targetLimit == FightEnum.TargetLimit.MySide then
			if var_9_6 > 1 then
				ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
					fromId = FightEntityScene.MySideId,
					skillId = var_9_2,
					callback = arg_9_0._useSkill,
					callbackObj = arg_9_0
				})

				return
			end

			if var_9_6 == 1 then
				arg_9_0:_useSkill(var_9_4[1].id)

				return
			end
		end

		arg_9_0:_useSkill(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function var_0_0._useSkill(arg_10_0, arg_10_1)
	arg_10_0:_playAudio(20249031)

	local var_10_0 = FightDataHelper.operationDataMgr:newOperation()

	var_10_0:playPlayerFinisherSkill(arg_10_0._curSkillId, arg_10_1)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_10_0)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, var_10_0)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, var_10_0)

	FightDataHelper.operationDataMgr.playerFinisherSkillUsedCount = (FightDataHelper.operationDataMgr.playerFinisherSkillUsedCount or 0) + 1

	arg_10_0:_refreshPower()
end

function var_0_0._onRefreshPlayerFinisherSkill(arg_11_0)
	arg_11_0:_initSkill()
	arg_11_0:_refreshPower()
	arg_11_0:_playChangeAudio()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_initSkill()
	arg_12_0:_refreshPower()
	arg_12_0:_playChangeAudio()
end

function var_0_0._playChangeAudio(arg_13_0)
	local var_13_0 = arg_13_0:_canUse()

	if var_13_0 ~= arg_13_0._lastCanUse then
		arg_13_0._lastCanUse = var_13_0

		arg_13_0:_playAudio(arg_13_0._lastCanUse and 20249032 or 20249030)
	end
end

function var_0_0._initSkill(arg_14_0)
	local var_14_0 = arg_14_0:_getSkillData()

	if var_14_0 then
		local var_14_1 = lua_skill.configDict[var_14_0.skillId]

		arg_14_0._title.text = var_14_1.name

		local var_14_2 = FightConfig.instance:getEntitySkillDesc(FightEntityScene.MySideId, var_14_1, var_14_0.skillId)

		arg_14_0._desc.text = HeroSkillModel.instance:skillDesToSpot(var_14_2, "#c56131", "#7c93ad")
	end
end

function var_0_0._getSkillData(arg_15_0)
	local var_15_0 = FightDataHelper.fieldMgr.playerFinisherInfo

	return var_15_0 and var_15_0.skills[1]
end

function var_0_0._refreshPower(arg_16_0)
	local var_16_0 = arg_16_0:_getSkillData()
	local var_16_1 = FightDataHelper.entityMgr:getById(FightEntityScene.MySideId)
	local var_16_2 = var_16_1 and var_16_1:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill)

	if var_16_2 then
		gohelper.setActive(arg_16_0.viewGO, true)

		local var_16_3 = FightDataHelper.operationDataMgr.playerFinisherSkillUsedCount or 0
		local var_16_4 = var_16_0 and var_16_0.needPower or 0
		local var_16_5 = var_16_2.max
		local var_16_6 = var_16_2.num
		local var_16_7 = var_16_6 - var_16_3 * var_16_4

		gohelper.setActive(arg_16_0._used, var_16_3 > 0)
		gohelper.setActive(arg_16_0._power, var_16_3 <= 0 and var_16_7 > 0)
		gohelper.setActive(arg_16_0._noPower, var_16_3 <= 0 and var_16_7 <= 0)

		for iter_16_0, iter_16_1 in ipairs(arg_16_0._powerList) do
			gohelper.setActive(iter_16_1, iter_16_0 <= var_16_5)
			gohelper.setActive(gohelper.findChild(iter_16_1, "light"), iter_16_0 <= var_16_6)

			local var_16_8 = iter_16_0 <= var_16_7 and "idle" or "flash"

			arg_16_0._aniList[iter_16_0]:Play(var_16_8, -1, 0)
		end
	else
		gohelper.setActive(arg_16_0.viewGO, false)
	end
end

function var_0_0._playAudio(arg_17_0, arg_17_1)
	AudioMgr.instance:trigger(arg_17_1)
end

function var_0_0._onPowerChange(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_1 == FightEntityScene.MySideId and arg_18_2 == FightEnum.PowerType.PlayerFinisherSkill then
		arg_18_0:_refreshPower()

		if arg_18_3 < arg_18_4 then
			for iter_18_0 = arg_18_3 + 1, arg_18_4 do
				arg_18_0._aniList[iter_18_0]:Play("add")
			end

			arg_18_0:_playAudio(20249033)
		end

		arg_18_0:_playChangeAudio()
	end
end

function var_0_0._onPowerInfoChange(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == FightEntityScene.MySideId and arg_19_2 == FightEnum.PowerType.PlayerFinisherSkill then
		arg_19_0:_refreshPower()
		arg_19_0:_playChangeAudio()
	end
end

return var_0_0
