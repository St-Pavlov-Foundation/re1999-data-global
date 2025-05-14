module("modules.common.others.LuaScrollRectTransition", package.seeall)

local var_0_0 = class("LuaScrollRectTransition", LuaCompBase)

function var_0_0.getByListView(arg_1_0)
	local var_1_0 = arg_1_0:getCsListScroll()
	local var_1_1 = arg_1_0._param
	local var_1_2 = var_1_0.gameObject
	local var_1_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_2, var_0_0)

	var_1_3.scrollRectGO = var_1_2
	var_1_3.dir = var_1_1.scrollDir
	var_1_3.lineCount = var_1_1.lineCount
	var_1_3.cellWidth = var_1_1.cellWidth
	var_1_3.cellHeight = var_1_1.cellHeight
	var_1_3.cellSpace = var_1_1.scrollDir == ScrollEnum.ScrollDirH and var_1_1.cellSpaceH or var_1_1.cellSpaceV
	var_1_3.startSpace = var_1_1.startSpace

	return var_1_3
end

function var_0_0.getByScrollRectGO(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local var_2_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0, var_0_0)

	var_2_0.scrollRectGO = arg_2_0
	var_2_0.dir = arg_2_1
	var_2_0.lineCount = arg_2_2
	var_2_0.cellWidth = arg_2_3
	var_2_0.cellHeight = arg_2_4
	var_2_0.cellSpace = arg_2_5 or 0
	var_2_0.startSpace = arg_2_6 or 0

	return var_2_0
end

function var_0_0.ctor(arg_3_0)
	arg_3_0.transitionTime = 0.2
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._scrollRect = arg_4_1:GetComponent(gohelper.Type_ScrollRect)
	arg_4_0._transform = arg_4_0._scrollRect.transform
	arg_4_0._contentTr = arg_4_0._scrollRect.content
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._tweenId then
		ZProj.TweenHelper.KillById(arg_5_0._tweenId)

		arg_5_0._tweenId = nil
	end
end

function var_0_0.focusCellInViewPort(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:_checkInitSize()

	local var_6_0 = SLFramework.UGUI.RectTrHelper.GetSize(arg_6_0._transform, arg_6_0.dir)
	local var_6_1 = SLFramework.UGUI.RectTrHelper.GetSize(arg_6_0._contentTr, arg_6_0.dir)
	local var_6_2 = arg_6_0._contentTr.childCount - (arg_6_3 or 0)
	local var_6_3 = (arg_6_0.dir == ScrollEnum.ScrollDirH and arg_6_0.cellWidth or arg_6_0.cellHeight) + arg_6_0.cellSpace
	local var_6_4 = arg_6_1 % arg_6_0.lineCount == 0 and Mathf.Round(arg_6_1 / arg_6_0.lineCount) or Mathf.Ceil(arg_6_1 / arg_6_0.lineCount)
	local var_6_5 = 0
	local var_6_6 = arg_6_0._scrollRect.normalizedPosition
	local var_6_7 = arg_6_0.dir == ScrollEnum.ScrollDirH and var_6_6.x or var_6_6.y

	if var_6_0 < var_6_1 then
		local var_6_8 = (var_6_4 * var_6_3 - var_6_3) / (var_6_1 - var_6_0)
		local var_6_9 = (var_6_4 * var_6_3 - var_6_0) / (var_6_1 - var_6_0)
		local var_6_10 = Mathf.Clamp01(arg_6_0:_fixNormalize(var_6_8))
		local var_6_11 = Mathf.Clamp01(arg_6_0:_fixNormalize(var_6_9))

		if var_6_10 <= var_6_7 and var_6_7 <= var_6_11 or var_6_11 <= var_6_7 and var_6_7 <= var_6_10 then
			return
		elseif math.abs(var_6_7 - var_6_10) < math.abs(var_6_7 - var_6_11) then
			var_6_5 = var_6_10
		else
			var_6_5 = var_6_11
		end
	else
		var_6_5 = arg_6_0:_fixNormalize(var_6_5)
	end

	if arg_6_0.dir == ScrollEnum.ScrollDirH then
		var_6_6.x = var_6_5
	else
		var_6_6.y = var_6_5
	end

	if arg_6_2 then
		arg_6_0._normalizedPosition = var_6_6
		arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_6_7, var_6_5, arg_6_0.transitionTime, arg_6_0._frameCallback, nil, arg_6_0)
	else
		arg_6_0._scrollRect.normalizedPosition = var_6_6
	end
end

function var_0_0._fixNormalize(arg_7_0, arg_7_1)
	if arg_7_0.dir == ScrollEnum.ScrollDirV then
		return 1 - arg_7_1
	end

	return arg_7_1
end

function var_0_0._frameCallback(arg_8_0, arg_8_1)
	if arg_8_0.dir == ScrollEnum.ScrollDirH then
		arg_8_0._normalizedPosition.x = arg_8_1
	else
		arg_8_0._normalizedPosition.y = arg_8_1
	end

	arg_8_0._scrollRect.normalizedPosition = arg_8_0._normalizedPosition
end

function var_0_0._checkInitSize(arg_9_0)
	local var_9_0 = (not arg_9_0.cellWidth or arg_9_0.cellWidth <= 0) and arg_9_0.dir == ScrollEnum.ScrollDirH
	local var_9_1 = (not arg_9_0.cellHeight or arg_9_0.cellHeight <= 0) and arg_9_0.dir == ScrollEnum.ScrollDirV

	if var_9_0 or var_9_1 then
		local var_9_2 = arg_9_0._contentTr:GetChild(0)

		if var_9_2 then
			arg_9_0.cellWidth = recthelper.getWidth(var_9_2)
			arg_9_0.cellHeight = recthelper.getHeight(var_9_2)
		end
	end
end

return var_0_0
