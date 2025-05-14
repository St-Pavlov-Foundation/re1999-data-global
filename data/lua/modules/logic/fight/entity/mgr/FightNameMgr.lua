module("modules.logic.fight.entity.mgr.FightNameMgr", package.seeall)

local var_0_0 = class("FightNameMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._hasReplaceNameBar = nil
	arg_1_0._nameParent = nil
	arg_1_0._fightNameUIList = nil
end

function var_0_0.init(arg_2_0)
	local var_2_0 = arg_2_0:getHudGO()

	arg_2_0._nameParent = gohelper.create2d(var_2_0, "NameBar")
	arg_2_0._fightNameUIList = {}
end

function var_0_0.getHudGO(arg_3_0)
	return ViewMgr.instance:getUILayer(UILayerName.Hud)
end

function var_0_0.dispose(arg_4_0)
	arg_4_0._hasReplaceNameBar = nil

	if arg_4_0._nameParent then
		gohelper.destroy(arg_4_0._nameParent)

		arg_4_0._nameParent = nil
	end

	arg_4_0._fightNameUIList = {}

	TaskDispatcher.cancelTask(arg_4_0._delayAdujstUISibling, arg_4_0)
end

function var_0_0.onRestartStage(arg_5_0)
	arg_5_0._fightNameUIList = {}

	TaskDispatcher.cancelTask(arg_5_0._delayAdujstUISibling, arg_5_0)
end

function var_0_0.getNameParent(arg_6_0)
	return arg_6_0._nameParent
end

function var_0_0.register(arg_7_0, arg_7_1)
	table.insert(arg_7_0._fightNameUIList, arg_7_1)
	TaskDispatcher.cancelTask(arg_7_0._delayAdujstUISibling, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._delayAdujstUISibling, arg_7_0, 1)
	arg_7_0:_replaceNameBar()
end

function var_0_0.unregister(arg_8_0, arg_8_1)
	tabletool.removeValue(arg_8_0._fightNameUIList, arg_8_1)
end

function var_0_0._replaceNameBar(arg_9_0)
	if arg_9_0._hasReplaceNameBar or #arg_9_0._fightNameUIList == 0 then
		return
	end

	local var_9_0 = arg_9_0._fightNameUIList[1]:getUIGO()

	if gohelper.isNil(var_9_0) then
		return
	end

	arg_9_0._hasReplaceNameBar = true

	local var_9_1 = gohelper.findChild(var_9_0, "NameBar")

	if gohelper.isNil(var_9_1) then
		return
	end

	local var_9_2 = arg_9_0:getHudGO()
	local var_9_3 = gohelper.clone(var_9_1, var_9_2, "NameBar")

	if gohelper.isNil(arg_9_0._nameParent) or gohelper.isNil(var_9_3) then
		return
	end

	local var_9_4 = arg_9_0._nameParent.transform
	local var_9_5 = var_9_3.transform

	for iter_9_0 = var_9_4.childCount - 1, 0, -1 do
		local var_9_6 = var_9_4:GetChild(iter_9_0)

		if not gohelper.isNil(var_9_6) then
			var_9_6:SetParent(var_9_5, false)
		end
	end

	gohelper.setSiblingAfter(var_9_3, arg_9_0._nameParent)
	gohelper.destroy(arg_9_0._nameParent)

	arg_9_0._nameParent = var_9_3

	gohelper.setActive(arg_9_0._nameParent, true)
end

function var_0_0._delayAdujstUISibling(arg_10_0)
	arg_10_0:_replaceNameBar()

	if #arg_10_0._fightNameUIList <= 1 then
		return
	end

	table.sort(arg_10_0._fightNameUIList, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0.entity.go.transform.position
		local var_11_1 = arg_11_1.entity.go.transform.position

		if var_11_0.z ~= var_11_1.z then
			return var_11_0.z > var_11_1.z
		elseif var_11_0.x ~= var_11_1.x then
			return math.abs(var_11_0.x) > math.abs(var_11_1.x)
		else
			return arg_11_0.entity.id > arg_11_1.entity.id
		end
	end)
	gohelper.setAsFirstSibling(arg_10_0._fightNameUIList[1]:getGO())

	for iter_10_0 = 2, #arg_10_0._fightNameUIList do
		local var_10_0 = arg_10_0._fightNameUIList[iter_10_0]
		local var_10_1 = arg_10_0._fightNameUIList[iter_10_0 - 1]

		gohelper.setSiblingAfter(var_10_0:getGO(), var_10_1:getGO())
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
