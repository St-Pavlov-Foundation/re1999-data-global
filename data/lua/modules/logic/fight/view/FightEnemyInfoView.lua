module("modules.logic.fight.view.FightEnemyInfoView", package.seeall)

local var_0_0 = class("FightEnemyInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_2_0._checkHideUI, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_2_0._onCameraFocusChanged, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpenEnemyInfo, arg_2_0.OnOpenEnemyInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, arg_3_0._checkHideUI, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_3_0._onCameraFocusChanged, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleOpenEnemyInfo, arg_3_0.OnOpenEnemyInfo, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.enemyInfoBtn = gohelper.findChildButton(arg_4_0.viewGO, "root/topLeftContent/enemyinfo/#btn_enemyinfo")
	arg_4_0.enemyInfoGo = gohelper.findChild(arg_4_0.viewGO, "root/topLeftContent/enemyinfo/")

	local var_4_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack)
	local var_4_1 = FightDataHelper.stateMgr.isReplay

	gohelper.setActive(arg_4_0.enemyInfoGo, var_4_0 and not var_4_1 and GMFightShowState.leftMonster)

	if var_4_0 then
		arg_4_0.enemyInfoBtn:AddClickListener(arg_4_0.enemyInfoBtnOnClick, arg_4_0)
	end
end

function var_0_0.OnOpenEnemyInfo(arg_5_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack) then
		arg_5_0:enemyInfoBtnOnClick()
	end
end

function var_0_0._onCameraFocusChanged(arg_6_0, arg_6_1)
	arg_6_0._isFocus = arg_6_1
end

function var_0_0._checkHideUI(arg_7_0)
	local var_7_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightBack)
	local var_7_1 = FightDataHelper.stateMgr.isReplay

	gohelper.setActive(arg_7_0.enemyInfoGo, var_7_0 and not var_7_1 and GMFightShowState.leftMonster)
end

function var_0_0.enemyInfoBtnOnClick(arg_8_0)
	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		logNormal("新手第一个指引不能长按查看详情")

		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		logNormal("出完牌了不能长按查看详情")

		return
	end

	if arg_8_0._isFocus then
		logNormal("正在查看怪物详情，不给点")

		return
	end

	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	arg_8_0.viewContainer:openFightFocusView()
end

function var_0_0.onClose(arg_9_0)
	arg_9_0.enemyInfoBtn:RemoveClickListener()
end

return var_0_0
