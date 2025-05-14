module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase", package.seeall)

local var_0_0 = class("V2a2_WarmUpLeftView_DayBase", RougeSimpleItemBase)
local var_0_1 = SLFramework.AnimatorPlayer
local var_0_2 = ZProj.TweenHelper
local var_0_3 = -1
local var_0_4 = 0
local var_0_5 = 1

function var_0_0.ctor(arg_1_0, arg_1_1)
	RougeSimpleItemBase.ctor(arg_1_0, arg_1_1)
	arg_1_0:markIsFinishedInteractive(false)
end

function var_0_0._editableInitView(arg_2_0)
	RougeSimpleItemBase._editableInitView(arg_2_0)

	arg_2_0._beforeGo = gohelper.findChild(arg_2_0.viewGO, "before")
	arg_2_0._afterGo = gohelper.findChild(arg_2_0.viewGO, "after")
	arg_2_0._animPlayer_before = var_0_1.Get(arg_2_0._beforeGo)
	arg_2_0._animPlayer_after = var_0_1.Get(arg_2_0._afterGo)
	arg_2_0._anim_before = arg_2_0._animPlayer_before and arg_2_0._animPlayer_before.animator
	arg_2_0._anim_after = arg_2_0._animPlayer_after and arg_2_0._animPlayer_after.animator

	arg_2_0:setActive_before(false)
	arg_2_0:setActive_after(false)

	arg_2_0._guideState = var_0_3
	arg_2_0._isDestroying = false
end

function var_0_0.episodeId(arg_3_0)
	return arg_3_0._episodeId
end

function var_0_0._internal_setEpisode(arg_4_0, arg_4_1)
	arg_4_0._episodeId = arg_4_1
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.viewGO, arg_5_1)
end

function var_0_0.setActive_before(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._beforeGo, arg_6_1)
end

function var_0_0.setActive_after(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._afterGo, arg_7_1)
end

function var_0_0.saveState(arg_8_0, arg_8_1)
	assert(arg_8_1 ~= 1999, "please call saveStateDone instead")
	arg_8_0:_assetGetViewContainer():saveState(arg_8_0:episodeId(), arg_8_1)
end

function var_0_0.getState(arg_9_0, arg_9_1)
	return arg_9_0:_assetGetViewContainer():getState(arg_9_0:episodeId(), arg_9_1)
end

function var_0_0.saveStateDone(arg_10_0, arg_10_1)
	arg_10_0:_assetGetViewContainer():saveStateDone(arg_10_0:episodeId(), arg_10_1)
end

function var_0_0.checkIsDone(arg_11_0)
	return arg_11_0:_assetGetViewContainer():checkIsDone(arg_11_0:episodeId())
end

function var_0_0.openDesc(arg_12_0)
	return arg_12_0:_assetGetViewContainer():openDesc()
end

function var_0_0.setPosToEnd(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	local var_13_0 = recthelper.rectToRelativeAnchorPos(arg_13_1.position, arg_13_2.parent)

	if arg_13_3 then
		arg_13_0._tweenIds = arg_13_0._tweenIds or {}

		var_0_2.KillByObj(arg_13_2)

		local var_13_1 = var_0_2.DOAnchorPos(arg_13_2, var_13_0.x, var_13_0.y, arg_13_4 or 0.2, arg_13_5, arg_13_6)

		table.insert(arg_13_0._tweenIds, var_13_1)
	else
		recthelper.setAnchor(arg_13_2, var_13_0.x, var_13_0.y)
	end
end

function var_0_0.tweenAnchorPos(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	GameUtil.onDestroyViewMember_TweenId(arg_14_0, "_tweenId_DOAnchorPos")

	arg_14_0._tweenId_DOAnchorPos = var_0_2.DOAnchorPos(arg_14_1, arg_14_2, arg_14_3, arg_14_4 or 0.2, arg_14_5, arg_14_6)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._isDestroying = true

	GameUtil.onDestroyViewMember_TweenId(arg_15_0, "_tweenId_DOAnchorPos")

	if arg_15_0._tweenIds then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._tweenIds) do
			var_0_2.KillById(iter_15_1)
		end

		arg_15_0._tweenIds = nil
	end

	CommonDragHelper.instance:setGlobalEnabled(true)
	RougeSimpleItemBase.onDestroyView(arg_15_0)
end

local var_0_6 = {
	"click",
	"click_r",
	"in",
	"out",
	"finish",
	"idle",
	"loop"
}
local var_0_7 = "playAnim_before_"
local var_0_8 = "playAnim_after_"
local var_0_9 = "playAnimRaw_before_"
local var_0_10 = "playAnimRaw_after_"

local function var_0_11()
	return
end

for iter_0_0, iter_0_1 in ipairs(var_0_6) do
	var_0_0[var_0_7 .. iter_0_1] = function(arg_17_0, arg_17_1, arg_17_2)
		if not arg_17_0._beforeGo.activeInHierarchy then
			arg_17_0:setActive_before(true)
		end

		arg_17_0._animPlayer_before:Play(iter_0_1, arg_17_1 or var_0_11, arg_17_2)
	end
	var_0_0[var_0_9 .. iter_0_1] = function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_18_0._anim_before

		var_18_0.enabled = true

		var_18_0:Play(iter_0_1, arg_18_1, arg_18_2)
	end
	var_0_0[var_0_8 .. iter_0_1] = function(arg_19_0, arg_19_1, arg_19_2)
		if not arg_19_0._afterGo.activeInHierarchy then
			arg_19_0:setActive_after(true)
		end

		arg_19_0._animPlayer_after:Play(iter_0_1, arg_19_1 or var_0_11, arg_19_2)
	end
	var_0_0[var_0_10 .. iter_0_1] = function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_20_0._anim_after

		var_20_0.enabled = true

		var_20_0:Play(iter_0_1, arg_20_1, arg_20_2)
	end
end

function var_0_0.markGuided(arg_21_0)
	arg_21_0._guideState = var_0_5
end

function var_0_0.markIsFinishedInteractive(arg_22_0, arg_22_1)
	arg_22_0._isFinishInteractive = arg_22_1
end

function var_0_0.isFinishInteractive(arg_23_0)
	return arg_23_0._isFinishInteractive
end

function var_0_0._onDragBegin(arg_24_0)
	arg_24_0:_setActive_guide(false)
	arg_24_0:markGuided()
end

function var_0_0._setActive_guide(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0._guideGo, arg_25_1)
end

function var_0_0.setData(arg_26_0)
	if arg_26_0:isFinishInteractive() then
		return
	end

	if arg_26_0._isDestroying then
		return
	end

	CommonDragHelper.instance:setGlobalEnabled(true)

	local var_26_0 = arg_26_0:checkIsDone()

	arg_26_0:_setActive_guide(not var_26_0 and arg_26_0._guideState <= var_0_3)
end

function var_0_0.onDataUpdateFirst(arg_27_0)
	arg_27_0._guideState = arg_27_0:checkIsDone() and var_0_4 or var_0_3

	arg_27_0:_setActive_guide(true)
end

function var_0_0.onDataUpdate(arg_28_0)
	if arg_28_0:isFinishInteractive() then
		return
	end

	arg_28_0:setData()
end

function var_0_0.onSwitchEpisode(arg_29_0)
	local var_29_0 = arg_29_0:checkIsDone()

	if arg_29_0._guideState == var_0_4 and not var_29_0 then
		arg_29_0._guideState = var_0_3 - 1
	elseif arg_29_0._guideState < var_0_3 and var_29_0 then
		arg_29_0._guideState = var_0_4
	end

	arg_29_0:setData()
end

return var_0_0
