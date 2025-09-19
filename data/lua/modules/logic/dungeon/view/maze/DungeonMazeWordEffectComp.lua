module("modules.logic.dungeon.view.maze.DungeonMazeWordEffectComp", package.seeall)

local var_0_0 = class("DungeonMazeWordEffectComp", LuaCompBase)
local var_0_1 = SLFramework.UGUI.RectTrHelper
local var_0_2 = "<size=40><alpha=#00>.<alpha=#ff></size>"
local var_0_3 = table.insert
local var_0_4 = string.gmatch

local function var_0_5(arg_1_0)
	if not arg_1_0 then
		return {}
	end

	local var_1_0 = {}

	for iter_1_0 in var_0_4(arg_1_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if (LangSettings.instance:isEn() or LangSettings.instance:isKr()) and iter_1_0 == " " then
			iter_1_0 = var_0_2
		end

		var_0_3(var_1_0, iter_1_0)
	end

	return var_1_0
end

function var_0_0._warpInScreenX(arg_2_0)
	FrameTimerController.onDestroyViewMember(arg_2_0, "_fTimer")

	arg_2_0._fTimer = FrameTimerController.instance:register(arg_2_0._onWarpInScreenX, arg_2_0, 2)

	arg_2_0._fTimer:Start()
end

function var_0_0._onWarpInScreenX(arg_3_0)
	if gohelper.isNil(arg_3_0.go) then
		return
	end

	if not arg_3_0._parent then
		return
	end

	local var_3_0 = arg_3_0._parent.viewGO

	if gohelper.isNil(var_3_0) then
		return
	end

	local var_3_1 = var_3_0.transform

	if gohelper.isNil(var_3_1) then
		return
	end

	local var_3_2 = UnityEngine.Screen.width * 0.5
	local var_3_3 = recthelper.getWidth(arg_3_0._itemTran) * 0.5
	local var_3_4 = Vector3(var_3_2, 0, 0)
	local var_3_5 = CameraMgr.instance:getUICamera()
	local var_3_6 = var_0_1.ScreenPosToAnchorPos(var_3_4, arg_3_0._itemTran.parent, var_3_5).x
	local var_3_7 = 15
	local var_3_8 = {
		min = var_3_6 + (-var_3_2 + var_3_3 + var_3_7),
		max = var_3_6 + (var_3_2 - var_3_3 - var_3_7)
	}
	local var_3_9 = arg_3_0._originalPosX

	if var_3_9 <= var_3_8.min or var_3_9 >= var_3_8.max then
		if arg_3_0._dir == DungeonMazeEnum.dir.right then
			var_3_9 = UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.MR_L, arg_3_0._itemTran, var_3_1).x - var_3_7
		elseif arg_3_0._dir == DungeonMazeEnum.dir.left then
			var_3_9 = UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.ML_R, arg_3_0._itemTran, var_3_1).x + var_3_7
		end

		var_3_9 = GameUtil.clamp(var_3_9, var_3_8.min, var_3_8.max)
	end

	recthelper.setAnchor(arg_3_0._itemTran, var_3_9, arg_3_0._originalPosY)
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	arg_4_0._parent = arg_4_1.parent
	arg_4_0._dir = arg_4_1.dir
	arg_4_0._co = arg_4_1.co
	arg_4_0._res = arg_4_1.res
	arg_4_0._done = arg_4_1.done
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._item = gohelper.findChild(arg_5_1, "item")
	arg_5_0._itemTran = arg_5_0._item.transform
	arg_5_0._originalPosX = recthelper.getAnchorX(arg_5_0._itemTran)
	arg_5_0._originalPosY = recthelper.getAnchorY(arg_5_0._itemTran)
	arg_5_0._trans = arg_5_1.transform
	arg_5_0.go = arg_5_1
	arg_5_0._line1 = gohelper.findChild(arg_5_1, "item/line1")
	arg_5_0._line2 = gohelper.findChild(arg_5_1, "item/line2")
	arg_5_0._effect = gohelper.findChild(arg_5_1, "item/effect")
	arg_5_0._animEffect = arg_5_0._effect:GetComponent(gohelper.Type_Animator)

	arg_5_0:createTxt()
	arg_5_0:_warpInScreenX()
end

function var_0_0.createTxt(arg_6_0)
	local var_6_0 = Season166Enum.WordTxtOpen + Season166Enum.WordTxtIdle + Season166Enum.WordTxtClose

	arg_6_0._allAnimWork = {}

	local var_6_1 = string.split(arg_6_0._co.desc, "\n")
	local var_6_2 = var_0_5(var_6_1[1]) or {}
	local var_6_3 = 0

	for iter_6_0 = 1, #var_6_2 do
		local var_6_4, var_6_5 = arg_6_0:getRes(arg_6_0._line1, false)

		var_6_5.text = var_6_2[iter_6_0]
		var_6_3 = var_6_3 + var_6_5.preferredWidth + Season166Enum.WordTxtPosXOffset

		local var_6_6 = var_6_5.transform.parent

		recthelper.setWidth(var_6_6, var_6_5.preferredWidth)
		table.insert(arg_6_0._allAnimWork, {
			playAnim = "open",
			anim = var_6_4,
			time = (iter_6_0 - 1) * Season166Enum.WordTxtInterval
		})
		table.insert(arg_6_0._allAnimWork, {
			playAnim = "close",
			anim = var_6_4,
			time = (iter_6_0 - 1) * Season166Enum.WordTxtInterval + var_6_0 - Season166Enum.WordTxtClose
		})
	end

	local var_6_7 = 0
	local var_6_8 = var_0_5(var_6_1[2]) or {}

	for iter_6_1 = 1, #var_6_8 do
		local var_6_9, var_6_10 = arg_6_0:getRes(arg_6_0._line2, false)

		var_6_10.text = var_6_8[iter_6_1]
		var_6_7 = var_6_7 + var_6_10.preferredWidth + Season166Enum.WordTxtPosXOffset

		local var_6_11 = var_6_10.transform.parent

		recthelper.setWidth(var_6_11, var_6_10.preferredWidth)
		table.insert(arg_6_0._allAnimWork, {
			playAnim = "open",
			anim = var_6_9,
			time = (iter_6_1 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay
		})
		table.insert(arg_6_0._allAnimWork, {
			playAnim = "close",
			anim = var_6_9,
			time = (iter_6_1 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay + var_6_0 - Season166Enum.WordTxtClose
		})
	end

	local var_6_12 = var_6_0 + Season166Enum.WordTxtInterval * (#var_6_2 - 1)
	local var_6_13 = 0

	if #var_6_8 > 0 then
		var_6_13 = var_6_0 + Season166Enum.WordTxtInterval * (#var_6_8 - 1)
	end

	local var_6_14 = math.max(var_6_12, var_6_13)

	table.insert(arg_6_0._allAnimWork, {
		showEndEffect = true,
		time = var_6_14 - Season166Enum.WordTxtClose
	})
	table.insert(arg_6_0._allAnimWork, {
		destroy = false,
		time = var_6_14
	})
	table.sort(arg_6_0._allAnimWork, Season166WordEffectComp.sortAnim)
	arg_6_0:nextStep()
end

function var_0_0.nextStep(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.nextStep, arg_7_0)

	local var_7_0 = table.remove(arg_7_0._allAnimWork, 1)

	if not var_7_0 then
		return
	end

	if var_7_0.destroy then
		gohelper.destroy(arg_7_0.go)

		return
	elseif var_7_0.showEndEffect then
		arg_7_0._animEffect:Play(UIAnimationName.Close, 0, 0)
	elseif var_7_0.playAnim == "open" then
		var_7_0.anim.enabled = true
	end

	local var_7_1 = arg_7_0._allAnimWork[1]

	if not var_7_1 then
		return
	end

	TaskDispatcher.runDelay(arg_7_0.nextStep, arg_7_0, var_7_1.time - var_7_0.time)
end

function var_0_0.sortAnim(arg_8_0, arg_8_1)
	return arg_8_0.time < arg_8_1.time
end

local var_0_6 = typeof(UnityEngine.Animator)

function var_0_0.getRes(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = gohelper.clone(arg_9_0._res, arg_9_1)
	local var_9_1 = gohelper.findChildSingleImage(var_9_0, "img")
	local var_9_2 = gohelper.findChildTextMesh(var_9_0, "txt")
	local var_9_3 = var_9_0:GetComponent(var_0_6)

	gohelper.setActive(var_9_1, arg_9_2)
	gohelper.setActive(var_9_2, not arg_9_2)
	gohelper.setActive(var_9_0, true)
	var_9_3:Play("open", 0, 0)
	var_9_3:Update(0)

	var_9_3.enabled = false

	return var_9_3, arg_9_2 and var_9_1 or var_9_2
end

function var_0_0.onDestroy(arg_10_0)
	FrameTimerController.onDestroyViewMember(arg_10_0, "_fTimer")
	TaskDispatcher.cancelTask(arg_10_0.nextStep, arg_10_0)
end

return var_0_0
