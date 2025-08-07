module("modules.logic.gm.view.GMSubViewEditorFight", package.seeall)

local var_0_0 = class("GMSubViewEditorFight", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "技能编辑器"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.initViewContent(arg_4_0)
	if arg_4_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_4_0)

	arg_4_0.lineIndex = 0

	arg_4_0:addLineIndex()

	arg_4_0.hideBuffLayerToggle = arg_4_0:addToggle(arg_4_0:getLineGroup(), "隐藏buff层数回合数", arg_4_0.onHideBuffLayerToggleValueChange, arg_4_0)
	arg_4_0.hideBuffLayerToggle.isOn = GMController.instance.hideBuffLayer and true or false
	arg_4_0.hideFloatToggle = arg_4_0:addToggle(arg_4_0:getLineGroup(), "隐藏飘字", arg_4_0.onHideFloatToggleValueChange, arg_4_0)
	arg_4_0.hideFloatToggle.isOn = GMController.instance.hideFloat and true or false
end

function var_0_0.onHideBuffLayerToggleValueChange(arg_5_0)
	GMController.instance.hideBuffLayer = arg_5_0.hideBuffLayerToggle.isOn

	FightController.instance:dispatchEvent(FightEvent.SkillHideBuffLayer)
end

function var_0_0.onHideFloatToggleValueChange(arg_6_0)
	GMController.instance.hideFloat = arg_6_0.hideFloatToggle.isOn
end

return var_0_0
