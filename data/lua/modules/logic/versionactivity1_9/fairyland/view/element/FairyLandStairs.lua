module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandStairs", package.seeall)

local var_0_0 = class("FairyLandStairs", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRoot = gohelper.findChild(arg_1_0.viewGO, "main/#go_Root")
	arg_1_0.rootTrs = arg_1_0.goRoot.transform
	arg_1_0.goStairs = gohelper.findChild(arg_1_0.goRoot, "#go_Stairs")
	arg_1_0.goPool = gohelper.findChild(arg_1_0.goStairs, "pool")
	arg_1_0.goStair = gohelper.findChild(arg_1_0.goStairs, "pool/stair")
	arg_1_0.stairPool = arg_1_0:getUserDataTb_()
	arg_1_0.stairDict = arg_1_0:getUserDataTb_()
	arg_1_0.noUseDict = {}
	arg_1_0.poolCount = 0
	arg_1_0.startPosX = -90
	arg_1_0.startPosY = -120
	arg_1_0.spaceX = 244
	arg_1_0.spaceY = 73
	arg_1_0.maxStair = 50

	local var_1_0 = recthelper.getWidth(arg_1_0.viewGO.transform)
	local var_1_1 = arg_1_0:caleStairPos(3)

	arg_1_0.offsetX = var_1_0 * 0.5 - var_1_1 - 318

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.DoStairAnim, arg_2_0.onDoStairAnim, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.SetStairPos, arg_2_0.onSetStairPos, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0.onDoStairAnim(arg_5_0, arg_5_1)
	if arg_5_0.stairDict[arg_5_1] then
		arg_5_0.stairDict[arg_5_1].anim:Play("open", 0, 0)
	end
end

function var_0_0.moveToPos(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_6_0.moveTweenId)

		arg_6_0.moveTweenId = nil
	end

	arg_6_1 = math.min(arg_6_0.maxStair - 6, arg_6_1)

	local var_6_0, var_6_1 = arg_6_0:caleStairRootPos(arg_6_1)

	if arg_6_2 then
		local var_6_2 = arg_6_0._tweenTime or 1

		arg_6_0.moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_6_0.rootTrs, var_6_0, var_6_1, var_6_2, arg_6_0._moveDone, arg_6_0, nil, EaseType.OutQuad)
	else
		recthelper.setAnchor(arg_6_0.rootTrs, var_6_0, var_6_1)
		arg_6_0:updateStairs()
	end
end

function var_0_0._moveDone(arg_7_0)
	if arg_7_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_7_0.moveTweenId)

		arg_7_0.moveTweenId = nil
	end

	arg_7_0:updateStairs()
end

function var_0_0.caleStairRootPos(arg_8_0, arg_8_1)
	local var_8_0 = -arg_8_1 * arg_8_0.spaceX + FairyLandEnum.StartCameraPosX + arg_8_0.offsetX
	local var_8_1 = arg_8_1 * arg_8_0.spaceY + FairyLandEnum.StartCameraPosY

	return var_8_0, var_8_1
end

function var_0_0.onSetStairPos(arg_9_0, arg_9_1)
	local var_9_0 = FairyLandModel.instance:getStairPos()

	if arg_9_1 then
		arg_9_0:moveToPos(var_9_0, true)
	else
		arg_9_0:moveToPos(var_9_0)
		arg_9_0:updateStairs()
	end
end

function var_0_0.updateStairs(arg_10_0)
	local var_10_0 = FairyLandModel.instance:getStairPos()
	local var_10_1 = math.min(arg_10_0.maxStair - 6, var_10_0)
	local var_10_2 = var_10_1 + arg_10_0:getScreenStairCount()
	local var_10_3 = var_10_1 - 2

	arg_10_0:setNoUseStairs()

	for iter_10_0 = var_10_3, var_10_2 do
		arg_10_0:getStair(iter_10_0)
	end

	arg_10_0:recycleStairs()
end

function var_0_0.getScreenStairCount(arg_11_0)
	if arg_11_0.stairCount then
		return arg_11_0.stairCount
	end

	local var_11_0 = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local var_11_1 = recthelper.getHeight(var_11_0.transform)

	arg_11_0.stairCount = math.ceil(var_11_1 / arg_11_0.spaceY) + 2

	return arg_11_0.stairCount
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.setNoUseStairs(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.stairDict) do
		arg_13_0.noUseDict[iter_13_0] = true
	end
end

function var_0_0.recycleStairs(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.noUseDict) do
		arg_14_0:recycleStair(arg_14_0.stairDict[iter_14_0])

		arg_14_0.stairDict[iter_14_0] = nil
	end

	arg_14_0.noUseDict = {}
end

function var_0_0.getStair(arg_15_0, arg_15_1)
	arg_15_0.noUseDict[arg_15_1] = nil

	local var_15_0 = arg_15_0.stairDict[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getOrCreateStair(arg_15_1)
		arg_15_0.stairDict[arg_15_1] = var_15_0
	end

	local var_15_1 = arg_15_1 <= arg_15_0.maxStair

	gohelper.setActive(var_15_0.go, var_15_1)

	return var_15_0
end

function var_0_0.getOrCreateStair(arg_16_0, arg_16_1)
	local var_16_0

	if arg_16_0.poolCount > 0 then
		var_16_0 = table.remove(arg_16_0.stairPool)
		arg_16_0.poolCount = arg_16_0.poolCount - 1

		gohelper.addChild(arg_16_0.goStairs, var_16_0.go)
	else
		var_16_0 = arg_16_0:getUserDataTb_()
		var_16_0.go = gohelper.clone(arg_16_0.goStair, arg_16_0.goStairs)
		var_16_0.transform = var_16_0.go.transform
		var_16_0.anim = var_16_0.go:GetComponent(typeof(UnityEngine.Animator))
	end

	var_16_0.go.name = tostring(arg_16_1)

	local var_16_1, var_16_2 = arg_16_0:caleStairPos(arg_16_1)

	recthelper.setAnchor(var_16_0.transform, var_16_1, var_16_2)

	return var_16_0
end

function var_0_0.caleStairPos(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.startPosX + arg_17_1 * arg_17_0.spaceX
	local var_17_1 = arg_17_0.startPosY - arg_17_1 * arg_17_0.spaceY

	return var_17_0, var_17_1
end

function var_0_0.recycleStair(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	gohelper.addChild(arg_18_0.goPool, arg_18_1.go)
	table.insert(arg_18_0.stairPool, arg_18_1)

	arg_18_0.poolCount = arg_18_0.poolCount + 1
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_19_0.moveTweenId)

		arg_19_0.moveTweenId = nil
	end
end

return var_0_0
