module("modules.logic.necrologiststory.view.NecrologistStoryTipView", package.seeall)

local var_0_0 = class("NecrologistStoryTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Layout/right/#txt_title")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Layout/right/descNode/#go_Talk/Scroll DecView/Viewport/Content/info1")

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

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.initViewParam(arg_6_0)
	arg_6_0.tagId = arg_6_0.viewParam.tagId
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_wulu_paiqian_open)
	arg_7_0:initViewParam()
	arg_7_0:setTagTip(arg_7_0.tagId)
end

function var_0_0.setTagTip(arg_8_0, arg_8_1)
	local var_8_0 = tonumber(arg_8_1)
	local var_8_1 = NecrologistStoryConfig.instance:getIntroduceCo(var_8_0)

	if not var_8_1 then
		return
	end

	arg_8_0.txtTitle.text = var_8_1.name
	arg_8_0.txtDesc.text = var_8_1.desc
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
