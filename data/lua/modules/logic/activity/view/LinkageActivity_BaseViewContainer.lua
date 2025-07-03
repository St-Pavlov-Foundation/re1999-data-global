module("modules.logic.activity.view.LinkageActivity_BaseViewContainer", package.seeall)

local var_0_0 = class("LinkageActivity_BaseViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	assert(false, "please override this function")
end

function var_0_0.view(arg_2_0)
	assert(false, "please override this function")
end

function var_0_0.switchPage(arg_3_0, arg_3_1)
	arg_3_0:view():selectedPage(arg_3_1)
end

function var_0_0.itemCo2TIQ(arg_4_0, arg_4_1)
	if string.nilorempty(arg_4_1) then
		return
	end

	local var_4_0 = string.split(arg_4_1, "#")

	assert(#var_4_0 >= 2, "[LinkageActivity_BaseViewContainer] invalid itemCo=" .. tostring(arg_4_1))

	local var_4_1 = string.split(arg_4_1, "#")
	local var_4_2 = tonumber(var_4_1[1])
	local var_4_3 = tonumber(var_4_1[2])
	local var_4_4 = tonumber(var_4_1[3])

	return var_4_2, var_4_3, var_4_4
end

function var_0_0.getItemConfig(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ItemConfigGetDefine.instance:getItemConfigFunc(arg_5_1)

	assert(var_5_0, "[LinkageActivity_BaseViewContainer] ItemIconGetDefine-getItemConfigFunc unsupported materialType: " .. tostring(arg_5_1))

	local var_5_1 = var_5_0(arg_5_2)

	assert(var_5_1, "[LinkageActivity_BaseViewContainer] item config not found materialType=" .. tostring(arg_5_1) .. " id=" .. tostring(arg_5_2))

	return var_5_1
end

function var_0_0.getItemIconResUrl(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return ""
	end

	local var_6_0 = ItemIconGetDefine.instance:getItemIconFunc(arg_6_1)

	assert(var_6_0, "[LinkageActivity_BaseViewContainer] ItemIconGetDefine-getItemIconFunc unsupported materialType: " .. tostring(arg_6_1))

	local var_6_1 = arg_6_0:getItemConfig(arg_6_1, arg_6_2)

	return var_6_0(var_6_1) or ""
end

function var_0_0.getAssetItem_VideoLoadingPng(arg_7_0)
	local var_7_0 = arg_7_0._viewSetting.otherRes

	return arg_7_0:getRes(var_7_0[1])
end

function var_0_0.Vxax_LinkageActivity_xxxView_Container(arg_8_0, arg_8_1)
	function arg_8_0.buildViews(arg_9_0)
		arg_9_0._view = arg_8_1.New()

		return {
			arg_9_0._view
		}
	end

	function arg_8_0.view(arg_10_0)
		return arg_10_0._view
	end
end

function var_0_0.Vxax_LinkageActivity_FullView(arg_11_0, arg_11_1, arg_11_2)
	return
end

function var_0_0.Vxax_LinkageActivity_PanelView(arg_12_0, arg_12_1, arg_12_2)
	return
end

local function var_0_1(arg_13_0)
	local var_13_0 = GameBranchMgr.instance:getMajorVer()
	local var_13_1 = GameBranchMgr.instance:getMinorVer()

	return _G[string.format(arg_13_0, var_13_0, var_13_1)]
end

function var_0_0.Vxax_LinkageActivity_FullView_ContainerImpl()
	return var_0_1("V%sa%s_LinkageActivity_FullViewContainer")
end

function var_0_0.Vxax_LinkageActivity_PanelView_ContainerImpl()
	return var_0_1("V%sa%s_LinkageActivity_PanelViewContainer")
end

return var_0_0
