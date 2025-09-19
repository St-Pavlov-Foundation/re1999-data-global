module("modules.logic.fight.view.FightSurvivalTalentView", package.seeall)

local var_0_0 = class("FightSurvivalTalentView", FightBaseView)

var_0_0.Status = {
	CanUse = 2,
	CantUse = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0.iconImage = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#skill/#image_skill")
	arg_1_0.txtSkillName = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_skill")
	arg_1_0.goVxNormal = gohelper.findChild(arg_1_0.viewGO, "root/#skill/#normal")
	arg_1_0.goVxActive = gohelper.findChild(arg_1_0.viewGO, "root/#skill/#active")
	arg_1_0.goVxGray = gohelper.findChild(arg_1_0.viewGO, "root/#skill/#gray")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "root/#btn_click")

	arg_1_0.longPress = SLFramework.UGUI.UILongPressListener.Get(var_1_0)

	arg_1_0.longPress:SetLongPressTime({
		0.5,
		99999
	})
	gohelper.setActive(arg_1_0.goVxNormal, false)
	gohelper.setActive(arg_1_0.goVxActive, false)
	gohelper.setActive(arg_1_0.goVxGray, false)

	arg_1_0.status2Vx = {
		[var_0_0.Status.CantUse] = arg_1_0.goVxGray,
		[var_0_0.Status.CanUse] = arg_1_0.goVxActive
	}

	arg_1_0:initData()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.longPress:AddClickListener(arg_2_0.onClickTalent, arg_2_0)
	arg_2_0.longPress:AddLongPressListener(arg_2_0.onLongPressTalent, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PowerChange, arg_2_0.onPowerChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.CancelOperation, arg_2_0.onCancelOperation, arg_2_0)
end

function var_0_0.onCancelOperation(arg_3_0)
	arg_3_0:refreshVX()
end

function var_0_0.onPowerChange(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_1 ~= arg_4_0.entityId then
		return
	end

	if arg_4_2 ~= FightEnum.PowerType.PlayerFinisherSkill then
		return
	end

	arg_4_0:refreshVX()
end

function var_0_0.onClickTalent(arg_5_0)
	if not arg_5_0.skillCo then
		return
	end

	if FightDataMgr.instance.stageMgr:getCurStage() ~= FightStageMgr.StageType.Normal then
		return
	end

	local var_5_0 = FightDataHelper.operationDataMgr.survivalTalentSkillUsedCount or 0

	if var_5_0 > FightDataHelper.fieldMgr.playerFinisherInfo.roundUseLimit then
		return
	end

	local var_5_1 = FightDataHelper.entityMgr:getById(arg_5_0.entityId)

	if not var_5_1 then
		return
	end

	local var_5_2 = var_5_1:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill)

	if not var_5_2 then
		return
	end

	local var_5_3 = FightDataHelper.fieldMgr.playerFinisherInfo

	if not (var_5_3 and var_5_3.skills[1]) then
		return
	end

	if var_5_2.num - var_5_0 * arg_5_0.needPower < arg_5_0.needPower then
		return
	end

	if arg_5_0.skillCo and FightEnum.ShowLogicTargetView[arg_5_0.skillCo.logicTarget] and arg_5_0.skillCo.targetLimit == FightEnum.TargetLimit.MySide then
		local var_5_4 = FightDataHelper.entityMgr:getMyNormalList()

		if #var_5_4 <= 0 then
			return
		end

		if #var_5_4 > 1 then
			ViewMgr.instance:openView(ViewName.FightSkillTargetView, {
				skillId = arg_5_0.skillId,
				callback = arg_5_0._playSkill,
				callbackObj = arg_5_0
			})
		else
			arg_5_0:_playSkill(var_5_4[1].id)
		end
	else
		arg_5_0:_playSkill(FightDataHelper.operationDataMgr.curSelectEntityId)
	end
end

function var_0_0._playSkill(arg_6_0, arg_6_1)
	FightDataHelper.operationDataMgr:addSurvivalTalentSkillUsedCount(1)

	local var_6_0 = FightDataHelper.operationDataMgr:newOperation()

	var_6_0:playPlayerFinisherSkill(arg_6_0.skillId, arg_6_1)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_6_0)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, var_6_0)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, var_6_0)
	arg_6_0:refreshVX()
end

function var_0_0.onLongPressTalent(arg_7_0)
	if FightDataMgr.instance.stageMgr:getCurStage() ~= FightStageMgr.StageType.Normal then
		return
	end

	if not arg_7_0.skillCo then
		return
	end

	arg_7_0.tempInfo = arg_7_0.tempInfo or {}

	tabletool.clear(arg_7_0.tempInfo)

	arg_7_0.tempSkillIdList = arg_7_0.tempSkillIdList or {}
	arg_7_0.tempSkillIdList[1] = arg_7_0.skillId
	arg_7_0.tempInfo.super = arg_7_0.skillCo.isBigSkill == 1
	arg_7_0.tempInfo.skillIdList = arg_7_0.tempSkillIdList
	arg_7_0.tempInfo.skillIndex = 1
	arg_7_0.tempInfo.userSkillId = arg_7_0.skillId
	arg_7_0.tempInfo.monsterName = ""

	if arg_7_0.tempInfo.super then
		ViewMgr.instance:openView(ViewName.TowerSkillTipView, arg_7_0.tempInfo)
	else
		ViewMgr.instance:openView(ViewName.SkillTipView, arg_7_0.tempInfo)
	end
end

function var_0_0.onOpen(arg_8_0)
	if not arg_8_0.skillCo then
		return
	end

	arg_8_0.txtSkillName.text = arg_8_0.skillCo and arg_8_0.skillCo.name or ""

	arg_8_0:refreshVX()
end

function var_0_0.refreshVX(arg_9_0)
	local var_9_0 = arg_9_0:getStatus()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.status2Vx) do
		gohelper.setActive(iter_9_1, iter_9_0 == var_9_0)
	end
end

function var_0_0.getStatus(arg_10_0)
	local var_10_0 = FightDataHelper.operationDataMgr.survivalTalentSkillUsedCount or 0
	local var_10_1 = FightDataHelper.entityMgr:getById(arg_10_0.entityId)

	if not var_10_1 then
		return var_0_0.Status.CantUse
	end

	local var_10_2 = var_10_1:getPowerInfo(FightEnum.PowerType.PlayerFinisherSkill)

	if not var_10_2 then
		return var_0_0.Status.CantUse
	end

	local var_10_3 = FightDataHelper.fieldMgr.playerFinisherInfo

	if not (var_10_3 and var_10_3.skills[1]) then
		return var_0_0.Status.CantUse
	end

	if var_10_2.num - var_10_0 * arg_10_0.needPower < arg_10_0.needPower then
		return var_0_0.Status.CantUse
	end

	return var_0_0.Status.CanUse
end

function var_0_0.initData(arg_11_0)
	arg_11_0.entityId = FightEntityScene.MySideId

	local var_11_0 = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]

	if not var_11_0 then
		return
	end

	arg_11_0.talentGroupId = var_11_0.talentGroupId
	arg_11_0.talentGroupCo = arg_11_0.talentGroupId and lua_survival_talent_group.configDict[arg_11_0.talentGroupId]

	local var_11_1 = FightDataHelper.fieldMgr.playerFinisherInfo
	local var_11_2 = var_11_1 and var_11_1.skills[1]

	arg_11_0.useLimit = var_11_1 and var_11_1.roundUseLimit or 0
	arg_11_0.skillId = var_11_2 and var_11_2.skillId
	arg_11_0.needPower = var_11_2 and var_11_2.needPower or 0
	arg_11_0.skillCo = arg_11_0.skillId and lua_skill.configDict[arg_11_0.skillId]

	arg_11_0:updateTalentIcon()
end

function var_0_0.updateTalentIcon(arg_12_0)
	local var_12_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.talentBox.groupId
	local var_12_2 = lua_survival_talent_group.configDict[var_12_1]

	arg_12_0.iconImage:LoadImage(ResUrl.getSurvivalTalentIcon(var_12_2.folder .. "/icon_1"))
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0.longPress:RemoveClickListener()
	arg_13_0.longPress:RemoveLongPressListener()

	arg_13_0.longPress = nil
end

return var_0_0
