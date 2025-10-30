module("modules.logic.gm.view.GM_LoginVideoView", package.seeall)

local var_0_0 = class("GM_LoginVideoView", BaseView)

function var_0_0.onOpenFinish(arg_1_0)
	arg_1_0:_startMGLoader()
end

function var_0_0.onDestroyView(arg_2_0)
	if arg_2_0._dropDownComp then
		arg_2_0._dropDownComp:RemoveOnValueChanged()

		arg_2_0._dropDownComp = nil
	end

	if arg_2_0._loader then
		arg_2_0._loader:dispose()

		arg_2_0._loader = nil
	end
end

function var_0_0._startMGLoader(arg_3_0)
	if not arg_3_0._loader then
		arg_3_0._loader = SequenceAbLoader.New()

		arg_3_0._loader:addPath(var_0_0.GMVideoTestPath)
		arg_3_0._loader:startLoad(arg_3_0._onLoadFinish, arg_3_0)
	end
end

function var_0_0._onLoadFinish(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getAssetItem(var_0_0.GMVideoTestPath)

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0:GetResource(var_0_0.GMVideoTestPath)

	arg_4_0._gologinvideotest = gohelper.clone(var_4_1, arg_4_0.viewGO)

	arg_4_0:_showTest()
end

function var_0_0._showTest(arg_5_0)
	arg_5_0._dropDownComp = gohelper.findChildDropdown(arg_5_0._gologinvideotest, "Dropdown")
	arg_5_0._videoNameList = {
		"19208003k",
		"19208001w",
		"256010803k",
		"256010801w"
	}

	arg_5_0._dropDownComp:ClearOptions()
	arg_5_0._dropDownComp:AddOptions(arg_5_0._videoNameList)
	arg_5_0._dropDownComp:AddOnValueChanged(arg_5_0._onDropDownChanged, arg_5_0)
end

function var_0_0._onDropDownChanged(arg_6_0, arg_6_1)
	local var_6_0 = ViewMgr.instance:getContainer(ViewName.LoginView)

	if var_6_0 then
		local var_6_1 = arg_6_0._videoNameList[arg_6_1 + 1]

		if var_6_1 then
			var_6_0:dispatchEvent(LoginEvent.OnLoginVideoSwitch, string.format("videos/%s.mp4", var_6_1))
		end
	end
end

var_0_0.GMVideoTestPath = "ui/viewres/gm/gmloginvideotest.prefab"

return var_0_0
