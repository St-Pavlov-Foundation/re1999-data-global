module("modules.logic.rouge.view.RougeCollectionInitialCollectionTipsTagItem", package.seeall)

local var_0_0 = class("RougeCollectionInitialCollectionTipsTagItem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
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

function var_0_0.ctor(arg_4_0, arg_4_1)
	RougeSimpleItemBase.ctor(arg_4_0, arg_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	RougeSimpleItemBase._editableInitView(arg_5_0)

	arg_5_0._txt = gohelper.findChildText(arg_5_0.viewGO, "")
	arg_5_0._img = gohelper.findChildImage(arg_5_0.viewGO, "image_tagicon")
end

function var_0_0.setData(arg_6_0, arg_6_1)
	local var_6_0 = lua_rouge_tag.configDict[arg_6_1]

	arg_6_0._txt.text = var_6_0.name

	UISpriteSetMgr.instance:setRougeSprite(arg_6_0._img, var_6_0.iconUrl)
end

return var_0_0
