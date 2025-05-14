module("modules.logic.guide.controller.GuideBlockMgr", package.seeall)

local var_0_0 = class("GuideBlockMgr")

var_0_0.BlockTime = 0.5

function var_0_0.ctor(arg_1_0)
	arg_1_0._eventSystemGO = nil
	arg_1_0._startBlockTime = nil
	arg_1_0._blockTime = nil
	arg_1_0._isBlock = false
end

function var_0_0.startBlock(arg_2_0, arg_2_1)
	if not arg_2_0._eventSystemGO then
		arg_2_0._eventSystemGO = gohelper.find("EventSystem")

		if not arg_2_0._eventSystemGO then
			logError("can't find EventSystem GO")
		end

		TaskDispatcher.runRepeat(arg_2_0._onTick, arg_2_0, 0.2)
	end

	if not arg_2_0._startBlockTime then
		arg_2_0._isBlock = true

		gohelper.setActive(arg_2_0._eventSystemGO, false)

		ZProj.TouchEventMgr.Fobidden = true
	end

	arg_2_0._startBlockTime = Time.time
	arg_2_0._blockTime = arg_2_1 or var_0_0.BlockTime
end

function var_0_0.removeBlock(arg_3_0)
	arg_3_0:_removeBlock()
end

function var_0_0._removeBlock(arg_4_0)
	arg_4_0._startBlockTime = nil
	arg_4_0._isBlock = false

	gohelper.setActive(arg_4_0._eventSystemGO, true)

	ZProj.TouchEventMgr.Fobidden = false
end

function var_0_0.isBlock(arg_5_0)
	return arg_5_0._isBlock
end

function var_0_0._onTick(arg_6_0)
	if arg_6_0._startBlockTime and Time.time - arg_6_0._startBlockTime >= arg_6_0._blockTime then
		arg_6_0:_removeBlock()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
