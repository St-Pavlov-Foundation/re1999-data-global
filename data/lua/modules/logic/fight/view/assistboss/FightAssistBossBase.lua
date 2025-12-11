module("modules.logic.fight.view.assistboss.FightAssistBossBase", package.seeall)

local var_0_0 = class("FightAssistBossBase", UserDataDispose)

var_0_0.InCDColor = Color(0.5019607843137255, 0.5019607843137255, 0.5019607843137255)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.goContainer = arg_1_1
	arg_1_0.loadDone = false

	arg_1_0:setPrefabPath()
	arg_1_0:loadRes()
end

function var_0_0.setPrefabPath(arg_2_0)
	arg_2_0.prefabPath = "ui/viewres/assistboss/boss0.prefab"
end

function var_0_0.loadRes(arg_3_0)
	arg_3_0.loader = PrefabInstantiate.Create(arg_3_0.goContainer)

	arg_3_0.loader:startLoad(arg_3_0.prefabPath, arg_3_0.onResLoaded, arg_3_0)
end

function var_0_0.onResLoaded(arg_4_0)
	arg_4_0.loadDone = true
	arg_4_0.viewGo = arg_4_0.loader:getInstGO()

	arg_4_0:initView()
	arg_4_0:addEvents()
	arg_4_0:refreshUI()
end

function var_0_0.initView(arg_5_0)
	arg_5_0.headImage = gohelper.findChildImage(arg_5_0.viewGo, "head/boss")
	arg_5_0.headSImage = gohelper.findChildSingleImage(arg_5_0.viewGo, "head/boss")
	arg_5_0.goCD = gohelper.findChild(arg_5_0.viewGo, "cd")
	arg_5_0.txtCD = gohelper.findChildText(arg_5_0.viewGo, "cd/cdbg/#txt_cd")

	local var_5_0 = gohelper.findChild(arg_5_0.viewGo, "clickarea")

	arg_5_0.longListener = SLFramework.UGUI.UILongPressListener.Get(var_5_0)

	arg_5_0.longListener:SetLongPressTime({
		0.5,
		99999
	})
	arg_5_0.longListener:AddLongPressListener(arg_5_0.onLongPress, arg_5_0)
	arg_5_0.longListener:AddClickListener(arg_5_0.playAssistBossCard, arg_5_0)
end

function var_0_0.addEvents(arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnAssistBossPowerChange, arg_6_0.onAssistBossPowerChange, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnAssistBossCDChange, arg_6_0.onAssistBossCDChange, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.PowerChange, arg_6_0.onPowerChange, arg_6_0)
	arg_6_0:addEventCb(FightController.instance, FightEvent.OnResetCard, arg_6_0.onResetCard, arg_6_0)
end

function var_0_0.refreshUI(arg_7_0)
	if not arg_7_0.loadDone then
		return
	end

	arg_7_0:refreshHeadImage()
	arg_7_0:refreshPower()
	arg_7_0:refreshCD()
end

function var_0_0.onAssistBossPowerChange(arg_8_0)
	arg_8_0:refreshPower()
end

function var_0_0.onAssistBossCDChange(arg_9_0)
	arg_9_0:refreshCD()
end

function var_0_0.onPowerChange(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_2 ~= FightEnum.PowerType.AssistBoss then
		return
	end

	local var_10_0 = FightDataHelper.entityMgr:getAssistBoss()

	if not var_10_0 or var_10_0.id ~= arg_10_1 then
		return
	end

	arg_10_0:refreshPower()
end

function var_0_0.onResetCard(arg_11_0)
	arg_11_0:refreshPower()
	arg_11_0:refreshCD()
end

function var_0_0.refreshHeadImage(arg_12_0)
	local var_12_0 = FightDataHelper.entityMgr:getAssistBoss().originSkin
	local var_12_1 = FightConfig.instance:getSkinCO(var_12_0)

	arg_12_0.headSImage:LoadImage(ResUrl.monsterHeadIcon(var_12_1.headIcon))
end

function var_0_0.refreshPower(arg_13_0)
	arg_13_0:refreshHeadImageColor()
end

function var_0_0.checkInCd(arg_14_0)
	local var_14_0 = FightDataHelper.paTaMgr:getCurCD()

	return var_14_0 and var_14_0 > 0
end

function var_0_0.refreshCD(arg_15_0)
	local var_15_0 = arg_15_0:checkInCd()

	gohelper.setActive(arg_15_0.goCD, var_15_0)

	if var_15_0 then
		arg_15_0.txtCD.text = tostring(FightDataHelper.paTaMgr:getCurCD())
	end

	arg_15_0:refreshHeadImageColor()
end

function var_0_0.refreshHeadImageColor(arg_16_0)
	if not FightDataHelper.paTaMgr:getCurUseSkillInfo() then
		arg_16_0.headImage.color = var_0_0.InCDColor

		return
	end

	if arg_16_0:checkInCd() then
		arg_16_0.headImage.color = var_0_0.InCDColor

		return
	end

	arg_16_0.headImage.color = Color.white
end

function var_0_0.onLongPress(arg_17_0)
	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	local var_17_0 = FightDataHelper.paTaMgr:getCurUseSkillInfo()
	local var_17_1 = FightDataHelper.paTaMgr:getBossSkillInfoList()

	if not var_17_0 then
		var_17_0 = var_17_1[1]

		if not var_17_0 then
			logError("boss not found any one skill!")

			return
		end
	end

	local var_17_2 = var_17_0.skillId
	local var_17_3 = lua_skill.configDict[var_17_2]

	if not var_17_3 then
		logError("long press assist boss, skill not exist !!! id : " .. tostring(var_17_2))

		return
	end

	arg_17_0.tempInfo = arg_17_0.tempInfo or {}

	tabletool.clear(arg_17_0.tempInfo)

	arg_17_0.tempSkillIdList = arg_17_0.tempSkillIdList or {}

	tabletool.clear(arg_17_0.tempSkillIdList)

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		table.insert(arg_17_0.tempSkillIdList, iter_17_1.skillId)
	end

	arg_17_0.tempInfo.super = var_17_3.isBigSkill == 1
	arg_17_0.tempInfo.skillIdList = arg_17_0.tempSkillIdList
	arg_17_0.tempInfo.skillIndex = 1
	arg_17_0.tempInfo.userSkillId = var_17_0.skillId

	local var_17_4 = FightDataHelper.entityMgr:getAssistBoss()

	arg_17_0.tempInfo.monsterName = var_17_4 and var_17_4:getEntityName() or ""

	if var_17_4 and arg_17_0.tempInfo.super then
		ViewMgr.instance:openView(ViewName.TowerSkillTipView, arg_17_0.tempInfo)
	else
		ViewMgr.instance:openView(ViewName.SkillTipView, arg_17_0.tempInfo)
	end
end

function var_0_0.playAssistBossCard(arg_18_0)
	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	local var_18_0 = arg_18_0:canUseSkill()

	if not var_18_0 then
		return
	end

	local var_18_1 = FightDataHelper.operationDataMgr:newOperation()

	var_18_1:playAssistBossHandCard(var_18_0.skillId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_18_1)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, var_18_1)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, var_18_1)
	FightDataHelper.paTaMgr:playAssistBossSkill(var_18_0)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)

	return true
end

function var_0_0.canUseSkill(arg_19_0)
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if not FightDataHelper.paTaMgr:canUseSkill() then
		return
	end

	local var_19_0 = FightDataHelper.paTaMgr:getCurCD()

	if var_19_0 and var_19_0 > 0 then
		return
	end

	local var_19_1 = FightDataHelper.paTaMgr:getCurUseSkillInfo()

	if not var_19_1 then
		return
	end

	if FightDataHelper.paTaMgr:getNeedPower(var_19_1) > FightDataHelper.paTaMgr:getAssistBossPower() then
		return
	end

	return var_19_1
end

var_0_0.Duration = 0.5

function var_0_0.setFillAmount(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:killTween()

	if not arg_20_1 then
		arg_20_0.curImage = nil

		return
	end

	local var_20_0 = arg_20_1.fillAmount

	arg_20_0.curImage = arg_20_1
	arg_20_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_20_0, arg_20_2, var_0_0.Duration, arg_20_0.onFrameCallback, nil, arg_20_0, nil, EaseType.Linear)
end

function var_0_0.onFrameCallback(arg_21_0, arg_21_1)
	arg_21_0.curImage.fillAmount = arg_21_1
end

function var_0_0.killTween(arg_22_0)
	if arg_22_0.tweenId then
		ZProj.TweenHelper.KillById(arg_22_0.tweenId)
	end
end

function var_0_0.destroy(arg_23_0)
	arg_23_0:killTween()

	if arg_23_0.headSImage then
		arg_23_0.headSImage:UnLoadImage()
	end

	if arg_23_0.loader then
		arg_23_0.loader:dispose()

		arg_23_0.loader = nil
	end

	if arg_23_0.longListener then
		arg_23_0.longListener:RemoveClickListener()
		arg_23_0.longListener:RemoveLongPressListener()

		arg_23_0.longListener = nil
	end

	arg_23_0.loadDone = false

	arg_23_0:__onDispose()
end

return var_0_0
