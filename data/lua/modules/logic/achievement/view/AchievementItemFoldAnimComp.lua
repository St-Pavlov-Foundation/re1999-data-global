module("modules.logic.achievement.view.AchievementItemFoldAnimComp", package.seeall)

local var_0_0 = class("AchievementItemFoldAnimComp", LuaCompBase)

function var_0_0.Get(arg_1_0, arg_1_1)
	local var_1_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_0:setFoldRoot(arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._btnpopup = gohelper.getClickWithDefaultAudio(arg_2_0.go)
	arg_2_0._gooff = gohelper.findChild(arg_2_0.go, "#go_off")
	arg_2_0._goon = gohelper.findChild(arg_2_0.go, "#go_on")
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnpopup:AddClickListener(arg_3_0._btnpopupOnClick, arg_3_0)
	arg_3_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnPlayGroupFadeAnim, arg_3_0._onPlayGroupFadeAnimation, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnpopup:RemoveClickListener()
end

function var_0_0._btnpopupOnClick(arg_5_0)
	local var_5_0 = arg_5_0._mo:getIsFold()
	local var_5_1 = arg_5_0._mo:getGroupId()

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnClickGroupFoldBtn, var_5_1, not var_5_0)
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0:killTween()
end

function var_0_0.setFoldRoot(arg_7_0, arg_7_1)
	arg_7_0._gofoldroot = arg_7_1
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	if arg_8_0._mo ~= arg_8_1 then
		arg_8_0:killTween()
	end

	arg_8_0._mo = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0._onPlayGroupFadeAnimation(arg_9_0, arg_9_1)
	if not arg_9_1 or arg_9_1.mo ~= arg_9_0._mo then
		return
	end

	arg_9_0._isFold = arg_9_1.isFold

	if not arg_9_0._isFold then
		arg_9_0._mo:setIsFold(arg_9_0._isFold)
	end

	local var_9_0 = arg_9_1.orginLineHeight
	local var_9_1 = arg_9_1.targetLineHeight
	local var_9_2 = arg_9_1.duration

	arg_9_0._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(var_9_0, var_9_1, var_9_2, arg_9_0._onOpenTweenFrameCallback, arg_9_0._onOpenTweenFinishCallback, arg_9_0, nil)
end

function var_0_0._onOpenTweenFrameCallback(arg_10_0, arg_10_1)
	arg_10_0._mo:overrideLineHeight(arg_10_1)
	AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():onModelUpdate()
end

function var_0_0._onOpenTweenFinishCallback(arg_11_0)
	arg_11_0._mo:clearOverrideLineHeight()
	arg_11_0._mo:setIsFold(arg_11_0._isFold)
	AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():onModelUpdate()
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = arg_12_0._mo:getIsFold()

	gohelper.setActive(arg_12_0._goon, not var_12_0)
	gohelper.setActive(arg_12_0._gooff, var_12_0)
	gohelper.setActive(arg_12_0._gofoldroot, not var_12_0)
end

function var_0_0.killTween(arg_13_0)
	if arg_13_0._openAnimTweenId then
		ZProj.TweenHelper.KillById(arg_13_0._openAnimTweenId)

		arg_13_0._openAnimTweenId = nil
	end
end

return var_0_0
