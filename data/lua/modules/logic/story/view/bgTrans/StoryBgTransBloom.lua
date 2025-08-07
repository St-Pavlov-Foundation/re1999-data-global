module("modules.logic.story.view.bgTrans.StoryBgTransBloom", package.seeall)

local var_0_0 = class("StoryBgTransBloom", StoryBgTransBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

local var_0_1 = 0.25

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)
	arg_2_0:setBgTransType(StoryEnum.BgTransType.Bloom1)

	arg_2_0._bloomAnimPath = "ui/animations/dynamic/story_bloomchange.controller"

	table.insert(arg_2_0._resList, arg_2_0._bloomAnimPath)
end

function var_0_0.setBgTransType(arg_3_0, arg_3_1)
	arg_3_0._transType = arg_3_1
	arg_3_0._transMo = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_3_0._transType)
end

function var_0_0.start(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super.start(arg_4_0)

	arg_4_0._finishedCallback = arg_4_1
	arg_4_0._finishedCallbackObj = arg_4_2

	arg_4_0:loadRes()
	GameUtil.setActiveUIBlock("bgTrans", true, false)
end

function var_0_0.onLoadFinished(arg_5_0)
	var_0_0.super.onLoadFinished(arg_5_0)
	StoryTool.enablePostProcess(true)

	local var_5_0 = arg_5_0._loader:getAssetItem(arg_5_0._bloomAnimPath):GetResource()
	local var_5_1 = CameraMgr.instance:getUICameraGO()

	arg_5_0._animRoot = gohelper.findChild(var_5_1, "PPUIVolume")
	arg_5_0._bloomAnim = gohelper.onceAddComponent(arg_5_0._animRoot, typeof(UnityEngine.Animator))
	arg_5_0._bloomAnim.runtimeAnimatorController = var_5_0
	arg_5_0._bloomAnim.speed = arg_5_0._transMo.transTime > 0.01 and var_0_1 / arg_5_0._transMo.transTime or 1

	arg_5_0._bloomAnim:Play("trans", 0, 0)
	TaskDispatcher.runDelay(arg_5_0.onSwitchBg, arg_5_0, arg_5_0._transMo.transTime)
end

function var_0_0.onSwitchBg(arg_6_0)
	var_0_0.super.onSwitchBg(arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.onTransFinished, arg_6_0, arg_6_0._transMo.transTime)
end

function var_0_0.onTransFinished(arg_7_0)
	var_0_0.super.onTransFinished(arg_7_0)

	if arg_7_0._finishedCallback then
		arg_7_0._finishedCallback(arg_7_0._finishedCallbackObj)
	end

	arg_7_0:_clearTrans()
end

function var_0_0._clearTrans(arg_8_0)
	GameUtil.setActiveUIBlock("bgTrans", false, false)
	gohelper.removeComponent(arg_8_0._animRoot, typeof(UnityEngine.Animator))

	arg_8_0._finishedCallback = nil
	arg_8_0._finishedCallbackObj = nil
end

function var_0_0.destroy(arg_9_0)
	var_0_0.super.destroy(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.onSwitchBg, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.onTransFinished, arg_9_0)
	arg_9_0:_clearTrans()
end

return var_0_0
