module("modules.ugui.icon.common.CommonHeadIcon", package.seeall)

local var_0_0 = class("CommonHeadIcon", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._headIcon = gohelper.findChildSingleImage(arg_1_1, "#simage_headicon")
	arg_1_0._goframe = gohelper.findChild(arg_1_1, "frame")
	arg_1_0._imgaeheadIcon = gohelper.findChildImage(arg_1_1, "#simage_headicon")
	arg_1_0._imageframe = gohelper.findChildImage(arg_1_1, "frame")
	arg_1_0._goframenode = gohelper.findChild(arg_1_1, "framenode")
	arg_1_0._btnClick = gohelper.findChildClick(arg_1_1, "#simage_headicon")
end

function var_0_0.addEventListeners(arg_2_0)
	if arg_2_0._btnClick then
		arg_2_0._btnClick:AddClickListener(arg_2_0._onClick, arg_2_0)
	end
end

function var_0_0.removeEventListeners(arg_3_0)
	if arg_3_0._btnClick then
		arg_3_0._btnClick:RemoveClickListener()

		arg_3_0._btnClick = nil
	end
end

function var_0_0._onClick(arg_4_0)
	if arg_4_0.noClick then
		return
	end

	if not arg_4_0._materialType or not arg_4_0._itemId then
		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_4_0._materialType, arg_4_0._itemId)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0.mo = arg_5_1

	arg_5_0:setItemId(arg_5_1.materilId, arg_5_1.materialType)
end

function var_0_0.setItemId(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._itemId = arg_6_1
	arg_6_0._materialType = arg_6_2 or MaterialEnum.MaterialType.Item
	arg_6_0._config = ItemModel.instance:getItemConfigAndIcon(arg_6_0._materialType, arg_6_1)

	arg_6_0:setHeadIcon()
	arg_6_0:updateFrame()
	arg_6_0:setVisible(true)
end

function var_0_0.setHeadIcon(arg_7_0)
	if not arg_7_0._liveHeadIcon then
		arg_7_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_7_0._headIcon)
	end

	arg_7_0._liveHeadIcon:setLiveHead(arg_7_0._config.id)
end

function var_0_0.updateFrame(arg_8_0)
	local var_8_0 = string.split(arg_8_0._config.effect, "#")

	if #var_8_0 > 1 and arg_8_0._config.id == tonumber(var_8_0[#var_8_0]) then
		gohelper.setActive(arg_8_0._goframe, false)
		gohelper.setActive(arg_8_0._goframenode, true)

		if not arg_8_0.frame and not arg_8_0.isloading then
			arg_8_0.isloading = true

			local var_8_1 = "ui/viewres/common/effect/frame.prefab"

			arg_8_0._frameloader = MultiAbLoader.New()

			arg_8_0._frameloader:addPath(var_8_1)
			arg_8_0._frameloader:startLoad(arg_8_0._onFrameLoadCallback, arg_8_0)
		end
	else
		gohelper.setActive(arg_8_0._goframe, true)
		gohelper.setActive(arg_8_0._goframenode, false)
	end
end

function var_0_0._onFrameLoadCallback(arg_9_0)
	arg_9_0.isloading = false

	local var_9_0 = arg_9_0._frameloader:getFirstAssetItem():GetResource()

	arg_9_0.frame = gohelper.clone(var_9_0, arg_9_0._goframenode, "frame")
end

function var_0_0.setColor(arg_10_0, arg_10_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._imgaeheadIcon, arg_10_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._imageframe, arg_10_1)
end

function var_0_0.setVisible(arg_11_0, arg_11_1)
	if arg_11_0.isVisible == arg_11_1 then
		return
	end

	arg_11_0.isVisible = arg_11_1

	gohelper.setActive(arg_11_0.go, arg_11_1)
end

function var_0_0.setNoClick(arg_12_0, arg_12_1)
	arg_12_0.noClick = arg_12_1
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._headIcon:UnLoadImage()
end

return var_0_0
