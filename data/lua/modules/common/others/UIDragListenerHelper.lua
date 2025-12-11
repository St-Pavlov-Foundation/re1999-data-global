module("modules.common.others.UIDragListenerHelper", package.seeall)

local var_0_0 = class("UIDragListenerHelper", UserDataDispose)
local var_0_1 = math.pi
local var_0_2 = 1e-05
local var_0_3 = math.abs
local var_0_4 = math.sqrt
local var_0_5 = math.acos
local var_0_6 = 180
local var_0_7 = ZProj.TweenHelper
local var_0_8 = SLFramework.UGUI.UIDragListener

var_0_0.EventBegin = 1
var_0_0.EventDragging = 2
var_0_0.EventEnd = 3

local var_0_9 = {
	Down = -1,
	Up = 1,
	Right = -1,
	Left = 1,
	None = 0
}

local function var_0_10(arg_1_0)
	return arg_1_0 * var_0_1 / var_0_6
end

local function var_0_11(arg_2_0)
	return var_0_6 / var_0_1 * arg_2_0
end

local function var_0_12(arg_3_0)
	return var_0_3(arg_3_0) <= var_0_2
end

local function var_0_13(arg_4_0, arg_4_1)
	return arg_4_0.x * arg_4_1.x + arg_4_0.y * arg_4_1.y
end

local function var_0_14(arg_5_0, arg_5_1)
	return arg_5_0.x * arg_5_1.x + arg_5_0.y * arg_5_1.y + arg_5_0.z * arg_5_1.z
end

local function var_0_15(arg_6_0, arg_6_1)
	return Vector3.New(arg_6_0.y * arg_6_1.z - arg_6_0.z * arg_6_1.y, arg_6_0.z * arg_6_1.x - arg_6_0.x * arg_6_1.z, arg_6_0.x * arg_6_1.y - arg_6_0.y * arg_6_1.x)
end

local function var_0_16(arg_7_0, arg_7_1)
	local var_7_0 = var_0_13(arg_7_0, arg_7_0)
	local var_7_1 = var_0_13(arg_7_1, arg_7_1)

	if var_0_12(var_7_0) or var_0_12(var_7_1) then
		return 0
	end

	local var_7_2 = var_0_13(arg_7_0, arg_7_1) / var_0_4(var_7_0 * var_7_1)

	return var_0_5(var_7_2)
end

local function var_0_17(arg_8_0, arg_8_1)
	local var_8_0 = Mathf.Cos(arg_8_1)
	local var_8_1 = Mathf.Sin(arg_8_1)

	return Vector2.New(arg_8_0.x * var_8_0 - arg_8_0.y * var_8_1, arg_8_0.x * var_8_1 + arg_8_0.y * var_8_0)
end

function var_0_0.ctor(arg_9_0)
	arg_9_0:__onInit()
	LuaEventSystem.addEventMechanism(arg_9_0)

	arg_9_0._dragInfo = {
		delta = {
			x = 0,
			y = 0
		}
	}
	arg_9_0._swipeH = var_0_9.None
	arg_9_0._swipeV = var_0_9.None

	arg_9_0:clear()
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0:release()
	arg_10_0:__onDispose()
end

function var_0_0.create(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:release()

	arg_11_0._transform = arg_11_1.transform
	arg_11_0._csDragObj = var_0_8.Get(arg_11_1)

	arg_11_0._csDragObj:AddDragBeginListener(arg_11_0._onDragBegin, arg_11_0, arg_11_2)
	arg_11_0._csDragObj:AddDragListener(arg_11_0._onDragging, arg_11_0, arg_11_2)
	arg_11_0._csDragObj:AddDragEndListener(arg_11_0._onDragEnd, arg_11_0, arg_11_2)
end

function var_0_0.createByScrollRect(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:create(arg_12_1.gameObject, arg_12_2)

	arg_12_0._scrollRectCmp = arg_12_1
end

function var_0_0.release(arg_13_0)
	GameUtil.onDestroyViewMember_TweenId(arg_13_0, "_tweenId_DOAnchorPos")
	arg_13_0:unregisterAllCallback(var_0_0.EventBegin)
	arg_13_0:unregisterAllCallback(var_0_0.EventDragging)
	arg_13_0:unregisterAllCallback(var_0_0.EventEnd)

	if arg_13_0._csDragObj then
		arg_13_0._csDragObj:RemoveDragBeginListener()
		arg_13_0._csDragObj:RemoveDragListener()
		arg_13_0._csDragObj:RemoveDragEndListener()
	end

	arg_13_0._csDragObj = nil
	arg_13_0._scrollRectCmp = nil
end

function var_0_0.clear(arg_14_0)
	local var_14_0 = arg_14_0._dragInfo

	var_14_0.hasBegin = false
	var_14_0.isDragging = false
	var_14_0.hasEnd = false
end

function var_0_0.dragInfo(arg_15_0)
	return arg_15_0._dragInfo
end

function var_0_0.transform(arg_16_0)
	return arg_16_0._transform
end

function var_0_0._refreshSwipeDir(arg_17_0)
	local var_17_0 = arg_17_0._dragInfo
	local var_17_1 = var_17_0.delta.x
	local var_17_2 = var_17_0.delta.y

	if var_17_1 > 0 then
		arg_17_0._swipeH = var_0_9.Right
	elseif var_17_1 < 0 then
		arg_17_0._swipeH = var_0_9.Left
	else
		arg_17_0._swipeH = var_0_9.None
	end

	if var_17_2 < 0 then
		arg_17_0._swipeV = var_0_9.Down
	elseif var_17_2 > 0 then
		arg_17_0._swipeV = var_0_9.Up
	else
		arg_17_0._swipeV = var_0_9.None
	end
end

function var_0_0._onDragBegin(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:clear()

	local var_18_0 = arg_18_0._dragInfo

	var_18_0.screenPos = arg_18_2.position
	var_18_0.hasBegin = true
	var_18_0.isDragging = true
	var_18_0.delta = arg_18_2.delta
	var_18_0.screenPos_st = var_18_0.screenPos

	arg_18_0:_refreshSwipeDir()
	arg_18_0:dispatchEvent(var_0_0.EventBegin, arg_18_0, arg_18_1)
end

function var_0_0._onDragging(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._dragInfo

	var_19_0.screenPos = arg_19_2.position
	var_19_0.isDragging = true
	var_19_0.delta = arg_19_2.delta

	arg_19_0:_refreshSwipeDir()
	arg_19_0:dispatchEvent(var_0_0.EventDragging, arg_19_0, arg_19_1)
end

function var_0_0._onDragEnd(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._dragInfo

	var_20_0.screenPos = arg_20_2.position
	var_20_0.delta = arg_20_2.delta
	var_20_0.hasEnd = true
	var_20_0.isDragging = false
	var_20_0.screenPos_ed = var_20_0.screenPos

	arg_20_0:dispatchEvent(var_0_0.EventEnd, arg_20_0, arg_20_1)
end

function var_0_0.isStoped(arg_21_0)
	local var_21_0 = arg_21_0._dragInfo

	return var_21_0.hasEnd == true or var_21_0.hasEnd == false and var_21_0.hasBegin == false and var_21_0.isDragging == false
end

function var_0_0.isEndedDrag(arg_22_0)
	return arg_22_0._dragInfo.hasEnd
end

function var_0_0.isDragging(arg_23_0)
	return arg_23_0._dragInfo.isDragging
end

function var_0_0.isSwipeNone(arg_24_0)
	return arg_24_0._swipeH == var_0_9.None and arg_24_0._swipeV == var_0_9.None
end

function var_0_0.isSwipeRight(arg_25_0)
	return arg_25_0._swipeH == var_0_9.Right
end

function var_0_0.isSwipeLeft(arg_26_0)
	return arg_26_0._swipeH == var_0_9.Left
end

function var_0_0.isSwipeUp(arg_27_0)
	return arg_27_0._swipeV == var_0_9.Up
end

function var_0_0.isSwipeDown(arg_28_0)
	return arg_28_0._swipeV == var_0_9.Down
end

function var_0_0.isSwipeLT(arg_29_0)
	return arg_29_0:isSwipeLeft() and arg_29_0:isSwipeUp()
end

function var_0_0.isSwipeRT(arg_30_0)
	return arg_30_0:isSwipeRight() and arg_30_0:isSwipeUp()
end

function var_0_0.isSwipeLB(arg_31_0)
	return arg_31_0:isSwipeLeft() and arg_31_0:isSwipeDown()
end

function var_0_0.isSwipeRB(arg_32_0)
	return arg_32_0:isSwipeRight() and arg_32_0:isSwipeDown()
end

function var_0_0.stopMovement(arg_33_0)
	arg_33_0._scrollRectCmp:StopMovement()
	arg_33_0:clear()

	arg_33_0._swipeH = var_0_9.None
	arg_33_0._swipeV = var_0_9.None
end

function var_0_0.isMoveVerticalMajor(arg_34_0)
	if arg_34_0:isSwipeNone() then
		return false
	end

	local var_34_0 = arg_34_0._dragInfo

	return math.abs(var_34_0.delta.x) < math.abs(var_34_0.delta.y)
end

function var_0_0.isMoveHorizontalMajor(arg_35_0)
	if arg_35_0:isSwipeNone() then
		return false
	end

	local var_35_0 = arg_35_0._dragInfo

	return math.abs(var_35_0.delta.x) > math.abs(var_35_0.delta.y)
end

function var_0_0.tweenToAnchorPos(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	arg_36_1 = arg_36_1 or arg_36_0._transform
	arg_36_3 = arg_36_3 or 0.2

	local var_36_0, var_36_1 = recthelper.getAnchor(arg_36_1)

	var_0_7.KillByObj(arg_36_1)

	if math.abs(var_36_0 - arg_36_2.x) > 10 or math.abs(var_36_1 - arg_36_2.y) > 10 then
		GameUtil.onDestroyViewMember_TweenId(arg_36_0, "_tweenId_DOAnchorPos")

		arg_36_0._tweenId_DOAnchorPos = var_0_7.DOAnchorPos(arg_36_1, arg_36_2.x, arg_36_2.y, arg_36_3, arg_36_4, arg_36_5)
	else
		recthelper.setAnchor(arg_36_1, arg_36_2.x, arg_36_2.y)
	end
end

function var_0_0.screenPosV2ToAnchorPosV2(arg_37_0, arg_37_1, arg_37_2)
	arg_37_1 = arg_37_1 or arg_37_0._transform
	arg_37_2 = arg_37_2 or arg_37_0._dragInfo.screenPos

	return (recthelper.screenPosToAnchorPos(arg_37_2, arg_37_1.parent))
end

function var_0_0.tweenToScreenPos(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5)
	local var_38_0 = arg_38_0:screenPosV2ToAnchorPosV2(arg_38_1, arg_38_2)

	arg_38_0:tweenToAnchorPos(arg_38_1, var_38_0, arg_38_3, arg_38_4, arg_38_5)
end

function var_0_0.tweenToMousePos(arg_39_0)
	local var_39_0 = arg_39_0._dragInfo

	arg_39_0:tweenToScreenPos(arg_39_0._transform, var_39_0.screenPos)
end

function var_0_0.tweenToMousePosWithConstrainedDirV2(arg_40_0, arg_40_1, arg_40_2)
	assert(tonumber(arg_40_1.x) ~= nil and tonumber(arg_40_1.y) ~= nil)

	local var_40_0 = arg_40_0._transform
	local var_40_1 = arg_40_0._dragInfo
	local var_40_2 = recthelper.screenPosToAnchorPos(var_40_1.screenPos, var_40_0.parent)
	local var_40_3, var_40_4 = recthelper.getAnchor(var_40_0)
	local var_40_5 = Vector2.New(var_40_3, var_40_4)
	local var_40_6 = var_40_2 - var_40_5
	local var_40_7 = var_0_13(var_40_6, arg_40_1)

	var_40_2.x = var_40_5.x + arg_40_1.x * var_40_7
	var_40_2.y = var_40_5.y + arg_40_1.y * var_40_7

	if arg_40_2 then
		local var_40_8 = recthelper.rectToRelativeAnchorPos(arg_40_2.position, var_40_0.parent)
		local var_40_9 = Vector2.Distance(var_40_8, var_40_5)

		var_40_2 = Vector2.MoveTowards(var_40_5, var_40_2, var_40_9)
	end

	arg_40_0:tweenToAnchorPos(var_40_0, var_40_2)
end

function var_0_0.quaternionToMouse(arg_41_0, arg_41_1, arg_41_2)
	arg_41_2 = arg_41_2 or recthelper.uiPosToScreenPos(arg_41_1)

	local var_41_0 = arg_41_0._dragInfo
	local var_41_1 = var_41_0.screenPos
	local var_41_2 = var_41_1 - var_41_0.delta - arg_41_2
	local var_41_3 = var_41_1 - arg_41_2
	local var_41_4 = Vector3.New(var_41_2.x, var_41_2.y, 0)
	local var_41_5 = Vector3.New(var_41_3.x, var_41_3.y, 0)
	local var_41_6 = Quaternion.FromToRotation(var_41_4, var_41_5)
	local var_41_7, var_41_8 = var_41_6:ToAngleAxis()
	local var_41_9 = var_41_8.z
	local var_41_10

	if var_41_9 < 0 then
		var_41_10 = true
	elseif var_41_9 > 0 then
		var_41_10 = false
	end

	return var_41_6, var_41_7, var_41_10
end

function var_0_0.rotateZToMousePos(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0, var_42_1, var_42_2 = arg_42_0:quaternionToMouse(arg_42_1, arg_42_2)

	arg_42_1.rotation = arg_42_1.rotation * var_42_0

	return var_42_0, var_42_1, var_42_2
end

function var_0_0.rotateZToMousePosWithCenterTrans(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = recthelper.uiPosToScreenPos(arg_43_2)

	arg_43_0:rotateZToMousePos(arg_43_1, var_43_0)
end

function var_0_0.degreesFromBeginDrag(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0._dragInfo

	if not var_44_0.screenPos_st then
		return 0
	end

	arg_44_1 = arg_44_1 or arg_44_0:transform()
	arg_44_2 = arg_44_2 or recthelper.uiPosToScreenPos(arg_44_1)

	local var_44_1 = var_44_0.screenPos
	local var_44_2 = var_44_0.screenPos_st - arg_44_2
	local var_44_3 = var_44_1 - arg_44_2

	return var_0_11(var_0_16(var_44_2, var_44_3))
end

function var_0_0.setAnchorByMousePos(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0:screenPosV2ToAnchorPosV2(arg_45_1)

	recthelper.setAnchor(arg_45_1, var_45_0)
end

return var_0_0
