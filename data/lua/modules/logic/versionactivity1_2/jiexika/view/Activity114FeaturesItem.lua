module("modules.logic.versionactivity1_2.jiexika.view.Activity114FeaturesItem", package.seeall)

local var_0_0 = class("Activity114FeaturesItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.go, "#txt_name")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.go, "#image_bg")
	arg_1_0._click = gohelper.getClickWithAudio(arg_1_0.go)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0._onClick(arg_4_0)
	Activity114Controller.instance:dispatchEvent(Activity114Event.ShowFeaturesTips)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	local var_5_0 = Activity114FeaturesModel.instance:getFeaturePreferredLength(arg_5_0._txtName, 276, 420)

	recthelper.setWidth(arg_5_0.go.transform, var_5_0)

	arg_5_0.mo = arg_5_1

	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(arg_5_0._imageIcon, arg_5_1.inheritable == 1 and "img_shuxing1" or "img_shuxing2")

	arg_5_0._txtName.text = arg_5_0.mo.features
end

function var_0_0.onDestroyView(arg_6_0)
	return
end

return var_0_0
