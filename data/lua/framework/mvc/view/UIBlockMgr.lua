module("framework.mvc.view.UIBlockMgr", package.seeall)

local var_0_0 = class("UIBlockMgr")

var_0_0.DefaultKey = "default"

function var_0_0.ctor(arg_1_0)
	arg_1_0._blockKeyDict = {}
	arg_1_0._goBlock = nil
	arg_1_0._clickCounter = 0
end

function var_0_0.startBlock(arg_2_0, arg_2_1)
	arg_2_1 = arg_2_1 or var_0_0.DefaultKey
	arg_2_0._blockKeyDict[arg_2_1] = true

	arg_2_0:_checkFirstCreateMask()
	gohelper.setActive(arg_2_0._goBlock, true)
end

function var_0_0.endBlock(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or var_0_0.DefaultKey
	arg_3_0._blockKeyDict[arg_3_1] = nil

	for iter_3_0, iter_3_1 in pairs(arg_3_0._blockKeyDict) do
		return
	end

	gohelper.setActive(arg_3_0._goBlock, false)

	arg_3_0._clickCounter = 0
end

function var_0_0.endAll(arg_4_0)
	if arg_4_0:isBlock() then
		arg_4_0._blockKeyDict = {}

		gohelper.setActive(arg_4_0._goBlock, false)

		arg_4_0._clickCounter = 0
	end
end

function var_0_0.isBlock(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._blockKeyDict) do
		return true
	end
end

function var_0_0.isKeyBlock(arg_6_0, arg_6_1)
	return arg_6_0._blockKeyDict[arg_6_1]
end

function var_0_0.getBlockGO(arg_7_0)
	arg_7_0:_checkFirstCreateMask()

	return arg_7_0._goBlock
end

function var_0_0._checkFirstCreateMask(arg_8_0)
	if not arg_8_0._goBlock then
		arg_8_0._goBlock = gohelper.find("UIRoot/TOP/UIBlock")

		SLFramework.UGUI.UIClickListener.Get(arg_8_0._goBlock):AddClickListener(arg_8_0._onClickBlock, arg_8_0)
	end
end

function var_0_0._onClickBlock(arg_9_0)
	arg_9_0._clickCounter = arg_9_0._clickCounter + 1

	if arg_9_0._clickCounter == 5 then
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_0._blockKeyDict) do
			table.insert(var_9_0, iter_9_0)
		end

		logNormal("BlockKeys: " .. table.concat(var_9_0, ","))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
