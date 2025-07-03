module("modules.logic.versionactivity2_7.act191.view.Act191ItemView", package.seeall)

local var_0_0 = class("Act191ItemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goRoot = gohelper.findChild(arg_1_0.viewGO, "#go_Root")
	arg_1_0._imageRare = gohelper.findChildImage(arg_1_0.viewGO, "#go_Root/#image_Rare")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_Root/#image_Icon")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/#txt_Name")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/scroll_desc/Viewport/go_desccontent/#txt_Desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0.config = arg_3_0.viewParam

	if arg_3_0.config.rare ~= 0 then
		UISpriteSetMgr.instance:setAct174Sprite(arg_3_0._imageRare, "act174_roleframe_" .. arg_3_0.config.rare)
	end

	gohelper.setActive(arg_3_0._imageRare, arg_3_0.config.rare ~= 0)
	UISpriteSetMgr.instance:setAct174Sprite(arg_3_0._imageIcon, arg_3_0.config.icon)

	arg_3_0._txtName.text = arg_3_0.config.name
	arg_3_0._txtDesc.text = arg_3_0.config.desc

	if arg_3_0.config.id == 1001 then
		transformhelper.setLocalScale(arg_3_0._imageIcon.gameObject.transform, 0.75, 0.75, 1)
	end
end

return var_0_0
