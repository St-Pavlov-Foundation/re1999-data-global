module("modules.logic.guide.view.GuideView", package.seeall)

local var_0_0 = class("GuideView", BaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = GMController.instance:getGMNode("guideview", arg_1_0.viewGO)

	if var_1_0 then
		arg_1_0._btnJump = gohelper.findChildButtonWithAudio(var_1_0, "btnJump")
	end
end

function var_0_0.isOpenGM(arg_2_0)
	return isDebugBuild and PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1) == 1
end

function var_0_0.onOpen(arg_3_0)
	if arg_3_0._btnJump then
		gohelper.setActive(arg_3_0._btnJump.gameObject, arg_3_0:isOpenGM())
	end
end

function var_0_0.addEvents(arg_4_0)
	if arg_4_0._btnJump then
		arg_4_0._btnJump:AddClickListener(arg_4_0._onClickBtnJump, arg_4_0)
	end
end

function var_0_0.removeEvents(arg_5_0)
	if arg_5_0._btnJump then
		arg_5_0._btnJump:RemoveClickListener()
	end
end

function var_0_0._onClickBtnJump(arg_6_0)
	GuideModel.instance:onClickJumpGuides()

	local var_6_0 = GuideModel.instance:getDoingGuideId()
	local var_6_1 = var_6_0 and GuideModel.instance:getById(var_6_0)
	local var_6_2 = var_6_1 and var_6_1.currStepId

	logWarn(string.format("点击了指引跳过按钮！！！！！当前指引：%d_%d", var_6_0 or -1, var_6_2 or -1))

	if var_6_0 == GuideController.FirstGuideId then
		DungeonFightController.instance:sendEndFightRequest(true)
	end

	GuideController.instance:oneKeyFinishGuides()
	GuideStepController.instance:clearStep()
end

return var_0_0
