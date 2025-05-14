module("modules.logic.fight.view.indicator.FightSuccIndicator", package.seeall)

local var_0_0 = class("FightSuccIndicator", FightIndicatorBaseView)
local var_0_1 = "ui/viewres/versionactivity_1_2/versionactivity_1_2_successitem.prefab"

function var_0_0.initView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.initView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.goSuccContainer = gohelper.findChild(arg_1_0.goIndicatorRoot, "success_indicator")
end

function var_0_0.startLoadPrefab(arg_2_0)
	gohelper.setActive(arg_2_0.goSuccContainer, true)

	arg_2_0.loader = PrefabInstantiate.Create(arg_2_0.goSuccContainer)

	arg_2_0.loader:startLoad(var_0_1, arg_2_0.onLoadCallback, arg_2_0)
end

function var_0_0.onLoadCallback(arg_3_0)
	arg_3_0.loadDone = true
	arg_3_0.instanceGo = arg_3_0.loader:getInstGO()
	arg_3_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_3_0.instanceGo)
	arg_3_0.txtIndicatorProcess = gohelper.findChildText(arg_3_0.instanceGo, "txt_itemProcess")

	local var_3_0 = FightDataHelper.fieldMgr:getIndicatorNum(arg_3_0.indicatorId)

	arg_3_0.txtIndicatorProcess.text = string.format("%d/%d", var_3_0, arg_3_0.totalIndicatorNum)
end

function var_0_0.onIndicatorChange(arg_4_0)
	if not arg_4_0.loadDone then
		return
	end

	arg_4_0:updateUI()
end

function var_0_0.updateUI(arg_5_0)
	if not arg_5_0.loadDone then
		return
	end

	local var_5_0 = FightDataHelper.fieldMgr:getIndicatorNum(arg_5_0.indicatorId)

	arg_5_0.txtIndicatorProcess.text = string.format("%d/%d", var_5_0, arg_5_0.totalIndicatorNum)

	FightModel.instance:setWaitIndicatorAnimation(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_triumph_dreamepilogue_collect)
	arg_5_0.animatorPlayer:Play("add", arg_5_0.onAddAnimationDone, arg_5_0)
end

function var_0_0.onAddAnimationDone(arg_6_0)
	if FightDataHelper.fieldMgr:getIndicatorNum(arg_6_0.indicatorId) == arg_6_0.totalIndicatorNum then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_triumph_dreamepilogue_achieve)
		arg_6_0.animatorPlayer:Play("finish", arg_6_0.onFinishAnimationDone, arg_6_0)
	else
		FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
	end
end

function var_0_0.onFinishAnimationDone(arg_7_0)
	FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
end

function var_0_0.onDestroy(arg_8_0)
	if arg_8_0.loader then
		arg_8_0.loader:dispose()
	end

	var_0_0.super.onDestroy(arg_8_0)
end

return var_0_0
