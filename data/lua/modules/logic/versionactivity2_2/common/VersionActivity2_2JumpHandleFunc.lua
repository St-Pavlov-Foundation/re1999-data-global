-- chunkname: @modules/logic/versionactivity2_2/common/VersionActivity2_2JumpHandleFunc.lua

module("modules.logic.versionactivity2_2.common.VersionActivity2_2JumpHandleFunc", package.seeall)

local VersionActivity2_2JumpHandleFunc = class("VersionActivity2_2JumpHandleFunc")

function VersionActivity2_2JumpHandleFunc:jumpTo12201()
	VersionActivity2_2EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_2JumpHandleFunc:jumpTo12202(paramsList)
	local actId = paramsList[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_2JumpHandleFunc:jumpTo12210(paramsList)
	local actId = paramsList[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_2JumpHandleFunc:jumpTo12203(paramsList)
	local actId = paramsList[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		TianShiNaNaController.instance:openMainView()
	end, nil, actId)
end

function VersionActivity2_2JumpHandleFunc:jumpTo12204(paramsList)
	local actId = paramsList[2]

	VersionActivity2_2EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		LoperaController.instance:openLoperaMainView()
	end, nil, actId)
end

return VersionActivity2_2JumpHandleFunc
