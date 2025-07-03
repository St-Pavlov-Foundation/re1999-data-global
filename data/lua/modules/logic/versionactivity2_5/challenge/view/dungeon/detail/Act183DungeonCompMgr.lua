module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonCompMgr", package.seeall)

local var_0_0 = class("Act183DungeonCompMgr", LuaCompBase)
local var_0_1 = {
	Running = 3,
	Idle = 2,
	Init = 1
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.compInstMap = {}
	arg_1_0.compInstList = {}
	arg_1_0.layoutCompInstMap = {}
	arg_1_0.layoutCompInstList = {}
	arg_1_0._scrolldetail = gohelper.findChildScrollRect(arg_1_0.go, "#scroll_detail")
	arg_1_0._goScrollContent = gohelper.findChild(arg_1_0.go, "#scroll_detail/Viewport/Content")
	arg_1_0._status = var_0_1.Init
end

function var_0_0.addComp(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0.compInstMap[arg_2_2] then
		logError(string.format("重复挂载 clsDefine = %s", arg_2_2))

		return
	end

	local var_2_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_1, arg_2_2)

	var_2_0.mgr = arg_2_0
	arg_2_0.compInstMap[arg_2_2] = var_2_0

	table.insert(arg_2_0.compInstList, var_2_0)

	if arg_2_3 then
		arg_2_0.layoutCompInstMap[arg_2_2] = var_2_0

		table.insert(arg_2_0.layoutCompInstList, var_2_0)
	end
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0._status = var_0_1.Running

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.compInstList) do
		iter_3_1:onUpdateMO(arg_3_1)
	end

	arg_3_0._status = var_0_1.Idle

	arg_3_0:_reallyFocus()
end

function var_0_0.getComp(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.compInstMap[arg_4_1]

	if not var_4_0 then
		logError("组件不存在" .. arg_4_1.__cname)
	end

	return var_4_0
end

function var_0_0.getFuncValue(arg_5_0, arg_5_1, arg_5_2, ...)
	local var_5_0 = arg_5_0:getComp(arg_5_1)

	if var_5_0 then
		local var_5_1 = var_5_0[arg_5_2]

		if not var_5_1 then
			logError(string.format("方法不存在 clsDefine = %s, funcName = %s", arg_5_1.__cname, arg_5_2))

			return
		end

		return var_5_1(var_5_0, ...)
	end
end

function var_0_0.getFieldValue(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getComp(arg_6_1)

	return var_6_0 and var_6_0[arg_6_2]
end

function var_0_0.isCompVisible(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getComp(arg_7_1)

	return var_7_0 and var_7_0:checkIsVisible()
end

function var_0_0.focus(arg_8_0, arg_8_1, ...)
	local var_8_0 = arg_8_0.layoutCompInstMap[arg_8_1]

	if not var_8_0 then
		local var_8_1 = arg_8_1 and arg_8_1.__cname

		logError(string.format("定位失败, 定位目标组件不存在!!! cls = %s", var_8_1))

		return
	end

	arg_8_0._focusTargetInst = var_8_0
	arg_8_0._focusParams = {
		...
	}
	arg_8_0._waitFocus = true

	if arg_8_0._status ~= var_0_1.Idle then
		return
	end

	arg_8_0:_reallyFocus()
end

function var_0_0._reallyFocus(arg_9_0)
	if not arg_9_0._waitFocus then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(arg_9_0._goScrollContent.transform)

	local var_9_0 = 0
	local var_9_1 = false

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.layoutCompInstList) do
		if iter_9_1 == arg_9_0._focusTargetInst then
			var_9_0 = var_9_0 + (iter_9_1:focus(unpack(arg_9_0._focusParams)) or 0)
			var_9_1 = true

			break
		end

		var_9_0 = var_9_0 + (iter_9_1:getHeight() or 0)
	end

	var_9_0 = var_9_1 and var_9_0 or 0

	local var_9_2 = recthelper.getHeight(arg_9_0._goScrollContent.transform)
	local var_9_3 = recthelper.getHeight(arg_9_0._scrolldetail.transform)

	arg_9_0._scrolldetail.verticalNormalizedPosition = 1 - math.abs(var_9_0) / (var_9_2 - var_9_3)
	arg_9_0._waitFocus = false
	arg_9_0._focusTargetInst = nil
	arg_9_0._focusParams = nil
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0:__onDispose()
end

return var_0_0
