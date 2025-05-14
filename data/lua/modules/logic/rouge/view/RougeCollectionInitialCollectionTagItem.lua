module("modules.logic.rouge.view.RougeCollectionInitialCollectionTagItem", package.seeall)

local var_0_0 = class("RougeCollectionInitialCollectionTagItem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	RougeSimpleItemBase.ctor(arg_4_0, arg_4_1)
end

function var_0_0._btnclickOnClick(arg_5_0)
	arg_5_0:parent():setActiveTips(true)
end

function var_0_0._editableInitView(arg_6_0)
	RougeSimpleItemBase._editableInitView(arg_6_0)

	arg_6_0._imageTagFrame = gohelper.findChildImage(arg_6_0.viewGO, "image_tagframe")
	arg_6_0._imageTagIcon = gohelper.findChildImage(arg_6_0.viewGO, "image_tagicon")

	UISpriteSetMgr.instance:setRougeSprite(arg_6_0._imageTagFrame, "rouge_collection_tagframe_1")
end

function var_0_0.setData(arg_7_0, arg_7_1)
	local var_7_0 = lua_rouge_tag.configDict[arg_7_1]

	UISpriteSetMgr.instance:setRougeSprite(arg_7_0._imageTagIcon, var_7_0.iconUrl)
end

return var_0_0
