module("modules.logic.explore.view.ExploreGetItemView", package.seeall)

local var_0_0 = class("ExploreGetItemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagepropicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_propicon")
	arg_1_0._txtpropname = gohelper.findChildText(arg_1_0.viewGO, "#txt_propname")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._txtdesc2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Scroll View/Viewport/Content/#txt_usedesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

	arg_4_0._config = ExploreConfig.instance:getItemCo(arg_4_0.viewParam.id)

	arg_4_0._simagepropicon:LoadImage(ResUrl.getPropItemIcon(arg_4_0._config.icon))

	arg_4_0._txtpropname.text = arg_4_0._config.name
	arg_4_0._txtdesc.text = arg_4_0._config.desc
	arg_4_0._txtdesc2.text = arg_4_0._config.desc2
end

function var_0_0.onClose(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	ExploreController.instance:dispatchEvent(ExploreEvent.ShowBagBtn)
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0._simagepropicon:UnLoadImage()
end

return var_0_0
