module("modules.logic.fight.view.preview.SkillEffectStatView", package.seeall)

local var_0_0 = class("SkillEffectStatView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnOpen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnOpen")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")
	arg_1_0._btnClear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/title/btnClear")
	arg_1_0._btnSpeed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/title/btnSpeed")
	arg_1_0._txtSpeed = gohelper.findChildText(arg_1_0.viewGO, "view/title/btnSpeed/Text")
	arg_1_0._slider = gohelper.findChildSlider(arg_1_0.viewGO, "view/title/slider")
	arg_1_0._contentViewGO = gohelper.findChild(arg_1_0.viewGO, "view")
	arg_1_0._imgViewBg = arg_1_0._contentViewGO:GetComponent(gohelper.Type_Image)

	arg_1_0._slider:SetValue(arg_1_0._imgViewBg.color.a)
	gohelper.setActive(arg_1_0._btnOpen.gameObject, true)
	gohelper.setActive(arg_1_0._btnClose.gameObject, false)
	gohelper.setActive(arg_1_0._contentViewGO.gameObject, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnOpen:AddClickListener(arg_2_0._onClickOpen, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnClear:AddClickListener(arg_2_0._onClickClear, arg_2_0)
	arg_2_0._btnSpeed:AddClickListener(arg_2_0._onClickSpeed, arg_2_0)
	arg_2_0._slider:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnHideSkillEditorUIEvent, arg_2_0._onHideSkillEditorUIEvent, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnOpen:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnClear:RemoveClickListener()
	arg_3_0._btnSpeed:RemoveClickListener()
	arg_3_0._slider:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_3_0._onFrame, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnHideSkillEditorUIEvent, arg_3_0._onHideSkillEditorUIEvent, arg_3_0)
end

function var_0_0._onHideSkillEditorUIEvent(arg_4_0, arg_4_1)
	gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.CanvasGroup)).alpha = arg_4_1
end

function var_0_0._onClickOpen(arg_5_0)
	gohelper.setActive(arg_5_0._btnOpen.gameObject, false)
	gohelper.setActive(arg_5_0._btnClose.gameObject, true)
	gohelper.setActive(arg_5_0._contentViewGO.gameObject, true)
	TaskDispatcher.runRepeat(arg_5_0._onFrame, arg_5_0, 0.01)
end

function var_0_0._onClickClose(arg_6_0)
	gohelper.setActive(arg_6_0._btnOpen.gameObject, true)
	gohelper.setActive(arg_6_0._btnClose.gameObject, false)
	gohelper.setActive(arg_6_0._contentViewGO.gameObject, false)
	TaskDispatcher.cancelTask(arg_6_0._onFrame, arg_6_0)
end

function var_0_0._onClickSpeed(arg_7_0)
	if UnityEngine.Time.timeScale < 0.5 then
		arg_7_0._txtSpeed.text = "速度0.01"
		UnityEngine.Time.timeScale = 1
	else
		UnityEngine.Time.timeScale = 0.01
		arg_7_0._txtSpeed.text = "恢复速度"
	end
end

function var_0_0._onClickClear(arg_8_0)
	SkillEffectStatModel.instance:clearStat()
end

function var_0_0._onValueChanged(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._imgViewBg.color

	var_9_0.a = arg_9_2
	arg_9_0._imgViewBg.color = var_9_0
end

function var_0_0._onFrame(arg_10_0)
	SkillEffectStatModel.instance:statistic()
end

return var_0_0
